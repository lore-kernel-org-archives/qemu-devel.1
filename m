Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EA4C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB562075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZpD8aRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB562075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKsN-0006Z5-KN
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOKrb-0005N3-Bv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOKrZ-0005pY-PY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:40:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOKrZ-0005or-LC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfDbAbI4Y3oq3UsZPuy5zvsx0E1roAz+/VG1VOiIdgw=;
 b=aZpD8aRYHhM3jTDkImfH6tv2Bjvi52HZW/X9SIUL1yHgOzgeqAWlDeJknNvg/QrfD2kgII
 XxSwxygAs54aUlOu1v+skkvJgxZUnoBP/pWuAKDQ6fq8Tceb4Las35ifuPVLxLGqYeY318
 CwzmW/eZA6zwdbiIM4VH8Zx51MJI5ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-scp_bCGFMaafLmEdh6LTug-1; Tue, 14 Apr 2020 08:40:21 -0400
X-MC-Unique: scp_bCGFMaafLmEdh6LTug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AF948017F5;
 Tue, 14 Apr 2020 12:40:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19D475DA66;
 Tue, 14 Apr 2020 12:40:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C99F11385C8; Tue, 14 Apr 2020 14:40:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v3 01/23] scripts/coccinelle: Catch missing
 error_propagate() calls in realize()
References: <20200412224144.12205-1-f4bug@amsat.org>
 <20200412224144.12205-2-f4bug@amsat.org>
Date: Tue, 14 Apr 2020 14:40:11 +0200
In-Reply-To: <20200412224144.12205-2-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 Apr 2020 00:41:22
 +0200")
Message-ID: <87v9m2s0k4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> In some DeviceClass::realize() while we can propagate errors
> to the caller, we forgot to do so. Add a Coccinelle patch to
> automatically add the missing code.
>
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  .../use-error_propagate-in-realize.cocci      | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 scripts/coccinelle/use-error_propagate-in-realize.coc=
ci
>
> diff --git a/scripts/coccinelle/use-error_propagate-in-realize.cocci b/sc=
ripts/coccinelle/use-error_propagate-in-realize.cocci
> new file mode 100644
> index 0000000000..7b59277a50
> --- /dev/null
> +++ b/scripts/coccinelle/use-error_propagate-in-realize.cocci
> @@ -0,0 +1,54 @@
> +// Add missing error-propagation code in DeviceClass::realize()
> +//
> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
> +// This work is licensed under the terms of the GNU GPLv2 or later.
> +//
> +// spatch \
> +//  --macro-file scripts/cocci-macro-file.h --include-headers \
> +//  --sp-file scripts/coccinelle/use-error_abort-in-instance_init.cocci =
\
> +//  --keep-comments --timeout 60 --in-place
> +//
> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691=
638.html
> +
> +
> +@ match_class_init @
> +TypeInfo info;
> +identifier class_initfn;
> +@@
> +    info.class_init =3D class_initfn;
> +
> +
> +@ match_realize @
> +identifier match_class_init.class_initfn;
> +DeviceClass *dc;
> +identifier realizefn;
> +@@
> +void class_initfn(...)
> +{
> +    ...
> +    dc->realize =3D realizefn;
> +    ...
> +}
> +
> +
> +@ propagate_in_realize @
> +identifier match_realize.realizefn;
> +identifier err;
> +identifier errp;
> +identifier func_with_errp;
> +symbol error_abort, error_fatal;
> +@@
> +void realizefn(..., Error **errp)
> +{
> +    ...
> +    Error *err =3D NULL;
> +    <+...
> +    func_with_errp(...,
> +-                      \(&error_abort\|&error_fatal\));
> ++                      &err);
> ++   if (err) {
> ++       error_propagate(errp, err);
> ++       return;

Issues:

0. The script patches only realize() methods of DeviceClass, not of
   subclasses, and no helpers.

   Example of a subclass method: see my review of "[PATCH-for-5.1 v3
   02/24] scripts/coccinelle: Script to simplify DeviceClass error
   propagation".

   Example of a helper method: pnv_chip_core_realize().

1. When the function can't actually fail, the script adds dead error
   handling.

2. When the function can fail, it may well add incomplete error
   handling: it can't add the code needed to revert what has been done
   so far.

   Example: ivshmem_common_realize() has:

        error_setg(&s->migration_blocker,
                   "Migration is disabled when using feature 'peer mode' in=
 device 'ivshmem'");
        migrate_add_blocker(s->migration_blocker, &err);
        if (err) {
            error_propagate(errp, err);
            error_free(s->migration_blocker);
            return;
        }

   If the error handling was missing, the script would fail to add the
   error_free().

Even imperfect scripts can lead us to code in need of improvement.  But
you should explain the script's limitations, both in the script and the
commit message.

> ++   }
> +    ...+>
> +}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6203543ec0..54e05ecbdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2060,6 +2060,7 @@ F: scripts/coccinelle/error_propagate_null.cocci
>  F: scripts/coccinelle/remove_local_err.cocci
>  F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>  F: scripts/coccinelle/use-error_fatal.cocci
> +F: scripts/coccinelle/use-error_propagate-in-realize.cocci
> =20
>  GDB stub
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>


