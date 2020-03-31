Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2653C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A34920786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ4fIWf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A34920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIlG-0004sa-Qa
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jJIk7-0003W4-QP
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jJIk6-0000Va-Rd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jJIk6-0000VI-NX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585668234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiZ54EpbLWeNgpEnFuSnIKVF1JaxEtFrgaGDHpfWJ7E=;
 b=hZ4fIWf352p4RkKFppAMwg5v5bEmjRkoqnc4TGjJcVk9STsjnYJBDPcYjbd1F9Qmqls3eq
 HUhLNS6aXjti4SIw0yiIUsuFTsKY6V7s0wKZUry8YxRrwBKY4gTOKBtvsueUcuToYCY0N9
 7QifxL10CfXFBp5q5e65x1rQIHHWyss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-NtXxep7XPBm2_tVekLqwtQ-1; Tue, 31 Mar 2020 11:23:47 -0400
X-MC-Unique: NtXxep7XPBm2_tVekLqwtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33ADC13F7;
 Tue, 31 Mar 2020 15:23:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 664448F34F;
 Tue, 31 Mar 2020 15:23:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4BE3A31F24; Tue, 31 Mar 2020 17:23:42 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:23:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 5/6] acpi: serial: don't use _STA method
Message-ID: <20200331152342.vdfhosgpi6popy2x@sirius.home.kraxel.org>
References: <20200327121111.1530-1-kraxel@redhat.com>
 <20200327121111.1530-6-kraxel@redhat.com>
 <20200327153340.519fac3f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200327153340.519fac3f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > -static Aml *build_com_device_aml(uint8_t uid)
> > +static void build_com_device_aml(Aml *scope, uint8_t uid)
> >  {
> >      Aml *dev;
> >      Aml *crs;
> > -    Aml *method;
> > -    Aml *if_ctx;
> > -    Aml *else_ctx;
> > -    Aml *zero =3D aml_int(0);
> > -    Aml *is_present =3D aml_local(0);
> > -    const char *enabled_field =3D "CAEN";
> >      uint8_t irq =3D 4;
> >      uint16_t io_port =3D 0x03F8;
> > =20
> >      assert(uid =3D=3D 1 || uid =3D=3D 2);
> >      if (uid =3D=3D 2) {
> > -        enabled_field =3D "CBEN";
> >          irq =3D 3;
> >          io_port =3D 0x02F8;
> >      }
> > +    if (!memory_region_present(get_system_io(), io_port)) {
>                                   ^^^^^^
> even though acpi_setup() is a part of board code, usually it's not recomm=
ended to=20
> use get_system_foo() outside of machine_init()
>=20
> how about fishing out present serial ports from isa device in a helper
> like acpi_get_misc_info(), and then generalize AML like
>    build_com_device_aml(Aml *scope, uint8_t uid, io_port, irq)

Hmm, I'm wondering whenever it would be useful to have ...

   ISADeviceClass->build_aml(Aml *scope, ISADevice *dev);

... then just walk all isa devices and call the handler
(if present).  Maybe the same for sysbus.

cheers,
  Gerd


