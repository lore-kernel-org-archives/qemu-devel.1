Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E70C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C756D2082E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C756D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVmb-0007zB-Ta
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1izVlQ-0007Wl-Q2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1izVlP-00007x-9K
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:15:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2696 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1izVlO-0008RE-BU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:15:26 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5584C60521CBB73F985F;
 Thu,  6 Feb 2020 09:15:20 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 6 Feb 2020
 09:15:09 +0800
Subject: Re: [PATCH 0/3] delay timer_new to avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <peter.maydell@linaro.org>
References: <20200205070659.22488-1-pannengyuan@huawei.com>
 <ef35a825-b1c8-84cf-a72a-3c4877b5ad98@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <f21be513-ed77-8a9d-f033-ad22c940c382@huawei.com>
Date: Thu, 6 Feb 2020 09:14:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ef35a825-b1c8-84cf-a72a-3c4877b5ad98@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/5/2020 9:16 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/5/20 8:06 AM, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> This series delay timer_new into realize() to fix some memleaks when w=
e call 'device-list-properties'.
>>
>> Pan Nengyuan (3):
>> =C2=A0=C2=A0 armv7m_systick: delay timer_new to avoid memleaks
>> =C2=A0=C2=A0 stm32f2xx_timer: delay timer_new to avoid memleaks
>> =C2=A0=C2=A0 stellaris: delay timer_new to avoid memleaks
>>
>> =C2=A0 hw/arm/stellaris.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 7 ++++++-
>> =C2=A0 hw/timer/armv7m_systick.c=C2=A0 | 6 ++++++
>> =C2=A0 hw/timer/stm32f2xx_timer.c | 5 +++++
>> =C2=A0 3 files changed, 17 insertions(+), 1 deletion(-)
>=20
> You might want to look at Coccinelle [*] and write a spatch script to c=
heck/fix all the codebase at once. You can find some examples in scripts/=
coccinelle/.

Thanks for these tips. I will pay attention.

>=20
> [*] http://coccinelle.lip6.fr/
>=20

