Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7897FC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7E22067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h278LjZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7E22067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipW72-0007yP-BN
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipW5o-0006ne-RW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipW5n-0003Ul-Jn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipW5n-0003Or-EX
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578569710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SksMo1Yvq2cCXf+dJt8HRLqT8SePXD8BPoDcE9bsckA=;
 b=h278LjZhGyGdxTgp7jeRd5maCmhk7wIDEhRFq5XfuE6p7CDAdz8YQyMkeSmKQg5fN5lIpJ
 ZjwEdSu5oWlJxWNxa0bx0KjMrRV4cxmBxFkFyH2jGXrLOgYrIh2XObM8ORDN7kt/Fn72SK
 QfIjGmp4Y1gC70xSFzGYbXhEhLvH+uU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-tl-lSpp_NsSrKD0ThQDgZQ-1; Thu, 09 Jan 2020 06:35:09 -0500
Received: by mail-qt1-f198.google.com with SMTP id e37so4023578qtk.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Pr1UleAJRqhMiwdIrjOq3X6efhT0bIv1oFlvnhEveCs=;
 b=YHT+X5KwcsQpgPq654PvEW76zxpD8OqPamCdtrZ2N5zY1LSvDw8CjMCcrQAlUrDXCA
 XGttuxPJexo68B0gfzc0qddensgYvCTXIYKOKBJ6q3M1XcvaFAVfxFV8VsAkqUlVEeQm
 eGcqhK2TgbenZz9P0dw2qd9HKfg7+/PSuEa/s1iSCS+CcPNhTzHTxSaqY0gSDDBqFqe7
 n+KVlpKFMaacMBmw4ex4ZlQzxat21bMX/TZdwb3z5YmUwAINCxZg9bUwJhY6Hkpkn/vL
 KSsIwzWHYg6L+clTtlKQZ4RRsrcMdaKmn9tqeIftsF87AFDWCOxh++6tGiUxFP0mJ82X
 r8KA==
X-Gm-Message-State: APjAAAVYdySMMvL3J/c3ty3+XRHKyyxZe/IkFrQbyisgrfv39RJgjtSN
 W7Cw2FUFrZTmRlkoHzzICRCx6C/Pbz4hQxr5P+RrrXUbFaSiqKP1f7+9L/AX85vkXpW5HiRCxo4
 nFxtH9FyoYrqlMus=
X-Received: by 2002:ae9:ec01:: with SMTP id h1mr9217129qkg.33.1578569708736;
 Thu, 09 Jan 2020 03:35:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVfOcTARSlHx56Kc906D9F1jBzIg5vETrHYsyvDZDq62mHdwkbtSQMQVHqYCH+YGN2+29zYg==
X-Received: by 2002:ae9:ec01:: with SMTP id h1mr9217112qkg.33.1578569708546;
 Thu, 09 Jan 2020 03:35:08 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id r12sm2865590qkm.94.2020.01.09.03.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:35:07 -0800 (PST)
Date: Thu, 9 Jan 2020 06:35:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/smbios/smbios: Use MachineState::ram_size instead of
 global one
Message-ID: <20200109063400-mutt-send-email-mst@kernel.org>
References: <20200108233138.20434-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200108233138.20434-1-philmd@redhat.com>
X-MC-Unique: tl-lSpp_NsSrKD0ThQDgZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 12:31:38AM +0100, Philippe Mathieu-Daud=E9 wrote:
> The smbios_get_tables() function has access the a machine state.

the a -> the

> Use the field

the field -> the machine state field

> instead of accessing the global ram_size variable.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/smbios/smbios.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 11d476c4a2..ded5f1f4e2 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -630,7 +630,7 @@ static void smbios_build_type_11_table(void)
> =20
>  #define MAX_T16_STD_SZ 0x80000000 /* 2T in Kilobytes */
> =20
> -static void smbios_build_type_16_table(unsigned dimm_cnt)
> +static void smbios_build_type_16_table(ram_addr_t ram_size, unsigned dim=
m_cnt)
>  {
>      uint64_t size_kb;
> =20
> @@ -847,6 +847,7 @@ void smbios_get_tables(MachineState *ms,
>                         uint8_t **anchor, size_t *anchor_len)
>  {
>      unsigned i, dimm_cnt;
> +    ram_addr_t ram_size =3D ms->ram_size;
> =20
>      if (smbios_legacy) {
>          *tables =3D *anchor =3D NULL;
> @@ -876,7 +877,7 @@ void smbios_get_tables(MachineState *ms,
> =20
>          dimm_cnt =3D QEMU_ALIGN_UP(ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
> =20
> -        smbios_build_type_16_table(dimm_cnt);
> +        smbios_build_type_16_table(ram_size, dimm_cnt);
> =20
>          for (i =3D 0; i < dimm_cnt; i++) {
>              smbios_build_type_17_table(i, GET_DIMM_SZ);
> --=20
> 2.21.1


