Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF9C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0DC22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP55PSwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0DC22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUvG-0006a4-Pn
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifUuY-00066n-Ny
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifUuW-0007aT-Pe
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:18:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifUuW-0007Z0-EC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576181887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGFdRK9zG9V0RRn6RjouUd6u6qy1KsDOc3FyCEoJruE=;
 b=LP55PSwnXBpbZmT8RtYc8e2eo+ctRAi6AM85E6i5OKnNrclVxM/gRH1hpJSNh2sou07Za3
 BUJb5MmKosfVGMNk8lWs2mhI3JTbfM/gqrtAzHxV5vAK2IEz9AQU+qvRhddz3alPcoRyBl
 BrEeTg5hI0ZE77fVY3xbCxCT6GvrWn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-o3BrMgcKNDOnSTfFpIGOKA-1; Thu, 12 Dec 2019 15:18:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C51CD802B60;
 Thu, 12 Dec 2019 20:18:02 +0000 (UTC)
Received: from work-vm (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D005A1001DE1;
 Thu, 12 Dec 2019 20:18:01 +0000 (UTC)
Date: Thu, 12 Dec 2019 20:17:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
Message-ID: <20191212201759.GF4282@work-vm>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAFEAcA82wRy0U-DzPr64s5QiKo6XmZM96O88c4-AY4zP926GPw@mail.gmail.com>
 <CAJ+F1CKwZJnJMFzc4Z1zsY3dZAsXL1SLaXYu8y0G7=u319DWDg@mail.gmail.com>
 <CAFEAcA8nSVe2kGU9kuBxb+5BGs7GRVUHf4aHR2kUwvRNF-9-EA@mail.gmail.com>
 <CAJ+F1CL6i05tt7LmY1opSTdKq6tdJomF20MU0btBwqW-FvRGYg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL6i05tt7LmY1opSTdKq6tdJomF20MU0btBwqW-FvRGYg@mail.gmail.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: o3BrMgcKNDOnSTfFpIGOKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Apologies for the delay.

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Sun, Dec 1, 2019 at 10:10 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Sun, 1 Dec 2019 at 17:27, Marc-Andr=E9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > >
> > > Hi
> > >
> > > On Sun, Dec 1, 2019 at 9:18 PM Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> > > >
> > > > On Sun, 1 Dec 2019 at 10:19, Marc-Andr=E9 Lureau
> > > > <marcandre.lureau@gmail.com> wrote:
> > > > >
> > > > > - "serial: register vmsd with DeviceClass"
> > > > >
> > > > > This is standard qdev-ification, however it breaks backward migra=
tion,
> > > > > but that's just how qdev_set_legacy_instance_id() works.
> > > >
> > > > I don't understand this part. Surely the whole point
> > > > of setting a legacy instance ID is exactly to preserve
> > > > migration compatibility? If it doesn't do that then what
> > > > does setting legacy ID value do?
> > > >
> > >
> > > It works in old->new direction only, because new code can match the
> > > legacy instance id.
> > >
> > > But when going from new->old, the legacy instance id is lost, as it
> > > uses new 0-based instance_id.
> >
> > I still don't understand. My mental model of the situation is:
> >
> >  * in the old (current) version of the code, the instance ID
> >    is some random thing resulting from what the old code does
>=20
> right
>=20
> >  * in the new version of the code, we use qdev_set_legacy_instance_id,
> >    and so instead of using the ID you'd naturally get as a
> >    written-from-scratch qdev device, it uses the legacy value
> >    you pass in
>=20
> no, it only sets the SaveStateEntry.alias_id, which is only used
> during incoming migration in find_se().
>=20
> Iow, it only works old->new.
>=20
> >  * thus the device/board in both old and new versions of QEMU
> >    uses the same value and migration in both directions works
>=20
> sadly no
>=20
> >
> > I don't understand why we would ever be using a "new 0-based
> > instance_id" -- it seems to me that the whole point of setting
> > a legacy ID value is that we will use it always, and I don't
> > understand how the board code can know that it's going to be
> > the target of an old->new migration as opposed to being the
> > source of a new->old migration such that it can end up with
> > a different ID value in the latter case.
>=20
> The target will find the "legacy" alias with find_se() on incoming
> migration, but any new outgoing migration will use the new 0-based
> instance_id
>=20
> >
> > If qdev_set_legacy_instance_id() doesn't work the way I
> > think it does above, what *does* it do ?
>=20
> just set the old alias_id for incoming migration.
>=20
> David, is that correct?

Yes, I think it is.
However, I'm curious which devices you're finding are explicitly setting
their id's;  there aren't many - although there are some that probably
should!
For example, running an x86 image with:
   -device isa-parallel,chardev=3D... -device isa-serial -device isa-serial=
 -trace enable=3Dqemu_loadvm_state_section_startfull

shows:
qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr,=
 uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"

165217@1576179638.856300:qemu_loadvm_state_section_startfull 41(serial) 0 3
165217@1576179638.856307:qemu_loadvm_state_section_startfull 42(serial) 1 3
165217@1576179638.856311:qemu_loadvm_state_section_startfull 43(parallel_is=
a) 0 1

so those two serial devices are instances '0' and '1' I think by luck of
their command line order, rather than having specified their base
address (which would have been safer).

Dave



> thanks
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


