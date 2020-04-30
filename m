Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C4C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68552173E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByCYwZ3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68552173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU2ri-00016k-4j
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2pO-0006YP-V9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2mz-0005QA-Qd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:37:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57058
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU2mz-0005Pz-EN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588228516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1kBZ+4CB2+KvTYlUmWVD6VdvSbzBCuOtcOQIMEkuxI=;
 b=ByCYwZ3qLcriaF57ZRY13AwrSzSRQ1pLho+3sO93HlkwVclZdYSe6gdtSIlh2RQdo7HYWh
 4Vczm8ESaXthKkii0U8Dry1b0v0wX61bze0GjAsugjl7tVvVOXGnPby70bupzm907ykvP5
 PXp1Qa57supymgzuBWeA8VmiSusTy7A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-D4mEuq_SPJeJMr_WqoONcQ-1; Thu, 30 Apr 2020 02:35:14 -0400
X-MC-Unique: D4mEuq_SPJeJMr_WqoONcQ-1
Received: by mail-wm1-f69.google.com with SMTP id h6so361675wmi.7
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 23:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uGqQCxmzgfDpRku5zdKb4R/U/vK3xj80GElxItF9Ogs=;
 b=DaWFwfaoYllIbU7gy4Xw9Zb/eJIEIoXNPDZiNBZ8vVpmgqYW89dFB4iLOuZyrr/8R8
 LUIyZcTBYor/0xxVVzC0fBTBjW431GyLHB5gG5QDj1Jp0oTJPjuKRN12h0eEx8ahF7i0
 7kFORGt7d+GjcLJbOe/RiYM4pHWRsJf2JGrwlZUhhTg4IlpcL17V0UNgYYqFvFQ7+1kp
 GpL9ZMq3aJCBuHiIHDeKDqSOf6toSVmy3EZacbbd06nRlOeal0QMi6W005vyZ93FLHlc
 0JdwQyjR/9vuW/RA1gJhptcWWHnoDoaESbKls/8VDLifQTSChdpr1C6OKHgSBvwYftIN
 MGfA==
X-Gm-Message-State: AGi0PuYDyEDcAkTi+AYBDBtArBUkjlMd6HGEskloHBReAnUZCmwjrIC0
 w0vP+/WagmW3wbqBXSy5p8WVfhBoLU/HpLrS0KQ2rJPnvflcsMQ19VAH/my9XYyRPmetSM+ykAu
 TQdBBbBC75OacWzw=
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr1142326wmc.132.1588228513091; 
 Wed, 29 Apr 2020 23:35:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypI3vYKa7fNBAAHC53JtCkOk7FWduBMo/cOdkmuUUfIb69HwgmMXZvBw52IosAbPhfOzVMeQmQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr1142303wmc.132.1588228512841; 
 Wed, 29 Apr 2020 23:35:12 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id t8sm2339022wrq.88.2020.04.29.23.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 23:35:12 -0700 (PDT)
Subject: Re: [PATCH v3 01/15] move 'typedef Aml' to qemu/types.h
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c8bd7fd5-d1f8-8242-f1b1-f573c1495670@redhat.com>
Date: Thu, 30 Apr 2020 08:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 3:59 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/hw/acpi/aml-build.h | 1 -
>   include/qemu/typedefs.h     | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 0f4ed53d7fbf..1539fe066714 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -33,7 +33,6 @@ struct Aml {
>       uint8_t op;
>       AmlBlockFlags block_flags;
>   };
> -typedef struct Aml Aml;
>  =20
>   typedef enum {
>       AML_COMPATIBILITY =3D 0,
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 375770a80f06..ecf3cde26c3c 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -24,6 +24,7 @@
>   typedef struct AdapterInfo AdapterInfo;
>   typedef struct AddressSpace AddressSpace;
>   typedef struct AioContext AioContext;
> +typedef struct Aml Aml;
>   typedef struct AnnounceTimer AnnounceTimer;
>   typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
>   typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
>=20


