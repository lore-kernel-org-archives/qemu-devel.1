Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF3AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 23:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F57C2137B
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 23:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0Y7HQy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F57C2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV1Ro-0004dn-A0
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 19:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jV1R5-0004DR-Br
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jV1R4-0008Pn-7j
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:20:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jV1R3-0008Nu-QZ
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:20:41 -0400
Received: by mail-wr1-x42a.google.com with SMTP id i10so16408996wrv.10
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XpvGMT7upoJDOribvjdfl2OGoIPu25JGBzss0Bk0xVU=;
 b=S0Y7HQy4BdLsSS9HJjxo5fCU28DMuHovNYGr93B4DHXpPXY62EOp26yzc43hrTUez6
 Qr5OsGEzCLvfFBCMQwhn7zynM3/DWEHB2q6/k1YZ2DIvCU51EOeqDWqsOLItYzrGMZvN
 UH9aOIib0T5Ak3KNicmZRd9DSEbA0rncl5N1OSE0cmPr/N5HwvQuTa9FloP83U7uHjTa
 Dei/2W2tWhu8226swPuRNaFBCqBV/mUHfQCmmsZVBvlKJ5B7lMEDawmHZYFWXP4TqNHn
 f57NDLitaxqFiMKsO5RcQAd/3Zh2dbn5MSuHY/8Pu1mqazxbTCpzbOJsNLayGtoMkjnF
 p14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XpvGMT7upoJDOribvjdfl2OGoIPu25JGBzss0Bk0xVU=;
 b=UOH2TIzc+UE+x6QoodS3J4tZ8FIs/EoBwljPUUTqywXtfu9AmV7FOsSIKrA6GZxhbo
 LeDRJ2N5LkMTIws7Dv+0D51Vt0DO4Rz4CZjLzDM1jNtkB+Vc7FtOJTqiA/aPdb1h6XZm
 xAKNcM4wRUSEnjIE4Eyl7N8k4fllpNol/d0Is+HbR9FzCIeOKV/qbiSRy7DDyrKUdOoJ
 Vje+zGdYhFGOb5BuROAWb9Zk10DqB4aQsJA6+R+1ncSou1bUczPkx7xnmloGMgzPk688
 s5dVmIOPoMe71TzTXBZwrRELHuIZIcjy95zFc2Lhc1Xdnp10hlKVVW1JWwwYm8Acemx4
 JRSw==
X-Gm-Message-State: AGi0PuY1L3lszc4z95/zKfNqprLmEAzUuZQf2Vbg2wcDJKskeZRK5ETP
 10Qv7Wh/lf2NupX6EPXVgmykH3YWpmWK885bmL0Y1vGGEDY=
X-Google-Smtp-Source: APiQypJreU6i0rnHyU1LezgDHRflNwuVHMRb01FLWCn3SFzlMBfpmJcxZLd35Fe2GTaoVT+JOW4wvdlAeGTGslRYJ1Q=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr11234078wrj.329.1588461639570; 
 Sat, 02 May 2020 16:20:39 -0700 (PDT)
MIME-Version: 1.0
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 3 May 2020 01:20:26 +0200
Message-ID: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
Subject: [INFO] Some preliminary performance data
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, craxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000c4178005a4b28ba7"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42a
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c4178005a4b28ba7
Content-Type: text/plain; charset="UTF-8"

Hi, all.

I just want to share with you some bits and pieces of data that I got while
doing some preliminary experimentation for the GSoC project "TCG Continuous
Benchmarking", that Ahmed Karaman, a student of the fourth final year of
Electical Engineering Faculty in Cairo, will execute.

*User Mode*

   * As expected, for any program dealing with any substantional
floating-point calculation, softfloat library will be the the heaviest CPU
cycles consumer.
   * We plan to examine the performance behaviour of non-FP programs
(integer arithmetic), or even non-numeric programs (sorting strings, for
example).

*System Mode*

   * I did profiling of booting several machines using a tool called
callgrind (a part of valgrind). The tool offers pletora of information,
however it looks it is little confused by usage of coroutines, and that
makes some of its reports look very illogical, or plain ugly. Still, it
seems valid data can be extracted from it. Without going into details, here
is what it says for one machine (bear in mind that results may vary to a
great extent between machines):
     ** The booting involved six threads, one for display handling, one for
emulations, and four more. The last four did almost nothing during boot,
just almost entire time siting idle, waiting for something. As far as
"Total Instruction Fetch Count" (this is the main measure used in
callgrind), they were distributed in proportion 1:3 between display thread
and emulation thread (the rest of threads were negligible) (but,
interestingly enough, for another machine that proportion was 1:20).
     ** The display thread is dominated by vga_update_display() function
