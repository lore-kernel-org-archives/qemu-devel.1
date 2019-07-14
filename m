Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5605C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 22:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E9A20C01
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 22:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoL9gEGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E9A20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmn9f-0006X7-65
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 18:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52504)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hmn9T-000694-5O
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 18:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hmn9S-0006Au-4A
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 18:39:27 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:34402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hmn9R-0006AV-Tt
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 18:39:26 -0400
Received: by mail-yw1-xc42.google.com with SMTP id q128so6792436ywc.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=6vpRkwwLKmEGWOnW6DOU1/rdiSBk9iVmXNTZP3XD0Hs=;
 b=SoL9gEGrURlHmy7MYtv0fsD71FIOK4/tABenMwnSQPmrasICR6VlJzZzCT2yTbRTMN
 TOfhcviDiulTkxk0RUpf+m21KrhRtlerLkPvEZe6M1ag65rHI5aP2mWhGHDMIh4okXy/
 1FmtXDHwfXaR5slxR87ZqgelhsnQstKK+Hcj20iOHXR1jerI62w/nHCKVzGSKB/k1In6
 lum9KevA2hwRwJkQrK67xXEj9Hmo7ofQ04vtYVcUTYkw8hnVPwPQPDp2XqekpQaYk36c
 2dy0eColmsaW+78NzKDY7NujFclebb+j0luxMVQRHzFss5PEc5eSwjt74d/zALTt5Is0
 dIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=6vpRkwwLKmEGWOnW6DOU1/rdiSBk9iVmXNTZP3XD0Hs=;
 b=MzVii/BOTgvNcqHsQ8ByatEfSF9qHmafk5MnQM30b/MbiJO/7Nq4xH/cWMI2NcdL2G
 z3u7KAzQPomb8cnRdRet1IWIHiKVJ22ShpvqV7dxfdZV1G1+V66WkCpYWUA8qd+rX20z
 t+t35ZKdiiWRe+RTRuqkLi9cATKLRWFf13zA416Nva/xoK7Jf0t6Yfs0yFkejCOdK0nw
 UzEp2YPtIQaw2jMQYROs0pIPiKZ4wHY6Ht0RorKoNwH0X/5i05fjQSMzaM8zX/F46hGd
 KUE8ZpNkULMHSPY+YWYkSVdh/EtFoxASfcjpP0Bw/iwS8b9s2w9bF1jTIha41Fu0f47A
 qNmg==
X-Gm-Message-State: APjAAAW9W8Vd2gIz7fo4iUTV/TI7Nlg1kBozv55hNWYqXLr1D2DzDpcT
 mIOQ6adm98UnsuYsJ6LWoDw=
