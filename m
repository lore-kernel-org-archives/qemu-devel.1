Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D663C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFDD2074D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OERYO6U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFDD2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC8tD-0004UT-Gj
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 17:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1jC8pz-0003E6-DF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1jC8px-0000QS-F7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:24:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:43105)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1jC8pu-0000KM-Ku
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583961804;
 bh=OzxrCA8H13UDrZkDLuSwI1RvylmfvTgLhZltPfzrlbE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=OERYO6U4Fz9PRmYpliNcmPH3LHSXdn1BXoToxM18M12ygNBcdBi9/e8iVnUg7ZGV9
 MGvRL7nIyxYFsurDcGEU+MZHzigIgJRKWFyOTasyL2eK8wf6K3/hEe7vcVRFl+geHy
 EEQh1ISYmXQOH661fOfTK46sU062orEtdWYPSMK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.79.191.25]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ma24s-1irBdY2bWm-00VzYt; Wed, 11
 Mar 2020 22:23:24 +0100
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Maxime Villard <max@m00nbsd.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
 <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
 <CABgObfZjnFFV3hosrP+sf5d3KmPPGuFJZo-oY5=u340wtxLYGg@mail.gmail.com>
 <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
 <24fe7b93-8a34-e5d7-18b5-0f7607221ad3@redhat.com>
 <85e4202d-91dd-0d31-373a-febe566353ab@m00nbsd.net>
 <93e2e198-26ed-c8c7-b47e-977915156a17@redhat.com>
 <f48f9c36-5104-1346-cb91-d52c2887097b@m00nbsd.net>
 <050cacce-41fc-db89-ded9-5cdf6c20a2de@redhat.com>
 <cad16d05-13db-cb80-a049-84bb048def23@m00nbsd.net>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <0b81483b-65ab-0c6a-72ff-080da10fccc3@gmx.com>
Date: Wed, 11 Mar 2020 22:22:20 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cad16d05-13db-cb80-a049-84bb048def23@m00nbsd.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pkKIiuX1M2gLfE8r2/L3jWyTD8zTKHgz27CGfWYW0RD4TRHO96c
 DQAQNTFyJHbfr4AoTwro52LmyQoN6P7nJXjILXiEfC2XZUN+wjUHTek3eNU435bonJhhA6R
 ioUE1hSd4EFfRyS/EtINOVY5dn+k8srXAmvVW9FcDSwUOVPeUVup3H8IJtDCBk/Tn0K671T
 UatUZ6gL6CrZ85DdWb0Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ymEzBqR7t8=:kPFikKAgnK1xbIBJ7XufAx
 5Nt1V+LohL0AzkAO7zsC8fxJARA/qiB4qRx+noTysgAZq63Cl53tHWvE19YiNS7ellQrFNMNX
 HD7A/7/2MvRnl/otcp3TI8nQGs61q7pY0HWHJEv+UL4YEB2PLpVKmjbvQXPYqsndhhkjnOFnG
 DyuIYx0k5b6XvHNvNuaTrtZeZbMuSbgvgIM62002hOroD8w/RmaFWwCUuIk5cAh0EmKvx/2IP
 JoECPEX+NxXFwUBhpVwzv6v+ZGIF6DXI+oxhWvXibhhT5e1DYq9pxmSavHdJx14RUZ73kN3qC
 T2SIueZTtpzZQtpEzmXghsB3vH/wIxejeyxqFXQAbQkpaT5wmVlyKQq9mnwfKzK7h/XRPTCCA
 ZTG4CubWEXW5l5Jn2a1NF/+JFktd97LehcyFUCY6ZAHtFJqCUcidaW4juTfEqCnVq6gqNX8er
 AFvSfySmMA5Qa/annP+VopmQd7N8tYTq2ohb2YLY+hVbtLPZoUmf7cWm3MTLVrTBzJh4GCVfz
 abCcVQJ8W2Ezae5NErwdfhZaa9/H+3zlUPtbsjXss5Rbbc3cq4an9nicsur5/9LsUZErKLncs
 V55sNLyhAHl+RBtUexA1hVER8rgBMLVGrMpZPe7rTwWn5RsVS5eH2q+kU0Qq4psO2CQ3MJ+2/
 hV+U34P0o0ldVZr7YOTS7aWe6uc8FD8eOjzZeFgMEYd0AShWnaXvU8hTQRRr4DmhFyLYGFpYR
 we0VqgZJ+P0RGjTzQiOD9JjeihpgICOmnxUjdjTdDK28J9QlyiUB+69u0oDwyXD/ol/yf1NYQ
 l647WwLGo4FUBivyKwpT3wXWvKdV+mvQFTgLGjEj1CUIUC8hkkgq1Hp8+UBWNZXw140b53sJV
 zVZLTZp+kTBDO5BWgqeCa6nL15KfIOHyeCCRteN1V76i48h96Ic3TV+3oPMZjNCXorgMx+z9w
 APKLHXZJQvkabKoPyOjCe3YpFeZXvIkm4NtFLRH5Cg0ugHqdPzi9ikZs0xdfWU7MRJmwYXZ07
 vno55V5LtUk/6Yao0gLpddsD4q03UpVu7oo/ejzLbwIDbTUAnvDBwQk6JNu+403KzNoVp3N2s
 R4799+b7FCNFlEBfUK3WmCdnumH0vVg2oxvlmkys7kREOWKc+QXDbKKM+c7Mz21A1h9E17jEP
 RhNaYammlXNSA/a6E9c5GyIRVDCCpyLppbcXAYHZI6ymUvuS0DtRjUXSSEa5D+k9i8eL6u7sP
 e+L2KC0U7mQMu3tqyf2cDFQNz0uM909smKLvRly9dtbYlzbEWr/SbQSVozCg3sBddkVn/zfq1
 I+qmUgX9ojER2tOdP9jJCEelO+R03YBP79LOyyPBcQLk7qUOgDh/PN7gGwr0vLDPFR/3HyKu
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, jmcneill@invisible.ca, philmd@redhat.com,
 rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11.03.2020 22:21, Maxime Villard wrote:
> Le 11/03/2020 =C3=A0 21:42, Paolo Bonzini a =C3=A9crit=C2=A0:
>> On 11/03/20 21:14, Maxime Villard wrote:
>>>> The problem is that qcpu->stop is checked _before_ entering the
>>>> hypervisor and not after, so there is a small race window.
>>> Ok. I don't understand what's supposed to be the race here. If we get =
an
>>> IPI between the check and the call to nvmm_vcpu_run() then we'll just =
do
>>> one run and stop in the next iteration, because the IPI will have set
>>> qcpu->stop. Is this extra iteration undesired?
>>
>> Yes, you don't know how long that run would take.  I don't know about
>> NVMM but for KVM it may even never leave if the guest is in HLT state.
>
> Ok, I see, thanks.
>
> In NVMM the runs are short, the syscalls are fast, and pending signals
> cause returns to userland. Therefore, in practice, it's not a big proble=
m,
> because (1) the window is small and (2) if we have a miss it's not going
> to take long to come back to Qemu.
>
> I see a quick kernel change I can make to reduce 95% of the window
> already in the current state. The remaining 5% will need a new
> nvmm_vcpu_kick() function.
>
> For now this issue is unimportant and no Qemu change is required.
>
> Kamil, please also drop the XXX in
>     /* XXX Needed, otherwise infinite loop. */
> It's not a bug.
>

OK. I will do it.

> Thanks,
> Maxime
>


