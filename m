Received: from eggs.gnu.org ([2001:4830:134:3::10]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evK8j-00038u-Uz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evK8e-0004Ss-4E
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:53:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evK8d-0004Rl-VM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:53:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CF02406802D
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:53:03 +0000 (UTC)
References: <20180312094308.21716-1-pbonzini@redhat.com>
	<68ce30df-0acd-d50e-5af4-0ca23e3a6ca5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3bd96555-ac06-f66a-6c0f-a84c3987c9ca@redhat.com>
Date: Mon, 12 Mar 2018 10:53:01 +0100
MIME-Version: 1.0
In-Reply-To: <68ce30df-0acd-d50e-5af4-0ca23e3a6ca5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/i386: make IOMMUs configurable via
 default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 12/03/2018 10:48, Thomas Huth wrote:
>> +obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o
>> +obj-$(CONFIG_AMD_IOMMU) += x86-iommu.o amd_iommu.o
> The linker likely does not care if x86-iommu.o is included twice

The linker actually cares, but rules.mak drops the duplicate:

    commit e2a99ad3e174ab4c9d2320dcecd779230409829f
    Author: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
    Date:   Thu Aug 25 09:18:52 2011 +0100

    build: sort objects to remove duplicates for link

    Avoid duplicate object files during the link.  There are legitimate
    cases where a link command-line would include duplicate object files
    because two independent subsystems both depend on common
    infrastructure.

    Use GNU make's $(sort) function to remove duplicate object files
    from the link command-line.

    Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
    Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

> , but wouldn't it be clearer to use this instead:
> 
> obj-$(call lor,$(CONFIG_VTD),$(CONFIG_AMD_IOMMU)) += x86-iommu.o

Possibly, but it doesn't scale too well when we add a third IOMMU.  The
right solution would be something like "select" in Kconfig.  Let me know
what you prefer for x86-iommu.c between obj-y and specifying the file
twice, and I'll do it.

Paolo
