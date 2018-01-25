Received: from eggs.gnu.org ([2001:4830:134:3::10]:48916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeh8M-0002wu-PS
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeh8J-0008Di-N9
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:00:02 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eeh8J-0008Cv-Fo
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:59:59 -0500
Received: by mail-wm0-x229.google.com with SMTP id r78so14802655wme.0
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 04:59:59 -0800 (PST)
References: <CABLmASFzQz+=LD_RBn_PfPzY2JdMT71DM3F5jK9J=i2CmxOShQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CABLmASFzQz+=LD_RBn_PfPzY2JdMT71DM3F5jK9J=i2CmxOShQ@mail.gmail.com>
Date: Thu, 25 Jan 2018 12:59:56 +0000
Message-ID: <87a7x26qlv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


Howard Spoelstra <hsp.cat7@gmail.com> writes:

> Hi,
>
> I built qemu-system-ppc for OSX and Windows from
> https://github.com/stsquad/qemu/tree/softfloat-refactor-and-fp16-v3
> and noticed a considerable drop in floating point performance on both
> hosts.
> Running Mac OS 9.2 in OSX, using MacBench 3.0, the score for the
> floating point performance dropped from ~60 to ~42.
>
> Recent tcg optimisations had improved processor and floating point
> performance considerably, but that gain seems to be more than lost for
> the floating point performance.
>
> Any idea what is causing this?

Well we expected a little degradation but it's a bit more than I
expected.

Re-factor

12:32:18 [alex@zen:~/m/t/aarch64] master(+0/-0) =C2=B1 ~/lsrc/qemu/qemu.git=
/aarch64-linux-user/qemu-aarch64 ./vector-benchmark -b float64-add
float64-add         : test took 1743387 msec
                      67108864 ops, ~25978 nsec/kop
12:32:26 [alex@zen:~/m/t/aarch64] master(+0/-0) =C2=B1 ~/lsrc/qemu/qemu.git=
/aarch64-linux-user/qemu-aarch64 ./vector-benchmark -b float64-add
float64-add         : test took 1735526 msec
                      67108864 ops, ~25861 nsec/kop
12:32:32 [alex@zen:~/m/t/aarch64] master(+0/-0) =C2=B1 ~/lsrc/qemu/qemu.git=
/aarch64-linux-user/qemu-aarch64 ./vector-benchmark -b float64-add
float64-add         : test took 1742030 msec
                      67108864 ops, ~25958 nsec/kop

Original

12:32:35 [alex@zen:~/m/t/aarch64] master(+0/-0) =C2=B1 ~/lsrc/qemu/qemu-bui=
lddirs/arm-targets.build/aarch64-linux-user/qemu-aarch64 ./vector-benchmark=
 -b float64-add
float64-add         : test took 1255007 msec
                      67108864 ops, ~18701 nsec/kop
12:32:44 [alex@zen:~/m/t/aarch64] master(+0/-0) =C2=B1 ~/lsrc/qemu/qemu-bui=
lddirs/arm-targets.build/aarch64-linux-user/qemu-aarch64 ./vector-benchmark=
 -b float64-add
float64-add         : test took 1243866 msec
                      67108864 ops, ~18535 nsec/kop
12:32:46 [alex@zen:~/m/t/aarch64] master(+0/-0) =C2=B1 ~/lsrc/qemu/qemu-bui=
lddirs/arm-targets.build/aarch64-linux-user/qemu-aarch64 ./vector-benchmark=
 -b float64-add
float64-add         : test took 1278100 msec
                      67108864 ops, ~19045 nsec/kop

The main difference is all the code has a common path now and works on a
canonicalized representation of the floating point number rather than
direct bit-fiddling of the register representation. This is obviously
going to have some cost but it looks like we should spend a bit more
time seeing if we can claw some of that back.

That said any floating point on QEMU is going to be slow by the very
nature of the implementation. Because we don't translate guest<->host
instructions directly we will be several orders of magnitude slower for
floating point instructions compared to normal integer and bitwise
operations. If we want to bring on FPU performance we need to look at
how we can safely use host instructions to get the exact same results as
we currently do with softfloat.

I'm still keen on the re-factor as it does achieve the other goals of
improving readability of the code and making it much easier to reason
with. It also reduces the amount of effective copy and paste but with
slightly different constants which the old code had.

>
> Best regards,
> Howard


--
Alex Benn=C3=A9e
