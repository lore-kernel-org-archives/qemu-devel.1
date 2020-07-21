Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC6C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2158E20720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht8duJ9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2158E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnTZ-0002Ks-CL
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxnQo-0007Fp-P9
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:15:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxnQn-00054p-72
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yB2lHZjP9aBy2jDhXfVT/IcBm55wqqKHNuvHg857ees=;
 b=ht8duJ9a8/qZwwTlTf+H325TXzHjXEkFm3Ipthm1Id55C0i7MTPfHUYNKNr+C98t4a9DXR
 hDePpaNZm74somEw+IIpR7tt4dDg7vDQaTpfckfn0611bJH9+yuHeAkKBFBFvC7zsR46dh
 A1LQdXTn0lXSqNmgLp0AOCTWxlag6Ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-ONGM8ilROQagTnOoAmUnIg-1; Tue, 21 Jul 2020 04:15:18 -0400
X-MC-Unique: ONGM8ilROQagTnOoAmUnIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94F6480183C;
 Tue, 21 Jul 2020 08:15:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7E3778535;
 Tue, 21 Jul 2020 08:15:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61E52111CA27; Tue, 21 Jul 2020 10:15:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1] hw/isa/isa-superio: Fix IDE controller realization
References: <20200720172348.23465-1-f4bug@amsat.org>
Date: Tue, 21 Jul 2020 10:15:13 +0200
In-Reply-To: <20200720172348.23465-1-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 20 Jul 2020 19:23:48
 +0200")
Message-ID: <87zh7t9tda.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> When realizing a Super I/O with IDE controller [*], we get:
>
>   qom/object.c:1684: object_property_try_add_child: Assertion `!child->pa=
rent' failed.
>   Aborted (core dumped)
>
> This is because the device is already realized when we try to
> add the QOM property to the parent. Fix by realizing *after*
> adding the QOM relationship.
>
> [*] Set ISASuperIOClass::ide.count =3D N with N not zero

Is this a latent bug, or can it bite in master?  If the latter, can you
show how to reproduce?

> Fixes: e508430619 ("hw/isa/superio: Make the components QOM children")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/isa/isa-superio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index e2e47d8fd9..179c185695 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -158,8 +158,8 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>          if (k->ide.get_irq) {
>              qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
>          }
> -        isa_realize_and_unref(isa, bus, &error_fatal);
>          object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
> +        isa_realize_and_unref(isa, bus, &error_fatal);
>          sio->ide =3D isa;
>          trace_superio_create_ide(0,
>                                   k->ide.get_iobase ?


