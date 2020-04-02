Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22387206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6oC+m5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22387206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJxOV-0008BE-8f
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJxNJ-0007LV-C6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJxNI-0003hn-1S
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:47:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJxNH-0003hV-Td
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585824423;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oj2jCV+QffT5ZsFLH2wdxDyEyDufsbRcfkbfz/rZwt8=;
 b=C6oC+m5QgHKS2l2GrluGJ5W1ts5K1IjLLhFKkrzZIjLX+GROOSL3O17oV8knbKgu4JWxva
 t2FhSw85N8FEZwIDX4SdHW+OH99+yibbzPVjzk95YCkpK8aDjCyXyeecSJfn20sUkDF2e/
 CFZmzFOi6I9T73IOQfn/xJx11Cftcec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-J4A7q5j2PmCXtkmrOLzFWw-1; Thu, 02 Apr 2020 06:47:01 -0400
X-MC-Unique: J4A7q5j2PmCXtkmrOLzFWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CAC1107ACC4;
 Thu,  2 Apr 2020 10:46:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C7A50BEE;
 Thu,  2 Apr 2020 10:46:48 +0000 (UTC)
Date: Thu, 2 Apr 2020 11:46:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200402104645.GF423991@redhat.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MN2PR02MB620500A5010B71F1C0D8695E8BC90@MN2PR02MB6205.namprd02.prod.outlook.com>
 <CAJ+F1CLU4kPK1Tw3X7oTAWtUp0Q4Q=wm3-Uj-_2JO09vq0paBg@mail.gmail.com>
 <20200402101942.GF28280@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200402101942.GF28280@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 11:19:42AM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 01, 2020 at 06:58:20PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > On Wed, Apr 1, 2020 at 5:51 PM Thanos Makatos
> > <thanos.makatos@nutanix.com> wrote:
> > > > > Bear in mind that since this is just a PoC lots of things can bre=
ak, e.g. some
> > > > > system call not intercepted etc.
> > > >
> > > > Cool, I had a quick look at libvfio and how the transport integrate=
s
> > > > into libmuser.  The integration on the libmuser side is nice and sm=
all.
> > > >
> > > > It seems likely that there will be several different implementation=
s of
> > > > the vfio-over-socket device side (server):
> > > > 1. libmuser
> > > > 2. A Rust equivalent to libmuser
> > > > 3. Maybe a native QEMU implementation for multi-process QEMU (I thi=
nk JJ
> > > >    has been investigating this?)
> > > >
> > > > In order to interoperate we'll need to maintain a protocol
> > > > specification.  Mayb You and JJ could put that together and CC the =
vfio,
> > > > rust-vmm, and QEMU communities for discussion?
> > >
> > > Sure, I can start by drafting a design doc and share it.
> >=20
> > ok! I am quite amazed you went this far with a ldpreload hack. This
> > demonstrates some limits of gpl projects, if it was necessary.
> >=20
> > I think with this work, and the muser experience, you have a pretty
> > good idea of what the protocol could look like. My approach, as I
> > remember, was a quite straightforward VFIO over socket translation,
> > while trying to see if it could share some aspects with vhost-user,
> > such as memory handling etc.
> >=20
> > To contrast with the work done on qemu-mp series, I'd also prefer we
> > focus our work on a vfio-like protocol, before trying to see how qemu
> > code and interface could be changed over multiple binaries etc. We
> > will start with some limitations, similar to the one that apply to
> > VFIO: migration, introspection, managements etc are mostly left out
> > for now. (iow, qemu-mp is trying to do too many things simultaneously)
>=20
> qemu-mp has been cut down significantly in order to make it
> non-invasive.  The model is now much cleaner:
> 1. No monitor command or command-line option forwarding.  The device
>    emulation program has its own command-line and monitor that QEMU
>    doesn't know about.
> 2. No per-device proxy objects.  A single RemotePCIDevice is added to
>    QEMU.  In the current patch series it only supports the LSI SCSI
>    controller but once the socket protocol is changed to
>    vfio-over-socket it will be possible to use any PCI device.
>=20
> We recently agreed on dropping live migration to further reduce the
> patch series.  If you have specific suggestions, please post reviews on
> the latest patch series.

To clarify - the decision was to *temporarily* drop live migration, to
make the initial patch series smaller and thus easier to merge. It does
ultimately need live migration, so there would be followup patch series
to provide migration support, after the initial merge.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


