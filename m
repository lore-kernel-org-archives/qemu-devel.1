Received: from eggs.gnu.org ([2001:4830:134:3::10]:55859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06gH-0005xx-JR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06gG-0007XX-SS
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06gG-0007XA-Lv
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 996057F41C
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 13:59:15 +0000 (UTC)
Date: Thu, 5 Oct 2017 15:59:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171005155912.5871c4d7@nial.brq.redhat.com>
In-Reply-To: <1507206738-816-2-git-send-email-thuth@redhat.com>
References: <1507206738-816-1-git-send-email-thuth@redhat.com>
	<1507206738-816-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev_monitor: Simplify error handling
 in qdev_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu,  5 Oct 2017 14:32:17 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Instead of doing the clean-ups on errors multiple times, introduce
> a jump label at the end of the function that can be used by all
> error paths that need this cleanup.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qdev-monitor.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 8fd6df9..cb2b109 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -620,22 +620,21 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>  
>      /* set properties */
>      if (qemu_opt_foreach(opts, set_property, dev, &err)) {
> -        error_propagate(errp, err);
> -        object_unparent(OBJECT(dev));
> -        object_unref(OBJECT(dev));
> -        return NULL;
> +        goto err_del_dev;
>      }
>  
>      dev->opts = opts;
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
> -    if (err != NULL) {
> -        error_propagate(errp, err);
> -        dev->opts = NULL;
> -        object_unparent(OBJECT(dev));
> -        object_unref(OBJECT(dev));
> -        return NULL;
> +    if (!err) {
> +        return dev;
>      }
typically the same error check pattern is used through out the function
so I'd not do inversion here. i.e. keep normal flow non-branched and jump on error

 if (err != NULL) {
    goto err_del_dev;
 }
 return dev;

 err_del_dev:
    dev->opts = NULL;

> -    return dev;
> +    dev->opts = NULL;
> +
> +err_del_dev:
> +    error_propagate(errp, err);
> +    object_unparent(OBJECT(dev));
> +    object_unref(OBJECT(dev));
> +    return NULL;
>  }
>  
>  