X-Google-Smtp-Source: APXvYqwwSBFGUxMP4d74ukuDiCwxvPp/PJCTfaUG7IS8FvcovbEB+xlCzX9Vi4P69dD3tpJkdPR8fw==
X-Received: by 2002:a81:2e50:: with SMTP id u77mr13094317ywu.138.1563143965180; 
 Sun, 14 Jul 2019 15:39:25 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id u6sm3871672ywl.10.2019.07.14.15.39.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 15:39:24 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-5-jan.bobek@gmail.com>
 <e64091a9-d8f4-a71c-fcbd-ac27d85d2e64@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFbeakcBEACzYOxOXdeT3Ns+5fdSqZFODAb3VXBKQ9DL7ooxLQRhvAx6rKXP/ZkBD7eg
 q8DJuvx6FbH227wpX+JZQawtolRJO+BTOuyU4ANPn3LGQHNtI78VhjafK7/Geb/9J6mTLl+P
 iS1EpLjKFbaLQboOaVVCPOHfLJOMNm5Ks9iHVKPQcUWUnroZdm55MIWjRw+wYGpmLD/R+FK/
 Cm1fS3j+tu9VYFoEFZmwW//PYzmEtYHpwXA6dOWEd12cu2208/JcEHYBl0Z6Oga0xAk2OxU5
 BOELuewGLuSiWik4z594GLVleC2NMnr3gUPl1y8ADrKzQwYmPgytIdsQ0tkV5rK9R1XTk03e
 ZLViYWJt5dgea+jGWcHPKPfLln53V4nCbwklGFLJQDMo8hL82bjJ7x9bsXoAnkPxJgYHgsM0
 LCLewqEIN6khniNv/1vOAKnwoXywlIKsWrx/pFz4xXNLVHoLlkRUl1DeWWzuaha2xEsm0yfe
 QkntqMrHC0CkBFzM1/ZE8fj8JBMjMG8me93RK9mr03TV4aROgQfi4Pjy55VKal/WpVkD4tKo
 nTN0nHkPVsHfx+htN/+A3nnUFyfesE1wWdCxhqhIn8d/Aw9KqraYmbyTzRErXLadA4O0UmZZ
 yPyNWQhTgGfJ9r66S+CifsiHkHlzJ/9i9AcHeh6+rXs9gjk4YwARAQABtB9KYW4gQm9iZWsg
 PGphbi5ib2Jla0BnbWFpbC5jb20+iQJRBBMBAgA7AhsDAh4BAheAAhkBFiEETAzi4j5xV5X9
 nNm0vpyriGq+2b4FAlwy32MFCwkIBwIGFQoJCAsCBBYCAwEACgkQvpyriGq+2b6NPw/9Fi+N
 vmxMd81Oh3hHUZlh8fNqcvXmHqnKHslJJG9M8CXkWcd1cF+sWX+lhi2Pvi4KA2Ng++NEpi6p
 sPrY9ZSPb4gAQYFgq6aXonnsrNSHeBMZI0E2mbK1YW4lYYJuMpqotBKqpgpoP9Fd8QbBR9vA
 Dm18fcDQFJP0vBmLY2TWo2tdqUH1X3z1xpdADpdjMZeQ+LrQ823Vi8ib0aanaR+gJ+20w7tn
 M+iTAGSz9jj+IAjDvrt6dpgwKaN+sFpqQFr0ClItDgtWWChIOEo7AVxK35jEHZnRpAbSvX3q
 WxETfA/1/UiDD67FQ5mwzTm95oYw+bN6jYpQgv9BkWeOhvVi63bcQ212B5w/YJ/WysriD2tp
 j/cTbVBgW2Al29fbeKyqdCr43yqR0ZyZcKuOKpwEtkF4xo3Z4ZR6x4uZewCjNirlwKDSI9sE
 w137DWzREIk7sd2kZrMnFAjVOTVic8fs+jCeohuy6Eq7l+lMCWsyJTcXSY3HHmXAgoQu8HRE
 uwQB0H5rTWn4Hz/2OtWlYHxHcqGwcUP3bdxqch001JwycoYJFnqM27whPussfxRK3i6d0CiX
 8N1lwBb4ukIH8y5ZFmdhMA960aTGVpeew5fnzRveZj2Fn6kPZX7Z5t0eXpdl0sYyKvxPy/rP
 9atlD0qdA7LSBksLIoSQ5EE+rfhAvSO5Ag0EVt5qRwEQAL1zSWDNDk5M7kPTRuonvez0WbBq
 Sl36BBKMSsAVT7L5TTksQH0T/5N7+vTIXlOTefP2KN+8uITUR7Ld2grjdcLIpx86ff4gVmuv
 P7Xc0wKd/dmDPVqEtBKbCPCtnHznZWUWe/zJNru9aE2RwumMjMzAqXX8VEzy+XSqToneX1a2
 +k6+4ZRWvrJ5Kb+5vs+ccw5hQlWyF7vruUNLLVO9LgPD4BbIKyyhosuVp8PtJqdsz27eb3y0
 oh4ThSwx+S7lYucUB30HUtqBWJ9gMiqmXDLEhx+3v5wxCWm0oko9nnwk0PstRkZ39WAawnix
 gpQ+3Gw32yFZaDOEbfbob2+Tyc3/NA7aTnllvK1ihXaHr7dzwbE96XSEsz1RPOl/Cn2cZ0gY
 1/kMzUesBqrlyBIGl9TY/QLu3z2B/INwc/ZlN3oEIJRXhS0KvtUA8tT4NSXVz8yLLO7tQv/g
 tSP0B2jsZRhm3QReCJT/cNmlOJ3O7b835Vpd+QbFoyCbKRcT6dVHl+Ay5UZykihg45HXDwtl
 FRgYUh7xJuxHnF8SDMlPcFqdOocPXq/fgfbxDFhLOFIj/qzEI892wu5lxfDGn9u8KCZ8p55N
 YSlcLOYlvDfCr5/syBWqO928XMOXdmQqhUFsP2aV0L3pL35qh7kfsAdSN4S0KgdQq4DUe8Mf
 +GXaHyIVABEBAAGJAjwEGAECACYCGwwWIQRMDOLiPnFXlf2c2bS+nKuIar7ZvgUCXGyXZwUJ
 By12uwAKCRC+nKuIar7Zvj4mEACW5/tViY+6MMv4Qh7zCXTmyNOepFjaSdbeBXpgL6IHbO3y
 kH5K90vCGl8rgQvIxOnX5cj/o1/y8NnfJ+lv94Hlqg9DkDHt4V2Zu570gIs81dlhxOqjZh/h
 14LLigmx699j6ZfpRksuGKS07/3ZomrBBsMTzK+44+BXX1zLBqSamwD038TAq8n9DwILAVma
 5C814/i1OciQz2HhK6QH8hMFMtX/8E//B6Q5oy9GPjrznYy+Wq52cmrwX7asqTkJ8q+oryaO
 I/popEdiE2boPz2KTa2fti2otyhU7Qc1iTdvIoUxyXZtQP7bI5RspvGHk6IP+5ksOdBjG6D6
 IifJ1gw7cHip1mxz75uFb52jscIjkdSDhveAiSqnwAlMBy/UD2QVwTTL2o34jXwofkK+I20S
 J5kDhUuqYrsD4zMGHX/PWa7w7oeUU3cHejj0KI6MrN6LdvYPckycglZbS2AKUd82m6XES8gA
 2pVPSjTH8BQKQ/Bbdgt7X416igU0nfpuj5aXe3NuLSO1sJbYRGFERTkUgxZm/RpRytGL4SPt
 PQUBJBl8uNYwyN5Y19lwsghGFPeYeTgcPsaEf6YsLVwozZBId4WNDAaVgnxibxH4Xjb6JkwJ
 2W9jjN3tvmY+O0w1rnvRIJ99Btq6Qls7Nj+tdDDEKhufxpRrHTmwBUuLN+zZ9LkCDQRcbJZM
 ARAAvczli16jbnLXksVpMj0Z8JRiIdJvE23xofalA4R+Y5oKrK+mcpTUcb+XIdkArrQNQQtq
 pgPHLI5Dn4urmgs4E9KlBe+4fQBIzP0jyx8wH1MjhGak9QQXpLL5Z6evUdhjuyIoAb5rUgOb
 yl+wu9vmIYsJD4HzYul+nQkx/RxTZ3/OUN5JamL7AoAL5dHKOSpEUqRHq7ZoNqn6OGDxRInX
 dgnSs0SDYVAKVK7B8iFhEmdFXN25jOXLAtwtAh9cVGISfjEQftlvnoLQ6g+UbJ0XMWr6Y8pf
 mfOXPEoP9takIlhoZqxFiJ98lHtbkJ2u0hDTuAYe+HxBZT16bcCsucSITC6h3qQJTMxJgQ0C
 5fA23ZUA9l4RszA7Lb6/wxIzko2jzZDbMaK8tsX5hHn7pJoPA34w3sY9hocMn707PWcxVVYf
 zl9YL3cAqcbD3hMTi3v+ukw7ArQ8sKaSYMBBC9GH54ePmiLpJ3wOsgNxxeIVvnCjVwMms8Br
 fLfnV+kuB0GABOOCsVXLkS73VjpouDzZ9k7SuZ+wVPZbJfgqLIHOT/j2nyVYVQCmzZ733E2c
 1/Qywe2hUfZz5NWg4fFiFywBGqcHCoeMjDuZgJ6VRMxtfAQhC3FWoLrcQYhY3l1MvNToIm6M
 4quvsQcJ6CMnVxpu1ULAhSkpmTvsH0BCjWeYLBEAEQEAAYkEcgQYAQoAJgIbAhYhBEwM4uI+
 cVeV/ZzZtL6cq4hqvtm+BQJcbJqwBQkBn0q2AkDBdCAEGQEKAB0WIQRI9g6q0xHepFmsS61l
 6DaV2uM2zwUCXGyWTAAKCRBl6DaV2uM2z0m3D/9ebunqJVHvk1pIiJ29GfzXqUIVCyG3aXyG
 T0RwXrQ9mKil+6/zLvAWh9NeksSIqKFDCQkC55WTUd1jL/lpDdipLo32BBLG+N0L40Nab1dM
 QldolDWocwmJuD99bWJmd0bkmVGCLDiXVgOyec8BFggixnqVEvrz7Sh0lP9tnsb4BE7v63Q0
 q8uFt+n3swBvMnbjbNs2uGCyRz4f0tasF3Dd3R+08LZydrarJ15C0Smqghjald8UmJNi7uvI
 ZVwcEHSt6imp9gd4uAtcis8ebXkwAkWhW/n5DCpNVlZ8ve3haA767SJCuf4eIcPLIwW9KcgE
 nZ3zQPqclkd9TEmttIxk7C/MoRjxNC+gkyAMQXksxPIDVutythS8JVacMSaDshFtO0RiZ/mH
 e4oGdsBcRhThM923M9iMZAM1XLQpd5Pe+VhDsDN3+QXwkDH88t7tocamj/Ew5UT8qmZy7BJt
 vtDPeybOgxgiVDTlvEARUHK20UiLa7l8HEnJNInlSjakch6MF6axI1Ye81Ahc/snl5PP1gYl
 lmoQkJlRPTYgH/NLtRqcECff5pjOtUEoWWXrxRSKc0QRsTT5DhC4Z2CX3p6k0RDeMvZJnbyV
 geYWFyT5YBPvZBf0meL541JsfvTpOhcfdk//2RvMsyxNaGeemvWQEJKg/C/fTH3So3pEmPkE
 GwkQvpyriGq+2b6xKw//ToIcWJv1S+COsfuCZLTPL0f80pIr7yFYGcOcEfhbkdoZHAcWZP/X
 50NeUuSOYGoT6+pU6a6lvycB7JTuAHuSIHo8HpIPF+sju14FN47Yd1n9akW89HLeSzR5paw3
 g9FD1TbK9uFmK+bxMREAj1Gtd7qcummK6ArpjkEdOjwPXBz9n1iVo/Jgq11Mbhg8TYCP8WRw
 8Lv+znH/cTSTgDxM92S79wDuFoO50zhlWzPa/g2prrUIxJxs74uBEGYy8LulRv25MfdQJVAY
 YE6+HYAJL6S/ko2m6XCr3hLsnD0kXamzvpJtDhbgBcXDd05XDjEFurZTOWv+thwVb+BAedhP
 XrH9DQ7/VUQBHnXz1ts5NYMjBI5NC1d16DYPtkCY0N9Jcv+fyJlAYpS7PHlZsyZmK7uUbm6p
 xRARxxjf+U86NTBAtdnDIO/NYxhX587vXuTm2pA2pnkKYTK74QLc/ys6rO3Cwo2QSFkxx3UZ
 uD1PmEfcmmfqPmuv037Dzpe5hYj5csGsdNLMLSK1WZqaAhBAtCnh3Rme71Je7f+eObRAHHGZ
 sftsaIi3kpdIyUnKybZhViIlXs8Cde5O2HCI0NhHnaDnxKdmHaIZVlH1hX3koaRrWCeGjts1
 WWOVGHwSUSJ3lpUXEBHBicrX3bH/vUVTNTnwzGLSf/23VC9WYAe69II=
