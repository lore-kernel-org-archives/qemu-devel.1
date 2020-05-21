Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BB32072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4MxR/RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BB32072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblBS-00074d-TR
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jblAt-0006P9-1M
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:23:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jblAq-0003aI-8Z
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590067427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69+0jpmi4aaJAaSRKaPOfFRtIFsEMvq+Hz8ebExXVvU=;
 b=Y4MxR/RMKBrKqFUew7sXWjl0cKE1eFdBb4KqfwcG7+FhxcQpQBR2PjGB204vWVDvGdK4MF
 Z6PxVbmepUpA3R6uFuT8plSPeB/zWPHSx3mLUcl13pOHVxMmPhi3laOYssJEi//EP8rKDd
 CM8hSzTs8r+igwDAlw+e7OkOBDj3Ke4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-ldPLOJYiMVqFahhAjcTiQg-1; Thu, 21 May 2020 09:23:46 -0400
X-MC-Unique: ldPLOJYiMVqFahhAjcTiQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCEFD1005510;
 Thu, 21 May 2020 13:23:44 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3B4A6606D;
 Thu, 21 May 2020 13:23:33 +0000 (UTC)
Date: Thu, 21 May 2020 15:23:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200521152330.5958bae1@redhat.com>
In-Reply-To: <20200521060511-mutt-send-email-mst@kernel.org>
References: <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
 <20200520114354.1982cb63@nas.mammed.net>
 <20200520054714-mutt-send-email-mst@kernel.org>
 <20200520115626.6a2a2355@nas.mammed.net>
 <20200520060645-mutt-send-email-mst@kernel.org>
 <20200520130547.7ac568b8@nas.mammed.net>
 <20200520072055-mutt-send-email-mst@kernel.org>
 <20200520142012.5394b2f6@nas.mammed.net>
 <20200520121043-mutt-send-email-mst@kernel.org>
 <20200521093217.4f440fbc@nas.mammed.net>
 <20200521060511-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Laine Stump <laine@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 06:07:25 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, May 21, 2020 at 09:32:17AM +0200, Igor Mammedow wrote:
> > On Wed, 20 May 2020 12:13:35 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > On Wed, May 20, 2020 at 02:20:12PM +0200, Igor Mammedow wrote: =20
> > > > On Wed, 20 May 2020 07:23:21 -0400
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >    =20
> > > > > On Wed, May 20, 2020 at 01:05:47PM +0200, Igor Mammedow wrote:   =
=20
> > > > > > On Wed, 20 May 2020 06:28:37 -0400
> > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > >      =20
> > > > > > > On Wed, May 20, 2020 at 11:56:26AM +0200, Igor Mammedow
> > > > > > > wrote:     =20
> > > > > > > > On Wed, 20 May 2020 05:47:53 -0400
> > > > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > >        =20
> > > > > > > > > On Wed, May 20, 2020 at 11:43:54AM +0200, Igor Mammedow
> > > > > > > > > wrote:       =20
> > > > > > > > > > On Fri, 15 May 2020 12:13:53 +0000
> > > > > > > > > > Ani Sinha <ani.sinha@nutanix.com> wrote:
> > > > > > > > > >          =20
> > > > > > > > > > > > On May 14, 2020, at 1:13 AM, Igor Mammedov
> > > > > > > > > > > > <imammedo@redhat.com> wrote:          =20
> > > > > > > > > > > >>=20
> > > > > > > > > > > >>            =20
> > > > > > > > > > > >>> Will following hack work for you?
> > > > > > > > > > > >>> possible permutations
> > > > > > > > > > > >>> 1) ACPI hotplug everywhere
> > > > > > > > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=3Don -global
> > > > > > > > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Do=
n
> > > > > > > > > > > >>> -device pci-bridge,chassis_nr=3D1,shpc=3Ddoesnt_m=
atter
> > > > > > > > > > > >>> -device e1000,bus=3Dpci.1,addr=3D01,id=3Dnetdev1=
=20
> > > > > > > > > > > >>>=20
> > > > > > > > > > > >>> 2) No hotplug at all
> > > > > > > > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=3Doff -global
> > > > > > > > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Do=
n
> > > > > > > > > > > >>> -device pci-bridge,chassis_nr=3D1,shpc=3Doff -dev=
ice
> > > > > > > > > > > >>> e1000,bus=3Dpci.1,addr=3D01,id=3Dnetdev1
> > > > > > > > > > > >>>=20
> > > > > > > > > > > >>> -global PIIX4_PM.acpi-pci-hotplug=3Doff -global
> > > > > > > > > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=3Do=
ff
> > > > > > > > > > > >>> -device pci-bridge,chassis_nr=3D1,shpc=3Ddoesnt_m=
atter
> > > > > > > > > > > >>> -device e1000,bus=3Dpci.1,addr=3D01,id=3Dnetdev1
> > > > > > > > > > > >>>      =20
> > > > > > > > > > > >>=20
> > > > > > > > > > > >> Given that my patch is not acceptable, I=E2=80=99d=
 prefer
