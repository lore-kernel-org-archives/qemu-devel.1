Received: from eggs.gnu.org ([2001:4830:134:3::10]:37810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddGFN-0001O2-Je
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddGFJ-0007Cd-U3
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ddGFJ-00077X-Om
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:33:01 -0400
Date: Thu, 3 Aug 2017 14:32:53 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170803133253.GF9141@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1501766821-76419-1-git-send-email-hare@suse.de>
	<1501766821-76419-2-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501766821-76419-2-git-send-email-hare@suse.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] scsi: Make LUN 0 a simple enclosure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.com>, qemu-devel@nongnu.org

On Thu, Aug 03, 2017 at 03:27:00PM +0200, Hannes Reinecke wrote:
> Instead of having an 'invisible' LUN0 (in case LUN 0 is not connected)
> this patch maks LUN0 a enclosure service, exposing it to the OS.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  hw/scsi/scsi-bus.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 23c51de..c89e82d 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -493,10 +493,11 @@ static bool scsi_target_emulate_inquiry(SCSITargetReq *r)
>      if (r->req.lun != 0) {
>          r->buf[0] = TYPE_NO_LUN;
>      } else {
> -        r->buf[0] = TYPE_NOT_PRESENT | TYPE_INACTIVE;
> +        r->buf[0] = TYPE_ENCLOSURE;
>          r->buf[2] = 5; /* Version */
>          r->buf[3] = 2 | 0x10; /* HiSup, response data format */
>          r->buf[4] = r->len - 5; /* Additional Length = (Len - 1) - 4 */
> +        r->buf[6] = 0x40; /* Enclosure service */
>          r->buf[7] = 0x10 | (r->req.bus->info->tcq ? 0x02 : 0); /* Sync, TCQ.  */
>          memcpy(&r->buf[8], "QEMU    ", 8);
>          memcpy(&r->buf[16], "QEMU TARGET     ", 16);

I would think this needs to be tied into machine type version, otherwise
when you migrate old to new QEMU, LUN0 is suddenly going to change beneath
the running guest ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
