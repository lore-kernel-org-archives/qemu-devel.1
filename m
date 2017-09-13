Received: from eggs.gnu.org ([2001:4830:134:3::10]:35694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ds8XP-0004pT-Gw
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ds8XJ-0003cU-DL
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:11 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:9928)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ds8XJ-0003WN-6R
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:05 -0400
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
	<CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <0c3db1e3-1638-cfbe-8c97-0d1aa87547b0@imgtec.com>
Date: Wed, 13 Sep 2017 15:20:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergey Smolov <smolov@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 13/09/2017 12:01, Peter Maydell wrote:
> On 13 September 2017 at 08:29, Sergey Smolov <smolov@ispras.ru> wrote:
>> -d options are a bit high-level for me, because I just see the execution
>> result for every instruction. So it will be a mistake to think that every
>> change of some register's value is just a new value writing.
>>
>> As I understand, at "translate time" QEMU creates a TCG model that can be
>> run as x86 code on the host machine. May be it is possible to find some
>> mapping in this model between x86 and MIPS registers? Having such a mapping,
>> one can detect that some value has been written in a x86 register that
>> conforms to some GPR MIPS register. Am I right?
> 
> No. The process of code generation does not care about
> having consistent mapping between MIPS registers and
> x86 registers -- all it does is ensure that architecturally
> the right values are in the guest-visible registers when
> they are visible to the guest.
> 
> As I say, we may some day have a tracing API that allows you
> to look at things at the level of detail that you want;
> for now -d is the best we have.
> 
> thanks
> -- PMM
> 


(Especially while implementing new instructions), I tended to add couple of
helper functions for tracing temporally.

op_helper.c:
void helper_trace_reg_access(CPUMIPSState *env, target_ulong val)
{
    printf("reg = "TARGET_FMT_lx"\n", val);
}

helper.h:
DEF_HELPER_2(trace_reg_access, void, env, tl)

After this you could use the helper function where you want to trace the
register value.
For your case, you can add following line after the tcg_gen_mov_tl().
gen_helper_trace_reg_access(cpu_env, cpu_gpr[rs]);

You will get the printf every time the part of code is being executed
(which might be too often).

Regards,
Yongbok
