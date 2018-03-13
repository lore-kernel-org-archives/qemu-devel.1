Received: from eggs.gnu.org ([2001:4830:134:3::10]:45037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evnLs-0008H6-1m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evnLq-0002ny-Ui
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:04:40 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:46344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evnLq-0002ni-QY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:04:38 -0400
Received: by mail-oi0-x234.google.com with SMTP id x12so266087oie.13
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 10:04:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520850690-23245-5-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1520850690-23245-5-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 17:04:17 +0000
Message-ID: <CAFEAcA8B-U-DNT2Bxe5CDLiH+B-qA=oje0Vsgb0XAdwR5uaLsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/4] target/arm: Add
 arm_gdb_set_sysreg() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 12 March 2018 at 10:31, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> This is a callback to set the cp-regs registered by the dynamic XML.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>>> Adding to that our customers may need this write access, our tool TRACE=
32=C2=AE
>>> needs this also in some particular cases. For example: temporary disabl=
ing MMU
>>> to do a physical memory access.
>
>> By clearing the SCTLR bit? That's a good example of a case that
>> won't work reliably. If you clear the SCTLR.M bit via raw_write
>> this will not perform the tlb_flush() that it needs to, which
>> means that if anything does a memory access via the QEMU TLB
>> it may get the wrong cached results. If you always clear the
>> bit, do one gdb memory access then set the bit then it will
>> probably not run into problems but you're walking on thin ice.
>
> Does adding tlb_flush() before or after write_raw_cp_reg()
> could solve the reliability issue for other particular cases?
> Or is there any improvement that could be done for this write
> callback in order to get more reliable results for other
> particular cases?

(We kind of discussed some of this on IRC, so this is just writing
that conversation down as I understand the situation. I think we
can get the first 3 patches in to shape to apply without having
to resolve the writing-registers part first, anyway.)

I think there's an underlying unaddressed design question here,
which is: what should the semantics of gdbstub writes to system
registers be, and how can we best implement that? At the moment
system registers have basically two access methods:
 * real guest reads and writes, which we open-code in the
   code-generation parts of translate.c and translate-a64.c.
   This includes access-permission checks that don't allow a
   guest running at a lower exception level to access higher EL
   registers, and is also the code path that uses the CPRegInfo
   accessfn, readfn and writefn functions if a register spec
   defines them.
 * "raw" reads and writes. These were designed for VM migration
   and for synchronization of state with the kernel when running
   under KVM. That means they're not expected to actually be
   changing the state of the CPU, and they just update the
   underlying CPU state data structure fields for the most part.

Neither of those is necessarily the right thing for a write from GDB.

We get away with using 'raw read' for reads from GDB because
generally that gives us the right value and if we do happen
to return a wrong value that's pretty harmless: it won't have
upset the state of QEMU. But raw writes are potentially dangerous
if we let the user make them. SCTLR.M is one example discussed
above. Another is if you allow the user to write SCR_EL3 directly
when the CPU isn't at EL3 then you might be allowing them to set
SCR_EL3.NS =3D=3D 0 with a PSTATE indicating EL2; QEMU will likely
assert() shortly after because that's not architecturally valid.

Using an equivalent of the "real guest write" path would at
least be a bit safer than a raw write, but I'm not sure that
"sorry, can't do a physical memory access because the CPU's
at EL0 and we can't write SCTLR" is the behaviour you want...

So my feeling is that to safely support guest sysreg writes
from the gdbstub we need to:
 * define what the semantics of doing that are (preferably
   by reference to something architectural, eg what you get
   if you try it via halting debug mode)
 * provide some way of getting those semantics, which is probably
   another function pointer in the regdef struct for a gdb write
 * go through the various regdefs and update them to be able
   to handle gdb writes (either by providing a function to do
   the job, or by being flagged as "raw write is ok for gdb
   write" or something. Will depend on the individual register.)

The really important part here is 1, I think. Part 3 will be
a bit tedious, but I don't think there is any way to avoid
it. There's no "works for all registers" shortcut.

thanks
-- PMM
