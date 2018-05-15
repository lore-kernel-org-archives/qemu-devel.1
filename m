Received: from eggs.gnu.org ([2001:4830:134:3::10]:37096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYg6-0001C5-LT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYg5-0001Be-D7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:03:38 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIYg5-0001B8-7f
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:03:37 -0400
Received: by mail-ot0-x244.google.com with SMTP id i5-v6so18126447otf.1
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 05:03:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgcrvemu.fsf@linaro.org>
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<87lgcrvemu.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 13:03:16 +0100
Message-ID: <CAFEAcA_3Rg-qhLRmg=TtakVtzOffKrdOKU8z=-=cGts4TTC2+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 10 May 2018 at 14:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:
>
>> The previous version:
>> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D33714
>>
>> Abdallah Bouassida (3):
>>   target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo
>>     type
>>   target/arm: Add "_S" suffix to the secure version of a sysreg
>>   target/arm: Add the XML dynamic generation
>>
>
> So I got a fixed up gdb and I was testing the reading of the virtual
> counter:
>
> =3D> 0xffffff800854a118 <arch_counter_get_cntvct+16>:     mrs     x0, cnt=
vct_el0
>    0xffffff800854a11c <arch_counter_get_cntvct+20>:     b       0xffffff8=
00854a148 <arch_counter_get_cntvct+64>
>    0xffffff800854a120 <arch_counter_get_cntvct+24>:     adrp    x0, 0xfff=
fff800896a000 <scsi_format_log+3568>
>    0xffffff800854a124 <arch_counter_get_cntvct+28>:     add     x0, x0, #=
0x5a0
>    0xffffff800854a128 <erratum_set_next_event_tval_virt+4294964112>:    m=
rs     x1, tpidr_el1
>
> p/x $x0
>  $6 =3D 0xffffff800854a108
> p/x $cntvct_el0
>  $7 =3D 0x0
> stepi
> 0xffffff800854a11c      160             return arch_timer_reg_read_stable=
(cntvct_el0);
> =3D> 0xffffff800854a11c <arch_counter_get_cntvct+20>:     b       0xfffff=
f800854a148 <arch_counter_get_cntvct+64>
>    0xffffff800854a120 <arch_counter_get_cntvct+24>:     adrp    x0, 0xfff=
fff800896a000 <scsi_format_log+3568>
>    0xffffff800854a124 <arch_counter_get_cntvct+28>:     add     x0, x0, #=
0x5a0
> p/x $x0
>   $8 =3D 0x7a5b32b
> p/x $cntvct_el0
>   $9 =3D 0x0
>
> So I'm wondering why there is a disparity here?

CNTVCT_EL0 isn't in the set of registers we expose to gdb (it's
marked up as ARM_CP_NO_RAW), so I'm not sure why gdb is
giving you any value at all. Does it do that for any
random $no_such_thing strings ? Is CNTVCT_EL0 listed
if you ask gdb to display all registers?

thanks
-- PMM
