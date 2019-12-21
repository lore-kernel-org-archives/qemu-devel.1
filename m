Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E70AC2D0C3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4408B206EF
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jG/Ekdnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4408B206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iii2v-0007VO-AE
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 11:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iii27-0006y3-Fd
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iii24-0003f9-7Y
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:55:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iii23-0003Uv-OH
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576947310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oD744Z/8k1aMPJGmwRWlOVEeDulkttJM8pH/DLfCiM8=;
 b=jG/EkdncBwS1Fq9dnhAqk7MqV2KGRpu79NgeTItO7n1Yg9b7JWuHD2nmyusLS1U90dwFIN
 PHliqgA6M5p3lcEsegFSkHnaKEKJtgnk5L+sxqFpDS4ZC0zzneyDJYFw2sikT/SwaevJ4c
 RtHwFCAOgAARS9nRE9zL+T31849rqCI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-y9YdmKCJMoiR-bnW2px_hw-1; Sat, 21 Dec 2019 11:55:08 -0500
Received: by mail-wr1-f71.google.com with SMTP id h30so1682819wrh.5
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 08:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l5wUHMnXvNAn+4mqLUeGMy+o6IFhf1m1EeiUh9W/Sk0=;
 b=ScVb9RHx0NRp7ov+LYSV4vAn2T4/vu3EF8GMiV13zCEBilLgOcFsPK49d1cxu6a/gJ
 1tap1O6wyp70KE9u8PSJZd0yZv6yX5XLiHBuEOKuS94xQ7nvgVszVvadMtq0byB7gFRD
 t4PUzSZ/7QQJdrs/BU32c4bpmpVuaYbHm959EbS3wUgR7XOb9+s7sBK5mhD7pzvaPhSG
 8pS3p+yqBLIXCaoo0I+k/TNlv5l9SR/3KErTXh99S0ydhK22S2J13he1FFi85psARIyL
 ZHGQ6d3TY8zJv9fIq1UYHJyOKWZy/sAefbSj/jtJJ1OU7DBwerh+W29p55P06WZCZ3ma
 G36g==
X-Gm-Message-State: APjAAAXv2vgisGIYIxi93O/d2oASo4cwBOLQurW2vne6ifde4KtI0wNY
 pzebMtF7LvBQGryod5q6bQd4EnrgF+nRPAZjP8rg969Cp3tiwZ19pguzE7YUJNB2HQX5kFdAkjy
 RE5nyLEpRKvscX8I=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr21978534wrv.358.1576947307848; 
 Sat, 21 Dec 2019 08:55:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7khAV+/82lvsf3E8JL7Wi9ZNmGdXflyqif2MCeSshLO6L2suLOHVe8GyJErVQLxyLOjvNGg==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr21978526wrv.358.1576947307664; 
 Sat, 21 Dec 2019 08:55:07 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t1sm13704169wma.43.2019.12.21.08.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2019 08:55:07 -0800 (PST)
Subject: Re: [PATCH v27 06/21] target/rx: CPU definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20191221144238.127766-1-ysato@users.sourceforge.jp>
 <20191221144238.127766-7-ysato@users.sourceforge.jp>
 <CAL1e-=iFV=PumJ2M=rcpntkJ3NFWT7sqMcroJmiLYhsibwFf4Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f822bed-dfbc-b4d2-c88f-f61bf5f16bfa@redhat.com>
Date: Sat, 21 Dec 2019 17:55:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iFV=PumJ2M=rcpntkJ3NFWT7sqMcroJmiLYhsibwFf4Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: y9YdmKCJMoiR-bnW2px_hw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 5:03 PM, Aleksandar Markovic wrote:
>=20
>=20
> On Saturday, December 21, 2019, Yoshinori Sato=20
> <ysato@users.sourceforge.jp <mailto:ysato@users.sourceforge.jp>> wrote:
>=20
>     Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp
>     <mailto:ysato@users.sourceforge.jp>>
>=20
>     Message-Id: <20190616142836.10614-4-ysato@users.sourceforge.jp
>     <mailto:20190616142836.10614-4-ysato@users.sourceforge.jp>>
>     Reviewed-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     Message-Id: <20190607091116.49044-4-ysato@users.sourceforge.jp
>     <mailto:20190607091116.49044-4-ysato@users.sourceforge.jp>>
>=20
>=20
> Hi, Yoshinori,
>=20
> I noticed you have a lot of line like this
>=20
> Message-Id: <20190607091116.49044-9-ysato@users.sourceforge.jp=20
> <mailto:20190607091116.49044-9-ysato@users.sourceforge.jp>>
>=20
> ... sometimes even several in the same message.
>=20
> May I ask you to delete *all* such lines from commit messages, and=20
> resend the series?

I expected this series to be ready for merge, and asked Richard if he=20
could do that to avoid a respin of new version, but apparently Yoshinori=20
missed my comment:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg664071.html

>=20
> Also, I don't see =C2=A0the documentation update for the new target. Plea=
se=20
> provide dome appropriate content in qemu-doc.texi (
> https://github.com/qemu/qemu/blob/master/qemu-doc.texi ), and include it=
=20
> in the next version.
>=20
> Best regards,
>=20
> Aleksandar


