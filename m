Received: from eggs.gnu.org ([2001:4830:134:3::10]:41013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqxNl-00039O-R6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqxNi-0006eM-Nm
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:46:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqxNi-0006e2-J4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:46:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 205918182D17
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:46:34 +0000 (UTC)
Date: Wed, 28 Feb 2018 16:46:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228084628.GB27381@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-11-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-11-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/29] vhost+postcopy: Register shared
 ufd with postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Fri, Feb 16, 2018 at 01:16:06PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Register the UFD that comes in as the response to the 'advise' method
> with the postcopy code.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/virtio/vhost-user.c   | 21 ++++++++++++++++++++-
>  migration/postcopy-ram.h |  2 +-
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 4f59993baa..dd4eb50668 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -24,6 +24,7 @@
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <linux/vhost.h>
> +#include <linux/userfaultfd.h>

Why this line?

>  
>  #define VHOST_MEMORY_MAX_NREGIONS    8
>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
> @@ -155,6 +156,7 @@ struct vhost_user {
>      CharBackend *chr;
>      int slave_fd;
>      NotifierWithReturn postcopy_notifier;
> +    struct PostCopyFD  postcopy_fd;
>  };
>  
>  static bool ioeventfd_enabled(void)
> @@ -780,6 +782,17 @@ out:
>      return ret;
>  }
>  
> +/*
> + * Called back from the postcopy fault thread when a fault is received on our
> + * ufd.
> + * TODO: This is Linux specific
> + */
> +static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
> +                                             void *ufd)
> +{
> +    return 0;
> +}
> +
>  /*
>   * Called at the start of an inbound postcopy on reception of the
>   * 'advise' command.
> @@ -819,8 +832,14 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
>          error_setg(errp, "%s: Failed to get ufd", __func__);
>          return -1;
>      }
> +    fcntl(ufd, F_SETFL, O_NONBLOCK);

Only curious: would it work even without this line?

>  
> -    /* TODO: register ufd with userfault thread */
> +    /* register ufd with userfault thread */
> +    u->postcopy_fd.fd = ufd;
> +    u->postcopy_fd.data = dev;
> +    u->postcopy_fd.handler = vhost_user_postcopy_fault_handler;
> +    u->postcopy_fd.idstr = "vhost-user"; /* Need to find unique name */
> +    postcopy_register_shared_ufd(&u->postcopy_fd);
>      return 0;
>  }
>  
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 4bda5aa509..23efbdf346 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -153,7 +153,7 @@ struct PostCopyFD {
>      /* Handler to be called whenever we get a poll event */
>      pcfdhandler handler;
>      /* A string to use in error messages */
> -    char *idstr;
> +    const char *idstr;

Move to previous patch?

>  };
>  
>  /* Register a userfaultfd owned by an external process for
> -- 
> 2.14.3
> 

-- 
Peter Xu
