Received: from eggs.gnu.org ([2001:4830:134:3::10]:42993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dJ2IH-0007JV-VL
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dJ2ID-0001In-Jh
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:36:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45297
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dJ2ID-0001Ie-DU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:36:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58IXiQm046444
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 14:36:24 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aybe7hhb9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 14:36:23 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 8 Jun 2017 15:36:22 -0300
References: <20170608172743.10132-1-lvivier@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 8 Jun 2017 15:35:58 -0300
MIME-Version: 1.0
In-Reply-To: <20170608172743.10132-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <b297a96d-171c-334d-9232-5172fac386d4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/2] spapr: disable
 hotplugging without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org



On 06/08/2017 02:27 PM, Laurent Vivier wrote:
> If the OS is not started, QEMU sends an event to the OS
> that is lost and cannot be recovered. An unplug is not
> able to restore QEMU in a coherent state.
> So, while the OS is not started, disable CPU and memory hotplug.
> We guess the OS is started if the CAS has been negotiated.
>
> This series also revert previous fix which was not really fixing
> the hotplug problem when the OS is not running.
>
> v2:
> - fix indent
> - remove useless local_err
> - allow hotplug if the VM is not started (pre-launch or incoming state)
> - remove vector 6, instead just mark the end of CAS negotiation
>
> Laurent Vivier (2):
>    spapr: disable hotplugging without OS
>    Revert "spapr: fix memory hot-unplugging"
>
>   hw/ppc/spapr.c             | 51 +++++++++++++++++++++++++++++++++++++++++++---
>   hw/ppc/spapr_drc.c         | 20 +++---------------
>   hw/ppc/spapr_hcall.c       |  1 +
>   include/hw/ppc/spapr.h     |  2 ++
>   include/hw/ppc/spapr_drc.h |  1 -
>   5 files changed, 54 insertions(+), 21 deletions(-)
>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>

This is curious. I was having a little look into hotplug/unplug and DRC 
states yesterday
while taking a look at the latest David's cleanup. I was trying to find 
out a way to tune
spapr_drc_needed() in a way that we don't accidentally migrate more DRCs 
than necessary
and at the same time handle that scenario of libvirt migration after 
hotplug (libvirt hotplugs
the device on target instead of adding it in the command line).

I would like to migrate the DRCs if and only if:

1 - a device was hotplugged
2 - a device is undergoing hotplug/unplug

(2) is easy and is already taken care of. But (1) is tricky because, 
before this patch, if a migration
occurs *before* CAS we don't need to migrate the DRC - the object will 
go through the state
changes after the migration. With this series this scenario is not going 
to happen, then
we can happily add a

if (dev->hotplugged) return true;

in spapr_drc_needed and fix the libvirt migration scenario again.



Daniel