(21.5% "self" time, and 51.6% "self + callees" time, called almost 40000
times). Other functions worth mentioning are
cpu_physical_memory_snapshot_get_dirty() and
memory_region_snapshot_get_dirty(), which are very small functions, but are
both invoked over 26 000 000 times, and contribute with over 20% of display
thread instruction fetch count together.
     ** Focusing now on emulation thread, "Total Instruction Fetch Counts"
were roughly distributed this way:
           - 15.7% is execution of GIT-ed code from translation block buffer
           - 39.9% is execution of helpers
           - 44.4% is code translation stage, including some coroutine
activities
        Top two among helpers:
          - helper_le_stl_memory()
          - helper_lookup_tb_ptr() (this one is invoked whopping 36 000 000
times)
        Single largest instruction consumer of code translation:
          - liveness_pass_1(), that constitutes 21.5% of the entire
"emulation thread" consumption, or, in other way, almost half of code
translation stage (that sits at 44.4%)

Please take all this with a little grain of salt, since these results are
just of preliminary nature.

I would like to use this opportunity to welcome Ahmed Karaman, a talented
young man from Egypt, into QEMU development community, that'll work on "TCG
Continuous Benchmarking" project this summer. Please do help them in his
first steps as our colleague. Best luck to Ahmed!

Thanks,
Aleksandar

--000000000000c4178005a4b28ba7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, all.<br><br><div>I just want to share with you some bi=
ts and pieces of data that I got while doing some preliminary experimentati=
on for the GSoC project &quot;TCG Continuous Benchmarking&quot;, that Ahmed=
 Karaman, a student of the fourth final year of Electical Engineering Facul=
ty in Cairo, will execute.</div><div><br></div><div><u>User Mode</u></div><=
div><br></div><div>=C2=A0=C2=A0 * As expected, for any program dealing with=
 any substantional floating-point calculation, softfloat library will be th=
e the heaviest CPU cycles consumer.</div><div>=C2=A0=C2=A0 * We plan to exa=
mine the performance behaviour of non-FP programs (integer arithmetic), or =
even non-numeric programs (sorting strings, for example).</div><div><br></d=
iv><div><div><u>System Mode</u></div></div><div><br></div><div>=C2=A0=C2=A0=
 * I did profiling of booting several machines using a tool called callgrin=
d (a part of valgrind). The tool offers pletora of information, however it =
looks it is little confused by usage of coroutines, and that makes some of =
its reports look very illogical, or plain ugly. Still, it seems valid data =
can be extracted from it. Without going into details, here is what it says =
for one machine (bear in mind that results may vary to a great extent betwe=
en machines):</div><div>=C2=A0=C2=A0=C2=A0=C2=A0 ** The booting involved si=
x threads, one for display handling, one for emulations, and four more. The=
 last four did almost nothing during boot, just almost entire time siting i=
dle, waiting for something. As far as &quot;Total Instruction Fetch Count&q=
uot; (this is the main measure used in callgrind), they were distributed in=
 proportion 1:3 between display thread and emulation thread (the rest of th=
reads were negligible) (but, interestingly enough, for another machine that=
 proportion was 1:20).</div><div>=C2=A0=C2=A0=C2=A0=C2=A0 ** The display th=
read is dominated by vga_update_display() function (21.5% &quot;self&quot; =
time, and 51.6% &quot;self + callees&quot; time, called almost 40000 times)=
. Other functions worth mentioning are cpu_physical_memory_snapshot_get_dir=
ty() and memory_region_snapshot_get_dirty(), which are very small functions=
, but are both invoked over 26 000 000 times, and contribute with over 20% =
of display thread instruction fetch count together.<br></div><div>=C2=A0=C2=
=A0=C2=A0=C2=A0 ** Focusing now on emulation thread, &quot;Total Instructio=
n Fetch Counts&quot; were roughly distributed this way:</div><div>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 15.7% is execution of=
 GIT-ed code from translation block buffer</div><div>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 39.9% is execution of helpers</di=
v><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 44.4%=
 is code translation stage, including some coroutine activities</div><div>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Top two among helpers:</div><div=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - helper_le_stl_mem=
ory()</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - he=
lper_lookup_tb_ptr() (this one is invoked whopping 36 000 000 times)</div><=
div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Single largest instruction c=
onsumer of code translation:</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - liveness_pass_1(), that constitutes 21.5% of the entir=
e &quot;emulation thread&quot; consumption, or, in other way, almost half o=
f code translation stage (that sits at 44.4%)</div><div><br></div><div>Plea=
se take all this with a little grain of salt, since these results are just =
of preliminary nature.</div><div><br></div><div>I would like to use this op=
portunity to welcome Ahmed Karaman, a talented young man from Egypt, into Q=
EMU development community, that&#39;ll work on &quot;TCG Continuous Benchma=
rking&quot; project this summer. Please do help them in his first steps as =
our colleague. Best luck to Ahmed!<br></div><div><br></div><div>Thanks,</di=
v><div>Aleksandar<br></div><div><br></div></div>

--000000000000c4178005a4b28ba7--

