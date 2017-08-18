Received: from eggs.gnu.org ([2001:4830:134:3::10]:33380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diY7J-0006u2-4u
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diY7F-0004lJ-T5
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:38:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diY7F-0004l5-Md
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:38:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A06E13A82
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 03:38:32 +0000 (UTC)
Date: Fri, 18 Aug 2017 11:38:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170818033829.GA15392@lemon>
References: <20170817141148.13111-1-famz@redhat.com>
	<dad88591-da0d-d9dd-ef0d-4153bbc68b85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad88591-da0d-d9dd-ef0d-4153bbc68b85@redhat.com>
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

On Thu, 08/17 16:23, Paolo Bonzini wrote:
> > +        if (scsi_sense_matches(r, SENSE_CODE(NO_MEDIUM))) {
> > +            error = ENOMEDIUM;
> > +        } else if (scsi_sense_matches(r, SENSE_CODE(TARGET_FAILURE))) {
> > +            error = ENOMEM;
> > +        } else if (scsi_sense_matches(r, SENSE_CODE(INVALID_FIELD))) {
> > +            error = EINVAL;
> > +        } else if (scsi_sense_matches(r, SENSE_CODE(SPACE_ALLOC_FAILED))) {
> > +            error = ENOSPC;
> > +        } else {
> > +            error = EIO;
> 
> Nice touch :) and in fact the ENOSPC case is needed for correctness.
> 

Offline you mentioned iscsi_translate_sense(). Makes sense to unify both. We can
create a util/scsi.c to move it there.

About the error/non-error condition, is it enough to add a check "status ==
CHECK_CONDITION"?

Fam
