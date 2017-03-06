Received: from eggs.gnu.org ([2001:4830:134:3::10]:42317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ckq8v-0006T7-1E
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ckq8q-0003gn-11
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:45:29 -0500
Received: from greensocs.com ([193.104.36.180]:48199)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ckq8p-0003gO-H7
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:45:23 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<058f0960-bc1b-fd44-9871-66d11d2e9b76@greensocs.com>
	<87pohuivtw.fsf@linaro.org>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <b2e0a31d-4804-f834-ce99-91fc8e54fc45@greensocs.com>
Date: Mon, 6 Mar 2017 11:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <87pohuivtw.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] MTTCG fixups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, bobby.prani@gmail.com

On 03/06/2017 10:43 AM, Alex Benn=C3=A9e wrote:
>=20
> Frederic Konrad <fred.konrad@greensocs.com> writes:
>=20
>> Hi All,
>>
>> I've a strangeness with the "drop iolock" patch.
>> It seems it has an impact on the MMIO execution patch-set I'm working
>> on:
>=20
> Hmm the only real change is the BQL (implicit or explict) being taken o=
n
> entry to the mmio functions.

Yes maybe it just trigger a bug more easily..

Fred

>=20
>> Basically modifying the memory tree is causing a Bad Ram Address error=
.
>> I wonder if this can't happen with hotplug/unplug model as well.
>=20
> Isn't this all done under an RCU? I don't think any of this should have
> changed for the MTTCG patch series.
>=20
>> I'll look into this.
>> Shoot if you have any evidence of why that doesn't work :).
>=20
> --enable-tcg-debug will turn on more lock checking (at a performance
>   hit). You could try that.
>=20
>>
>> Thanks,
>> Fred
>>
>> On 03/02/2017 08:53 PM, Alex Benn=C3=A9e wrote:
>>> Hi Peter,
>>>
>>> So perhaps predictably the merging of MTTCG has thrown up some issues
>>> during soft-freeze. The following patches fix up some of those:
>>>
>>> The following where in v1 and just have r-b tags:
>>>
>>>   vl/cpus: be smarter with icount and MTTCG
>>>   target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
>>>   cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
>>>
>>> The next change downgrades the asserts to tcg_debug_asserts. This wil=
l
>>> reduce the instances of production builds failing on non-MTTCG enable=
d
>>> guests. The races still need to be fixed but you now have to
>>> --enable-debug-tcg to go hunting for them:
>>>
>>>   translate: downgrade IRQ BQL asserts to tcg_debug_assert
>>>
>>> This never came up in my testing but it seems some guests can
>>> translate while doing a tlb_fill. The call to cpu_restore_state never
>>> worked before (as we are translating the block you are looking for)
>>> but by bugging out we avoid the double tb_lock().
>>>
>>>   translate-all: exit cpu_restore_state early if translating
>>>
>>> Then we have a bunch of fixes from the reports on the list. They are
>>> safe to merge but I'll leave that up to the maintainers. There may be
>>> an argument for holding these patches back until the guest is
>>> converted to be MTTCG aware and a full audit of the CPU<->HW emulatio=
n
>>> boundaries is done for each one:
>>>
>>>   sparc/sparc64: grab BQL before calling cpu_check_irqs
>>>   s390x/misc_helper.c: wrap IO instructions in BQL
>>>   target/xtensa: hold BQL for interrupt processing
>>>   target/mips/op_helper: hold BQL before calling cpu_mips_get_count
>>>
>>> Finally these are just tiny debug fixes while investigating the icoun=
t
>>> regression:
>>>
>>>   target/arm/helper: make it clear the EC field is also in hex
>>>   hw/intc/arm_gic: modernise the DPRINTF
>>>
>>> Going forward I think 1-5 are ready to be merged now. For 6-9 we
>>> should await decisions from the target maintainers. The last two are
>>> entirely up to you.
>>>
>>> It looks like the -icount regression is a poor interaction between
>>> icount timers and the BQL but this is going to require discussion wit=
h
>>> Paolo in the morning.
>>>
>>> Cheers,
>>>
>>>
>>> Alex Benn=C3=A9e (11):
>>>   vl/cpus: be smarter with icount and MTTCG
>>>   target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
>>>   cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
>>>   translate: downgrade IRQ BQL asserts to tcg_debug_assert
>>>   translate-all: exit cpu_restore_state early if translating
>>>   sparc/sparc64: grab BQL before calling cpu_check_irqs
>>>   s390x/misc_helper.c: wrap IO instructions in BQL
>>>   target/xtensa: hold BQL for interrupt processing
>>>   target/mips/op_helper: hold BQL before calling cpu_mips_get_count
>>>   target/arm/helper: make it clear the EC field is also in hex
>>>   hw/intc/arm_gic: modernise the DPRINTF
>>>
>>>  cpus.c                      | 11 +++++++----
>>>  hw/intc/arm_gic.c           | 13 +++++++++----
>>>  hw/sparc/sun4m.c            |  3 +++
>>>  hw/sparc64/sparc64.c        |  3 +++
>>>  target/arm/helper.c         |  2 +-
>>>  target/i386/cpu.h           |  3 +++
>>>  target/mips/op_helper.c     | 17 ++++++++++++++---
>>>  target/s390x/misc_helper.c  | 21 +++++++++++++++++++++
>>>  target/sparc/int64_helper.c |  3 +++
>>>  target/sparc/win_helper.c   | 11 +++++++++++
>>>  target/xtensa/helper.c      |  1 +
>>>  target/xtensa/op_helper.c   |  7 +++++++
>>>  translate-all.c             |  9 ++++++++-
>>>  translate-common.c          |  3 ++-
>>>  vl.c                        |  7 ++-----
>>>  15 files changed, 95 insertions(+), 19 deletions(-)
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
