Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53B224655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8OV1Sat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53B224655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuC5M-0007qG-JC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 04:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuC4k-0007Jb-EK
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuC4j-0001oy-Ds
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:13:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuC4j-0001om-AC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579684404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDbI7OTlrrx+8hBmmG1MtiPWbuF4ypqTlenAEs63DtA=;
 b=P8OV1SatLf01xpCu2aNX5WwXkFW5IE2XGPzJErtb7QseQsXW/0ct2BkoVQPB+sEGV8lVOo
 OnDUFuonhuJ4HolEqzrCDSMnkLe2YIkzz71ZxVJx+W4Ys45DPjNz+BKCc4EnASzj1ZhjSx
 +O2Cb9lOZNuK4poZrdElKr5uZBVC3tw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-I1lbvoyrPFe3R1j77PRv6w-1; Wed, 22 Jan 2020 04:13:23 -0500
Received: by mail-wr1-f69.google.com with SMTP id y7so2762185wrm.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 01:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kEbmcbg7TibgUGlnmptgAqwSmbj11fboB5V1mvfzQNs=;
 b=DroGHsvgdK9JWOtlCKLj2+/y0S1vzvDxFHoS0i2H+UFNf+6Csd865kDneBq5RtSoq0
 4QNEzDlvwqdqaITfArQAI7M5z+hJR5HHiNAXky+wB9VRsK+78vXv+zIaC7Sdf0eRGE/m
 HqLIgeVoqfh5iZ+WXI8SEjQwjljpmlc84MI7Z06F3viYPPrf7sKxRoR2/034oaoWUkZv
 1ioqbvjuH6oZmY9GXO3pDSwmLH2gUpfAb7fgnnbajIvnHqxRQ/zdjcsEPy75bSZ96TrY
 G0JLUWE58jpRUHq2n9Ltl67r9wOyZdmUdmQo0WDLnGdlhdR/2yYbm4XVVwDeTAGUOTui
 XyYA==
X-Gm-Message-State: APjAAAUF0D2MWAjckxFKqfENMRFoQPdLXEZGgrdQoxVBQ1jvm/8f9NTC
 fTFCwVIGLSFEzh9J/UyMz/M2Ikjz5n1C/BVc/QKiNaWsIqAjL3MEaR78bYfJwMvAciB7uYpsCyd
 W5hNOPh5rc49DfVw=
X-Received: by 2002:adf:de86:: with SMTP id w6mr10421497wrl.115.1579684402043; 
 Wed, 22 Jan 2020 01:13:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzu9MB04odvTXl+60w+m8i7sJTwgRfyB5JTA9t0CNhUlrOReZ0ZKxs0wFR/XYjaJf8sK5jsdA==
X-Received: by 2002:adf:de86:: with SMTP id w6mr10421473wrl.115.1579684401825; 
 Wed, 22 Jan 2020 01:13:21 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 t125sm3167746wmf.17.2020.01.22.01.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 01:13:21 -0800 (PST)
Date: Wed, 22 Jan 2020 04:13:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 2/5] bios-tables-test: fix up DIFF generation
Message-ID: <20200122041248-mutt-send-email-mst@kernel.org>
References: <20200122080538.591734-1-mst@redhat.com>
 <20200122080538.591734-3-mst@redhat.com>
 <1f1a0e72-d0ab-9b50-434f-32763c168d4e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1f1a0e72-d0ab-9b50-434f-32763c168d4e@redhat.com>
X-MC-Unique: I1lbvoyrPFe3R1j77PRv6w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 10:00:01AM +0100, Laurent Vivier wrote:
> On 22/01/2020 09:05, Michael S. Tsirkin wrote:
> > Turns out it goes to stdout which is suppressed even with V=3D1.
> > Force DIFF output to stderr to make it visible.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  tests/qtest/bios-tables-test.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-t=
est.c
> > index 6b5f24bf62..c8db2839b2 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -463,13 +463,18 @@ static void test_acpi_asl(test_data *data)
> >                          "Actual [asl:%s, aml:%s], Expected [asl:%s, am=
l:%s].\n",
> >                          exp_sdt->aml, sdt->asl_file, sdt->aml_file,
> >                          exp_sdt->asl_file, exp_sdt->aml_file);
> > +                fflush(stderr);
> >                  if (getenv("V")) {
> >                      const char *diff_cmd =3D getenv("DIFF");
> >                      if (diff_cmd) {
> > -                        int ret G_GNUC_UNUSED;
> >                          char *diff =3D g_strdup_printf("%s %s %s", dif=
f_cmd,
> >                              exp_sdt->asl_file, sdt->asl_file);
> > +                        int out =3D dup(STDOUT_FILENO);
> > +                        int ret G_GNUC_UNUSED;
> > +
> > +                        dup2(STDERR_FILENO, STDOUT_FILENO);
> >                          ret =3D system(diff) ;
> > +                        dup2(out, STDOUT_FILENO);
>=20
> I think you need a "close(out)" here.
>=20
> Thanks,
> Laurent

Can't hurt, thanks!


