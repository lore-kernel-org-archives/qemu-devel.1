Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDFAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0322420731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 13:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5yFMw5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioSKi-0000EC-7O
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 08:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ioSK2-0008DR-TL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ioSK1-0006Eh-Q9
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:21:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ioSK1-0006EN-Mq
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 08:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578316889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wEjK0LRIWVI/0ThY6RhW14P+mB4LG0NNsTuyex5JeDU=;
 b=h5yFMw5cZfuFqJJOSf6xpcJRlO8n0uDpuFm2uwupCEtmrwv1og/9Ue7+SsDMiiRqQulM1x
 +9J0kaIwlyIXerT5M/vqnUkaa5b+X2AtBV89yMWWUtrEmQel26nLGmxZnDhfIBKGTpWbn/
 zsJbFAKVKiAP6EzFnpv4Rg0E0MNTfwA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-0Zkc3DFSPTmdtuzB4VqCQg-1; Mon, 06 Jan 2020 08:21:25 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so2840276wma.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 05:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wEjK0LRIWVI/0ThY6RhW14P+mB4LG0NNsTuyex5JeDU=;
 b=LgrYiZWsEnFItMmDWcqlOqF9SP9CQvWPRNtCyVjGdnJ43p7WIf7Tepo2N5rUieMX+Q
 ccjPEQ7IPkYJAZ/9nS3Z8fMhkYBPdyb9g9DLNSleH0Tm55E6UsFheil/xdnLWi76Tswk
 kMUakHmwVW+hUZyYx/QXZd2QrQ5nNF8SUBIUynZoNz7QTka3On15a+k1LGHXx2kRzIUI
 5cACZqbiFBN0rvTGGObSYOvSGSahNVYzagtUwsxFdhxexkTlBKJqRc9Nj+pIYO0bOlhl
 RynD/pnA+aeIkY0WUrKPnFzK0lw1AfZjZ6EpY98RGXzWefEGD7WNaJb0Mm9OhLfeitzl
 v45w==
X-Gm-Message-State: APjAAAVXKy1mNfoU995k2jmqw9w3TeTicV3ga+zRh8+NX4h4cm6mGYRM
 S3CQ0X9Kx2lQUiTGQDX4GSxJQciyz7eMK5MJMNRqABWzW5z4IsO6I/a6DKpjv1F7S861RPR5gHB
 AuPa5gqMDg1FPBhOohEn16QF2om3Q2Gs=
X-Received: by 2002:a1c:4004:: with SMTP id n4mr34291334wma.153.1578316884684; 
 Mon, 06 Jan 2020 05:21:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+5hbXzvlG2rgWUaP+7c06y9LJpbSf0ardp3WfJMF261/Y8NWUMITR+lOsbd3lyK24QbZ3Ei2pp3Ge/x3n4go=
X-Received: by 2002:a1c:4004:: with SMTP id n4mr34291324wma.153.1578316884519; 
 Mon, 06 Jan 2020 05:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20200106123746.18201-1-kraxel@redhat.com>
 <bb1948f0-e9df-f250-cad4-825c985b3141@redhat.com>
In-Reply-To: <bb1948f0-e9df-f250-cad4-825c985b3141@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 6 Jan 2020 14:21:13 +0100
Message-ID: <CAP+75-XkoWOuvsTzSE63inNbrp0qHG=64BDmF=NWmQHsaiVikA@mail.gmail.com>
Subject: Re: [PATCH] freebsd: use python37
To: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
X-MC-Unique: 0Zkc3DFSPTmdtuzB4VqCQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 6, 2020 at 2:19 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 1/6/20 1:37 PM, Gerd Hoffmann wrote:
> > FreeBSD seems to use python37 by default now, which breaks the build

BTW it looks clearer replacing by 'python3.7' here and in subject.

> > script.  Add python to the package list, to explicitly pick the version=
,
> > and also adapt the configure command line.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   tests/vm/freebsd | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> > index 1825cc58218b..33a736298a9a 100755
> > --- a/tests/vm/freebsd
> > +++ b/tests/vm/freebsd
> > @@ -32,6 +32,7 @@ class FreeBSDVM(basevm.BaseVM):
> >           "git",
> >           "pkgconf",
> >           "bzip2",
> > +        "python37",
> >
> >           # gnu tools
> >           "bash",
> > @@ -63,7 +64,7 @@ class FreeBSDVM(basevm.BaseVM):
> >           mkdir src build; cd src;
> >           tar -xf /dev/vtbd1;
> >           cd ../build
> > -        ../src/configure --python=3Dpython3.6 {configure_opts};
> > +        ../src/configure --python=3Dpython3.7 {configure_opts};
> >           gmake --output-sync -j{jobs} {target} {verbose};
> >       """
> >
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


