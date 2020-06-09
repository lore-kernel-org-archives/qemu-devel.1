Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C162072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo0rULpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C162072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigeH-0000N9-J2
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jigdG-0007zB-J1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:57:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jigdE-00028a-NA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591718263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNs9jeteGY+3kn+q6WZJCMkhC/sM0vD18diT76nN1QA=;
 b=eo0rULpoWv+IVYeHlDQ2KRlrEqtH1wj/nssK/N99SJq/MGnFQRTup+2sVdHa9G8K/rxxMs
 E0SnP9OLuMAzBD9TFycxcCMX9koY4IM8DMMvw3jBFkb8GyMC7kHzeQO7fESXGfNh80HOno
 152qGBVXcSpzsYn59hzrXCKJQyEp4pY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-nxwQf534OEWcZiQKhDJzQA-1; Tue, 09 Jun 2020 11:57:35 -0400
X-MC-Unique: nxwQf534OEWcZiQKhDJzQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2820107ACCD;
 Tue,  9 Jun 2020 15:57:33 +0000 (UTC)
Received: from gondolin (ovpn-114-205.ams2.redhat.com [10.36.114.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2D8719D61;
 Tue,  9 Jun 2020 15:57:27 +0000 (UTC)
Date: Tue, 9 Jun 2020 17:57:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200609175715.26dc7bf8.cohuck@redhat.com>
In-Reply-To: <20200609174046.0a0d83b9.pasic@linux.ibm.com>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
 <20200606162014-mutt-send-email-mst@kernel.org>
 <20200607030735.GN228651@umbus.fritz.box>
 <20200609121641.5b3ffa48.cohuck@redhat.com>
 <20200609174046.0a0d83b9.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/1m1XVfImDtpqQRNdANZgJAd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/1m1XVfImDtpqQRNdANZgJAd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2020 17:40:46 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 9 Jun 2020 12:16:41 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Sun, 7 Jun 2020 13:07:35 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Sat, Jun 06, 2020 at 04:21:31PM -0400, Michael S. Tsirkin wrote: =
=20
> > > > On Thu, May 21, 2020 at 01:43:04PM +1000, David Gibson wrote:   =20
> > > > > The default behaviour for virtio devices is not to use the platfo=
rms normal
> > > > > DMA paths, but instead to use the fact that it's running in a hyp=
ervisor
> > > > > to directly access guest memory.  That doesn't work if the guest'=
s memory
> > > > > is protected from hypervisor access, such as with AMD's SEV or PO=
WER's PEF.
> > > > >=20
> > > > > So, if a guest memory protection mechanism is enabled, then apply=
 the
> > > > > iommu_platform=3Don option so it will go through normal DMA mecha=
nisms.
> > > > > Those will presumably have some way of marking memory as shared w=
ith the
> > > > > hypervisor or hardware so that DMA will work.
> > > > >=20
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > ---
> > > > >  hw/core/machine.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index 88d699bceb..cb6580954e 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -28,6 +28,8 @@
> > > > >  #include "hw/mem/nvdimm.h"
> > > > >  #include "migration/vmstate.h"
> > > > >  #include "exec/guest-memory-protection.h"
> > > > > +#include "hw/virtio/virtio.h"
> > > > > +#include "hw/virtio/virtio-pci.h"
> > > > > =20
> > > > >  GlobalProperty hw_compat_5_0[] =3D {};
> > > > >  const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
> > > > > @@ -1159,6 +1161,15 @@ void machine_run_board_init(MachineState *=
machine)
> > > > >           * areas.
> > > > >           */
> > > > >          machine_set_mem_merge(OBJECT(machine), false, &error_abo=
rt);
> > > > > +
> > > > > +        /*
> > > > > +         * Virtio devices can't count on directly accessing gues=
t
> > > > > +         * memory, so they need iommu_platform=3Don to use norma=
l DMA
> > > > > +         * mechanisms.  That requires disabling legacy virtio su=
pport
> > > > > +         * for virtio pci devices
> > > > > +         */
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-leg=
acy", "on");
> > > > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_pl=
atform", "on");
> > > > >      }
> > > > >     =20
> > > >=20
> > > > I think it's a reasonable way to address this overall.
> > > > As Cornelia has commented, addressing ccw as well   =20
> > >=20
> > > Sure.  I was assuming somebody who actually knows ccw could do that a=
s
> > > a follow up. =20
> >=20
> > FWIW, I think we could simply enable iommu_platform for protected
> > guests for ccw; no prereqs like pci's disable-legacy.
> >  =20
>=20
> For s390x having a memory-encryption object is not prereq for doing
> protected virtualization, so the scheme does not work for us right now.

Yeah, that would obviously need to be added first.

>=20
> I hope Jansoch will chime in after he is back from his vacation. IMHO
> having a memory-protection object will come in handy for migration,
> but the presence or absence of this object should be largely transparent
> to the user (and not something that needs to be explicitly managed via
> command line). AFAIU this object is in the end it is just QEMU plumbing.
>=20
> > >  =20
> > > > as cases where user has
> > > > specified the property manually could be worth-while.   =20
> > >=20
> > > I don't really see what's to be done there.  I'm assuming that if the
> > > user specifies it, they know what they're doing - particularly with
> > > nonstandard guests there are some odd edge cases where those
> > > combinations might work, they're just not very likely. =20
> >=20
> > If I understood Halil correctly, devices without iommu_platform
> > apparently can crash protected guests on s390. Is that supposed to be a
> > "if it breaks, you get to keep the pieces" situation, or do we really
> > want to enforce iommu_platform? =20
>=20
> I strongly oppose to adopting the "if it breaks, you get to keep the
> pieces" strategy here. It is borderline acceptable on startup, although
> IMHO not preferable, but a device hotplug bringing down a guest that is
> already running userspace is not acceptable at all.

There's still the option to fail to add such a device, though.

--Sig_/1m1XVfImDtpqQRNdANZgJAd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl7fsVsACgkQ3s9rk8bw
L6/luw//crG/w8vGDPyO1tMEdwanZmr0GSRCJVQWv7IH0x4Sp18c0cgu3/Fqk323
KZIEf8LLb4IpyOG6jGiahYSWpO0ugn/cF9ABraTpQxCDqoJwnw6O1yoZ+/PizZRJ
cydd16TNwC4ygTxJJ+SE5ozuG4/QzsDn0h5njD4WuAuGQcAwZQUfyy+XrGNgEN3n
sTFSsbvuYgGBlu+WADUo5WyuSc79QppRasLQX/p4+u6M1Laye588SN871BNyU3Uu
svo+iCBmy+PImc0wpDmTx7laJNiNOuOMrTuf+EEqnq0SEBjXGMX3Q8WewheoZomB
PavCkM3eBx620jsaBv8dUb18NjD8+ijLZmTprbpSu0zMcmwV1Q90GebZPXC6Tk+s
XBsBt8bcmGzZ5AU5NiMw1VoWVmGLEbnnyZ4zuGxxs1AjtU4rXeWxB40KStaS8f0+
7iZCd+UEMQUZdx/1qZJS3+ftfmfotI5j/3dCoB9ZLR/UbXCQoFdAUPTCew4WO2Im
6IRttLEfSBqu6HueaazUTG92XFegYQCI/Zfa//n7l0KV2e+BGcVW4KTP582nTqCN
KD6vMj16rUupVaT5PiqNor9ICRm53MlHBa6f49dGSlX4o+9EOQXGsp5XFURxxZOa
o9rrmXlMDmLibgZmi34EZ+c9lXMtF0mp4oHf+W6LRFvAsd33mGM=
=jAji
-----END PGP SIGNATURE-----

--Sig_/1m1XVfImDtpqQRNdANZgJAd--


