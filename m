Received: from eggs.gnu.org ([2001:4830:134:3::10]:45401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgHzR-0003kG-Ig
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgHzO-0007UV-Ev
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:28:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1cgHzO-0007UK-8a
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:28:50 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 440543A768A
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 21:28:50 +0000 (UTC)
References: <20170221190955.8616.21658.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0ec79096-c8b8-9565-9073-0b6e0a9e57f1@redhat.com>
Date: Tue, 21 Feb 2017 22:28:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170221190955.8616.21658.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Report errors from qdev_unplug()
 via device request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

Hi Alex,

On 21/02/2017 20:10, Alex Williamson wrote:
> Currently we ignore this error, report it with error_reportf_err()
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  hw/vfio/pci.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 332f41d6627f..f2ba9b6cfafc 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2506,12 +2506,16 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>  static void vfio_req_notifier_handler(void *opaque)
>  {
>      VFIOPCIDevice *vdev = opaque;
> +    Error *err = NULL;
>  
>      if (!event_notifier_test_and_clear(&vdev->req_notifier)) {
>          return;
>      }
>  
> -    qdev_unplug(&vdev->pdev.qdev, NULL);
> +    qdev_unplug(&vdev->pdev.qdev, &err);
> +    if (err) {
> +        error_reportf_err(err, WARN_PREFIX, vdev->vbasedev.name);
> +    }
>  }
>  
>  static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
> 
