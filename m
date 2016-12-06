Received: from eggs.gnu.org ([2001:4830:134:3::10]:44154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cEJuJ-0001TR-MK
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cEJuF-0000UT-QA
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:51:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35927
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cEJuF-0000U3-Fk
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:51:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6HoJ6c129602
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 12:51:52 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 275x4g04j7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:51:52 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 6 Dec 2016 17:51:51 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2A917219005E
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 17:50:59 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id uB6Hpm5710551564
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 17:51:48 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id uB6Hpmwb021423
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 10:51:48 -0700
Date: Tue, 6 Dec 2016 18:51:46 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161206162545.GA4027@thinpad.lan.raisama.net>
References: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206162545.GA4027@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161206185146.1a5b7c0c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 6 Dec 2016 14:25:45 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Dec 06, 2016 at 04:41:12PM +0100, Greg Kurz wrote:
> > The current code recursively applies global properties from child up to
> > parent types. This can cause properties passed with the -global option to
> > be silently overridden by internal compat properties.
> > 
> > This is exactly what happens with virtio-*-pci drivers since commit:
> > 
> > "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"
> > 
> > Passing -device virtio-blk-pci.disable-modern=off has no effect on 2.6
> > machine types because the internal virtio-pci.disable-modern=on compat
> > property always prevail.
> > 
> > This patch fixes the issue by reversing the logic: we now go through the
> > global property list and, for each property, we check if it is applicable
> > to the device.
> > 
> > This result in compat properties being applied first, in the order they
> > appear in the HW_COMPAT_* macros, followed by global properties, in they
> > order appear on the command line.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> FWIW, this is the behavior I would like to see. But:
> 
> I think it's too late to change the rules on 2.8. I would like to
> change behavior only on 2.9, so we have time to discuss and test
> it. I believe the 2.8 fix should be just changing the HW_COMPAT_*
> macros to touch only the device subclasses, so we fix the
> regression introduced by commit 9a4c0e220d8a without changing any
> rules on how -global is handled.

Agreed on both counts.
