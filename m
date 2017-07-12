Received: from eggs.gnu.org ([2001:4830:134:3::10]:36566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dVI0c-0000DS-Q9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dVI0X-0004ZZ-On
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:48:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53124
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dVI0X-0004ZU-Il
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:48:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CDiUS8133540
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:48:48 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj63w4f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:48:48 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 10:48:46 -0300
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 10:48:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170712055317.26225-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <8b7aefb2-66e3-bc2b-ce13-11b130c85ce4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv2 0/8] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com, groug@kaod.org
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com

The dreaded Libvirt hotplug-migrate-hotunplug scenario is working nicely.

device_add when the machine is in RUN_STATE_PRELAUNCH (-S) still doesn't
work but it is expected - as discussed in "[RFC drcVI PATCH] spapr:=20
reset DRCs
on migration pre_load=E2=80=8B", this scenario can't be fixed solely by t=
his DRC=20
cleanup.

Given that we'll review the DT code sometime in the future I guess we can
postpone the fix for device_adding in pre-launch for that time.


Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>

On 07/12/2017 02:53 AM, David Gibson wrote:
> This sixth set of DRC cleanup patches is a complete rework of DRC
> state management.  We stop tracking some unnecessary things, and
> change the basic state representation to a simpler and more robust
> model.
>
> Many of the patches in this set "break" migration from earlier git
> snapshots, but not from any released qemu version.  The previous
> migration stream format had multiple problems, so better to fix them
> now, before 2.10 is out.
>
> Although there are certainly more things that can be improved in the
> DRC system, with this series we should have a solid foundation for
> migrating DRCs - the state trasferred is about as minimal and well
> defined as it's possible to be.
>
> Changes since v1:
>    * Rebased onto current tree
>    * Added cleanup to unplug path
>    * Added restriction of DR-indicator to physical DRCs
>    * Included revised version of Laurent's patch to correctly handle
>      things "hot" plugged before incoming migration
>
> David Gibson (7):
>    spapr: Remove 'awaiting_allocation' DRC flag
>    spapr: Simplify unplug path
>    spapr: Refactor spapr_drc_detach()
>    spapr: Cleanups relating to DRC awaiting_release field
>    spapr: Consolidate DRC state variables
>    spapr: Remove sPAPRConfigureConnectorState sub-structure
>    spapr: Implement DR-indicator for physical DRCs only
>
> Laurent Vivier (1):
>    spapr: Treat devices added before inbound migration as coldplugged
>
>   hw/ppc/spapr.c             |  89 +++-------
>   hw/ppc/spapr_drc.c         | 399 ++++++++++++++++++++++++------------=
---------
>   hw/ppc/spapr_pci.c         |  17 +-
>   hw/ppc/trace-events        |   3 +-
>   include/hw/ppc/spapr_drc.h |  74 ++++++---
>   5 files changed, 301 insertions(+), 281 deletions(-)
>
