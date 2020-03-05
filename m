Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1332073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7MYf4qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1332073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qqR-0004es-Hx
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9qpG-0003jF-I7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9qpF-0008Of-Hk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:46:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9qpF-0008Ii-DU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583415967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6i6J/ZO2uJcvhEMUp6AaWtb7QAU+P3DUj5FKCo8zhpM=;
 b=Y7MYf4qyvS9V64J35XtR5PZ5150dLzqxYrj6WfgetvGG9g8DrRD7pJXov8ngrPnNRp9prx
 LTuZdRhYdCRo4C5yHgS9cfs6i4NQXo7KrL2IaJA5IqdL7yEXVLRWEsaa6YQXtjukySaOpj
 lQDxDXykFWH0ehc+/TplDS/c+9YaCcY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-4ydibTN5OwGR1M1vrzFHwg-1; Thu, 05 Mar 2020 08:46:04 -0500
X-MC-Unique: 4ydibTN5OwGR1M1vrzFHwg-1
Received: by mail-wm1-f70.google.com with SMTP id b23so2107819wmj.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 05:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=R70thXHi2jvFEPUziKxN/UBg3AR9WUqn2zvOAbJVSGY=;
 b=on/a8U8675qtjEdL1cfDBH14gD1689A9KZ0gcGV0gYV2UxCb8P9DVibb/fGsF77Icq
 aRDsmo4QLRdu/YghWL7C7vgr4OVlvpXOiQS2R4wlHKV99CAVlqTDyWmXQi6CevH2wN8F
 90lH3RC6aFMGx2TTGrWRcjkQf8o/bXAceSCDim/EAe17nO4AzsdpNBH1QvCEAwIgEiWJ
 DoRbRTk3JNKvPGfxl8Dtvt7pcAbj80TO+m0MW0S5MLwx7Hk66/ms0Zqyq+1LiKPjPO+s
 WOANfO3ooRQBw8YLUi+m9aleuwuIHou5Fd3BWX8ohrBahBxP1aC+lkrrW+dnTSN+5NBM
 cg2g==
X-Gm-Message-State: ANhLgQ3ZlillvKNRLXoIPywzVE8rNgaNwXP+wDsWqgVOZzm0aEgZdHS/
 xCJ3z7+6CpIhy34Uotp4VnKBYEbGtkDsq/07AS/EZiIZoFzU5JdnTq6RbcTfSb2YzJfnsqg0gzE
 Kc8FXo9GEYd/6/Nk=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr9518974wmd.23.1583415963430;
 Thu, 05 Mar 2020 05:46:03 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsTsbUktOcERlYeYj35xB/mlIbD0LIvakGqkk80wLIsxAj+VRiJpHQTtWVNo+j2yvwFXEpl9g==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr9518954wmd.23.1583415963233;
 Thu, 05 Mar 2020 05:46:03 -0800 (PST)
Received: from steredhat (host34-204-dynamic.43-79-r.retail.telecomitalia.it.
 [79.43.204.34])
 by smtp.gmail.com with ESMTPSA id f6sm11781555wrw.4.2020.03.05.05.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 05:46:02 -0800 (PST)
Date: Thu, 5 Mar 2020 14:46:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 7/9] ui/curses: Make control_characters[] array const
Message-ID: <20200305134600.w3hdfi7o7tldivww@steredhat>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305124525.14555-8-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305124525.14555-8-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 01:45:23PM +0100, Philippe Mathieu-Daud=E9 wrote:
> As we only use this array as input, make it const.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  ui/curses.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/ui/curses.c b/ui/curses.c
> index 3a1b71451c..3bafc10c1c 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -529,7 +529,7 @@ static void font_setup(void)
>       * Control characters are normally non-printable, but VGA does have
>       * well-known glyphs for them.
>       */
> -    static uint16_t control_characters[0x20] =3D {
> +    static const uint16_t control_characters[0x20] =3D {
>        0x0020,
>        0x263a,
>        0x263b,
> --=20
> 2.21.1
>=20


