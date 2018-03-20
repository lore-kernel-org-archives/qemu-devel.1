Received: from eggs.gnu.org ([2001:4830:134:3::10]:53012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.qin@linux.intel.com>) id 1eyBxy-0006bK-Ir
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.qin@linux.intel.com>) id 1eyBxv-00040T-Gb
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:45:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:25571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.qin@linux.intel.com>)
	id 1eyBxv-0003wP-6j
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:45:51 -0400
References: <1521450289-5005-1-git-send-email-chao.qin@linux.intel.com>
	<20180319170525.1016391d@igors-macbook-pro.local>
	<c7354c76-afb6-e6f2-a0ca-86b6077228ea@linux.intel.com>
	<20180320081226.66d4b92e@redhat.com>
From: "Qin, Chao" <chao.qin@linux.intel.com>
Message-ID: <05e0dd7c-6e0a-d126-cdc5-e0989bf9bdf6@linux.intel.com>
Date: Tue, 20 Mar 2018 15:45:45 +0800
MIME-Version: 1.0
In-Reply-To: <20180320081226.66d4b92e@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hax: Properly handle IA32_APIC_BASE MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, yu.ning@linux.intel.com, Qin Chao <chao.qin@intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 3/20/2018 3:12 PM, Igor Mammedov wrote:
> On Tue, 20 Mar 2018 13:29:24 +0800 "Qin, Chao"  > <chao.qin@linux.intel.com> wrote: > >> On 3/20/2018 12:05 AM, Igor 
Mammedov wrote: >>> On Mon, 19 Mar 2018 17:04:49 +0800 
chao.qin@linux.intel.com >>> wrote: > >> From: Qin Chao 
<chao.qin@intel.com> > / something horribly wrong with mail client used 
for reply / >
Very sorry for the wrong reply style.

>>> @@  >> -933,6 +944,9 @@ static int hax_set_msrs(CPUArchState *env) >> >> 
hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->fmask); >> >> 
hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE, >> >> 
env->kernelgsbase); #endif + hax_msr_entry_set(&msrs[n++], >> >> 
MSR_IA32_APICBASE, \ + >> >> 
cpu_get_apic_base(x86_env_get_cpu(env)->apic_state)); + md.nr_msr = >> 
 >> n; md.done = 0; > Does it work for you if you drop everything >> 
except of this chunk? Yes, it works just with this chunk. > Could you 
send v2 dropping unnecessary chunks pls? (provided that > Paolo would 
drop queued v1).
I think you may missed the clarification for the codes that syncing
IA32_APIC_BASE MSR from HAXM to QEMU due to rhe wrong reply style.
Sorry again for the inconvenience. Please refer to the following.

Yes, the BSP is hard-coded in QEMU. But other bits, not just BSP flag, are
alse needed to sync from HAXM, such as x2APIC mode flag (bit 10) and
APIC enable/disable flag (bit 11). As in the Google Zircon
(https://github.com/fuchsia-mirror/zircon/blob/master/kernel/arch/x86/lapic.cpp#L157),
it will change IA32_APIC_BASE[10] and the the bit to 1 if x2APIC enabled.
Although x2APIC mode is not supported yet for TCG mode, it's worthy to
keep the codes that syncing IA32_APIC_BASE from HAXM to QEMU and
if x2APIC mode is supported fro TCG in future, there is no any effort needed
to make HAXM to work with this mode. Alos, in KVM it synced the 
IA32_APIC_BASE
MSR to QEMU at every VM-Exit.
