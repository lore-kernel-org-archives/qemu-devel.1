Received: from eggs.gnu.org ([209.51.188.92]:35999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goVmg-0003mx-MM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goVmf-0000RF-Nv
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:58:46 -0500
Date: Tue, 29 Jan 2019 15:58:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190129155832.GJ30796@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190125174653.4604-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] scsi-disk: Deprecate device_id
 fallback to BlockBackend name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org

On Fri, Jan 25, 2019 at 06:46:53PM +0100, Kevin Wolf wrote:
> We should never have exposed BlockBackend names to the guest, it's a
> host detail. Deprecate this behaviour. Users who need to maintain the
> guest ABI can explicitly set the value with the device_id property.

I don't think we've deprecated things in the past which would cause
a guest ABI change when finally deleted.

Shouldn't we be instead setting using machine type versioning here,
so that existing machine types keep using the blk_name() fallback
forever, while QEMU 4.0+ machine types avoid blk_name() fallback
immediately.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/scsi/scsi-disk.c  |  5 +++++
>  qemu-deprecated.texi | 22 +++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e74e1e7c48..38f1fe2570 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2366,6 +2366,11 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
>              const char *str = blk_name(s->qdev.conf.blk);
>              if (str && *str) {
>                  s->device_id = g_strdup(str);
> +                warn_report("Using the backend drive ID for the Device "
> +                            "Identification VPD page is deprecated. "
> +                            "Please specify the serial or device_id options "
> +                            "explicitly to avoid guest-visible changes in "
> +                            "future QEMU versions.");
>              }
>          }
>      }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
