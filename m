Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3DEC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF4E21655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCfIwrmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF4E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0voI-0006Rp-2g
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i0vmq-0005Zn-Kb
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i0vmp-00067X-Ab
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:42:32 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i0vmm-00066D-Dw; Thu, 22 Aug 2019 18:42:28 -0400
Received: by mail-lj1-x243.google.com with SMTP id l14so7042557ljj.9;
 Thu, 22 Aug 2019 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pWkhXZk0KKhhkWWI9QaiGFst0vqmbdagqtqVp2rp5C4=;
 b=mCfIwrmCURPq/cMacLsNsxrTCxvCkOxfwBuWJRAr+9w+rE0iv+SlogWm96GBuEqk+Q
 kg999OPgBQxvo+cfMlIO2EdUPgYm3VLCEUTAgL+e2N9i8QmpCWTnVW+ICeHabjKfwUUq
 u3yHWEsnVgBL+yX03gsS6XwLnhalGHx9yL9jAmrWaUb/+V8pN6dJzpVUMgqq3bo0tAvy
 GeriYiOPGD7/nUozDcz/wNA1Bfb8Tw9uTTcexG7Gmq0wkxl5s1kRZYC+x8e7rqUxAH08
 Aew/dgc90cvEk++S5I2FlGt5J1ZptVHEuVE//gn3mnYbOp7vLu2idq6DtOnw65MuVRPv
 Dewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pWkhXZk0KKhhkWWI9QaiGFst0vqmbdagqtqVp2rp5C4=;
 b=Sz9Okec2RoPiGXH0NnMZOugc2hWy7cdfSJFQHpLxsV/iEzzvVrD/sa4p607En8yHzh
 ABOgXi+APWxIdLkMeT4vwF19jYov4sQ6bfBUdL2kguZXWNVv2etF2hzZ51pV2rUBf+7j
 jpLJVhiIhiAYBI0LcvOoJMKwr0wCTVtcqgCh+lqH3CvMEOuxHO2XL3D9a8rBBB7FYkke
 9RkZnn0nbcAFwXq+yCxw9/2PA64iqsQoJUo79x8hnjFkXR8+Btw/UqghhPfhistUOxGA
 1IAqF7AL5tWlfi3OlvQTsIK8suCJqFm11eXmC+SFZnZ300Q4WQ3+f1BHDy0nY9Me+KSI
 z6ew==
X-Gm-Message-State: APjAAAVgM+wTKB29GPpgJ9ISDzj5w5vZVsENxiIcyvg64yX6eo4+FPy4
 W21wrB4J8P7FnmJf7dX0RI91M57mxmVTdxrVOR4=
X-Google-Smtp-Source: APXvYqwto8vjdd+neGRTSnds/0l9pgJazvqBmN1LhGufG2ajT4+THwjLar9qe0uTQfyLadGcK/L/2VYtaAqYYFtsSKY=
X-Received: by 2002:a2e:a202:: with SMTP id h2mr956870ljm.146.1566513747343;
 Thu, 22 Aug 2019 15:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <0141541d-43ff-98d8-e9d4-4a2fdcfdcf36@c-sky.com>
 <CAKmqyKPr0V6acB2-Y+N1-aoj-5LSofwi=Jz=u6KFJN1fPUWjzA@mail.gmail.com>
 <2b741fb0-0f12-0f07-a516-9cc23abc0b6e@c-sky.com>
 <CAEiOBXU1SbdgJdsn_Cvny4=7NTxE+XQPrQQn6NevBxwB8Wox5w@mail.gmail.com>
 <8e288bee-75ee-5bd6-e085-d1679d1d1a1b@c-sky.com>
