Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8457DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B3C217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YWnJ4qSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B3C217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhJe-0000EP-8j
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izhGI-0008AJ-7B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izhGH-0004lJ-11
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:32:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:33579)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izhGG-0004bY-OR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580995914;
 bh=LDmZkNeL+vFN+Ws+NEav0ysm1pwtnlnuSEELSXeTa10=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=YWnJ4qSfhishWPlnPPYOMT29OEPZ8yY0CT+7hLKE0UNKLC/18N41WCuGLJc9VvEnG
 uDo8o9HlY/6IGMC5697phR0IzBGBYbXq4Mk4ZBiyv1hSR7OX2q35X2mIkinRtGjJWv
 oCuM+6u7rJhLE2D1n9mLsp2YsGIEL4agnCa0S2FI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGyxN-1inLCb1iy3-00E9P1; Thu, 06
 Feb 2020 14:31:54 +0100
Subject: Re: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-5-n54@gmx.com>
 <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
 <2ae4caf9-05fd-b740-2612-e1c1ecafe277@gmx.com>
 <87o8ubuapr.fsf@dusky.pond.sub.org>
 <CAP+75-VnwDz0My7p5Zy3SN2gPeACW0z02MUgrdFnSGiZm6xGXg@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <e87ac5e1-749e-84a2-2c9e-89ac1c69fcdc@gmx.com>
Date: Thu, 6 Feb 2020 14:31:08 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP+75-VnwDz0My7p5Zy3SN2gPeACW0z02MUgrdFnSGiZm6xGXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hxLv1CaDks79GXXnkn674FJEFnLuzf6sV1FS4/cUjdpkek1JTIn
 hl5b6Fl8PHYhI53pArpVxo1vZioXeKbzqUW0owVxJyEG5L1ZEVyNALrMsj+i3ch3yBzhUUI
 ub63mKqO3f9hQXKV9zZduTMzKOQd7gTKhRHX7xua1nCQIxG/mcgtMa0EpmVPUfDVyZZL0nD
 n6vUN4ueEWI6zTp2WM9xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8YLSPsZpDpI=:dfNRtqNLunkSZzUPVVwJC3
 wbCl2FVj3VMJrQ/cGlwawY1azfMEU0T+trKYsliN73uAxFqNbDF0obc5MTW81M9Visb1+48rq
 5SLd4mFEAcjawZxI1gxHH34MJxo8ZgPHnhciHa+JrHAAosialrL6ATvJ0TkvlBACy/8P5cYQH
 9NLKu2L1rpq+kJmOl9DtCOVEx9flcbR4ZRJUUQ/8vydMlxjgkMiAxJSIMsLb9BRkUTN4qEuxY
 cXSRCK+14axgZnFEWYRbeoPwpxAzrRbPyWc0aest8VqP3YzV2W96GvNcf5bwh2pmjk7pCT9Y1
 GlKPOL6OX1ttzcDT6rFRnbBUYH6vRAifF8nF6i83Mkhvg0nwh2m33QK7AGL+H5tR4IyyoMBqP
 pAdzNqJCd6zXwSWAihJ7H1+cnmYfjVbocZKbrkQpMdr56YqusIY+QL8LNv8z2oqLDQCK93Zic
 g/lj0NTTqxTw03TnujY25lSi0Ig3GnFS/IfEgZuHNE3h9alKIBPQ00IqdogqDy2TpF/B/Pxxl
 pITWuIQ9MXTOig9BXdM09SzzO4CR3Ogpne6TFF5VPiZSunQEYTkc0345IXdUE1TGweiO/BR51
 euUeesL3njgSplgLnBhYvONlKguoV1W+WREBGOkT9+Ke3ZibTbFRablj7SvGq1cOUAaUqR0ik
 Lpd/0YsQJAnx1N4znGittoyLWSHm4WGxRKaRtvKJ2zlIdsiBWl2kz9uOiin90PzzP89aFVNDK
 5lvvOpRtwNB0KUjX7VdwZAYzWv6GMkoZKmtGPwKWnaiyOso1sl1B8ofvOp4oR38ON1PwVyFhs
 PhbNc5fghx57g22gIc5XcLrdITtlGPMIeY1STmmw1AAgagBYuUCGl/63DhdVr6BI0viUcswom
 9UZxvqwRVUZH3pSNjZ1eMYdPahNtkouzkxQrdvJCAeKWCZ6iih6xK3dy/K45b8UMmXDb8VJ1T
 SzOa0rhINoVuvnoaoz2PKOMcI/sFJI2d/ub6XVcZk+KM7NOsoh8GqegV5WePTL9dv1soahap1
 nk2fiB0YyK59ZVyUS16QROQoUm6zmqMOttjKDZLUrwG+K7Vtddbmcz7Xu8pF86BtTUAhlEF9C
 mzm4UpiWYdnkjUlFrD50sNHyu7qbkrfHBpZZhcxFe4/U8pykql8I5R2ytzc3D0QSCC6a7QJKQ
 eqmfnNQ+jJNRgKlM6UutrKVqEPn3zN7xauyKltf+bc+fDGrG4oL9CPcJ/c0mpHalTHDg4=
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 max@m00nbsd.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.02.2020 14:09, Philippe Mathieu-Daud=C3=A9 wrote:
> On Thu, Feb 6, 2020 at 2:06 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>> Kamil Rytarowski <n54@gmx.com> writes:
>>
>>> On 03.02.2020 12:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> @@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *cp=
u)
>>>>>   #endif
>>>>>   }
>>>>>
>>>>> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
>>>>> +{
>>>>> +    char thread_name[VCPU_THREAD_NAME_SIZE];
>>>>> +
>>>>> +    cpu->thread =3D g_malloc0(sizeof(QemuThread));
>>>>> +    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
>>>>
>>>> Nitpick, we prefer g_new0().
>>>
>>> In this file other qemu_*_start_vcpu() use  g_malloc0().
>>>
>>> I will leave this part unchanged and defer tor future style fixups if
>>> someone is interested.
>>
>> Time to re-run Coccinelle with the semantic patch from commit
>> b45c03f585e.
>
> I thought about it, but then noticed it would be clever to modify
> checkpatch to refuse 'g_malloc0?(.*sizeof.*);'
>
>

As the patchset was reviewed, could we please merge it in the current
(v3) form (*) please?

Feel free to fixup the style after that as you like.

We plan to release NetBSD 9.0 in 1-2 weeks unless there will be a delay.

https://blog.netbsd.org/tnf/entry/second_final_release_candidate_for

(*) https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg01405.html

