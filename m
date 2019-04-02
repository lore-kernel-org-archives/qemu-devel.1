Received: from eggs.gnu.org ([209.51.188.92]:36409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBAW0-0000gU-0F
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 23:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBAVt-0000fs-BW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 23:55:10 -0400
Date: Tue, 2 Apr 2019 11:53:43 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190402035343.GA6527@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190313044253.31988-1-richardw.yang@linux.intel.com>
	<20190313044253.31988-4-richardw.yang@linux.intel.com>
	<20190313132300.3f56a5ca@redhat.com>
	<20190313133359.h2njohyijgvkcbtv@master>
	<20190313170943.5384f5cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313170943.5384f5cf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] hw/acpi: Extract build_mcfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org

On Wed, Mar 13, 2019 at 05:09:43PM +0100, Igor Mammedov wrote:
>On Wed, 13 Mar 2019 13:33:59 +0000
>Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> 
>> I am lost at this place.
>> 
>> sig is a part of ACPI table header, you mean the sig is not necessary to
>> be set in ACPI table header?
>> 
>> "skip table generation" means remove build_header() in build_mcfg()?
>I mean do not call build_mcfg() at all when you don't have to.
>
>And when you need to keep table_blob the same size (for old machines)
>using acpi_data_push() to reserve space instead of build_mcfg(sig="QEMU")
>might just work as well. it's still hack but it can live in x86 specific
>acpi_build() keeping build_mcfg() generic.
>
>As for defining what to use as criteria to decide when we need to keep
>table_blob size the same, I don't remember history of it, so I'd suggest
>to look at commit a1666142, study history of acpi_ram_update() and
>legacy_acpi_table_size to figure out since which machine type one doesn't
>have to keep table_blob size the same.
>

Hi, Igor

It took me sometime to go through the migration infrastructure.

Before continuing, I'd like to talk about what I understand to make sure my
direction is correct.

ACPI has a structure named AcpiBuildState, which contains all related
information. During migration, those data in AcpiBuildState should be
transferred to destination, e.g. table_mr, rsdp_mr and link_mr.

In the case related to mcfg, the problem lies in table_mr. And the reason
breaking migration is the size of table_mr is different between source and
destination.(This reason is a guess from those change logs and mails.)

The migration infrastructure has several SaveStateEntry to help migrate
different elements. The one with name "ram" take charge of RAMBlock. So this
SaveStateEntry and its ops is the next step for me to investigate. And from
this to see the effect of different size MemoryRegion during migration.

Is this sounds correct?

-- 
Wei Yang
Help you, Help me
