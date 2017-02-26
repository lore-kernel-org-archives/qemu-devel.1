Received: from eggs.gnu.org ([2001:4830:134:3::10]:40375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ci4JO-0004bb-UP
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ci4JL-0002zS-OD
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1ci4JL-0002zE-I6
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:16:47 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BEFF61BAB
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 19:16:46 +0000 (UTC)
References: <20170224182844.32452-1-dgilbert@redhat.com>
	<20170224182844.32452-17-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7f9d0f8b-5f84-d02c-7c22-6915e12da9ed@redhat.com>
Date: Sun, 26 Feb 2017 20:16:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170224182844.32452-17-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 16/16] postcopy: Add extra check for
 COPY function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

On 24/02/2017 19:28, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> As an extra sanity check, make sure the region we're registering
> can perform UFFDIO_COPY;  the COPY will fail later but this
> gives a cleaner failure.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/postcopy-ram.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 102fb61..effbeb6 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -378,6 +378,10 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
>          error_report("%s userfault register: %s", __func__, strerror(errno));
>          return -1;
>      }
> +    if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> +        error_report("%s userfault: Region doesn't support COPY", __func__);
> +        return -1;
> +    }
>  
>      return 0;
>  }
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
