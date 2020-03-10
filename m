Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0EC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E878222D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gWB6iqUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E878222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBc0i-0006BB-FU
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1jBbwi-0004cN-3r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1jBbwh-00026c-23
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:17:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:55065)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1jBbwg-0001yH-LI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583835400;
 bh=5IWOH5hYUMoiZGMY0ojyFdt65FL4Vuk3hLa68m32lqk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=gWB6iqUBRc8/BSHNM5n16GlRosQyoV99JRaNc6FDb7qjPtHCJPS9ZEvJDzuBpDu+d
 8V2zE3uFVR4Eo1IQMAKWKfnJGq7R3ouMlYEeS/gsjf6urHCgcQ1oYKVdxsmMKajpB5
 VKFci9nBfMmN+dfWDdp3/CNbXBGWRfHAQIZc1+10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.79.191.25]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ygO-1jENtZ39bK-006ADY; Tue, 10
 Mar 2020 11:16:39 +0100
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Maxime Villard <max@m00nbsd.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
 <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
 <ca1210a3-2ea5-3862-c4fa-bdcd5624fe29@m00nbsd.net>
 <CABgObfZjnFFV3hosrP+sf5d3KmPPGuFJZo-oY5=u340wtxLYGg@mail.gmail.com>
 <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 mQINBFVwUF8BEADHmOg7PFLIcSDdMx5HNDYr8MY2ExGfUTrKwPndbt3peaa5lHsK+UGoPG48
 KiWkhEaMmjaXHFa7XgVpJHhFmNoJXfPgjI/sOKTMCPQ5DEHEHTibC4mta7IBAk+rmnaOF0k8
 bxHfP8Qbls66wvicrAfTRXn/1ReeNc3NP4Sq39PoVHkfQTlnQiD4eAqBdq61B7DhzjhbKAZ4
 RsNtLfB6eOv9qvmblUzs50ChYewM9hvn+c7MdDH+x2UXoSDhkBDkKcJGkX91evos8s9AuoEd
 D32X5e+bmdUGe8Cr3cAZJ8IEXR6F9828/kxzPliMsCWVRx1Fr28baCJOUGgFPNr3ips78m9+
 Iw8PdQ101jU0dvucDFxw/1SCGYEZzV+O/237oRPuLCiDX5nhQoxf6dn9ukQleLBMNy2BLI4H
 g342NhF21HLA+KlyLOHaMKQCKzlal+zVNZTRTCh/ikMhsxWQjBfnqTDbMj85DnWwtump27SI
 qhPjUnS0a6MKoS/A+hbi64k5zztkvloELfCSrX7NyBTT0jgF2IGFIxZMrKCtQ9StcGMCV9MX
 tjcBy6fj7QMontEaIDRJEMjg8UIGw1B687OhalOv1ISia4xOWvpYAM6ipgqh6tBQmFzasL9P
 h1RtcVdFpFbhwVlr1Bly8c25gBNQHL5GUjLMn45LlQz50OzrkwARAQABtCdLYW1pbCBSeXRh
 cm93c2tpIChOZXRCU0QpIDxuNTRAZ214LmNvbT6JAjwEEwEIACYCGyMHCwkIBwMCAQYVCAIJ
 CgsEFgIDAQIeAQIXgAUCVbKGFwIZAQAKCRBLswjpsC52bIVpD/9i8npieI91xMIVvAHIUMeo
 cQO0IrNb+b/PuTj2qNemdwU7dhVJ7tVU5O1H2hI2M4rHGzjzDTxYzdxka0+A8CVEuvFdf6sF
 lXlXF0wM7rC6MoaB0QLAKxkZB5OtCILxLx7Bl2Y4cTPMU9v+qSL6yrdmhxogkufa4d6O9Zl/
 FCWO2kH/BphKOiDtbyvdo2WULSLWP2IXN+0rCpNL4wbTfYLgV9JtMf8f0naGsdy7BFuDWsIE
 vtHh8dkQZP7dz6Qy67kx8negZaehSEgXwiae0HwQIn3xTQrFmBDALDsCgXuLWPTvglSkqTak
 uG+8X5fyTy0cU10TNKsU+rFBO+/xsUoIQOGrARwfWOIfJNPelzh/qigSnyNQNH8u5vFRPg9n
 fqB/AcvvAvtOYOo8EN9Ofx11gNj397NXc5HBQTrX6k5GNAeBWE3Ng1uO6scIwAS7qGnqGezU
 ABmQKLN37gmJiiGwhQAnSE6HILLBC5Z2b0S2rQsPKg8WgUmPa1YIcDkDtNB/LJcDsdU4Fm+r
 U2ksKU7tGD2ZfBt8H2nqfPKKeB+Uv/TBigjRvx/m70vjhqVxwCZA9Fqr9vkQkZroNfqP+3dp
 Z5V5fjmxO5abE2+IikSvFagwMtgx56i8Yrr2BzE8P5/S4cKq1kgyQoF+lVGDKRkUKCv1i4Fo
 aftnSxN8jTFZDbkCDQRVcFBfARAAutbzb8wAHGL5FPPWKErQ3Bsrp9RDTVqRzp7kBMOtd/14
 MrOsWWyiml4XnvBYsJuhZWomFoeulcOXAPoTJ2vTw6erWYtdOiZymfQ3GMWpxzgkOVeNjsFF
 9AQ38FCMKmIDs9dgn+KXSIXlZA34khKLd163SN5U/KHfYlnnocec31u+7rVa1hlF5DBSSpoi
 s8cs41foBYC5NsB/i+yqGIlfzHy7pC2u5kyQCuJotLH4y0rT5X+YBC7z7cqKChtILNDGw0ht
 qps29fwOGBE/FWmu8CbpSHj8pvg7uUyQcKbZbNChBfWtOJKdjnNs5VHf2ec95SwYmWl6Xz66
 G892HY4ODtvl05/kh0qtdJd2oI4gJBsBx/N1585/3JYN4k78GIHTnML3xJydRRs9wwM3AXf/
 iDGrMyY7qHQVXJLdO5nPe7LHg48vryCMkBnTMw5iNFPVCu5w1BaZyHxuS2HvpsgUtQoBa2QE
 P1jYNI+2qgoiIG4VQDhYtrD0WJaYdi/C2UVDxRy07dt73SV3RQ7ijOiUrz4g3/deFKY16/1k
 sE+N5Sc5Tjt84ChjO3nJRbHrQxd6dCOElR70e3R2yAuSB4m7LJpO20IB9CtWhlF/0AtfL91W
 O8GGGqLWB0Z04hmwRs/l8T4WWIlykLshbunWN6jsP1Y27FeilTZ+Pc9mYOEUFfEAEQEAAYkC
 HwQYAQgACQUCVXBQXwIbDAAKCRBLswjpsC52bPayD/9jE8mdNudrudSxbDB2vf8pU8r5flCq
 vIkfOdpZGV/Wx/Zx+HFHHp+b2aNBGSNyFTnph1Ku9bvg06vD0o+b7SdA1vrBgRG41t0OCIyf
 vejz65Xpin2EtCllcBM8zUCxHo43blON8fNw70P1Ec0loBp4TAal1MiXbB8kxRTRcEPVO9YF
 9NPsFxycoWl0ZSvu4ESrQlrjRbVv+W0Fy/XqcQwEtDziFQHQXNRbTy8INPD49CsB7BkKRK+f
 1vMmw7SxfsyEhyCgo9ZWfHb/+w9T5h+UhF87L/m287z7W+s4aCAPBzjbIWhtngGJJwIgiWdI
 I9J6YJLcHLvVZLw7xzA/flcjc0VfzOgJOJw3hBukHnEz7/CKgnABwyNu52P+PQbxVTiTjMKm
 06eV732u9ZLD9ZgEazfmyGDHzsuzoXwsRnmcnbwYYAiynS+vfGl5oMtMa5qzsPhlzuvRlXHm
 zr8VjF8c9RThvyZyyHtWYAqNmBecMvM0whigjMeoAMJ5LtpyZgxjbHj1XnVdNBZgfJkOzsc/
 twffi7RYphRx0d9z5UZ1Yl5Rvl05vTaJ7YhhNC7xuE8yGOQmDUsPDwWqO/eXUDErJjCOBR5b
 0yILqRPYNT0Fj/th9gtEbZy1Gp0TVBkZM3tfjDRu43Pn6iSKObO/j0rNuq1LwN/EMxDifeZO
 4XSbcg==
