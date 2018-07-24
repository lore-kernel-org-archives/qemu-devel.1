Received: from eggs.gnu.org ([2001:4830:134:3::10]:54469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhzV7-00055b-8r
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhzV6-0000h4-BV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:45:25 -0400
References: <20180724153616.32352-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a69b9ba5-1973-0d37-0cb9-0de4e4f21a91@redhat.com>
Date: Tue, 24 Jul 2018 17:45:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180724153616.32352-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] hw/misc/tz-mpc: Zero the LUT on
 initialization, not just reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 24.07.2018 17:36, Peter Maydell wrote:
> In the tz-mpc device we allocate a data block for the LUT,
> which we then clear to zero in the device's reset method.
> This is conceptually fine, but unfortunately results in a
> valgrind complaint about use of uninitialized data on startup:
> 
> ==30906== Conditional jump or move depends on uninitialised value(s)
> ==30906==    at 0x503609: tz_mpc_translate (tz-mpc.c:439)
> ==30906==    by 0x3F3D90: address_space_translate_iommu (exec.c:511)
> ==30906==    by 0x3F3FF8: flatview_do_translate (exec.c:584)
> ==30906==    by 0x3F4292: flatview_translate (exec.c:644)
> ==30906==    by 0x3F2120: address_space_translate (memory.h:1962)
> ==30906==    by 0x3FB753: address_space_ldl_internal (memory_ldst.inc.c:36)
> ==30906==    by 0x3FB8A6: address_space_ldl (memory_ldst.inc.c:80)
> ==30906==    by 0x619037: ldl_phys (memory_ldst_phys.inc.h:25)
> ==30906==    by 0x61985D: arm_cpu_reset (cpu.c:255)
> ==30906==    by 0x98791B: cpu_reset (cpu.c:249)
> ==30906==    by 0x57FFDB: armv7m_reset (armv7m.c:265)
> ==30906==    by 0x7B1775: qemu_devices_reset (reset.c:69)
> 
> This is because of a reset ordering problem -- the TZ MPC
> resets after the CPU, but an M-profile CPU's reset function
> includes memory loads to get the initial PC and SP, which
> then go through an MPC that hasn't yet been reset.
> 
> The simplest fix for this is to zero the LUT when we
> initialize the data, which will result in the MPC's
> translate function giving the right answers for these
> early memory accesses.

Thanks, that fixes the issue, indeed:

Tested-by: Thomas Huth <thuth@redhat.com>
