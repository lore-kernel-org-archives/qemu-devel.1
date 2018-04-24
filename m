Received: from eggs.gnu.org ([2001:4830:134:3::10]:58887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fAxLF-0002yx-PE
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fAxLB-0002Mp-TH
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:46:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fAxLB-0002MQ-Nw
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:46:37 -0400
References: <152406338081.5947.5696498314762417499@sif>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6bb9731f-013d-018d-0b6e-c6dc55570f1f@redhat.com>
Date: Tue, 24 Apr 2018 14:46:27 +0200
MIME-Version: 1.0
In-Reply-To: <152406338081.5947.5696498314762417499@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.12.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>

Hi Peter,

On 04/18/18 16:56, Michael Roth wrote:
> A note from the maintainer:
> 
>   Barring any reports of showstopper bugs, the plan is to release
>   2.12.0 with no further changes on Tuesday 24th April.

I just noticed two QAPI bugs introduced in 2.12, in the following two
commits:

(1) ca230ff33f89 ("qmp: add architecture specific cpu data for
query-cpus-fast", 2018-02-26)

This commit added @arch to @CpuInfoFast, but it failed to set the new
field to CPU_INFO_ARCH_OTHER in qmp_query_cpus_fast(), when TARGET_S390X
is not defined.

(2) 25fa194b7b11 ("RISC-V Build Infrastructure", 2018-03-07)

This commit added the @riscv enum constant to @CpuInfoArch (used in both
@CpuInfo and @CpuInfoFast -- the return types of the @query-cpus and
@query-cpus-fast commands, respectively), and assigned, in both return
structures, the @CpuInfoRISCV sub-structure to the new enum value.

However, qmp_query_cpus_fast() does not populate the sub-structure, when
TARGET_RISCV is defined; only qmp_query_cpus() does.

The fixes don't look complicated. Do you want to hold the release while
I post the fixes?

I don't think these bugs are "show stoppers". On the other hand, QAPI is
an external interface.

Thanks
Laszlo
