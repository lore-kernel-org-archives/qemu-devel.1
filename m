Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46BCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDE92073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chQBTSHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDE92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qo6-0002rd-Ue
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9qnL-0002JB-MV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9qnK-0005Ub-KX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:44:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9qnK-0005U2-HM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583415850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwcwYXZlPF9Dk0/jPDfbxoZaOzWGw0oBubIUXep8s/I=;
 b=chQBTSHdpeXqs4Mv9AlvkdcQSx4C+AkY+66iLRJQOn10RquW1ZVxc/PaLw4th5h8kTZyKG
 RWUGaoKTnwR+tS6jtOmUwNA9e/aephX7ahK/gN1NNlvqj4bhICntgY0UHxjjb6/wijC6Jj
 7b9MztrWz9lycPAvqfHi4kidTFMYM+c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-WlwB11P5M6WibzTe5V2ReA-1; Thu, 05 Mar 2020 08:44:08 -0500
X-MC-Unique: WlwB11P5M6WibzTe5V2ReA-1
Received: by mail-wm1-f71.google.com with SMTP id t2so1601702wmj.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 05:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7l0LObX4r/xJtw1gjV6AL5tW2N5ztcljA57Sob6iSHE=;
 b=FsnoUtOBghkjCFa6+md2og2EDTYMl72vVL8ezMKOAV8j9DY5lFo/ym92EH6tKIcPse
 pGnyiViae/79+7EtKVCNgE6VGkDL5dkzHfI+wDiZpWzVvTdfpslsr6lw9z+fj5lW/GOb
 ZU6f4zltoVE5j5azSYl/2bG54l7qGmIPqAbzwIzATVsBUce20wJ8mBDRzNuatAWxhb+b
 wKYnfk1+Hr5VHHG/9pcAwTrjeX8UMVH7RMN92t1tSUJn3kPyybMc+rrHMGjs5nW1qX+9
 NB9EYiwAXKPvzFE6fIWqy0CsFxndeeS9+cWV/vO3t9lOq/P8j+QuBpvif8Ebc445E63C
 Zlfg==
X-Gm-Message-State: ANhLgQ3CuTiioLDzOVSmqKDjPtenFi5V6esY47O+gD49vu3XACRyxwts
 a6/ECLBCSrFCY48lfrK3a5kKWzHSKHT10C4VwAKCzpdzEK67Nxq3d8GEfpT5BMfAnoGFIpGn/Ui
 SSLAyw0hWirimKkE=
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr9502274wmf.162.1583415846993; 
 Thu, 05 Mar 2020 05:44:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvXx8VjEeaoJ9zKpAM+3to7ChD9HmipjjfEmJ2i5yqGd33zM0WYLyAjz43k44VLSEfOUWTDBw==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr9502243wmf.162.1583415846580; 
 Thu, 05 Mar 2020 05:44:06 -0800 (PST)
Received: from steredhat (host34-204-dynamic.43-79-r.retail.telecomitalia.it.
 [79.43.204.34])
 by smtp.gmail.com with ESMTPSA id l83sm2860204wmf.43.2020.03.05.05.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 05:44:05 -0800 (PST)
Date: Thu, 5 Mar 2020 14:44:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/9] hw/audio/fmopl: Move ENV_CURVE to .heap to save
 32KiB of .bss
Message-ID: <20200305134403.sagzdlf5iyk2iufs@steredhat>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305124525.14555-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305124525.14555-3-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 01:45:18PM +0100, Philippe Mathieu-Daud=E9 wrote:
> This buffer is only used by the adlib audio device. Move it to
> the .heap to release 32KiB of .bss (size reported on x86_64 host).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/audio/fmopl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index 173a7521f2..356d4dfbca 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -186,7 +186,7 @@ static int32_t *VIB_TABLE;
> =20
>  /* envelope output curve table */
>  /* attack + decay + OFF */
> -static int32_t ENV_CURVE[2*EG_ENT+1];
> +static int32_t *ENV_CURVE;
> =20
>  /* multiple table */
>  #define ML 2
> @@ -1090,6 +1090,7 @@ FM_OPL *OPLCreate(int clock, int rate)
>  =09OPL->clock =3D clock;
>  =09OPL->rate  =3D rate;
>  =09OPL->max_ch =3D max_ch;
> +    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
>  =09/* init grobal tables */
>  =09OPL_initialize(OPL);
>  =09/* reset chip */
> @@ -1127,6 +1128,7 @@ void OPLDestroy(FM_OPL *OPL)
>  #endif
>  =09OPL_UnLockTable();
>  =09free(OPL);
> +    g_free(ENV_CURVE);

Just for curiosity, here the entire fmopl.c is indented with tabs.

In this case, is it better to continue with the tabs or use spaces
for new changes?

Anyway the changes LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


