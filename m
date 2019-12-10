Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A09C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 23:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC3A2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 23:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZg5+MSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieolZ-0008V0-QF
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 18:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieokP-00081e-JJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieokM-0005Ri-MQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:16:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieokM-0005P2-6V
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 18:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576019809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw+19eYekJ5gSVR519h30+MJl8tjbpAqBdL+rwkvsjw=;
 b=IZg5+MSF731rkxk/cnTs03H90ZEB/A4921cz3HeniURLcz8qHYxsyJYLFlXxXD7ymPqIf+
 GvRXpbDdSLEBflgHNFM3U7DG2Rkxpi3iSpLuwhKsEVCl+qd0KjAkfb4+rrRJQ2s347oI4x
 6bwXzEznpBOjJrvsn1tzNCZXYAxeELc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-j69CaRFfNliFzWMICpjsQg-1; Tue, 10 Dec 2019 18:16:45 -0500
Received: by mail-wr1-f71.google.com with SMTP id z14so9660866wrs.4
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 15:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HkEmnKHm1rWPT17H6WcF34liMGxwPi5GKngwgbtX56w=;
 b=O8jVr4s6Q4id5/0mMEBjPybxwAjJIDObnRlXOIYLSe0D+meUierNOM3uvLTvN9R61r
 6mnBKPFP8tZOSjYgRYNiOVex0ekddRk5yYYAJqYDEOA2HbNPIxL1CCDAHGrrDKNJb15U
 CEQGybqwNAPJ07CunLXfNT/l2/q2Q2jAvp78LJUXIQa/jp/OdA3SqNzFWI9PjzikQiLQ
 g9k3Obs7FenPsjoN6Ufzfm/7DrfANWkNV4jVlmBFBMSWVasmcJjTkwphF2+lt3Er/Zq+
 isVpLE0T+mG+pQ1/yONa95u1gRnT1mTN9C+f3gwsPFLlPaAgd2SZUHOCk2TZka2UVXyQ
 YcAQ==
X-Gm-Message-State: APjAAAVVd88YqpLx2ZP/zqwfsvHImYqasFHEOYaX+mpPFWowAIFqsO0j
 iE+x51QAi0BmXlSeBTRia+vuW66KujSidESpxh9ZstlI8vZ3ppTvq7/kxAiAewBMCaC9Ywja+Zq
 hWwvyAE6uwLt8vlo=
X-Received: by 2002:adf:c74f:: with SMTP id b15mr65926wrh.272.1576019804737;
 Tue, 10 Dec 2019 15:16:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiHgfOvi+OsWVD4QJgSxKlj/TsFQcwhINEJhlrb5FtPri2xMtGXUEzVVz4FBBQl4+hn/dIiQ==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr65916wrh.272.1576019804539;
 Tue, 10 Dec 2019 15:16:44 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id h8sm30374wrx.63.2019.12.10.15.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 15:16:43 -0800 (PST)
Subject: Re: [PATCH v2 1/1] display/bochs-display: fix memory leak
To: Cameron Esfahani <dirty@apple.com>, qemu-devel@nongnu.org
References: <cover.1576013209.git.dirty@apple.com>
 <d6c26e68db134c7b0c7ce8b61596ca2e65e01e12.1576013209.git.dirty@apple.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61e67881-55fd-faf3-3112-31a525106465@redhat.com>
Date: Wed, 11 Dec 2019 00:16:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d6c26e68db134c7b0c7ce8b61596ca2e65e01e12.1576013209.git.dirty@apple.com>
Content-Language: en-US
X-MC-Unique: j69CaRFfNliFzWMICpjsQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/19 10:27 PM, Cameron Esfahani via wrote:
> Fix memory leak in bochs_display_update().  Leaks 304 bytes per frame.
>=20
> Signed-off-by: Cameron Esfahani <dirty@apple.com>

Funny to have a dirty@ email fixing a DirtyBitmapSnapshot leak =3D)

Fixes: 33ebad54056
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/display/bochs-display.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index dc1bd1641d..215db9a231 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -252,6 +252,8 @@ static void bochs_display_update(void *opaque)
>               dpy_gfx_update(s->con, 0, ys,
>                              mode.width, y - ys);
>           }
> +
> +        g_free(snap);
>       }
>   }
>  =20
>=20


