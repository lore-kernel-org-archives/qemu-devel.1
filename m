Received: from eggs.gnu.org ([2001:4830:134:3::10]:52509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dSJtJ-00033A-AE
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dSJtE-0004e4-A7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:13:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dSJtE-0004dQ-0J
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:13:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v6498xnh067412
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 05:12:58 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg78nbtjw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 05:12:58 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 19:12:56 +1000
Date: Tue, 4 Jul 2017 14:41:33 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
	<20170704033143.GA7689@in.ibm.com>
	<20170704035050.GB7689@in.ibm.com>
	<20170704100246.37100aa1@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704100246.37100aa1@bahia.lan>
Message-Id: <20170704091133.GC7689@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix memory hotplug error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Jul 04, 2017 at 10:02:46AM +0200, Greg Kurz wrote:
> > > There is some history to this. I was doing error recovery and propagation
> > > here similarly during memory hotplug development phase until Igor
> > > suggested that we shoudn't try to recover after we have done guest
> > > visible changes.
> > > 
> > > Refer to "changes in v6" section in this post:
> > > https://lists.gnu.org/archive/html/qemu-ppc/2015-06/msg00296.html
> > > 
> > > However at that time we were doing memory add by DRC index method
> > > and hence would attach and online one LMB at a time.
> > > In that method, if an intermediate attach fails we would end up with a few
> > > LMBs being onlined by the guest already. However subsequently
> > > we have switched (optionally, based on dedicated_hp_event_source) to
> > > count-indexed method of hotplug where we do attach of all LMBs one by one
> > > and then request the guest to hotplug all of them at once using count-indexed
> > > method.
> > > 
> > > So it will be a bit tricky to abort for index based case and recover
> > > correctly for count-indexed case.  
> > 
> > Looked at the code again and realized that though we started with
> > index based LMB addition, we later switched to count based addition. Then
> > we added support for count-indexed type subject to the presence
> > of dedidated hotplug event source while still retaining the support
> > for count based addition.
> > 
> > So presently we do attach of all LMBs one by one and then do onlining
> > (count based or count-indexed based) once. Hence error recovery
> > for both cases would be similar now. So I guess you should take care of
> > undoing pc_dimm_memory_plug() like Igor mentioned and also undo the
> > effects of partial successful attaches.
> > 
> 
> I've sent a v2 that adds rollback.

oh ok, somehow v2 didn't reach me at all and I saw the v2 in archives only
now. So just noting that my above replies were sent w/o being aware of v2 :)

> > > 
> > > Regards,
> > > Bharata.  
