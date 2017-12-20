Received: from eggs.gnu.org ([2001:4830:134:3::10]:48665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1eRmvN-0000tZ-Ge
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1eRmvJ-0001mQ-G0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:33:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39584
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@au1.ibm.com>) id 1eRmvJ-0001lb-AI
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:33:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBKMTLHs006064
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 17:33:09 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eyw1xhu5m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 17:33:09 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <benh@au1.ibm.com>;
	Wed, 20 Dec 2017 22:33:07 -0000
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
Date: Thu, 21 Dec 2017 09:32:59 +1100
In-Reply-To: <20171218092024.21645-1-david@gibson.dropbear.id.au>
References: <20171218092024.21645-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1513809179.2743.20.camel@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr: Add optional capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, surajjs@au1.ibm.com, groug@kaod.org, lvivier@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, abologna@redhat.com, mdroth@linux.vnet.ibm.com

On Mon, 2017-12-18 at 20:20 +1100, David Gibson wrote:
> This series is a first draft to add the notion of optional
> capabilities to the "pseries" machine type.  A default set of
> capabilities is selected based on the machine type version and
> selected cpu model, but this can be overridden with machine
> parameters.
> 
> The purpose of this is to get rid of a number of places where we
> implicitly decide what features to advertise to the guest based on
> capabilities of the host.  This is bad, because it means it's
> difficult to be certain if machines started at different ends of a
> migration really match from the guest's point of view.
> 
> By giving the user explicit control of these optional features, then
> validating that the chosen ones can be supplied on the host we make
> behaviour more predictable.
> 
> The more specific motivation for this is that POWER9 has bugs in its
> hardware transactional memory (HTM) implementation making it unsafe to
> migrate POWER8 guests to POWER9 if they use HTM

It might be worthwhile mentioning that we do plan to support TM and
migration from P8 for KVM guests at some point. Working on it ... there
are some SW workarounds involved in KVM to make it possible.

> Changes since RFC:
>  - Two preliminary patches not really related split off and already
>    merged.
>  - Assorted minor fixes based on review notes
>  - Change defaults to disable HTM on pseries-2.12 machine type
> 
> David Gibson (6):
>   spapr: Capabilities infrastructure
>   spapr: Treat Hardware Transactional Memory (HTM) as an optional
>     capability
>   spapr: Validate capabilities on migration
>   target/ppc: Clean up probing of VMX, VSX and DFP availability on KVM
>   spapr: Handle VMX/VSX presence as an spapr capability flag
>   spapr: Handle Decimal Floating Point (DFP) as an optional capability
> 
>  hw/ppc/Makefile.objs   |   2 +-
>  hw/ppc/spapr.c         |  47 +++++--
>  hw/ppc/spapr_caps.c    | 342 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  46 +++++++
>  target/ppc/kvm.c       |  27 +---
>  target/ppc/kvm_ppc.h   |   2 -
>  6 files changed, 429 insertions(+), 37 deletions(-)
>  create mode 100644 hw/ppc/spapr_caps.c
> 
