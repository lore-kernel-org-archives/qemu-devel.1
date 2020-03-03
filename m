Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B984C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D65224673
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65224673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8wLJ-0002II-FA
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j8wKO-0001kY-NN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 20:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j8wKL-0004pc-76
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 20:26:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3180 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j8wKI-0004h0-Pf; Mon, 02 Mar 2020 20:26:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 80E4BCA58B47A1D97B61;
 Tue,  3 Mar 2020 09:26:21 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 09:26:13 +0800
Subject: Re: [PATCH v3 0/6] delay timer_new from init to realize to fix
 memleaks.
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <CAFEAcA9stgfbRGdn0x2q38vVS9NDyysW656+XkjfyVui3OXXQw@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <fe95df60-5a97-9c82-36a3-82847a38da59@huawei.com>
Date: Tue, 3 Mar 2020 09:26:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9stgfbRGdn0x2q38vVS9NDyysW656+XkjfyVui3OXXQw@mail.gmail.com>
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
Cc: Euler Robot <euler.robot@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/2/2020 9:21 PM, Peter Maydell wrote:
> On Thu, 27 Feb 2020 at 02:35, Pan Nengyuan <pannengyuan@huawei.com> wro=
te:
>>
>> This series delay timer_new from init into realize to avoid memleaks w=
hen we call 'device_list_properties'.
>> And do timer_free only in s390x_cpu_finalize because it's hotplugable.=
 However, It's not valid in mos6522
>> if we move timer_new from init to realize, because it's never called a=
t all. So we also add calls to mos6522_realize()
>> in mac_via_realize to make this move to be valid.
>>
>> v1:
>>    - Delay timer_new() from init() to realize() to fix memleaks.
>> v2:
>>    - Similarly to other cleanups, move timer_new into realize in targe=
t/s390x/cpu.c (Suggested by Philippe Mathieu-Daud=C3=A9).
>>    - Send these two patches as a series instead of send each as a sing=
le patch but with wrong subject in v1.
>> v3:
>>    - It's not valid in mos6522 if we move timer_new from init to reali=
ze, because it's never called at all.
>>      Thus, we remove null check in reset, and add calls to mos6522_rea=
lize() in mac_via_realize to make this move to be valid.
>>    - split patch by device to make it more clear.
>=20
> Hi; I've applied patches 2, 3, 4 and 6 to target-arm.next,
> since I think those ones are OK and they're all arm related.
>=20
> You've already got review comment for patch 1 (s390)
> and 5 (m68k mac_via/mos6522).

Fine, thanks.

>=20
> thanks
> -- PMM
>=20