Message-ID: <b5933e42-dc91-008f-6220-ec515afbbea2@gmx.com>
Date: Tue, 10 Mar 2020 11:15:40 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a646f01d-fcf5-5984-d7ea-ccbb9a20ce2b@m00nbsd.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/drBLkbgL9tOudSepPOZ54AQYKiKN6XUqlXWD9SvTN18F2tnGhl
 E3pJE/ibEiCcrRGjsxtnRDTauGe/uKfOXJNi5/eIX/m1Y6EwSG3hea+DNylBIT7F6k05u9B
 JYP5/jez/+p4uucWhcMmq0qNUmffve5+XgpHkDCV5AwyKTa6d+rDn4MGS4h9gKb3Ke+B+cd
 pCdZhbJ1umniD2UmrLlMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iH8datTGZ18=:H7+gX1pVhRFPkaS11K9qdf
 FZ0jUjKnSqWneYlRLgp/UaYRjZzqBXLqjeYrm8sHu2nqMUbbEruL5jnnRA4Mg9a7uY40LC4Nu
 O5IQXRlWjmrj0I2vnFdCZLZfnt2Anm0hyzq9vTwJ98N0vTZrWxnFpi2rXl6kR7qPlU0KgWmGH
 qY4T5hm+2Xkv88mXjQyIBqrBU7XZMoSz078driRKLhtYs17ELfmdPnMYG4fuRYJLmnrUIA5JH
 kZ7mNAy6Bxxz4bP3xAioIaPhtJCZh+KUR1sVDb0UdTB3c7gf/DIAr+W2p9rdDHPpcdWi1RYSw
 Hd27FwmBTaiRM2louTtcbkNNXAPVsA5zjTPDpBkv4XQr1u7KgD7gjKZJYlzdIo2iiHGmhuBOe
 4BjA1ybw08XKK4KKLo/UIFQsos3E3gBP8gekh+HpAMTgDAWs02lcQBuRsub60/781sEy3XU/D
 x32qJBeQ+g/J8YH/n0H6Plv9WXJz3S9ktHQpT4MiJR6vilaZFCM1PjXZMXy/GdlggleNSWdQS
 pgYBlE+clxSvBhpSwb4c5SzpKKOh2zJQCvK/tP/VAd/THTrmGLe2WJCuoZ3YLc//Xi7OS3wPk
 E/zHkUcfAg08SDazC/VnKzs2ur5tnyt/BundbQRlXcPZqjwVOX5jBxyvqyNNLHyEoKCO4H/tA
 pO/c0i906txKMgec54aTiGRsku9d35VlBdHsvWw28vR0CmuNDUfk3dr2efQWkvhlD/N2fQy5I
 tK2Mfe8xQOECFalKEw9z026GjywFkI8G82G/U8PeHQ9xTqX6IM5unpLwF/1LuGAXROtvV5blA
 ddkT5sXbhZupgpS/3WsOT3BVnDheS5s4XRi7QkOO7JaRTW7ahdPKksT6iu6F7Y4oNlQLhR954
 L7ZQRVzZ9+ZMzMceVuMLl79N3DaSuM8kWijVajdPCv6KowboJpaoJ/VnPfKwcfJoxPEBMCkGE
 qCuryrST589O86M/Cc/gesyAVccjZGC1Ip7gi/tb4/i5hqvjJuOpsmQWn3+CmY1peAPUoal0r
 mMK2MCrBaAn7AE1ULNEAQguBuO9s9+nLAgyWNNYla+WTVScw6R6FNfGf/R1YAph2nW2+mmrXK
 qAklBGP62aglYG0OEIv22TSJ5+e1s0mIZU+aubSmk53mUDZ9EsXXu0cYqM2Pzwf+t8AJPuQzU
 0RJ9QECIj7V+cVXIEjw5H6nQxtnhpEUB3o5STfiAsgEzRlAoIclzM1cUdVsoI62EDU6iw=
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, jmcneill@invisible.ca, philmd@redhat.com,
 rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.03.2020 07:45, Maxime Villard wrote:
