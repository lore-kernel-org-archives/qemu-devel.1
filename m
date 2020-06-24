Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE9FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93742084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp3PwaQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93742084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnyyf-0005wn-3t
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 02:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jnyxk-0005Me-57
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 02:32:48 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jnyxi-0001J7-0P
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 02:32:47 -0400
Received: by mail-io1-xd44.google.com with SMTP id k23so926292iom.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 23:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vlZyer3uIuenFXuXoyoT2Kt5Jfs6Hd0EyV4jW802iqc=;
 b=Cp3PwaQGpY2ORXVLFGvxbAZyJwxZ1g+LTvlkT0ZeD+ieDbHSa5fGqlGkeJXeRmWS+W
 qkJp0pZfDY/iOyADtWlajzqJYL0GMg01irq2SBp9l/NQ0jc/R5whv3MFkNLdwYSH27py
 3itpNS50gtIWwNNd3S9eRa+2FQOMNjmMZLIdGx1XsMuvTkvYi6bb3gHDbJ8Ty26/oYbI
 GnbAM8aUyq9/L4ZZRYfAp5kUML3Wv2H8K09gax1r0T9wHJn3TJxBmE/u6qfr60mVDTCv
 qvHeEaAggdTk7jjLM2VSD6a9oIFChmQYtjKNB1gw9WrsDVkjOyggqr1i1+EHpAwHahaD
 XgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vlZyer3uIuenFXuXoyoT2Kt5Jfs6Hd0EyV4jW802iqc=;
 b=qkFkEgbCTJLey9XKvliExx0TU/5+N4lv7hDMVJR1BPvTMUZUSKYgm0hA1QYT+Vx3H1
 /8Hfl/luFYkDRBZyU4GO40wfk+C/O/xDpaWAmRA1ZxKwvWDvgs8U/wp4ix9alLF1NKoL
 Xf8kLLHdg/CpM4/HEieSl9hMqiYu8QeL0MXDimVcUfwW3NC4LZ7XahVlLKwAq38Z18yq
 KOY3t7nJ2AvIE6f/EVukTS34eTkPozu6Zy2oOej5aCHAQgZk0ao3UhgGnipb9bSfjWGh
 NdnusGYpQJ9gbSc8wmlw9sb3YIk+1sVPLEk//qZsC1A+crULpMao9c7PFUK2mhF1M4G4
 k8Vw==
X-Gm-Message-State: AOAM531IVv4UAEYYHQmzTQHU3cFdQMxDtTKolU5+D1PlHQ03O4ZmYQwE
 dTfR/K4EZXm3oBSV3Pdoi098IgL65UTgN1BMdik=
X-Google-Smtp-Source: ABdhPJy4+m2Otx66p30sQ3XoLxJ0hYDgSNXNYaGcVQzeR+2Ngo+3iQZVp2+jakt8hy82nTApJEo+o/2Tl8krnwhfbtU=
X-Received: by 2002:a05:6638:601:: with SMTP id
 g1mr19097178jar.137.1592980364759; 
 Tue, 23 Jun 2020 23:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <1592914438-30317-5-git-send-email-chenhc@lemote.com>
 <CAHiYmc5rCjZXc4Pt4QqD8zykqBo8pxbPAxjQP7rTWi6y=3bjsg@mail.gmail.com>
In-Reply-To: <CAHiYmc5rCjZXc4Pt4QqD8zykqBo8pxbPAxjQP7rTWi6y=3bjsg@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 24 Jun 2020 14:32:33 +0800
Message-ID: <CAAhV-H52JxsONfkq-7krGj5frK+C4s2kMxtZtmtNmoYnYNuWsA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V5 4/4] MAINTAINERS: Add Loongson-3 maintainer and
 reviewer
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Tue, Jun 23, 2020 at 9:50 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
>
>
> =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020., Huaca=
i Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> Add myself as a maintainer of Loongson-3 virtual platform, and also add
>> Jiaxun Yang as a reviewer.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  MAINTAINERS | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f0cb1fd..293188e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1095,6 +1095,12 @@ F: hw/isa/vt82c686.c
>>  F: hw/pci-host/bonito.c
>>  F: include/hw/isa/vt82c686.h
>>
>> +Loongson-3 Virtual Platform
>> +M: Huacai Chen <chenhc@lemote.com>
>> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> +S: Maintained
>> +F: hw/mips/loongson3_virt.c
>
>
>  hw/intc/loongson_liointc.c is missing.
Thanks, this will be added.

>
>>
>> +
>>  Boston
>>  M: Paul Burton <pburton@wavecomp.com>
>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> --
>> 2.7.0
>>

