Received: from eggs.gnu.org ([2001:4830:134:3::10]:38575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djkc1-0002O5-05
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djkbw-0004f9-SJ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1djkbw-0004cr-Jp
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:11:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB317C047B87
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 11:11:11 +0000 (UTC)
Date: Mon, 21 Aug 2017 19:11:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170821111108.GB4371@lemon>
References: <20170818141512.15205-1-famz@redhat.com>
	<20170818141512.15205-3-famz@redhat.com>
	<060c28df-bc84-01da-9c7b-2b47221f5311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060c28df-bc84-01da-9c7b-2b47221f5311@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] scsi: Enhance scsi_sense_to_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 08/18 16:36, Paolo Bonzini wrote:
> On 18/08/2017 16:15, Fam Zheng wrote:
> > Two changes:
> > 
> > 1) Look at asc/ascq for NOT_READY and DATA_PROTECT;
> > 2) Translate SPACE_ALLOC_FAILED as ENOSPC;
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  util/scsi.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/util/scsi.c b/util/scsi.c
> > index 92ca436cd0..d42ce33449 100644
> > --- a/util/scsi.c
> > +++ b/util/scsi.c
> > @@ -18,13 +18,11 @@
> >  int scsi_sense_to_errno(int key, int asc, int ascq)
> >  {
> >      switch (key) {
> > -    case 0x02: /* SCSI_SENSE_NOT_READY */
> > -        return EBUSY;
> > -    case 0x07: /* SCSI_SENSE_DATA_PROTECTION */
> > -        return EACCES;
> >      case 0x0b: /* SCSI_SENSE_COMMAND_ABORTED */
> >          return ECANCELED;
> > +    case 0x02: /* SCSI_SENSE_NOT_READY */
> >      case 0x05: /* SCSI_SENSE_ILLEGAL_REQUEST */
> > +    case 0x07: /* SCSI_SENSE_DATA_PROTECTION */
> >          /* Parse ASCQ */
> >          break;
> >      default:
> 
> UNIT_ATTENTION should also be passed down to the guest without stopping
> the VM.  Maybe map it to EAGAIN?

Or just 0?

> 
> Looking at what Linux does:
> 
> - RECOVERED_ERROR should just return 0
> 
> - 0x0401 is "unit in the process of becoming ready", and it should also
> be EAGAIN
> 
> - 0x0402 is "initializing command required", and probably can be fixed
> by the guest by scsi-block but not by iscsi so it should be its own
> errno, maybe ENOTCONN?  (iscsi might try sending START STOP UNIT
> followed by a bunch of TEST UNIT READYs, see scsi_eh_try_stu in Linux's
> drivers/scsi/scsi_error.c).

These makes sense to me.

Fam