> Le 02/03/2020 =C3=A0 20:35, Paolo Bonzini a =C3=A9crit=C2=A0:
>>
>>
>> Il lun 2 mar 2020, 20:28 Maxime Villard <max@m00nbsd.net <mailto:max@m0=
0nbsd.net>> ha scritto:
>>
>>
>>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nvmm_vcpu_pre_run(cpu);
>>     >> +
>>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (atomic_read(&cpu->exit_request)=
) {
>>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cpu_kick_self();
>>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>     >> +
>>     >
>>     > This is racy without something like KVM's immediate_exit mechanis=
m.
>>     > This should be fixed in NVMM.
>>
>>     I don't immediately see how this is racy.
>>
>>
>> You can get an IPI signal immediately after reading cpu->exit_request.
>>
>>     It reproduces the existing
>>     logic found in whpx-all.c, and if there is a real problem it can be
>>     fixed in a future commit along with WHPX.
>>
>>
>> It's buggy there too and it has to be fixed in the hypervisor so it can=
't be done at the same time I'm both. KVM does it right by having a flag (=
"immediate_exit") that is set by the signal handler and checked by the hyp=
ervisor.
>>
>> An earlier version of KVM instead atomically unblocked the signal while=
 executing the guest, and then ate it with a sigwaitinfo after exiting bac=
k to userspace.
>>
>> You don't have to fix it immediately, but adding a FIXME would be a goo=
d idea.
>>
>> Paolo
>
> Kamil, please add /* FIXME: possible race here */ before the atomic_read=
().
>
> Thanks
>

I will do it and submit a new patchset revision.