> > > > > > > > > > > >> the following in the order of preference:
> > > > > > > > > > > >>=20
> > > > > > > > > > > >> (a) Have an option to disable hot ejection of
> > > > > > > > > > > >> PCI-PCI bridge so that Windows does not even show
> > > > > > > > > > > >> this HW in the =E2=80=9Csafely remove HW=E2=80=9D =
option. If we
> > > > > > > > > > > >> can do this then from OS perspective the GUI
> > > > > > > > > > > >> options will be same as what is available with
> > > > > > > > > > > >> PCIE/q35 - none of the devices will be hot
> > > > > > > > > > > >> ejectable if the hot plug option is turned off
> > > > > > > > > > > >> from the PCIE slots where devices are plugged
> > > > > > > > > > > >> into. I looked at the code. It seems to manipulate
> > > > > > > > > > > >> ACPI tables of the empty slots of the root bus
> > > > > > > > > > > >> where no devices are attached (see comment "/* add
> > > > > > > > > > > >> hotplug slots for non present devices */ =E2=80=9C=
). For
> > > > > > > > > > > >> cold plugged bridges, it recurses down to scan the
> > > > > > > > > > > >> slots of the bridge. Is it possible to disable hot
> > > > > > > > > > > >> plug for the slot to which the bridge is attached?
> > > > > > > > > > > >>           =20
> > > > > > > > > > > >=20
> > > > > > > > > > > > I don't think it's possible to have per slot
> > > > > > > > > > > > hotplug on conventional PCI hardware. it's per
> > > > > > > > > > > > bridge property.  =20
> > > > > > > > > > >=20
> > > > > > > > > > > We add the AMLs per empty slot though. When the pic
> > > > > > > > > > > bridge is attached, we do nothing, just recurse into
> > > > > > > > > > > the bridge slots. That is what I was asking, if it wa=
s
> > > > > > > > > > > possible to just disable the AMLs or use some tricks
> > > > > > > > > > > to say that this particular slot is not hotpluggable.
> > > > > > > > > > > I am not sure why Windows is trying to eject the PCI
> > > > > > > > > > > bridge and failing. Maybe something related to this
> > > > > > > > > > > comment?
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > /* When hotplug for bridges is enabled, bridges are
> > > > > > > > > > >                              =20
> > > > > > > > > > >          * described in ACPI separately (see
> > > > > > > > > > > build_pci_bus_end).=20
> > > > > > > > > > >          * In this case they aren't themselves
> > > > > > > > > > > hot-pluggable.=20
> > > > > > > > > > >          * Hotplugged bridges *are* hot-pluggable.
> > > > > > > > > > > */         =20
> > > > > > > > > >=20
> > > > > > > > > > thinking some more on this topic, it seems that with
> > > > > > > > > > ACPI hotplug we already have implicit non-hotpluggble
> > > > > > > > > > slot (slot with bridge) while the rest are staying
> > > > > > > > > > hotpluggable.
> > > > > > > > > >=20
> > > > > > > > > > So my question is: if it's acceptable to add
> > > > > > > > > > 'PCIDevice::hotpluggable" property to all PCI devices s=
o
> > > > > > > > > > that user / libvirt could set it to false in case they
> > > > > > > > > > do not want coldplugged device be considered as
> > > > > > > > > > hotpluggable? (this way other devices could be treated
> > > > > > > > > > the same way as bridges)
> > > > > > > > > >=20
> > > > > > > > > > [...]         =20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > I think Julia already posted a patch adding this to
> > > > > > > > > downstream pcie bridges. Adding this to pci slots sounds
> > > > > > > > > like a reasonable thing.       =20
> > > > > > > > Question was more about external interface, were we do not
> > > > > > > > have ports as separate devices with conventional PCI. The
> > > > > > > > only knob we have is a a PCI device, where we have a
> > > > > > > > property to turn on/off hotplug. ex: -device
> > > > > > > > e1000,hotpluggable=3Doff and if libvirt would be able to us=
e
> > > > > > > > it       =20
> > > > > > >=20
> > > > > > > It would make sense but is it practical to add the capability
> > > > > > > is added in a generic way to all bridges and hosts?
> > > > > > > If not how do users probe for presence of the capability?    =
 =20
