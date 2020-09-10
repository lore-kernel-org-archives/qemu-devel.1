Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55917214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hs57V3RI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55917214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPWN-0005Os-EL
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGPV2-0003pJ-71
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:32:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGPUz-0000bU-Iu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599755556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bYfEJM+3qXbkVPwaBhygOYm7gSbXLlFZAcuMi07Z1yQ=;
 b=Hs57V3RIwWLYfDc7w/FrXyiTuW7FOYPrhuvKgLHDLoyrhHxPcHiUQ1U7F1sDZ8DAwKPJsh
 VxMVNBZAd33w8L5r/eLq9X91IIYIJ94n+8Z5sldb4TUkzDFmIdq78RUbhwzy95o/tsRa3n
 aC7aPM15wffgQryYiz+a8NuDwO0kbos=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-HmjnoH4nOiWerOdL7Kg1iw-1; Thu, 10 Sep 2020 12:32:32 -0400
X-MC-Unique: HmjnoH4nOiWerOdL7Kg1iw-1
Received: by mail-wm1-f72.google.com with SMTP id 189so194486wme.5
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 09:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:cc
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bYfEJM+3qXbkVPwaBhygOYm7gSbXLlFZAcuMi07Z1yQ=;
 b=lwo2TgGeDhntGwUl4rqfzHtOapFtyMnGDQitHrhPoksZd/jKKqSyvy3oP2g0vnquyr
 JgfrKPqUg4WwjLem6KC7fxqV/QBStK4npNEhoEg/hEyJEyp6HkVTAQ5L1PQqQXcUrLbi
 FnfW4xFTfbQJNsgBh8PnFzr87hpAESU+MhqEPX/kv/o03XzFheNMfL8BVdO9z2b2Va9d
 yJSTuJhUnWd7YLWC4NZBMA3QrqVblMANYC8ug6QuvLALMjT2HxXy0YfEuesp5t/lpPMr
 QdxxSWBVl/oT5CCist3oip7DIc7I0rcxOBS0jQadNzSc/k1SwKsRj/97bGi3do1uTwrN
 3hxg==
X-Gm-Message-State: AOAM532YArLIwC/FmhVcU1dphPvvTez0RloUDqq9kxIIJqtAvKo6Ao1i
 fkpNtmvRC4rDqwV1TujU4YUqIundBCuvWmeuatOo9LRix2n94xjkDc4GK/X24IU1QOJYtPXv2tO
 JaKrgjAKdgk/rr6Y=
X-Received: by 2002:a1c:bbd6:: with SMTP id l205mr854703wmf.79.1599755550849; 
 Thu, 10 Sep 2020 09:32:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCC4ipWHzFRhOL9cx+lXR2fRHgkCX5ePQJNa4MyzITA3Mcytk2CrsC32+0J7CS/M0BntFvHw==
X-Received: by 2002:a1c:bbd6:: with SMTP id l205mr854664wmf.79.1599755550490; 
 Thu, 10 Sep 2020 09:32:30 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n17sm10494756wrw.0.2020.09.10.09.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 09:32:29 -0700 (PDT)
Subject: Re: [PATCH 08/10] pc-bios: refresh edk2 build artifacts for
 edk2-stable202008
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-9-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <b2037644-bf48-e86f-23e3-f2c68e7ddc1f@redhat.com>
Date: Thu, 10 Sep 2020 18:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-9-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+GitLab team & Gerd (for building firmwares)

On 9/8/20 9:29 AM, Laszlo Ersek wrote:
> Rebuild the pc-bios/edk2-*.fd.bz2 binaries, based on the edk2-stable202008
> release.
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1178070 -> 1507722 bytes
>  pc-bios/edk2-arm-code.fd.bz2           | Bin 1172752 -> 1503187 bytes
>  pc-bios/edk2-i386-code.fd.bz2          | Bin 1736199 -> 1646741 bytes
>  pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1943949 -> 1860546 bytes
>  pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1717094 -> 1680164 bytes
>  pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1958037 -> 1912112 bytes
>  6 files changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/pc-bios/edk2-aarch64-code.fd.bz2 b/pc-bios/edk2-aarch64-code.fd.bz2
> index a074085b224f..5bf311464a79 100644
> Binary files a/pc-bios/edk2-aarch64-code.fd.bz2 and b/pc-bios/edk2-aarch64-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-arm-code.fd.bz2 b/pc-bios/edk2-arm-code.fd.bz2
> index 42453cd1f273..7a98069814dc 100644
> Binary files a/pc-bios/edk2-arm-code.fd.bz2 and b/pc-bios/edk2-arm-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-i386-code.fd.bz2 b/pc-bios/edk2-i386-code.fd.bz2
> index 633759688e32..e7b1befe2cfe 100644
> Binary files a/pc-bios/edk2-i386-code.fd.bz2 and b/pc-bios/edk2-i386-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-i386-secure-code.fd.bz2 b/pc-bios/edk2-i386-secure-code.fd.bz2
> index df27bdd2ddbd..b5df5bed3086 100644
> Binary files a/pc-bios/edk2-i386-secure-code.fd.bz2 and b/pc-bios/edk2-i386-secure-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-x86_64-code.fd.bz2 b/pc-bios/edk2-x86_64-code.fd.bz2
> index 0e108fc68a91..e1654d4003b7 100644
> Binary files a/pc-bios/edk2-x86_64-code.fd.bz2 and b/pc-bios/edk2-x86_64-code.fd.bz2 differ
> diff --git a/pc-bios/edk2-x86_64-secure-code.fd.bz2 b/pc-bios/edk2-x86_64-secure-code.fd.bz2
> index 522f8376aabe..767274c38c7f 100644
> Binary files a/pc-bios/edk2-x86_64-secure-code.fd.bz2 and b/pc-bios/edk2-x86_64-secure-code.fd.bz2 differ
> 

