Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E574FC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B130120674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH46aS31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B130120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFym-0003Fx-Tw
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBFy7-0002QQ-RL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBFy6-00033A-MV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:49:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBFy6-00032z-JJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583750946;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZL4+edmwxAeiMI/GUYPSW7ICUxmm0Rsgthn+BNGG5U=;
 b=fH46aS31bFYRBCcCRNFXY7k1ZIRvlHaGfHjZzEfcVIU1ovcZ31EulRRIav4VC/2hHvjIt9
 g3M1pF7OLDPZpfKIgmm4wB+UcQZ3AfAXteWZRAGetuZae2BqofZ/YKyqqb1IMVKtcZuvFk
 v8Qz3VDGTrILdHwrKtmFKd6WbWiWdr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-7_lzQlliNdyWWigsrtRu1g-1; Mon, 09 Mar 2020 06:48:58 -0400
X-MC-Unique: 7_lzQlliNdyWWigsrtRu1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C58800D48;
 Mon,  9 Mar 2020 10:48:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E2968882D;
 Mon,  9 Mar 2020 10:48:54 +0000 (UTC)
Date: Mon, 9 Mar 2020 10:48:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] core/qdev: fix memleak in qdev_get_gpio_out_connector()
Message-ID: <20200309104851.GD3033513@redhat.com>
References: <20200307030756.5913-1-pannengyuan@huawei.com>
 <CAJ+F1C+6QSYBhO_M+Vqps4XvOujnV+Wbq6o9Q+qUmC5Z0dmxSQ@mail.gmail.com>
 <87b027ab-7bed-249a-08a2-2c27fdd05a31@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <87b027ab-7bed-249a-08a2-2c27fdd05a31@vivier.eu>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 qemu trival <qemu-trivial@nongnu.org>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 10:16:28AM +0100, Laurent Vivier wrote:
> Le 07/03/2020 =C3=A0 11:39, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
> > Hi
> >=20
> > On Sat, Mar 7, 2020 at 3:53 AM Pan Nengyuan <pannengyuan@huawei.com> wr=
ote:
> >>
> >> Fix a memory leak in qdev_get_gpio_out_connector().
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> >=20
> > good catch,
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> trivial question:
>=20
> Why do we prefer g_autofree() to the g_free() function?

The g_autofree annotation guarantees that g_free() gets invoked
when the variable goes out of scope, in all code paths.

This avoids the need to do the classic "goto cleanup;" jumps
with manuall free calls. So as well as simplifying code it
makes it less error prone in general. Of course the method
in this patch is only three lines long so you don't really
see the benefits, but there's also no real harm. So I'd
personally always pick g_autofree in situations where it
is usable, as it is a good habit to be in when you get to
more complex codepaths.

> >> ---
> >>  hw/core/qdev.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >> index 3937d1eb1a..85f062def7 100644
> >> --- a/hw/core/qdev.c
> >> +++ b/hw/core/qdev.c
> >> @@ -557,7 +557,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev,=
 const char *name, int n,
> >>
> >>  qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *na=
me, int n)
> >>  {
> >> -    char *propname =3D g_strdup_printf("%s[%d]",
> >> +    g_autofree char *propname =3D g_strdup_printf("%s[%d]",
> >>                                       name ? name : "unnamed-gpio-out"=
, n);
> >>
> >>      qemu_irq ret =3D (qemu_irq)object_property_get_link(OBJECT(dev), =
propname,
> >> --

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


