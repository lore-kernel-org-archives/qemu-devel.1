Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A68D20705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0eMngF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A68D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVe0O-00076Y-L8
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jVdz6-000599-TV
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:30:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jVdz5-0006CL-5O
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588609821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yc5krUnhJZepkd1Df4HEmtDb27H4TpHMPEuTHYyKtpM=;
 b=R0eMngF0xCtT0GTEHpV1flgRHPNv4OJfChItnXdMeGjGTpXdCkQbwXrobsk/TWQP/ZVKPV
 ZRxK0qqqsVMBlVyRgb+uppos705Oipy2p92378DQVn9fVdemabcbUa9IzPRrEWrmtukU15
 YJNxec78Al74nYz9XrgChA4bQWdAoZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-p7HNtdxqPyeV97NWXuAkNg-1; Mon, 04 May 2020 12:30:19 -0400
X-MC-Unique: p7HNtdxqPyeV97NWXuAkNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58CB4800D24;
 Mon,  4 May 2020 16:30:18 +0000 (UTC)
Received: from localhost (ovpn-115-57.phx2.redhat.com [10.3.115.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7C8F63BBA;
 Mon,  4 May 2020 16:30:13 +0000 (UTC)
Date: Mon, 4 May 2020 12:30:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: Configuring onboard devices
Message-ID: <20200504163012.GO5244@habkost.net>
References: <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
 <51a4e9ea-eca3-6c1d-a753-86c5810ac094@ilande.co.uk>
 <874kt1dpw7.fsf@dusky.pond.sub.org>
 <c1fa0770-a07f-e5bc-9db8-6af0576c365f@ilande.co.uk>
 <877dxxc862.fsf@dusky.pond.sub.org>
 <0b745eed-841e-8879-c320-3166e2a46953@ilande.co.uk>
 <87imhe6g7v.fsf@dusky.pond.sub.org>
 <a0167fcc-b213-25e2-6ea2-62f2a0237a2f@ilande.co.uk>
MIME-Version: 1.0
In-Reply-To: <a0167fcc-b213-25e2-6ea2-62f2a0237a2f@ilande.co.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 03, 2020 at 11:13:41PM +0100, Mark Cave-Ayland wrote:
> On 02/05/2020 06:47, Markus Armbruster wrote:
>=20
> > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> >=20
> >> On 30/04/2020 16:20, Markus Armbruster wrote:
> >>
> >>>> Ah I see now, these aliases are for individual properties rather tha=
n objects. What I
> >>>> was trying to ask was if it were possible to have something like thi=
s:
> >>>>
> >>>> /machine (SS-5-machine)
> >>>>   /builtin
> >>>>     /nic0 -> link to "lance" device
> >>>>
> >>>> Here nic0 is an alias "published" by the maintainer of the SS-5 mach=
ine which is
> >>>> configured in the machine init() function using object_property_add_=
link() or a
> >>>> suitable wrapper. Users can then configure these builtin devices fro=
m the command
> >>>> line using your -machine nic0.netdev=3Dmy-netdev-id syntax or simila=
r.
> >>>
> >>> Got it now, thanks!
> >>>
> >>>> Having the default devices under /builtin or other known QOM path wo=
uld enable
> >>>> builtin devices to be easily enumerated programatically and/or from =
the command line
> >>>> as required.
> >>>
> >>> There are three standard containers under /machine/:
> >>>
> >>> * /machine/peripheral/
> >>>
> >>>   Devices with a user-specified ID go here, as /machine/peripheral/ID=
.
> >>>   User-specified means -device or device_add.
> >>>
> >>>   /machine/peripheral/ID is effectively a stable interface.  It's jus=
t
> >>>   underdocumented (undocumented?).
> >>>
> >>>   To be useful, the stuff below ID/ needed to be stable and documente=
d,
> >>>   too.
> >>>
> >>> * /machine/peripheral-anon/
> >>>
> >>>   Same, but user elected not to give an ID.
> >>>   /machine/peripheral-anon/device[N], where N counts up from zero in
> >>>   creation order.
> >>>
> >>>   N is obviously not stable, but this is a problem of the user's maki=
ng.
> >>>   If you want to refer to a device, give it an ID.
> >>>
> >>> * /machine/unattached/
> >>>
> >>>   The orphanage.  When a device has no parent when its realized, it g=
ets
> >>>   put here, as /machine/unattached/device[N], where N counts up from
> >>>   zero in realization order.
> >>>
> >>>   N is obviously not stable, and this time we can't blame the
> >>>   victim^Wuser.  You can search for devices of a certain type.
> >>>   Sometimes that's good enough.
> >>>
> >>>   All the onboard devices are here, and much more.  We've fathered a =
lot
> >>>   of unloved red-headed children, it seems...
> >>>
> >>>   Some of the "much more" is due to sloppy modelling, i.e. neglecting=
 to
> >>>   set the proper parent.
> >>>
> >>>   I figure we could put onboard devices in a nicer place, with nicer
> >>>   names.  Need a convention for the place and the names, then make bo=
ard
> >>>   code conform to it.
> >>
> >> That's good, it seems that this is already fairly close to how it work=
s for -device
> >> at the moment.
> >>
> >> I don't think that it is possible to come up a single place for on-boa=
rd devices to
> >> live directly though. Going back to one of my first examples: wiring u=
p a chardev to
> >> a serial port on the macio device. To me it makes sense for that to ex=
ist in QOM
> >> under /machine/pci-bus/mac-io/escc. In contrast an in-built NIC could =
live under
> >> /machine/pci-bus/in-built/nic, and placing one or both of these device=
s directly
> >> under /machine/foo doesn't feel intuitive.
> >=20
> > I'm not familiar with this machine.  You make me suspect the serial
> > thingy is a component of a larger device.
> >=20
> > Properly modelled, a composite device has its components as children.
> > These appear below their parent in the QOM composition tree.
> >=20
> > Example: a "serial-isa" device has a "serial" component.  When the
> > former is at /machine/unattached/device[28]/, the latter is at
> > /machine/unattached/device[28]/serial/.
> >=20
> > I guess that's what you want for macio's serial port.
> >=20
> > Counter-example: a "isa-super-io" device has compoenents of type
> > "isa-parallel", "isa-serial", "isa-fdc", "i8042", "isa-ide".
> > Nevertheless, these appear next to their parent in /machine/unattached/=
.
> > I'm still too much of a QOM ignoramus to explain why that's so.  Paolo,
> > can you?
>=20
> FWIW the older machines have a lot of calls to qdev_create(NULL, TYPE_FOO=
) for
> devices that are part of the machine because they live within the machine=
 address
> space but are not specifically attached to a qbus.
>=20
> >> AFAIK as per your ARM virt example I believe it is only possible to re=
gister an alias
> >> for a property rather than for an Object? The ultimate aim would be fo=
r
> >> object_resolve_path("/machine/builtin/nic0") and
> >> object_resolve_path("/machine/pci-bus/in-built/nic") to return the sam=
e Object, and
> >> for the aliases on built-in devices to be children of /machine/builtin=
 to allow easy
> >> iteration and introspection.
> >=20
> > Paolo, could link properties achieve that?
> >=20
> > Mark, I guess you want the alias / link from builtin/nic0 to the actual
> > place to simplify configuration: the user then needs to know less about
> > the board.  Correct?
>=20
> Correct. In a perfect world I'd love to say that Daniel's suggestion to u=
se QOM paths
> would work, however from my experience they change far too much. This is =
one of the
> reasons that the TYPE_FW_PATH_PROVIDER interface exists so that the gener=
ation of
> (boot) paths for the firmware is separate from the QOM/qdev paths.
>=20
> I don't feel too strongly whether it's a link property, some kind of alia=
s, or
> perhaps like OpenFirmware just a string property containing the QOM path =
to the
> device, since ultimately I imagine there would be wrapper functions for m=
achine
> init() to call which hide away the implementation details.

Whatever solution we use to make sure a new interface is stable,
we must have automated test cases to ensure we don't break it in
the future.  Otherwise we will be creating yet another
compatibility-keeping ritual that we fail to follow because
nobody notices when we break it.

I wouldn't like to move from "2 different object paths that can't
be trusted to be stable" to "3 different object paths that can't
be trusted to be stable".

--=20
Eduardo