Message-ID: <c0598465-4283-6451-c15c-e55fcb199ced@gmail.com>
Date: Sun, 14 Jul 2019 18:39:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e64091a9-d8f4-a71c-fcbd-ac27d85d2e64@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PMZ8qEvjNN8qnLCWnIeHB4MkpO9GkS60x"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: Re: [Qemu-devel] [RISU PATCH v3 04/18] risugen_x86_constraints: add
 module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PMZ8qEvjNN8qnLCWnIeHB4MkpO9GkS60x
Content-Type: multipart/mixed; boundary="JSdPuOZxCA78QVHwCyaFYB51OrX865b6C";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <c0598465-4283-6451-c15c-e55fcb199ced@gmail.com>
Subject: Re: [RISU PATCH v3 04/18] risugen_x86_constraints: add module
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-5-jan.bobek@gmail.com>
 <e64091a9-d8f4-a71c-fcbd-ac27d85d2e64@linaro.org>
In-Reply-To: <e64091a9-d8f4-a71c-fcbd-ac27d85d2e64@linaro.org>

--JSdPuOZxCA78QVHwCyaFYB51OrX865b6C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/12/19 10:24 AM, Richard Henderson wrote:
> On 7/12/19 12:32 AM, Jan Bobek wrote:
>> +sub vex($%)
>> +{
>> +    my ($insn, %vex) =3D @_;
>> +    my $regidw =3D $is_x86_64 ? 4 : 3;
>> +
>> +    # There is no point in randomizing other VEX fields, since
>> +    # VEX.R/.X/.B are encoded automatically by risugen_x86_asm, and
>> +    # VEX.M/.P are opcodes.
>> +    $vex{l} =3D randint(width =3D> 1) ? 256 : 128 unless defined $vex=
{l};
>=20
> VEX.L is sort-of opcode-like as well.  It certainly differentiates AVX1=
 vs
> AVX2, and so probably should be constrained somehow.  I can't think of =
what's
> the best way to do that at the moment, since our existing --xstate=3Dfo=
o isn't right.
>=20
> Perhaps just a FIXME comment for now?

So, the instructions that use VEX.L specify it in the !constraints
block in the config file. Originally, I thought some instructions are
supposed to ignore it (denoted by LIG in the Intel manual -- it's the
scalar instructions like ADDSS), so it might be worth randomizing.
However, when I later read the manual pages of some of these
instructions, it said they are supposed to be encoded with VEX.L=3D0
anyway. I didn't check every single one of them, but right now they
are all encoded with VEX.L=3D0, so I suppose this line can be removed
and we can rely on the caller (the !constraints block) to always
specify it.

>> +sub modrm_($%)
>> +{
>> +    my ($insn, %args) =3D @_;
>> +    my $regidw =3D $is_x86_64 ? 4 : 3;
>> +
>> +    my %modrm =3D ();
>> +    if (defined $args{reg}) {
>> +        # This makes the config file syntax a bit more accommodating
>> +        # in cases where MODRM.REG is an opcode extension field.
>> +        $modrm{reg} =3D $args{reg};
>> +    } else {
>> +        $modrm{reg} =3D randint(width =3D> $regidw);
>> +    }
>> +
>> +    # There is also a displacement-only form, but we don't know
>> +    # absolute address of the memblock, so we cannot test it.
>=20
> 32-bit mode has displacement-only, aka absolute; 64-bit replaces that w=
ith
> rip-relative.  But agreed that the first is impossible to test and the =
second
> is difficult.
>=20
>> +sub modrm($%)
>> +{
>> +    my ($insn, %args) =3D @_;
>> +    modrm_($insn, indexk =3D> 'index', %args);
>> +}
>=20
> How are you avoiding %rsp as index?
> I saw you die for that in the previous patch...

See write_mem_getoffset in risugen_x86.pm. I felt there's a better
place for it there, since that's when we actually need to write to it,
so the problem is more exposed.

-Jan

>=20
> r~
>=20


--JSdPuOZxCA78QVHwCyaFYB51OrX865b6C--

--PMZ8qEvjNN8qnLCWnIeHB4MkpO9GkS60x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0rrxgACgkQZeg2ldrj
Ns9qqg/8DNHqY2o5BMJfjWjmAQVzKBF514iqclESlqNPFYOXMQoDLmog+PY6MYE/
01nlzYOWJdbf+PcI27pHko4YB+K5rKzsHVpOgsqMRwLxx+ygQlXH4PUNNK1Wy55M
jEm5Ge5w+uZcAhsXOBvnk6uOE5vqT/TzdZmad6KNqTEZg68Fimg7LLE2IA6mC7Ln
8qhOEyNU1yPf6PidrzNYGCrnCrn0RIwQuznLY+0xy2i1vA30RXjI2TfATGtxu17p
YZUxfZ1MtXkA44icPJ2C3XVtF0t4irHgLg2/k64zKuyXzlqvWORWG7TByhi7V1BW
g14CzVu74SRwSwiODasSlgXTYYG7uxL9bUaVNALPpZ5s55EiUoHCyviX5ltzP++I
80yTwf5CVN6FiMhiX422NDrafbNUoYGSCV6aQOac+herq6NojdXX9CD6i3a+QMNw
FAmwScS7WOdj5oVRjMlBrJu1SAnb9kxww1vvrQHdk/QJNJHHfrU2miKMS9sKpEO+
b++ckLQiSTRIqBfF5Iwv4CHb4dPOKhXNQLLevCv8twz3U5qzduHLan+W7DxmD3Wk
RLFf6+CJbRWx0nOA1gCWuzmtxhfYt55ZQW3rnXvwGAqBhoORcTpY9eP5Lw6kwS4S
b8BX7LGQMe0rkiMCyBM16LF32dFFYDpOeBFyLVvWcPqDlBaMIxw=
=ZHYy
-----END PGP SIGNATURE-----

--PMZ8qEvjNN8qnLCWnIeHB4MkpO9GkS60x--

