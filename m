Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC78C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 06:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50428206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 06:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5mTSRLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50428206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV94z-0005ji-9u
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 01:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iV93y-0005Al-PX
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 01:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iV93w-0007w1-C3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 01:57:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iV93w-0007vE-43
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 01:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573714621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTgs9h1Qgyj1oIDYbHnE9js5kpA64+YRNAe7/qddthQ=;
 b=i5mTSRLehDAzJ0sIyufgeYN6GZVrarlUHlLg39wyW/D5bf9KrDko1ix7hOHqXOo3NGtoSB
 OxlAE/cY4uYkTZBPC5nz749qbPQ1ZKQ++mNQp2dhb9F6Iar6yYRs9OsteUxIm+mVXKEy6Q
 oh+Oc/K+a1lG1FYeu4zpFlEsBDYYGhE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-48LC8MdrNgmyET3DLrEXpA-1; Thu, 14 Nov 2019 01:55:34 -0500
Received: by mail-oi1-f200.google.com with SMTP id s204so2582007oib.7
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 22:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aTgs9h1Qgyj1oIDYbHnE9js5kpA64+YRNAe7/qddthQ=;
 b=hxKCJ30fx9IlSqmeX18B6B8BdjxuBIPy6OHyU/vAOrY/tS5LCbfQ2Bn9yApOJ0pPkL
 03bE7b3GjBxx7qxtm5lJfC24UHjG4N7wlZuZKwtz8Hn+/1MNdE7kTrsE3Ia0VwSlffnb
 rPn/nE4T3gBwNP9C5AvatAo/uDCsyIFkNdvT8QDW32qv8R2eiZowItnaIUEpPSOp5cu4
 wLfUWrbl4dk5zf2xWPwEVnxX6As3GrfYdm8PT6qtYypTj8Aw5A4+gMPPD/DX5zzcPXRV
 tGUQCnB+uEhnogINOKEUZ8sUPkICJpRaNYOqnOFzHtCVMicu8GgWI3TGybnD8yiRp/48
 P05Q==
X-Gm-Message-State: APjAAAV2hHhACIg3n6wQgIgSZD7U7vNsebrSW6BIL4a55HlEN/NpuHxe
 GglIRfxjMDZOZIY/elWZ9Kmx3T8OTWk14myh5s4qjMLkr/rTGqPmnFvyyN6LhoMOifUf7iCZdSx
 3W9ejT5rWhFvXj6dAafLkC2IgGYBT0Ys=
X-Received: by 2002:a05:6830:164a:: with SMTP id
 h10mr5797346otr.62.1573714534029; 
 Wed, 13 Nov 2019 22:55:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIwG9Bqt+UjqWEJpwAL9zIZF9Gx/3IPseGIPb2bggBNco854GHBl3rLEGHuBuUI8I6hzo6DEcqeC4AI7y5PQU=
X-Received: by 2002:a05:6830:164a:: with SMTP id
 h10mr5797336otr.62.1573714533814; 
 Wed, 13 Nov 2019 22:55:33 -0800 (PST)
MIME-Version: 1.0
References: <d64c9aa098cc6e5c0b638438c4959eddfa7e24e2.1573679311.git.crobinso@redhat.com>
In-Reply-To: <d64c9aa098cc6e5c0b638438c4959eddfa7e24e2.1573679311.git.crobinso@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 14 Nov 2019 10:55:22 +0400
Message-ID: <CAMxuvazypNCcEXLhVOk74DYLQt8tGesbDYAEpwzWqR1PArnQAQ@mail.gmail.com>
Subject: Re: [PATCH] tests: fix modules-test 'duplicate test case' error
To: Cole Robinson <crobinso@redhat.com>
X-MC-Unique: 48LC8MdrNgmyET3DLrEXpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 1:09 AM Cole Robinson <crobinso@redhat.com> wrote:
>
> ./configure --enable-sdl --audio-drv-list=3Dsdl --enable-modules
>
> Will generate two identical test names: /$arch/module/load/sdl
> Which generates an error like:
>
> (tests/modules-test:23814): GLib-ERROR **: 18:23:06.359: duplicate test c=
ase path: /aarch64//module/load/sdl
>
> Add the subsystem prefix in the name as well, so instead we get:
>
> /$arch/module/load/audio-sdl
> /$arch/module/load/ui-sdl
>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/modules-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/modules-test.c b/tests/modules-test.c
> index d1a6ace218..88217686e1 100644
> --- a/tests/modules-test.c
> +++ b/tests/modules-test.c
> @@ -64,7 +64,8 @@ int main(int argc, char *argv[])
>      g_test_init(&argc, &argv, NULL);
>
>      for (i =3D 0; i < G_N_ELEMENTS(modules); i +=3D 2) {
> -        char *testname =3D g_strdup_printf("/module/load/%s", modules[i =
+ 1]);
> +        char *testname =3D g_strdup_printf("/module/load/%s%s",
> +                                         modules[i], modules[i + 1]);
>          qtest_add_data_func(testname, modules + i, test_modules_load);
>          g_free(testname);
>      }
> --
> 2.23.0
>


