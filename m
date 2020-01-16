Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E1C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2462077B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjcdJdAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2462077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2b9-0001g2-GC
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1is2aH-0001AZ-5X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1is2aD-00034k-N3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:41:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1is2aD-00033y-JL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579171261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54n7jd5m5HlWOi5BydeTqPctLAGHF94eS1/AIz+t3ts=;
 b=BjcdJdAVgYkdXcL0vbXU/XeDbUEz8udo8X9eh0VKTxy0HpxSR2CzY5fjXwef5NfIwlMsS8
 g5UNXCoPyNXGVQq8Zbt7GEPDKHz0SJziYFz/NAwjhuz3SmZTonoziUMFJm22ppPY1oA0eD
 /o+GU8O0V/gGZOOPAnENE1Oz649n2Vs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-CxGlFMQuMqSwnswVVwszWA-1; Thu, 16 Jan 2020 05:40:55 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so9055464wrm.23
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 02:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jOBeq9oLGHAOWtsNwC1uTyKB81KSk4igxkB932lludM=;
 b=FGZcVvLxwlhspzLe4+dlf0bzwF87f/eK6RNPPoIkcMLvtupiIvosSq1qOCAJQxU7nD
 vJxYCgxoGT7z7/1O8lhb56o8wB0kWZ9+Mg847dw8uxFMxoV2YgEzZOOBhnjOzQ/98YvE
 B6vbm5qGJ3vN9EgXzLZfnAg/uu5G2F1Uk6Qqgl2mRCRU6pO6ReZZAyxb0jcgnSP3+bix
 Z0ex4zHmhvwqsQlU3iuxUkPv22YmZ94jaOT6A+G53k2cliILkTKB7CVPHYrDaVW1yHuY
 FDbeZUEBzxjXE2p6mxBNBJejxJwxUKLmaEsZpSr2hZVOwTpj4i9R3V8rIPidpPWutnNA
 Nhsw==
X-Gm-Message-State: APjAAAVu02lhaNscdAqvV2sEr21lVT/KXPq10cT1594JzPWt8h6FjYCM
 0uA4byE83M/fKHfZW1dBs1MfmMPw+3J+ri83jEQqnY6KpRmGrnEPKfniNXoT8gHSiD5kAUX/MRK
 WY79fnk2+CU0fdYk=
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr2607373wrw.31.1579171254211; 
 Thu, 16 Jan 2020 02:40:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTzD+ujpzcsnwH6X47p1RGWmT9dFu/pCYjMSVpK8l7aLrOao2Qdd2y5yT1Z8AfwjlmUFoUYw==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr2607355wrw.31.1579171253924; 
 Thu, 16 Jan 2020 02:40:53 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it.
 [79.31.49.84])
 by smtp.gmail.com with ESMTPSA id t1sm3912834wma.43.2020.01.16.02.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 02:40:53 -0800 (PST)
Date: Thu, 16 Jan 2020 11:40:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH v2] qcow2: Use a GString in report_unsupported_feature()
Message-ID: <20200116104050.jz3fr3vovniyrywg@steredhat>
References: <20200115135626.19442-1-berto@igalia.com>
MIME-Version: 1.0
In-Reply-To: <20200115135626.19442-1-berto@igalia.com>
X-MC-Unique: CxGlFMQuMqSwnswVVwszWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 02:56:26PM +0100, Alberto Garcia wrote:
> This is a bit more efficient than having to allocate and free memory
> for each item.
>=20
> The default size (60) is enough for all the existing incompatible
> features or the "Unknown incompatible feature" message.
>=20
> Suggested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  block/qcow2.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> v2: Use g_autoptr and update commit message
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index cef9d72b3a..e29fc07068 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -453,16 +453,15 @@ static void cleanup_unknown_header_ext(BlockDriverS=
tate *bs)
>  static void report_unsupported_feature(Error **errp, Qcow2Feature *table=
,
>                                         uint64_t mask)
>  {
> -    char *features =3D g_strdup("");
> -    char *old;
> +    g_autoptr(GString) features =3D g_string_sized_new(60);
> =20
>      while (table && table->name[0] !=3D '\0') {
>          if (table->type =3D=3D QCOW2_FEAT_TYPE_INCOMPATIBLE) {
>              if (mask & (1ULL << table->bit)) {
> -                old =3D features;
> -                features =3D g_strdup_printf("%s%s%.46s", old, *old ? ",=
 " : "",
> -                                           table->name);
> -                g_free(old);
> +                if (features->len > 0) {
> +                    g_string_append(features, ", ");
> +                }
> +                g_string_append_printf(features, "%.46s", table->name);
>                  mask &=3D ~(1ULL << table->bit);
>              }
>          }
> @@ -470,14 +469,14 @@ static void report_unsupported_feature(Error **errp=
, Qcow2Feature *table,
>      }
> =20
>      if (mask) {
> -        old =3D features;
> -        features =3D g_strdup_printf("%s%sUnknown incompatible feature: =
%" PRIx64,
> -                                   old, *old ? ", " : "", mask);
> -        g_free(old);
> +        if (features->len > 0) {
> +            g_string_append(features, ", ");
> +        }
> +        g_string_append_printf(features,
> +                               "Unknown incompatible feature: %" PRIx64,=
 mask);
>      }
> =20
> -    error_setg(errp, "Unsupported qcow2 feature(s): %s", features);
> -    g_free(features);
> +    error_setg(errp, "Unsupported qcow2 feature(s): %s", features->str);
>  }
> =20
>  /*
> --=20
> 2.20.1
>=20
>=20


