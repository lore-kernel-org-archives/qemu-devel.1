Received: from eggs.gnu.org ([2001:4830:134:3::10]:56634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHFMX-0004wo-Nf
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fHFMS-0002hk-Pj
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:14:01 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fHFMS-0002hP-Hv
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:13:56 -0400
Received: by mail-wr0-x233.google.com with SMTP id h5-v6so6567274wrm.4
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 14:13:56 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<87wowsk1ih.fsf@linaro.org>
	<8979b195-d1b0-de1f-7cad-864982108610@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8979b195-d1b0-de1f-7cad-864982108610@linaro.org>
Date: Fri, 11 May 2018 22:13:53 +0100
Message-ID: <87a7t5vqsu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/9] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/27/2018 10:22 AM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> When running the gcc testsuite with current aarch64-linux-user,
>>> the testsuite detects the presence of the fp16 extension and
>>> enables lots of extra tests for builtins.
>>>
>>> Quite a few of these new tests fail because we missed implementing
>>> some instructions.  We really should go back and verify that nothing
>>> else is missing from this (rather large) extension.
>>
>> So this set of instructions is generated from any ASL description that
>> contains "half":
>
> This still isn't all of them.  At least the insns from fmov_float_gen.htm=
l are
> missing.  The four insns could be handled with
>
> FMOV_H_general  A64_V sf:1 00 11110 11 100 11 o:1 000000 Rn:5 Rd:5
>
> Peter had pointed out that I didn't handle sf=3D1 in fmov during review.

It describes itself as:

   <docvars>
       <docvar key=3D"convert-type" value=3D"32-to-half" />
       <docvar key=3D"instr-class" value=3D"float" />
       <docvar key=3D"isa" value=3D"A64" />
       <docvar key=3D"mnemonic" value=3D"FMOV" />
   </docvars>

I found I had to make the --desc matching a lot more liberal to catch
stuff from the Aarch32 XML, so now:

22:11:47 [alex@zen:~/l/q/risu.git] add-asl-support-v2(+1/-1) + ./contrib/ar=
masl2risu.py --only-desc "half" xml/ISA_v83A_A64_xml_00bet6/*.xml | grep FM=
OV
FMOV_32H_float2int A64_V 0001111011100110000000 Rn:5  Rd:5
FMOV_H32_float2int A64_V 0001111011100111000000 Rn:5  Rd:5
FMOV_asimdimm_H_h A64_V 0 Q:1 00111100000 a:1  b:1  c:1 111111 d:1  e:1  f:=
1  g:1  h:1  Rd:5
FMOV_H64_float2int A64_V 1001111011100111000000 Rn:5  Rd:5
FMOV_64H_float2int A64_V 1001111011100110000000 Rn:5  Rd:5
FMOV_H_floatimm A64_V 00011110111 imm8:8 10000000 Rd:5
FMOV_H_floatdp1 A64_V 0001111011100000010000 Rn:5  Rd:5

Whereas I had:

22:11:58 [alex@zen:~/l/q/risu.git] add-asl-support-v2(+1/-1) + grep FMOV al=
l_v82_half.risu
FMOV_H_floatimm A64_V 00011110111 imm8:8 10000000 Rd:5
FMOV_H_floatdp1 A64_V 0001111011100000010000 Rn:5  Rd:5

I'll regenerate a set.

--
Alex Benn=C3=A9e
