Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8158C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C8220EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Etknw65e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C8220EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0su-0005ej-1q
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW0rq-0005Aa-Pl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW0rn-0000pn-I8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603474117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4B9HjSFH3WCMv3APy5oLWe35uzGvHymgqmqQgiBcZo=;
 b=Etknw65eGoupy6RM+PrEaMXK5IGqjGxfgrBrcVir3Kf9vWKwWyxzNl3xUKLWAhHxdezR8r
 Yvg7oLNm6oXsL7NAGi2dyrUZ4SFsTSuYkygrTGMtBzOhB4goIK7LXHUsVS3MAw+ZoSU6N+
 jI1N5ZRWuLPjNslhaBOKQrWC8Qp8/W8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-Uv3A92SNOlCZpmVGpZ-Jbg-1; Fri, 23 Oct 2020 13:28:36 -0400
X-MC-Unique: Uv3A92SNOlCZpmVGpZ-Jbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 522788DFFF7;
 Fri, 23 Oct 2020 17:28:21 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5040981F41;
 Fri, 23 Oct 2020 17:27:57 +0000 (UTC)
Date: Fri, 23 Oct 2020 19:27:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201023192755.1845b060@redhat.com>
In-Reply-To: <20201023115029-mutt-send-email-mst@kernel.org>
References: <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <20201023144901.5bd908a1@yekko.fritz.box>
 <CAC_L=vUh8LU5c8c00OhnbEiW7EzZFWKU61vOdub7c11wDMXeRg@mail.gmail.com>
 <20201023115029-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Libvirt Mailing List <libvir-list@redhat.com>,
 David Gibson <dgibson@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 11:54:40 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Oct 23, 2020 at 09:47:14AM +0300, Marcel Apfelbaum wrote:
> > Hi David,
> >=20
> > On Fri, Oct 23, 2020 at 6:49 AM David Gibson <dgibson@redhat.com> wrote=
:
> >=20
> >     On Thu, 22 Oct 2020 11:01:04 -0400
> >     "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> >     > On Thu, Oct 22, 2020 at 05:50:51PM +0300, Marcel Apfelbaum wrote:
> >     >=C3=83=E2=80=9A=C3=82=C2=A0 [...]=C3=83=E2=80=9A=C3=82=C2=A0
> >     >
> >     > Right. After detecting just failing unconditionally it a bit too
> >     > simplistic IMHO. =20
> >=20
> >     There's also another factor here, which I thought I'd mentioned
> >     already, but looks like I didn't: I think we're still missing some
> >     details in what's going on.
> >=20
> >     The premise for this patch is that plugging while the indicator is =
in
> >     transition state is allowed to fail in any way on the guest side.=
=C3=83=E2=80=9A=C3=82=C2=A0 I
> >     don't think that's a reasonable interpretation, because it's unwork=
able
> >     for physical hotplug.=C3=83=E2=80=9A=C3=82=C2=A0 If the indicator s=
tarts blinking while you're in
> >     the middle of shoving a card in, you'd be in trouble.
> >=20
> >     So, what I'm assuming here is that while "don't plug while blinking=
" is
> >     the instruction for the operator to obey as best they can, on the g=
uest
> >     side the rule has to be "start blinking, wait a while and by the ti=
me
> >     you leave blinking state again, you can be confident any plugs or
> >     unplugs have completed".=C3=83=E2=80=9A=C3=82=C2=A0 Obviously still=
 racy in the strict computer
> >     science sense, but about the best you can do with slow humans in th=
e
> >     mix.
> >=20
> >     So, qemu should of course endeavour to follow that rule as though i=
t
> >     was a human operator on a physical machine and not plug when the
> >     indicator is blinking.=C3=83=E2=80=9A=C3=82=C2=A0 *But* the qemu pl=
ug will in practice be fast
> >     enough that if we're hitting real problems here, it suggests the gu=
est
> >     is still doing something wrong.
> >=20
> >=20
> > I personally think there is a little bit of over-engineering=C3=83=E2=
=80=9A=C3=82=C2=A0here.
> > Let's start with the spec:
> >=20
> > =C3=83=E2=80=9A=C3=82=C2=A0 =C3=83=E2=80=9A=C3=82=C2=A0 Power Indicator=
 Blinking
> > =C3=83=E2=80=9A=C3=82=C2=A0 =C3=83=E2=80=9A=C3=82=C2=A0 A blinking Powe=
r Indicator indicates that the slot is powering up or
> > powering down and that
> > =C3=83=E2=80=9A=C3=82=C2=A0 =C3=83=E2=80=9A=C3=82=C2=A0 insertion or re=
moval of the adapter is not permitted.
> >=20
> > What exactly is an interpretation here?
> > As you stated, the races are theoretical, the whole point of the indica=
tor
> > is to let the operator know he can't plug the device just yet.
> >=20
> > I understand it would be more user friendly if the QEMU would wait inte=
rnally
> > for the
> > blinking to end, but the whole point of the indicator is to let the ope=
rator=C3=83=E2=80=9A=C3=82=C2=A0
> > (human or machine)
> > know they can't plug the device at a specific time.
> > Should QEMU take the responsibility=C3=83=E2=80=9A=C3=82=C2=A0of the op=
erator? Is it even correct?
> >=20
> > Even if we would want such a feature, how is it related to this patch?
> > The patch simply refuses to start a hotplug operation when it knows it =
will not
> > succeed.=C3=83=E2=80=9A=C3=82=C2=A0
> > =C3=83=E2=80=9A=C3=82=C2=A0
> > Another way that would make sense to me would be=C3=83=E2=80=9A=C3=82=
=C2=A0 is a new QEMU interface other
> > than
> > "add_device", let's say "adding_device_allowed", that would return true=
 if the
> > hotplug is allowed
> > at this point of time. (I am aware of the theoretical races)=C3=83=E2=
=80=9A=C3=82=C2=A0 =20
>=20
> Rather than adding_device_allowed, something like "query slot"
> might be helpful for debugging. That would help user figure out
> e.g. why isn't device visible without any races.

Would be new command useful tough? What we end up is broken guest
(if I read commit message right) and a user who has no idea if=20
device_add was successful or not.
So what user should do in this case
  - wait till it explodes?
  - can user remove it or it would be stuck there forever?
  - poll slot before hotplug, manually?

(if this is the case then failing device_add cleanly doesn't sound bad,
it looks similar to another error we have "/* Check if hot-plug is disabled=
 on the slot */"
in pcie_cap_slot_pre_plug_cb)

CCing libvirt, as it concerns not only QEMU.

>=20
> > The above will at least mimic the mechanics of the pyhs=C3=83=E2=80=9A=
=C3=82=C2=A0world.=C3=83=E2=80=9A=C3=82=C2=A0 The operator
> > looks at the indicator,
> > the management software checks if adding the device is allowed.
> > Since it is a corner case I would prefer the device_add to fail rather =
than
> > introducing a new interface,
> > but that's just me.
> >=20
> > Thanks,
> > Marcel
> >  =20
>=20
> I think we want QEMU management interface to be reasonably
> abstract and agnostic if possible. Pushing knowledge of hardware
> detail to management will just lead to pain IMHO.
> We supported device_add which practically never fails for years,

For CPUs and RAM, device_add can fail so maybe management is also
prepared to handle errors on PCI hotplug path.

> at this point it's easier to keep supporting it than
> change all users ...
>=20
>=20
> >=20
> >     --
> >     David Gibson <dgibson@redhat.com>
> >     Principal Software Engineer, Virtualization, Red Hat
> >  =20
>=20
>=20


