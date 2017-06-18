Received: from eggs.gnu.org ([2001:4830:134:3::10]:55523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMerO-0005KA-IN
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 14:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMerN-0002yw-L8
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 14:23:42 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dMerN-0002wm-Dl
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 14:23:41 -0400
Received: by mail-wr0-x232.google.com with SMTP id 77so60891093wrb.1
	for <qemu-devel@nongnu.org>; Sun, 18 Jun 2017 11:23:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87efujbu0g.fsf@linaro.org>
References: <CAFEAcA8ZTj4YRdcnSdMw6fEizEKa-cJndZG+=WFkkMDKHX9mYw@mail.gmail.com>
	<87efujbu0g.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Jun 2017 19:23:19 +0100
Message-ID: <CAFEAcA_Dc4_vUPASjxmscxPUX2F0H=sE9pO5ygjch50RGGv6dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ARM v6 memory barrier cp15 ops still implemented
 as NOPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>

On 16 June 2017 at 20:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Hi; I just noticed that we seem to still implement the ARM v6
>> memory-barrier cp15 ops as NOPs:
>>
>>     { .name =3D "ISB", .cp =3D 15, .crn =3D 7, .crm =3D 5, .opc1 =3D 0, =
.opc2 =3D 4,
>>       .access =3D PL0_W, .type =3D ARM_CP_NO_RAW, .writefn =3D arm_cp_wr=
ite_ignore },
>>     { .name =3D "DSB", .cp =3D 15, .crn =3D 7, .crm =3D 10, .opc1 =3D 0,=
 .opc2 =3D 4,
>>       .access =3D PL0_W, .type =3D ARM_CP_NOP },
>>     { .name =3D "DMB", .cp =3D 15, .crn =3D 7, .crm =3D 10, .opc1 =3D 0,=
 .opc2 =3D 5,
>>       .access =3D PL0_W, .type =3D ARM_CP_NOP },
>>
>> Don't these need to do something more complicated with the
>> advent of MTTCG ?
>
> Yeah they should - what does ISB do that it needs a write handler?

The comment just above the ISB definition says:

    /* We need to break the TB after ISB to execute self-modifying code
     * correctly and also to take any pending interrupts immediately.
     * So use arm_cp_write_ignore() function instead of ARM_CP_NOP flag.
     */

thanks
-- PMM
