Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862CC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E996920659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M7+T7K3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E996920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOY0-0003uC-N7
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izOOV-0000rS-2F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izOOT-0000hb-KA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:23:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:44743)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izOOS-0000ZL-5m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580923376;
 bh=kwXrSrjtmOXZfIFLTCEDzTYTHCEV3f0tki+t0S5sDDE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=M7+T7K3zpLNY/aRUvc7gpc9TAXW48lsyq9jVx8aY+erbKIiFCE6o4jgSoTux452VT
 qnZH2/iMjTrvOkcICcshcxB35ukRy58I1nFzqVCdF8R0lw4blKsaK7XPrrU/KV52rK
 JtZnHtHONOxVCpEtMzzzGp9t2ExMrMCJRjEt1b6E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOzT4-1jBOvj3ITc-00PKXA; Wed, 05
 Feb 2020 18:22:55 +0100
Subject: Re: [PATCH v2 3/4] Introduce the NVMM impl
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-4-n54@gmx.com>
 <c0b0fcb2-c370-52f9-b3ee-adc15455b902@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <8b3d2067-fba2-45e1-da11-4ca49ed7f2d5@gmx.com>
Date: Wed, 5 Feb 2020 18:22:08 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c0b0fcb2-c370-52f9-b3ee-adc15455b902@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YIfaQLMFnx3E7uwgE1UnUQqMiyeq5crzzodFrVNr7BcIiL2m2Jk
 5TA3+4EHtMuKaVYP0M5Ynrql0deRYFb2v8oZyxysk1N6/bI7ixsY1JdhXuBQ79UzWPCT5Ky
 f376osHVsJJ/tkP+YIuZFrv3QZ3fDYpD4Qz19GVlM3lOvQvfg0h2p1m+uA1lcKyu2OBBFrF
 PvYTSY9AKObPJCFThmBag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bBEPWRTLUz0=:DKc7kjMiwv6mkhwKoHad4J
 E7ZArH19empvPM/1ickyigB1eb9Y5HW/6hJ9XSuiRDTWJM9CE0mgGZzBYucbslYDI+P6mWo7e
 6UdMWHL9J5IXNFozmuj3tsbIvv87XgkUz5ov4gscz4fX2VnwFGg6OhK/W/jfJK7L6C5HU7cST
 1oOun4lPHDbiyaTW8I7OLYlxloPx7kfcQKSsoAmnagV8+RUMxTANpXgT6GrwmFg7uKmA7Xi/i
 gfIhdUDWWXJRRd4sRDz5jE6+mFOM7kCA8I/5RwtuJJWez/rYNXoiY3sOf8aAnG6rWRUMrG4dA
 85fHNuV2EpDzPK1bCiPSxHhDYj3A8dE5mh26IP3+LYV7x1dh1yObpg1AGqDsVBLhSNbVIB/JD
 jyzmfbpZ+fZh7eR893Jwx3+03BW9itlSOLOypT5avXZNfnpTKHuqbbIHKPWBawchky9W/Wk3I
 Kv4QNpmLcRx90bjiMxwuPij3esTRb6Y8IrZ1kHit37OzNV8OBmxl81OlHvg1ZPblRia/NV2wu
 ur2qKyH0ChERKwNm+RgVXLqGcXbWYdoQq5Wp7oOahGagavXABYhvLGyBMSXjCfSXoHKsw7QBR
 YRiaWOiYLG7qCKXndfUyouVpeOeeOcRMyoCLuRYE6IniSSI131wLODXpToWJWI0OSXv3XZPI4
 M/T8Gk7f8DiqCKY/2HffAC5Hj/9nK5iTyxw9WgOPqRteJBRnMRRGjyIVSZBVSH2htPTSovqop
 g76Y6c8JxZYN5Gijd4fNH9bRVexrsBXy02c/pcFG+kJcoeldL/0NBODoAE0OVHVrA2RX9DSh2
 Vwh5EfgnYqT6zuR8wbf+kaSDR1FREQf/8pXEVwijg7IKq7QAkBmwIQK1BfJkmdAT2qKl2Kw02
 Js3gBlsmiVuO9LqpSEesNe46RVrUZIPRDiqNKUql6fB27wbgMCLbTr78Gm+FEJTGGR8Av55HT
 O3OnJJMDSQGU/x9nz/NSVN29NHQEvadqu/kiqcGDsE6Crix2xajD9CemnK4ezoaz5HjQu9od/
 OwlYnQgtAO34h7kMnkFuXXiMBzY8sT4rWM0PoroAi821uSsSGpPSI2JWtnQ0jvuHtc9mvO26N
 qeOnqkjaJt2r3jOEbu+pEcosJiIRP8UVxup/pTT8ll5lqJhZDWm+piwTRB3/sCzNlf1Yw7v8k
 e/zhRR+r5iyYo1/4JYeIxzEdozOwx52538fYYlMIQ7mnWmUbqDp0lsOjqD8k4MKkB3SfA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
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

On 03.02.2020 12:51, Philippe Mathieu-Daud=C3=A9 wrote:
> Except the XXX comments, LGTM but I'm not a X86 guy.
>
>

These comments were old and I will drop them and resubmit.

