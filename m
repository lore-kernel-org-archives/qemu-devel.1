Received: from eggs.gnu.org ([209.51.188.92]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gooDT-00080c-1g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gooDP-00071o-OF
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:39:38 -0500
Date: Wed, 30 Jan 2019 12:39:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190130113907.GA892@localhost.localdomain>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-2-kwolf@redhat.com>
	<87a7jjqv2l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7jjqv2l.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] scsi-disk: Don't use empty string as
 device id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

Am 29.01.2019 um 17:37 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > scsi-disk includes in the Device Identification VPD page, depending on
> > configuration amongst others, a vendor specific designator that consists
> > either of the serial number if given or the BlockBackend name (which is
> > a host detail that better shouldn't have been leaked to the guest, but
> > now we have to maintain it for compatibility).
> >
> > With anonymous BlockBackends, i.e. scsi-disk devices constructed with
> > drive=<node-name>, and no serial number explicitly specified, this ends
> > up as an empty string. If this happens to more than one disk, we have
> > accidentally signalled to the OS that this is a multipath setup, which
> > is obviously not what was intended.
> >
> > Instead of using an empty string for the vendor specific designator,
> > simply leave out that designator, which makes Linux detect such setups
> > as separate disks again.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/scsi/scsi-disk.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index 0e9027c8f3..93eef40b87 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -652,12 +652,14 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
> >          DPRINTF("Inquiry EVPD[Device identification] "
> >                  "buffer size %zd\n", req->cmd.xfer);
> >  
> > -        outbuf[buflen++] = 0x2; /* ASCII */
> > -        outbuf[buflen++] = 0;   /* not officially assigned */
> > -        outbuf[buflen++] = 0;   /* reserved */
> > -        outbuf[buflen++] = id_len; /* length of data following */
> > -        memcpy(outbuf + buflen, str, id_len);
> > -        buflen += id_len;
> > +        if (id_len) {
> > +            outbuf[buflen++] = 0x2; /* ASCII */
> > +            outbuf[buflen++] = 0;   /* not officially assigned */
> > +            outbuf[buflen++] = 0;   /* reserved */
> > +            outbuf[buflen++] = id_len; /* length of data following */
> > +            memcpy(outbuf + buflen, str, id_len);
> > +            buflen += id_len;
> > +        }
> >  
> >          if (s->qdev.wwn) {
> >              outbuf[buflen++] = 0x1; /* Binary */
> 
> Before the patch, we always add this descriptor, but as you explain in
> your commit message, its contents can be wrong.
> 
> After the patch, we add this descriptor only when we have a suitable
> name (we use serial number, else falling back to BlockBackend name).
> It's possible we add *no* descriptors.  I wonder whether that's okay.  I
> consulted section SPC-4 section 7.8.5 Device Identification VPD page,
> but failed to penetrate the dense prose there.

I wasn't completely sure about the interpretation either, but to me the
most likely one is that according to SPC-4 not having a descriptor is
illegal because 7.8.5.2.1 requires that at least one descriptor of type
1, 2, 3 or 8 shall be included (all of them contain some sort of a
registered vendor ID, which we don't have).

The one that I'm removing is type 0, so it didn't meet the requirement
even before and I concluded that if this patch doesn't make things worse
in terms of spec compliance and fixes things in practice, it can't be
completely wrong.

Kevin
