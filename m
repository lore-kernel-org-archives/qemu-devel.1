Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB45C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F6E206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBQR1LE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F6E206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLP2R-0008Rg-EZ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLOy9-000481-7F
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLOy8-0002q6-0g
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:27:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLOy7-0002pQ-St
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586168822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uu+Bu7gwvfzeaCxPlFA6AVJgjPs2S8B3Fg9PjM8iziI=;
 b=jBQR1LE/ruhy5IwvcmWa4MWEGuQ0Noz9NU65g9pKsNakFM6IiIHzQrbylxq5JXv803Su24
 SdLPIwPQQUv/esHOS12DXyBJAyZJr36zSz3XdFdFZDZz1p7eIgAmfjTXbXFeTj8ob8apv3
 WI0ub770PNIQ4sEEOU6i6WFnbl17haU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249--zIb2D7TPzaBBVfJsQ5yNQ-1; Mon, 06 Apr 2020 06:27:00 -0400
X-MC-Unique: -zIb2D7TPzaBBVfJsQ5yNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B20B18C43DE;
 Mon,  6 Apr 2020 10:26:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81AA05C541;
 Mon,  6 Apr 2020 10:26:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B9BAC16E2C; Mon,  6 Apr 2020 12:26:52 +0200 (CEST)
Date: Mon, 6 Apr 2020 12:26:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 09/12] acpi: move aml builder code for parallel device
Message-ID: <20200406102652.lf2yq4wkm2lylgzf@sirius.home.kraxel.org>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-10-kraxel@redhat.com>
 <20200403121210.30a010cb@redhat.com>
 <20200403121601.35099bf5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200403121601.35099bf5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 03, 2020 at 12:16:01PM +0200, Igor Mammedov wrote:
> On Fri, 3 Apr 2020 12:12:10 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Fri,  3 Apr 2020 10:04:59 +0200
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >=20
> [...]
> > > +static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
> > > +{
> > > +    ISAParallelState *isa =3D ISA_PARALLEL(isadev);
> > > +    Aml *dev;
> > > +    Aml *crs;
> > > +
> > > +    if (isa->iobase !=3D 0x0378) {
> > > +        return;
> > > +    }
> if device is present why should we skip adding it to DSDT?

Well, that is the current state of affairs, only the first parallel
ports shows up in the dsdt.  And given how rare parallel ports are these
days I didn't bother changing that ...

We can handle this simliar to serial lines though, incremental below.
Do you prefer that?

take care,
  Gerd

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D cut here =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
From 617797cf42e56e18d5d62cb171af00c28589caba Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 6 Apr 2020 12:17:59 +0200
Subject: [PATCH] [fixup] parallel

---
 hw/char/parallel.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 2bff1f17fda7..7157d6816b77 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -572,10 +572,16 @@ static void parallel_isa_realizefn(DeviceState *dev, =
Error **errp)
 static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
 {
     ISAParallelState *isa =3D ISA_PARALLEL(isadev);
+    int i, uid =3D 0;
     Aml *dev;
     Aml *crs;
=20
-    if (isa->iobase !=3D 0x0378) {
+    for (i =3D 0; i < ARRAY_SIZE(isa_parallel_io); i++) {
+        if (isa->iobase =3D=3D isa_parallel_io[i]) {
+            uid =3D i + 1;
+        }
+    }
+    if (!uid) {
         return;
     }
=20
@@ -583,8 +589,9 @@ static void parallel_isa_build_aml(ISADevice *isadev, A=
ml *scope)
     aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
     aml_append(crs, aml_irq_no_flags(7));
=20
-    dev =3D aml_device("LPT");
+    dev =3D aml_device("LPT%d", uid);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
     aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
     aml_append(dev, aml_name_decl("_CRS", crs));
=20
--=20
2.18.2


