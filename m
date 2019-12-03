Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539BEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AD020659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5pO3lXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AD020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icGLa-00051G-4E
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1icFwI-0002c8-9n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1icFu7-0004LS-Ru
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:40:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1icFu7-0004Ak-MZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575409217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOi89gzNqsTMPqqa7zoMVPrp+8R/hVc7lgq/F85BMvo=;
 b=L5pO3lXjA1EJUhd48W2jZljuXykSQu5LDY/jw6uZmOQJw7ap0bFBl7AisLHqATCCBzThgp
 et3AtbJG8F00Nv1hD6damrmmzT7rG2fDVpepC/pxqw1fVPP1gBWFKr8H0MDEKtPmuPJnaa
 onVV4HmVZNxj4lA8y6vprOSxb3QZ8rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-vV21BReHPeaps9YTRT40yw-1; Tue, 03 Dec 2019 16:40:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A143F10054E3;
 Tue,  3 Dec 2019 21:40:14 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A52D19C68;
 Tue,  3 Dec 2019 21:40:05 +0000 (UTC)
Date: Tue, 3 Dec 2019 18:40:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
Message-ID: <20191203214004.GS14595@habkost.net>
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128182705.0635d1d4@redhat.com>
 <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
 <20191129132641.4c7da6c5@redhat.com>
 <CAFEAcA_gcxqu+N5iV0L5WLyWmm5yxTFNMtmqQryBgVd4CCCT8A@mail.gmail.com>
 <20191129200545.GG14595@habkost.net>
 <CAFEAcA-BkETOSpOwBegDcbO3bqxDO_a9xoTB7Fc8Ajw_+CDcFA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-BkETOSpOwBegDcbO3bqxDO_a9xoTB7Fc8Ajw_+CDcFA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vV21BReHPeaps9YTRT40yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+jfreimann, +mst

On Sat, Nov 30, 2019 at 11:10:19AM +0000, Peter Maydell wrote:
> On Fri, 29 Nov 2019 at 20:05, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
> > So, to summarize the current issues:
> >
> > 1) realize triggers a plug operation implicitly.
> > 2) unplug triggers unrealize implicitly.
> >
> > Do you expect to see use cases that will require us to implement
> > realize-without-plug?
>=20
> I don't think so, but only because of the oddity that
> we put lots of devices on the 'sysbus' and claim that
> that's plugging them into the bus. The common case of
> 'realize' is where one device (say an SoC) has a bunch of child
> devices (like UARTs); the SoC's realize method realizes its child
> devices. Those devices all end up plugged into the 'sysbus'
> but there's no actual bus there, it's fictional and about
> the only thing it matters for is reset propagation (which
> we don't model right either). A few devices don't live on
> buses at all.

That's my impression as well.

>=20
> > Similarly, do you expect use cases that will require us to
> > implement unplug-without-unrealize?
>=20
> I don't know enough about hotplug to answer this one:
> it's essentially what I'm hoping you'd be able to answer.
> I vaguely had in mind that eg the user might be able to
> create a 'disk' object, plug it into a SCSI bus, then
> unplug it from the bus without the disk and all its data
> evaporating, and maybe plug it back into the SCSI
> bus (or some other SCSI bus) later ? But I don't know
> anything about how we expose that kind of thing to the
> user via QMP/HMP.

This ability isn't exposed to the user at all.  Our existing
interfaces are -device, device_add and device_del.

We do have something new that sounds suspiciously similar to
"unplugged but not unrealized", though: the new hidden device
API, added by commit f3a850565693 ("qdev/qbus: add hidden device
support").

Jens, Michael, what exactly is the difference between a "hidden"
device and a "unplugged" device?

--=20
Eduardo