In-Reply-To: <8e288bee-75ee-5bd6-e085-d1679d1d1a1b@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Aug 2019 15:38:22 -0700
Message-ID: <CAKmqyKOw-p=vGthSPwxKH9wOHTpv92gN8mPThM3ADGmp9zz=0Q@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [Qemu-riscv]  RISCV: when will the CLIC be ready?
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 8:38 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
> On 2019/8/20 =E4=B8=8A=E5=8D=8812:38, Chih-Min Chao wrote:
>
>
>
> On Mon, Aug 19, 2019 at 9:47 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>>
>>
>> On 2019/8/17 =E4=B8=8A=E5=8D=881:29, Alistair Francis wrote:
>> > On Thu, Aug 15, 2019 at 8:39 PM liuzhiwei<zhiwei_liu@c-sky.com>  wrote=
:
>> >> Hi, Palmer
>> >>
>> >> When Michael Clark still was the maintainer of RISCV QEMU, he wrote i=
n the mail list, "the CLIC interrupt controller is under testing,
>> >> and will be included in QEMU 3.1 or 3.2". It is pity that the CLIC is=
 not in
>> >> included even in QEMU 4.1.0.
>> > I see that there is a CLIC branch available here:
>> > https://github.com/riscv/riscv-qemu/pull/157
>> >
>> > It looks like all of the work is in a single commit
>> > (https://github.com/riscv/riscv-qemu/pull/157/commits/206d9ac339feb9ef=
2c325402a00f0f45f453d019)
>> > and that most of the other commits in the PR have already made it into
>> > master.
>> >
>> > Although the CLIC commit is very large it doesn't seem impossible to
>> > manually pull out the CLIC bits and apply it onto master.
>> >
>> > Do you know the state of the CLIC model? If it's working it shouldn't
>> > be too hard to rebase the work and get the code into mainline.
>> >
>> > Alistair
>> >
>> Hi,  Alistair
>>
>> In my opinion, the CLIC code almost works.
>>
>> Last year when my workmate ported an RTOS, I once read the CLIC specific=
ation and used the CLIC model code. It worked through  all the tests after =
fixed two bugs. I also had sent the patch to Michael, but without response(=
maybe a wrong email address).
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 7bf6cbc..95d80ab 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -505,6 +505,9 @@ static target_ulong riscv_intr_pc(CPURISCVState *env=
,
>>       if (!(async || clic)) {
>>           return tvec & ~0b11;
>>       }
>> +    if (clic) {
>> +        cause &=3D 0x3ff;
>> +    }
>>
>>       /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D re=
served */
>>       switch (mode1) {
>> @@ -645,6 +648,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>           riscv_cpu_set_mode(env, PRV_M);
>>       }
>>
>> +    if (clic) {
>> +        env->exccode =3D 0;
>> +    }
>>       /* NOTE: it is not necessary to yield load reservations here. It i=
s only
>>          necessary for an SC from "another hart" to cause a load reserva=
tion
>>          to be yielded. Refer to the memory consistency model section of=
 the
>>
>> After that, the specification has updated and the code may changed. I di=
dn't pull new code again.
>>
>> If the CLIC model may merged into the mainline, and no body maintain the=
 code, I'd like to work on it, fixing the bugs and updating the code accord=
ing to latest specification.
>>
>> Best Regards,
>> Zhiwei
>>
>> >> As we have cpus using CLIC, I have to use the out of tree qemu code i=
n SIFIVE
>> >> a long time. Could you tell me when it will be upstreamed?
>> >>
>> >> Best Regards
>> >> Zhiwei
>> >>
>>
>
> Hi Zhiwei,
>
> I think what Alistair point out is the latest clic version (or https://gi=
thub.com/riscv/riscv-qemu/tree/riscv-qemu-3.1).  The two versions, on pull =
request and 3.1 branch, should be similar.
>
> As far as I know, there is no concrete plan on CLIC patch in short term.
> It is good to know that the clic patch has been run with real RTOS.
> It is also great if you could update the implementation to latest spec an=
d send the patch again.
>
> chihmin
>
> Hi chihmin,
>
> Thanks for your reminding and approval. I will pull the latest clic versi=
on code and send the patch about two or three weeks later.

Great! I'm glad to see more contributions!

Alistair

>
> The RTOS is Rhino,  which is the kernel of AliOS-Things(https://github.co=
m/alibaba/AliOS-Things).
>
> It is also the kernel of YOC(https://cop.c-sky.com).
>
> Best Regards
> Zhiwei

