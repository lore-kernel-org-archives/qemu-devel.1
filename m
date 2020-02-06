Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C944C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5812A206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JEm7L9gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5812A206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izePn-00006o-BV
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izeLs-0006wb-1g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izeLq-0003Ct-Vc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:25:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:58215)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izeLq-00032W-Hy
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580984729;
 bh=V9cUI2tAoA2DScxeQlHiJTtZnBLQOwCztW33xLfEdGw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=JEm7L9glSmIWgeQW5f+B+0PuUC/CIBJeBTLZE8j24KFRKEUJSQh2csBvqnXTfAPZ4
 nJXVkzW9Goz6MImkzRbTBT4fcYXh1gwSkSQbQIghgF9i5hW3GMozBqKAwk0BKXI/Mf
 EptzGlXG1On/FqHFKKc8fyrAhMFn3QkipNPG7fBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHGCo-1imQwL234y-00DK1i; Thu, 06
 Feb 2020 11:25:29 +0100
Subject: Re: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-5-n54@gmx.com>
 <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <2ae4caf9-05fd-b740-2612-e1c1ecafe277@gmx.com>
Date: Thu, 6 Feb 2020 11:24:44 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WPD7SLd7BtFFf8rhSQQ0VIg1jCKsWOI0xQn4Wlfoa74gcXpjLcd
 GpTYtCiPGHrWD6z7xrkemFHbNUHRl6nlTobWJ+hpQ4hm55SJYJN4bwhJuop+p5h6lOlLmXU
 78jiSLKmvpL+v2kvJ4nI0ylPGNNF1Cj4aYWN80Fmu1JmjYP8aUs9pXHPqtxQL0X9OcGKoll
 4B8VN9Q6q9FF76o13F/HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E5AtRDc/BMM=:c5InVWHALYuDIqqZtspnj4
 /iQzZkQJtDYTx7iKswBM5ifQCyqlMia0xj0xKJaTDXSDzsXMkWH3SmPyqN/zkKaQqZtMC4SKJ
 A40r5S/pzH9IBpg3X4+KQk2vObglDTjeneaW4WUEHPIl+xgwm2ghySK2ATZLon3pGfHhoNQDF
 vLx2Y5SLH8eDPIyASrou9153dSXYPEgHQsOoKwHrWtK8bh5ujena3CG0Es8CCLsK/3b4MyI71
 EwDnuCPAUcrbm2RinrjYBiAa0FYeTSPZetwjwJDHou1jJ2rEo1CmbaABj24squzk3oyqU938Z
 0E6VmEJQ4mtm8McopUotO0GXH6e2ezPLSo94WHc4gIjRsfdTRv5HEOha5nTiC+R9CIjPdIQWj
 rPliT2SMgwIt2WRRyRGr3Jh5npRsXvhkpwTvjRrblRIcoImvjnWleEm5DeHje4KilCkw0RM5a
 KTap5UBhib53KMf3LI7tWesnjp7YTAKrODIywnUzyYYGX1X4RF7p2wDIrwkelby5VEjFqTp24
 8WWlRsZZ6RBLWLmybSkcgNn8dWAe4VAj7Kw63wPZqFSN5KBUV2ibVXGAMVZWUTaPP6HcISUPA
 qEYQjcj1etf/VYKruGx70xOtS+/WV+g9ixNJdCNzBaE9SFgZaptNZOKXk4HqA6i6aQ+Z89wWw
 TjbswvPfRB7Il4LbOg8fiQDZRyS8PEaaU2dBlFPLWXN3IIsqZuPUxwp/tRdoJFCIRW0vL8fEz
 bDyzgdxF9ncQIIRDzTRiPoZDen6w6MDM5uXLe2GIijexfxDmxqIZKSsIGP9Ed5VYwCSJDBMcz
 c9gXeMgGD5seKHE4P0wdJg+VhIrOZet0GxS0Wx+2l7Ixpn4lX1gCFT5ilZ4qNPWUwoajZN9Lo
 5DLlc2nfxdfPEyO8XfnvDomHArj372wjYVYO5LnLG5OUbDIeQDHc9bhS+FFy7/AlCJ1gdIDtC
 ov6vYc+nxoiH9bLoW8pe3YNQxU1+CdoskzBON1fuGEBQ36FUaa39asTcZ92IbzWkojR1qEom0
 d2mvcwbYazDNzKmmh2Bo8wwBFz2hh1K/K8nQnrMEhp1yLAY9IpfnPETL5U9Mb//wYRRzsdL41
 Wg9zFWJqJYkSHR7PRHHUEPDMTaQQ841YYl/5wl5m55iDunfDyMKUIe0Ml/TQ4dt3IvM9jLgVP
 puTOOFLkpuy8RgrmBt5ZIWF4yQmkhkJkXSR93rysriNz77sB8kxZWm5abfo9EZiROSgwY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.02.2020 12:54, Philippe Mathieu-Daud=C3=A9 wrote:
>> @@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
>> =C2=A0 #endif
>> =C2=A0 }
>>
>> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0 char thread_name[VCPU_THREAD_NAME_SIZE];
>> +
>> +=C2=A0=C2=A0=C2=A0 cpu->thread =3D g_malloc0(sizeof(QemuThread));
>> +=C2=A0=C2=A0=C2=A0 cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
>
> Nitpick, we prefer g_new0().

In this file other qemu_*_start_vcpu() use  g_malloc0().

I will leave this part unchanged and defer tor future style fixups if
someone is interested.

