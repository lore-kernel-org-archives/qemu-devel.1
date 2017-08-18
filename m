Received: from eggs.gnu.org ([2001:4830:134:3::10]:41656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dihDw-0005rM-C1
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dihDs-000637-PN
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:22:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dihDs-00061R-Id
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:22:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84BC3C0587E8
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 13:21:59 +0000 (UTC)
Date: Fri, 18 Aug 2017 21:21:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170818132157.GD15392@lemon>
References: <20170817141148.13111-1-famz@redhat.com>
	<dad88591-da0d-d9dd-ef0d-4153bbc68b85@redhat.com>
	<20170818033829.GA15392@lemon>
	<39e28f27-c45c-b2a2-bb46-16b65f9d04f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e28f27-c45c-b2a2-bb46-16b65f9d04f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] scsi-block: Add qdev error properties
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

On Fri, 08/18 08:41, Paolo Bonzini wrote:
> On 18/08/2017 05:38, Fam Zheng wrote:
> > On Thu, 08/17 16:23, Paolo Bonzini wrote:
> >>> +        if (scsi_sense_matches(r, SENSE_CODE(NO_MEDIUM))) {
> >>> +            error = ENOMEDIUM;
> >>> +        } else if (scsi_sense_matches(r, SENSE_CODE(TARGET_FAILURE))) {
> >>> +            error = ENOMEM;
> >>> +        } else if (scsi_sense_matches(r, SENSE_CODE(INVALID_FIELD))) {
> >>> +            error = EINVAL;
> >>> +        } else if (scsi_sense_matches(r, SENSE_CODE(SPACE_ALLOC_FAILED))) {
> >>> +            error = ENOSPC;
> >>> +        } else {
> >>> +            error = EIO;
> >>
> >> Nice touch :) and in fact the ENOSPC case is needed for correctness.
> >>
> > 
> > Offline you mentioned iscsi_translate_sense(). Makes sense to unify both. We can
> > create a util/scsi.c to move it there.
> > 
> > About the error/non-error condition, is it enough to add a check "status ==
> > CHECK_CONDITION"?
> 
> No, CHECK_CONDITION is for almost every error.
> 
> Of those in iscsi_translate_sense:
> 
> - DATA_PROTECTION should be an error
> 
> - COMMAND_ABORTED should be passed down
> 
> - of the various ILLEGAL_REQUEST cases, only ENOMEDIUM and ENOACCES
> should stop.  LBA out of range should never happen (see
> scsi_disk_dma_command).
> 
> - NOT_READY should also look at asc/ascq individually, like
> ILLEGAL_REQUEST, see below

And the same to DATA PROTECT.

> 
> Of those in your list above, these are missing in iscsi_translate_sense:
> 
> - SPACE_ALLOC_FAILED (which should stop the VM)
> 
> - NOT_READY should also look at asc/ascq individually, like
> ILLEGAL_REQUEST.  NO_MEDIUM is returning -EBUSY instead of -ENOMEDIUM.
> 
> Among other sense keys, MEDIUM_ERROR and HARDWARE_ERROR probably should
> stop the VM.

Thanks, I'll work on a new version.

Fam
