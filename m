Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1A920709
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Jf8CPaAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1A920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4dl3-0005NE-0C
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4di3-0004rZ-1z
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:17:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:49303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4di0-0002FJ-LK
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950232;
 bh=4jD/V2m2pH2VyyFYydmB5euLNonzOwJo6O81OT0U4pU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Jf8CPaAPVNj9wqRwrT5kiULqELpVrr9dM7X00q/kn1ypO86CYT2XU7wmQzVOjEOUc
 XlVznrW//2lilmQ5hYq3tY+iLN5ShpPSiZwQmEDntJMiUvVuZibsR9K/vaEYJMpO44
 E11G8OEyhJSAaEALkjekb7ZQ3WZi/5JmUzYi1u6k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.185.161]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1kBsxq2hiY-00S7Cq; Sun, 09
 Aug 2020 07:17:12 +0200
Subject: Re: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to avoid
 buffer over-run
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200804140056.7690-1-deller@gmx.de>
 <20200804140056.7690-8-deller@gmx.de>
 <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
 <20200804212019.GA876@ls3530.fritz.box>
 <20200804220145.yjq265pk363466hx@mozz.bu.edu>
 <20200805204459.GA23951@ls3530.fritz.box>
 <20200806154556.ksb2ja3hghxhukdd@mozz.bu.edu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <01f10f58-1b29-d7f9-e4d5-6092d69aa127@gmx.de>
Date: Sun, 9 Aug 2020 07:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200806154556.ksb2ja3hghxhukdd@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fkzGEhK2zK73z09ZPkQIqtYa89qIylOViujxDG78G/285S9uimr
 NuhopEsseCGIlZvgPA7b3LXwKty/vK9GBEGK5d2Vx5tX37u2ewTBz1gu7dFgIhEQz1xzx/N
 vxZIqCPmp74bz7wGDr6u5EWZrbPGJsAEqdMsuATZ578NI2GPGGSygYffJRzEjO29VeqWToA
 J/yJUlR/IgHMi9n6xEb6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tpmZORe76UQ=:6XOSQhc+6G+oa74tJztUQ+
 jl2lzKzcFjUv5T/p3zSFVt6hXRokQMNC2edLxWyOVIKyMWJLBHxhVxqGvKuZrabDz48zmCBfR
 HqgRoJQbubU8RxSKmKr9j6NQRfn7wfmkwgfyvZ88CwM/4zaQJaxNGYhSiFrrHEkDpIohLd2Er
 XoaYKWIxxyVaXX3MyWICpOWiYQcmGsg/z5Mymaxr9IK+Z3pqAaCn/46GRwMHMS8OxS1eT8QIT
 QBPlnoPRr9R++Oe3VtT5hfiEyYOngLoam6SUYsDQ1JHJ5MEpcRcUEN+Da7tuODMfGOcnVTkge
 dt5IaIsjDBp8CUsNDlXrEnsl4PNpTJQj9+EON6UQ7/Fmj5WZqJl61REoDtMjbzUIIpRPWklNm
 o0aZjw4FmIotElCL5bQkKYuEAF8pRUX4/XPwnXRqHAMS4adSIzQUIR+sdkTyi4sX/7nh9wGnw
 MyFNTE9j3bjPD5mD9EPF3wxP5qeGw3edd4yMuRJOUcWHxAc6xKDZV4Y/jRmRVAAOaq74cb1W0
 5reFpuCXr3W3NS3pOWty8SyVe7Ksv2xUI5rz3YaFnp7PQK1b41YSm8tHdiBVAQ3nR8Js9rCei
 mV9yVFlsc4+UsD/klGXFiGZYU66sYfaLsYdi9FMwF29XUT1kQtvSb/Yx8w8/shJt2KGDjZ73r
 MvK9/RCJNAT+yZB1/QdGg+mZ9VXh/Jrvvxike0s97X/dJv798MX/5SBApNj15vzhVBZLpREIz
 DT6/27UI13fjFA5W4jfkGvc+qwouT+UwZPsPLXa5Rw+Bn5p7IcvzvrOzjcvGgJZ4EeSccKiEH
 vXrAt/5Wb1FLZoscm3gkSC3ZWVMxNQyUU+PMnwjLz35aOMKwlBOF2fbJcqMlTKCnF/ePP8DV5
 nGnRW0brHmII3nnC11tR/EIFa54VrUsZeJ5433pLjN+36UsgLNxoFXOtzXko/E5kBSiYXEWU8
 XyGntFlNSUi6ZTaHQEKnPp8IUicqVLz4SYoibhS3SjQTaTiXeV4gDrPC/Nw+xjT8n2GavxgEP
 GZP3k/sS2w6g3QSTHiky9Q4gW3o6MntpEY/DClrLKe960h2pSE8Q2rmbSNbCqyXqLZABcymP+
 rn75yaaoEg74Tl37guOkh/yN/QEJudlUjE8G5GPMznC0oIsZJVcSjA1J9f3sKlkeogx4AbFPv
 x4/QHFz5Qd3I7ifZtaKgU7WUkAFqxA8+BWV4chWtVAM65YhL2lmr0g1kZHbiJ1hJzGvz6TI6E
 gvh7QhDQcwFPco/5U
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:17:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Alexander,

On 06.08.20 17:46, Alexander Bulekov wrote:
> On 200805 2244, Helge Deller wrote:
>> * Alexander Bulekov <alxndr@bu.edu>:
>>> On 200804 2320, Helge Deller wrote:
>>>> * Alexander Bulekov <alxndr@bu.edu>:
>>>>> I applied this series and it fixes most of the problems I saw before=
.
>>>>> I still see a few crashes - I made issues for them on launchpad:
>>>>> https://bugs.launchpad.net/qemu/+bug/1890310
>>>>> https://bugs.launchpad.net/qemu/+bug/1890311
>>>>> https://bugs.launchpad.net/qemu/+bug/1890312
>>> Hi Helge, I can still reproduce this one  ^^^
>>> I'll fuzz it some more, but so far I am not finding anything else.
>>
>> I've now updated the patch which does address all issues you found
>> so far. It's attached below.
>>
> I pulled from your repo, but I can still reproduce LP1890312
> (I build with --enable-sanitizers). Maybe I am missing something? With
> this cleared up, I'm happy to leave an Acked-by for the artist patches
> in this series.
>
> git show --summary
> commit 1657a7a95adc15552138c2b4d310a06128093892 (HEAD, hppa/target-hppa,=
 target-hppa)
> Author: Helge Deller <deller@gmx.de>
> Date:   Tue Aug 4 15:35:38 2020 +0200

The current tree at
https://github.com/hdeller/qemu-hppa/commits/target-hppa
does survive all your tests and in addition fixes an artist bug which
made the dtwm window manager rendering wrong on HP-UX.
Please completely revert your tree before pulling again.
I'll send out a complete patch series shortly.

Thanks!
Helge

