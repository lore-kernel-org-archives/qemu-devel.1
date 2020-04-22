Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D51C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11862076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edRqhF9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11862076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGIx-00013O-M5
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRGHC-0007PK-HW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRGHB-0001F3-OK
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:22:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRGHB-0001CS-8P
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587565375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6Aqwo/erWNlusQUi8KDuNA5DgGb5VU3ApCpVcfQBvs=;
 b=edRqhF9vOsEekX30P4IaRgBEVTdPb+Ci5fUOq6UK8JM26eVZJkdclCY9HNrb1Vv/KhYOgi
 T1pQip+eAn+nhaLkiwGjCA2i6aA859DlptQcOLdtueKGrX24CFub0OMaNooQ+hl+ZjqM3U
 oJEuw48SqlI3teZiPL69JBeKAnmgME8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-kRVEBtnPOMabOk0-On6F5A-1; Wed, 22 Apr 2020 10:22:54 -0400
X-MC-Unique: kRVEBtnPOMabOk0-On6F5A-1
Received: by mail-wr1-f71.google.com with SMTP id 11so1136139wrc.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 07:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QNf+lEfO7mRvnYDR1ct8MJT0oTo7GFC9Jz/Rvt4X4Xk=;
 b=hycflGiXAt7HAvyUNLY+PVyM6ltibW4D2R6hbLMLroWkIocxwrjg79+bX9FTgAyqlV
 VyS3kwUZe5FSMR/EX2i7zRvxt6WUvUDEe0ysfEHDD4r7aVKjieuin5ZjdD0yV+UZoCnZ
 2l3Wo6IhYexNoVP4tOaVRs6xKeeh/IA7pRxVtPAjYZ8bEM4kx3GFX0tfRgby95n5xgTC
 JSJhmGuXoqZUJx2TEtDVZCN/J0wKblpKn2QZ8XffHhOWbEJ3i3DVsw0ITtAYwQqYBMsC
 R5XjEVawkbDddUyg+q5OQMiIGS72ocIEDxn4K4F0Pkl+lUUezSW3zoOlsKvb5lQ8rMAA
 6pVw==
X-Gm-Message-State: AGi0Pua/ayAh1MtQIt5MTLcppmpXIg24g8lMTVxhHn1xCQnuFgkRB+g5
 Y9zC8P9XLNSTPevUIrSvfVWgZonfdAIW6bHuvle6czAKwLoEFykMVeZ8TUKvvnLqgCICCXfr/Ww
 FnEROMQs78A3qJD8=
X-Received: by 2002:a1c:b757:: with SMTP id h84mr10880453wmf.188.1587565372891; 
 Wed, 22 Apr 2020 07:22:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypLkf9JVtG4aqFzjJb6u36H9RkH/MOB9rxrsiIpYQZY6iT15JUTxraNuRCE8AFLmTi49TvjfpA==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr10880367wmf.188.1587565371755; 
 Wed, 22 Apr 2020 07:22:51 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z1sm7923403wmf.15.2020.04.22.07.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 07:22:51 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] bamboo, sam460ex: Tidy up error message for
 unsupported RAM size
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200422134815.1584-1-armbru@redhat.com>
 <20200422134815.1584-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <279e0fe5-609a-3c3a-bcfa-62e6dc2877c1@redhat.com>
Date: Wed, 22 Apr 2020 16:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422134815.1584-4-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 3:48 PM, Markus Armbruster wrote:
> Improve
>=20
>      $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
>      qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB=
 DIMM/bank supported
>      qemu-system-ppc: Possible valid RAM size: 2048
>=20
> to
>=20
>      qemu-system-ppc: at most 1 bank of 2048, 1024, 512, 256, 128, 64, 32=
 MiB each supported
>      Possible valid RAM size: 1024 MiB

Thanks,

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/ppc/ppc4xx_devs.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 3376c43ff5..f1651e04d9 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -716,11 +716,11 @@ void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_b=
anks,
>           for (i =3D 0; sdram_bank_sizes[i]; i++) {
>               g_string_append_printf(s, "%" PRIi64 "%s",
>                                      sdram_bank_sizes[i] / MiB,
> -                                   sdram_bank_sizes[i + 1] ? " ," : "");
> +                                   sdram_bank_sizes[i + 1] ? ", " : "");
>           }
> -        error_report("Max %d banks of %s MB DIMM/bank supported",
> -            nr_banks, s->str);
> -        error_report("Possible valid RAM size: %" PRIi64,
> +        error_report("at most %d bank%s of %s MiB each supported",
> +                     nr_banks, nr_banks =3D=3D 1 ? "" : "s", s->str);
> +        error_printf("Possible valid RAM size: %" PRIi64 " MiB \n",
>               used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB=
);
>  =20
>           g_string_free(s, true);
>=20