Now I remember why I kept that patch on hold.

The CI idea is to have reproducible builds if possible.
When the submodule is updated (or the QEMU scripts containing the
-D defines), it triggers the 'build-edk2' job which produce these
same binaries.
My original idea was to push the tag on GitLab that triggers the
job, then download the produced binaries, test them, then commit
them.

With your series, I get these binaries:
https://gitlab.com/philmd/qemu/-/jobs/731618363/artifacts/browse/pc-bios/

However they differ with yours, for example:

0000 6100: 00 00 00 00 00 00 00 00  00 00 00 00 2F 68 6F 6D  ........
..../hom
0000 6110: 65 2F 6C 61 63 6F 73 2F  73 72 63 2F 75 70 73 74  e/lacos/
src/upst
0000 6120: 72 65 61 6D 2F 71 65 6D  75 2F 72 6F 6D 73 2F 65  ream/qem
u/roms/e
0000 6130: 64 6B 32 2F 42 75 69 6C  64 2F 41 72 6D 56 69 72  dk2/Buil
d/ArmVir
0000 6140: 74 51 65 6D 75 2D 41 41  52 43 48 36 34 2F 44 45  tQemu-AA
RCH64/DE
0000 6150: 42 55 47 5F 47 43 43 35  2F 41 41 52 43 48 36 34  BUG_GCC5
/AARCH64
0000 6160: 2F 41 72 6D 50 6C 61 74  66 6F 72 6D 50 6B 67 2F  /ArmPlat
formPkg/
0000 6170: 50 72 65 50 65 69 43 6F  72 65 2F 50 72 65 50 65  PrePeiCo
re/PrePe
0000 6180: 69 43 6F 72 65 55 6E 69  43 6F 72 65 2F 44 45 42  iCoreUni
Core/DEB
0000 6190: 55 47 2F 41 72 6D 50 6C  61 74 66 6F 72 6D 50 72  UG/ArmPl
atformPr
0000 61A0: 65 50 65 69 43 6F 72 65  2E 64 6C 6C 00 00 00 00  ePeiCore
.dll....

0000 6100: 00 00 00 00 00 00 00 00  00 00 00 00 2F 62 75 69  ........
..../bui
0000 6110: 6C 64 73 2F 70 68 69 6C  6D 64 2F 71 65 6D 75 2F  lds/phil
md/qemu/
0000 6120: 72 6F 6D 73 2F 65 64 6B  32 2F 42 75 69 6C 64 2F  roms/edk
2/Build/
0000 6130: 41 72 6D 56 69 72 74 51  65 6D 75 2D 41 41 52 43  ArmVirtQ
emu-AARC
0000 6140: 48 36 34 2F 44 45 42 55  47 5F 47 43 43 35 2F 41  H64/DEBU
G_GCC5/A
0000 6150: 41 52 43 48 36 34 2F 41  72 6D 50 6C 61 74 66 6F  ARCH64/A
rmPlatfo
0000 6160: 72 6D 50 6B 67 2F 50 72  65 50 65 69 43 6F 72 65  rmPkg/Pr
ePeiCore
0000 6170: 2F 50 72 65 50 65 69 43  6F 72 65 55 6E 69 43 6F  /PrePeiC
oreUniCo
0000 6180: 72 65 2F 44 45 42 55 47  2F 41 72 6D 50 6C 61 74  re/DEBUG
/ArmPlat
0000 6190: 66 6F 72 6D 50 72 65 50  65 69 43 6F 72 65 2E 64  formPreP
eiCore.d
0000 61A0: 6C 6C 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ll......
........

For now this is not a blocker, but we should consider switching to
this workflow at some point (caring about all the files that really
need to be archived, maybe debug symbols etc...).

w.r.t. your patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.


