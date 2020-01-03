Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 05:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3B321734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 05:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXSjkMbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3B321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inFKN-0001l5-1b
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 00:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inFJM-0001BV-Dl
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inFJK-0002fg-UU
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:15:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inFJK-0002cq-Q3
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 00:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578028545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xk/oYtcyWI2kEjScS+wnJwU1bBAVcjfeq6UuY63ZtRs=;
 b=EXSjkMbkUbOVF/bzDCgBbLcxEl681c0OsYYYXJuivcr2FYaoBLHym0mx8BIt60/0i1m7Qf
 ggsEew77TYyQmU+9fdc4km4RRQR5heVs/nFcFKKBgrmt3bJbUaUG17zcFwtk71lgOjUxk2
 H3eVFZnqn3ZGqS7ti6hDD0SRN2p3brE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-28HisiP1OQKHg2qRwpodYg-1; Fri, 03 Jan 2020 00:15:44 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so21805154wrm.23
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 21:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K4VC8jewsFV4NWukFz8Ld+Dyp29wuXxdSw4rkD+dXwg=;
 b=XgAMK8SVRq/ri8JkBqXtBlR8X7/a/9qLGJdsJLBaJdj9KlQGZpaNkhZSwuAy7jyLh1
 5iS1MUztBR4p8TbavT8ZUWNHvT9BuYsemHrMCBjaKavR5i7d3G4fooQ3s2qOXdOALeAQ
 dfvy5cJLisVLSGrzekzMurzvG39COKWY14KpuCQ4R96ZX89a9WetFyaGzmkL+l/uMs2X
 gGNXpyzDmCBQ+hhdkObfzWXdn4/sP+/h0V95ddZsggtnQLDvH5Jq79xU38pfj6RAzjMO
 4WyFhcyaDuYdDrifb06iR9goQQwQP3VgUaCFlzVfRG9ddfikBXV65bAm5LfWusxs6X1/
 vl9A==
X-Gm-Message-State: APjAAAW5Sehtk1YWc8wU5HJ1gzbayu9Ql2ugH8QxlPqPd7z/iLkiFABg
 6ITnquh7b6zJ79ciuioWVefwP+4kguQIkCoo0/M4ISdNXaJ4xlx8QDfJASiIUPAbNV2+CSLZtcO
 /Hm0413h5XMb+WDg=
X-Received: by 2002:adf:81c2:: with SMTP id 60mr82773351wra.8.1578028543040;
 Thu, 02 Jan 2020 21:15:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoY8VU9escta6b9O4xKZzn4IHoSXmv3k3v2AtkfJD8TKjjV7ShNc3AxUrUJfFUZCuFb2okUA==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr82773322wra.8.1578028542878;
 Thu, 02 Jan 2020 21:15:42 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id k11sm10563680wmc.20.2020.01.02.21.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 21:15:42 -0800 (PST)
Subject: Re: [PATCH 2/2] tpm-ppi: page-align PPI RAM
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200102210149.926077-1-marcandre.lureau@redhat.com>
 <20200102210149.926077-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <709262ed-fb3d-13c3-c8c7-987ee17c2eec@redhat.com>
Date: Fri, 3 Jan 2020 06:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102210149.926077-3-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: 28HisiP1OQKHg2qRwpodYg-1
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 10:01 PM, Marc-Andr=C3=A9 Lureau wrote:
> post-copy migration fails on destination with error such as:
> 2019-12-26T10:22:44.714644Z qemu-kvm: ram_block_discard_range:
> Unaligned start address: 0x559d2afae9a0
>=20
> Use qemu_memalign() to constrain the PPI RAM memory alignment.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/tpm/tpm_ppi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> index ff314592b4..6d9c1a3e40 100644
> --- a/hw/tpm/tpm_ppi.c
> +++ b/hw/tpm/tpm_ppi.c
> @@ -43,7 +43,8 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
>   void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>                     hwaddr addr, Object *obj)
>   {
> -    tpmppi->buf =3D g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> +    tpmppi->buf =3D qemu_memalign(qemu_real_host_page_size,
> +                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
>       memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
>                                         TPM_PPI_ADDR_SIZE, tpmppi->buf);
>       vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
>=20


