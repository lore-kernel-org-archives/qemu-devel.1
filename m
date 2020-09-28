Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBBC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CFC2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLks5E8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CFC2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMugI-0001nZ-VN
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 11:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kMudX-0000t6-1D
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:00:19 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kMudT-0000pS-0r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:00:18 -0400
Received: by mail-ej1-x644.google.com with SMTP id p9so8980947ejf.6
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+P1cJUpjFfUK2LvWDv4ExnyUoiv/17NqVefDevSMn/I=;
 b=QLks5E8W9MN6pkWMdNpuA1wG899K5KEIr62evvkNWSjQ0RnBh2i5kO5/GN5Bwr7Mqz
 QIJeJ1MVIWR4pE8/0RE98dYfozJIFNCBBqTO1Rn0sOPX74tTBWtGpn+mnWWqCnl46E9H
 6zJD7VpXewI5sl0qjaiTekHumbhZGxtrDFAEfh7lGKPu3BfBjudGc8RG5goKqJqjUye8
 ybF+OkGKZVcd/SkIpgpn1ioJQhCil/X27K+sRDVQoZj33eVzBs2WvfdTrp2pUyLxhwg+
 BTPmQYShhwyuL/S9cYHtnmn7JcSznmy2lldKkFYEpO3uw/B/kQwfTb3G1zIunEQrs92O
 MWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+P1cJUpjFfUK2LvWDv4ExnyUoiv/17NqVefDevSMn/I=;
 b=qVvQB22ypiXrWty7qa601b1CRiiyHSLFk9MTZ4CkzZhiyjFFwc3OEQEvKFffKb71t8
 mdvgS/upqSVj9SMwqk84SX4GpteOTHwmRnBggVuhEszPfCB8xprFJUpc3Qw73koS3wGu
 YBMZNISPqOzE/Yts8iAQzgaEVs8tToZDZ9IkNHPwwX755I1KggxMn7vg2yKgoxT4lomj
 kq6mWcCFr3GlJG7pq77SsXFXr4mxaZqcRQV00ZJSa8uBrjsyRyKjCU+9i3rIClBQmT8K
 Zac4WqZRTEjF+Sw3L8fln/z0KOr089BmPcDAM74jvL3zFWPGQ6kcKEfXWnjP6Rk6cdYj
 E4pA==
X-Gm-Message-State: AOAM530KOGhzUHgNqTDSWYttuOmHJ2xiEJC7VKzH+7t03gZQQnEMI2qC
 k26FbsjWrO80B1YW8Pdto+cpGGC2Pl/etNEE5pc=
X-Google-Smtp-Source: ABdhPJwE3Qt6+rFu2LdlUz6uJNQtB4zrnPOQU0aSqMNpJKzbL4cwhvvpk3mwuW+hLI+YYp/cRd3PLtBjlSBj272M5AY=
X-Received: by 2002:a17:907:417c:: with SMTP id
 oe20mr2014185ejb.322.1601305211297; 
 Mon, 28 Sep 2020 08:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-6-philmd@redhat.com>
 <CA+XhMqxdb9Y6HL_0Og4Px5OwdTqK5EKJcnKdafd790nJb8yYEQ@mail.gmail.com>
 <20200928141355.GI2230076@redhat.com>
In-Reply-To: <20200928141355.GI2230076@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 28 Sep 2020 16:00:00 +0100
Message-ID: <CA+XhMqzFPekKKY46teFgL9xGHcUApaPxF+BrpJFss1a5S2iHQw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] qemu/bswap: Use compiler __builtin_bswap() on Haiku
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Carlo Arenas <carenas@gmail.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

errors as
...
expected '=3D',   ',', ';', 'asm' r "__attribute__' before "builtin_swap16'
...

base gcc 8.3

On Mon, 28 Sep 2020 at 15:14, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Sep 28, 2020 at 03:09:01PM +0100, David CARLIER wrote:
> > Unfortunately it breaks the build.
>
> Can you provide details of the errors seen and toolchain versions.
>
> I notice we don't have any CI support for Haiku right now, nor
> any recipe in tests/vm/  for enabling users to setup a VM with
> Haiku installed. This very much makes Haiku a second class
> citizen right now in terms of QEMU's supported platforms, with
> no expectation of whether it'll work at any point in time.
>
>
> > On Mon, 28 Sep 2020 at 14:20, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> > >
> > > Since commit efc6c070aca ("configure: Add a test for the minimum
> > > compiler version") the minimum compiler version required for GCC
> > > is 4.8, which supports __builtin_bswap().
> > > Remove the Haiku specific ifdef'ry.
> > >
> > > This reverts commit 652a46ebba970017c7a23767dcc983265cdb8eb7
> > > ("bswap.h: Include <endian.h> on Haiku for bswap operations").
> > >
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > > Cc: David Carlier <devnexen@gmail.com>
> > > Cc: Carlo Arenas <carenas@gmail.com>
> > > ---
> > >  include/qemu/bswap.h | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > > index 55916670d39..719d620bfe6 100644
> > > --- a/include/qemu/bswap.h
> > > +++ b/include/qemu/bswap.h
> > > @@ -8,8 +8,6 @@
> > >  # include <machine/bswap.h>
> > >  #elif defined(__FreeBSD__)
> > >  # include <sys/endian.h>
> > > -#elif defined(__HAIKU__)
> > > -# include <endian.h>
> > >  #else
> > >  #undef  bswap16
> > >  #define bswap16(_x) __builtin_bswap16(_x)
> > > --
> > > 2.26.2
> > >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

