Received: from eggs.gnu.org ([2001:4830:134:3::10]:48333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIsLs-0004Pk-C1
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIsLn-0004pE-A2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:04:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIsLn-0004ok-0J
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:03:59 -0400
Received: by mail-wr0-x241.google.com with SMTP id p4-v6so45802wrh.3
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 02:03:58 -0700 (PDT)
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<87lgcrvemu.fsf@linaro.org>
	<CAFEAcA_3Rg-qhLRmg=TtakVtzOffKrdOKU8z=-=cGts4TTC2+A@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_3Rg-qhLRmg=TtakVtzOffKrdOKU8z=-=cGts4TTC2+A@mail.gmail.com>
Date: Wed, 16 May 2018 10:03:56 +0100
Message-ID: <87y3gkdlab.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/3] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 10 May 2018 at 14:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>
>> Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:
>>
>>> The previous version:
>>> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D33714
>>>
>>> Abdallah Bouassida (3):
>>>   target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo
>>>     type
>>>   target/arm: Add "_S" suffix to the secure version of a sysreg
>>>   target/arm: Add the XML dynamic generation
>>>
>>
>> So I got a fixed up gdb and I was testing the reading of the virtual
>> counter:
>>
>> =3D> 0xffffff800854a118 <arch_counter_get_cntvct+16>:     mrs     x0, cn=
tvct_el0
>>    0xffffff800854a11c <arch_counter_get_cntvct+20>:     b       0xffffff=
800854a148 <arch_counter_get_cntvct+64>
>>    0xffffff800854a120 <arch_counter_get_cntvct+24>:     adrp    x0, 0xff=
ffff800896a000 <scsi_format_log+3568>
>>    0xffffff800854a124 <arch_counter_get_cntvct+28>:     add     x0, x0, =
#0x5a0
>>    0xffffff800854a128 <erratum_set_next_event_tval_virt+4294964112>:    =
mrs     x1, tpidr_el1
>>
>> p/x $x0
>>  $6 =3D 0xffffff800854a108
>> p/x $cntvct_el0
>>  $7 =3D 0x0
>> stepi
>> 0xffffff800854a11c      160             return arch_timer_reg_read_stabl=
e(cntvct_el0);
>> =3D> 0xffffff800854a11c <arch_counter_get_cntvct+20>:     b       0xffff=
ff800854a148 <arch_counter_get_cntvct+64>
>>    0xffffff800854a120 <arch_counter_get_cntvct+24>:     adrp    x0, 0xff=
ffff800896a000 <scsi_format_log+3568>
>>    0xffffff800854a124 <arch_counter_get_cntvct+28>:     add     x0, x0, =
#0x5a0
>> p/x $x0
>>   $8 =3D 0x7a5b32b
>> p/x $cntvct_el0
>>   $9 =3D 0x0
>>
>> So I'm wondering why there is a disparity here?
>
> CNTVCT_EL0 isn't in the set of registers we expose to gdb (it's
> marked up as ARM_CP_NO_RAW), so I'm not sure why gdb is
> giving you any value at all. Does it do that for any
> random $no_such_thing strings ?

*sigh* yes....

> Is CNTVCT_EL0 listed
> if you ask gdb to display all registers?

I must have gotten confused parsing:

  CNTVOFF_EL2    0x0                 0
  CNTHP_CTL_EL2  0x0                 0
  CNTHP_CVAL_EL2 0x0                 0
  CNTHCTL_EL2    0x3                 3
  CNTV_CTL_EL0   0x0                 0
  CNTP_CVAL_EL0  0x13e39b327         5338936103
  CNTV_CVAL_EL0  0x0                 0
  CNTPS_CTL_EL1  0x0                 0
  CNTPS_CVAL_EL1 0x0                 0
  CNTP_CTL_EL0   0x1                 1

And of course case matters:

  (gdb) p/x $CNTP_CVAL_EL0
  $2 =3D 0x13e39b327
  (gdb) p/x $cntp_cval_el0
  $3 =3D 0x0

And gdb completion is broken so:

  p/x $CN<tab>
  completes to:
  p/x $CNTKCTL_EL1

So finally I tried another set of registers while tracing the early
bootcode:

  (gdb) p/x $SP_EL0
  $3 =3D 0x0
  (gdb) x/10i $pc
  =3D> 0xffffff8008900290 <__primary_switched+16>:  msr     sp_el0, x5
     0xffffff8008900294 <__primary_switched+20>:  adrp    x8, 0xffffff80080=
82000 <vectors>
     0xffffff8008900298 <__primary_switched+24>:  add     x8, x8, #0x0
     0xffffff800890029c <__primary_switched+28>:  msr     vbar_el1, x8
     0xffffff80089002a0 <__primary_switched+32>:  isb
     0xffffff80089002a4 <__primary_switched+36>:  stp     xzr, x30, [sp, #-=
16]!
     0xffffff80089002a8 <__primary_switched+40>:  mov     x29, sp
     0xffffff80089002ac <__primary_switched+44>:  adrp    x5, 0xffffff80089=
4f000 <tmp_cmdline.52085+2008>
     0xffffff80089002b0 <__primary_switched+48>:  str     x21, [x5, #280]
     0xffffff80089002b4 <__primary_switched+52>:  adrp    x4, 0xffffff80086=
b6000 <kimage_vaddr>
  (gdb) p/x $x5
  $4 =3D 0xffffff8008980780
  (gdb) i
  413             adr_l   x8, vectors                     // load VBAR_EL1 =
with virtual
  =3D> 0xffffff8008900294 <__primary_switched+20>:  adrp    x8, 0xffffff800=
8082000 <vectors>
     0xffffff8008900298 <__primary_switched+24>:  add     x8, x8, #0x0
     0xffffff800890029c <__primary_switched+28>:  msr     vbar_el1, x8
  (gdb) p/x $SP_EL0
  $5 =3D 0xffffff8008980780
  (gdb) p/x $VBAR
  $6 =3D 0x0
  (gdb) i
  0xffffff8008900298      413             adr_l   x8, vectors              =
       // load VBAR_EL1 with virtual
  =3D> 0xffffff8008900298 <__primary_switched+24>:  add     x8, x8, #0x0
     0xffffff800890029c <__primary_switched+28>:  msr     vbar_el1, x8
     0xffffff80089002a0 <__primary_switched+32>:  isb
  (gdb) i
  414             msr     vbar_el1, x8                    // vector table a=
ddress
  =3D> 0xffffff800890029c <__primary_switched+28>:  msr     vbar_el1, x8
     0xffffff80089002a0 <__primary_switched+32>:  isb
     0xffffff80089002a4 <__primary_switched+36>:  stp     xzr, x30, [sp, #-=
16]!
  (gdb) p/x $x8
  $7 =3D 0xffffff8008082000
  (gdb) p/x $VBAR
  $8 =3D 0x0
  (gdb) i
  415             isb
  =3D> 0xffffff80089002a0 <__primary_switched+32>:  isb
     0xffffff80089002a4 <__primary_switched+36>:  stp     xzr, x30, [sp, #-=
16]!
     0xffffff80089002a8 <__primary_switched+40>:  mov     x29, sp
  (gdb) p/x $VBAR
  $9 =3D 0xffffff8008082000
  (gdb)

So finally:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
