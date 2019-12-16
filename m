Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84562053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHXiHmm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84562053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igq7i-00074w-NZ
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igq6s-0006Tt-AX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igq6q-0000b4-O2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:08:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igq6q-0000Xf-Kf
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576501703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyiZEvdpmiR1z49QHsFUsuEwKpoYm9A3e9m9TSPFFVk=;
 b=HHXiHmm7blxpPajxhC+0jKvm4k8SgWOk4wfg4tFaiE/KXFuyDRI0W3sueAGb0mmmuuuOzQ
 OG7BIIhvoJr8l5jfzCHj7ceMH3R5gj//f2VByOHckzi9ln+vP4MjwofBxQlcP7/IPOGZLA
 Tk+1ga7Ie40ZohxyXKwgK+33ZSppHV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-O3Qe2DwPP66y_BQOGtnD1w-1; Mon, 16 Dec 2019 08:08:20 -0500
Received: by mail-wr1-f71.google.com with SMTP id f15so3722373wrr.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WflYuUQZousi4XGgb0GbdEmEJ1Nmz4fmXt3qQBXydNs=;
 b=UU6vsehAKHC+frpwqyaqe0Za/EnZxm4NhkFl168/m/CWO4u0qZq1GPOp+d2A/vqD2N
 5/t+IPFTkrt3L7fo4NtJzb9zJymhE99m1TUF8nwm/DI0+H+hAsKAVCrAgBo1wICmsqEd
 qKsT+IaTr6/rQ769tmhTeyRy9ggUmfIjm9K8m5ZTIwcq732Bz9NBMKmKw5+smIYGnw/8
 4wdlMZlzitXmoNf57hAIEaSeRGdFp3s2fw3Ul0169GWQJSyX4ytmyJ5DbEb0Islp9jA9
 liN+40Cl/TFvTBKluEryk/pOkSdykmQLkapOddfewq8DbYzFOYcF/LexRfjnXYe+T0RT
 FkIA==
X-Gm-Message-State: APjAAAU4imGrppA3fADa8ODNdUKBgAVjD2meL13w7bSvCMdOYN1HGa6i
 eQ7QR7qzaBMM6FAyz/nb7VEowov0OSebiMZ1fLrcQIeNSlu6F7/jIruxYAA6jbJU7N0LVev9MY/
 vN4FhUI+pRjxyiZE=
X-Received: by 2002:a7b:c183:: with SMTP id y3mr30780549wmi.0.1576501698867;
 Mon, 16 Dec 2019 05:08:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRbl2q590TOT2OqeitUM9v+z9P+Qz0KH3FrBi+3f9bTEkxnfY6AmhNwyO4t8n8hrRiXT4ZZQ==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr30780523wmi.0.1576501698651;
 Mon, 16 Dec 2019 05:08:18 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w19sm19885933wmc.22.2019.12.16.05.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:08:17 -0800 (PST)
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191214160223.20012-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
Date: Mon, 16 Dec 2019 14:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191214160223.20012-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: O3Qe2DwPP66y_BQOGtnD1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/12/19 17:02, Philippe Mathieu-Daud=C3=A9 wrote:
> If a subregion is mapped out of the parent region range, it
> will never get accessed. Since this is a bug, abort to help
> the developer notice the mistake.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  memory.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/memory.c b/memory.c
> index 06484c2bff..61f355dcd5 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2390,6 +2390,7 @@ static void memory_region_add_subregion_common(Memo=
ryRegion *mr,
>  {
>      assert(!subregion->container);
>      subregion->container =3D mr;
> +    assert(offset + memory_region_size(subregion) <=3D memory_region_siz=
e(mr));
>      subregion->addr =3D offset;
>      memory_region_update_container_subregions(subregion);
>  }
>=20

I think in some cases this could be intentional, for example if you have
different models with different BAR sizes and you organize this with the
same tree of MemoryRegion and different sizes for the parent.  I'm not
saying this happens in the current devices we support, I'm just
wondering if it should be a reason not to apply the patch.  I suppose
you did spend some time debugging something where the patch would have
been useful; what was that something?

Paolo