> > > > > > it probably won't work with native SHPC hotplug (which looks to
> > > > > > be incomplete in QEMU anyway), but it should work with ACPI and
> > > > > > per port PCIE hotplugs.
> > > > > > In case of SHPC, we probably should be able to cleanly error ou=
t
> > > > > > with 'unsupported' reason if  "hotpluggable" conflicts with
> > > > > > bridge policy.     =20
> > > > >=20
> > > > > "Try it and see if it works" is somewhat problematic from
> > > > > management POV since there's a never ending stream of new things
> > > > > they would have to try. If this approach is taken, we'd have to
> > > > > try to loop in some people from libvirt and see what's their
> > > > > take.   =20
> > > > to clarify, we are talking here about bridges to conventional
> > > > PCI with native SHPC hotplug semantics wrt mgmt and
> > > > potential pcidevice.hotpluggable property.
> > > > (the later should work fine in ACPI and PCIE hoptlug cases).
> > > >=20
> > > > currently by default pci bridges have property shpc=3Doff, so mgmt
> > > > should know that deals with PCI bridge and has to enable SHPC
> > > > on bridge explicitly,   =20
> > >=20
> > > Wait a second does that actually affect hotplug with ACPI too? =20
> > What do you mean exactly? =20
>=20
> I just tried to figure out why do you say
> "mgmt should know that deals with PCI bridge and has to enable SHPC
>  on bridge explicitly,"
> since on x86 bridges support hotplug through ACPI bypassing SHPC.

Current state in QEMU is that for ACPI hotplug, it doesn't have to do anyth=
ing
"acpi-pci-hotplug-with-bridge-support=3Don" by default and it's global sett=
ing for
coldplugged bridges, also it (sort of) overrides SHPC (even if was enabled =
with
'shpc=3Don' on a concrete coldplugged bridge).
(I wouldn't be surprised if mixing modes actually isn't functional)

Then there is hotplugged bridges (added at -S time or at runtime), for thos=
e
mgmt has to set 'shpc=3Don' explicitly to be able to hotplug devices into i=
t.
(so mgmt has to know that it's dealing wants SHPC and I suppose it can be t=
aught
that SHPC doesn't support mixed hotplug policy on slots/devices attached to=
 it).
Whether mgmt actually does something with shpc or not, I have no slightest =
idea.
(CCing Laine, perhaps he can clarify if we should care about SHPC here)


> > > > in which case it could probably be taught that
> > > > using conflicting hotpluggable for device attached to bridge and
> > > > shpc values is wrong thing.
> > > > If that's not it, then I'm not sure what kind of discovery you are
> > > > talking about.   =20
> > >=20
> > >=20
> > >=20
> > >  =20
>=20


