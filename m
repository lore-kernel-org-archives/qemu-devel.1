Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42808C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D1D2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA31YCgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D1D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibKM-0002Pf-Ak
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jibJi-0001yu-0y
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:17:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23847
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jibJg-00013P-Fa
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591697831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3kr0diAHGiZkx5sVcjzLX57ALpozHuI6negv/a0mFBA=;
 b=UA31YCgNkJRchpx7iNb64Njkxb0X8o2czBRJMk6Z/bv2bBz2LbZVc8gLnXm7VHwYtSbPPS
 Ty+KHEpNye71kQIhPrycH6Gk7kgSPTjtaMKD+X+oGQ5l84RHx+zN3FTSOhiDwXvd28yAkl
 oI84cQPEoOePaIc3u9zYDAWk1oobhCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-V3CNbOdPNHu6H7I0haBEHw-1; Tue, 09 Jun 2020 06:17:01 -0400
X-MC-Unique: V3CNbOdPNHu6H7I0haBEHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FFA11054F8B;
 Tue,  9 Jun 2020 10:16:59 +0000 (UTC)
Received: from gondolin (ovpn-113-27.ams2.redhat.com [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9EA6100164C;
 Tue,  9 Jun 2020 10:16:53 +0000 (UTC)
Date: Tue, 9 Jun 2020 12:16:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200609121641.5b3ffa48.cohuck@redhat.com>
In-Reply-To: <20200607030735.GN228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
 <20200606162014-mutt-send-email-mst@kernel.org>
 <20200607030735.GN228651@umbus.fritz.box>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/59YR5Udn9lEsdlpWfEsPJrT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, mdroth@linux.vnet.ibm.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/59YR5Udn9lEsdlpWfEsPJrT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jun 2020 13:07:35 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Sat, Jun 06, 2020 at 04:21:31PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 21, 2020 at 01:43:04PM +1000, David Gibson wrote: =20
> > > The default behaviour for virtio devices is not to use the platforms =
normal
> > > DMA paths, but instead to use the fact that it's running in a hypervi=
sor
> > > to directly access guest memory.  That doesn't work if the guest's me=
mory
> > > is protected from hypervisor access, such as with AMD's SEV or POWER'=
s PEF.
> > >=20
> > > So, if a guest memory protection mechanism is enabled, then apply the
> > > iommu_platform=3Don option so it will go through normal DMA mechanism=
s.
> > > Those will presumably have some way of marking memory as shared with =
the
> > > hypervisor or hardware so that DMA will work.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/core/machine.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 88d699bceb..cb6580954e 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -28,6 +28,8 @@
> > >  #include "hw/mem/nvdimm.h"
> > >  #include "migration/vmstate.h"
> > >  #include "exec/guest-memory-protection.h"
> > > +#include "hw/virtio/virtio.h"
> > > +#include "hw/virtio/virtio-pci.h"
> > > =20
> > >  GlobalProperty hw_compat_5_0[] =3D {};
> > >  const size_t hw_compat_5_0_len =3D G_N_ELEMENTS(hw_compat_5_0);
> > > @@ -1159,6 +1161,15 @@ void machine_run_board_init(MachineState *mach=
ine)
> > >           * areas.
> > >           */
> > >          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> > > +
> > > +        /*
> > > +         * Virtio devices can't count on directly accessing guest
> > > +         * memory, so they need iommu_platform=3Don to use normal DM=
A
> > > +         * mechanisms.  That requires disabling legacy virtio suppor=
t
> > > +         * for virtio pci devices
> > > +         */
> > > +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy"=
, "on");
> > > +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platfo=
rm", "on");
> > >      }
> > >   =20
> >=20
> > I think it's a reasonable way to address this overall.
> > As Cornelia has commented, addressing ccw as well =20
>=20
> Sure.  I was assuming somebody who actually knows ccw could do that as
> a follow up.

FWIW, I think we could simply enable iommu_platform for protected
guests for ccw; no prereqs like pci's disable-legacy.

>=20
> > as cases where user has
> > specified the property manually could be worth-while. =20
>=20
> I don't really see what's to be done there.  I'm assuming that if the
> user specifies it, they know what they're doing - particularly with
> nonstandard guests there are some odd edge cases where those
> combinations might work, they're just not very likely.

If I understood Halil correctly, devices without iommu_platform
apparently can crash protected guests on s390. Is that supposed to be a
"if it breaks, you get to keep the pieces" situation, or do we really
want to enforce iommu_platform?

--Sig_/59YR5Udn9lEsdlpWfEsPJrT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl7fYYkACgkQ3s9rk8bw
L6+Ogg/8CyUEKbMCFVoEYeE2/cCowf+ZgHo/5pBTjZPrDK4kczqle2Ggjpzan8Li
suuCWtxUT44MBJYecjUH6NQ9Y26Q/vhKLRKFSOeY/Tgxg2mrt4e+ZiBiZQ1H9XTH
o0PZeTyHJoUFmzOl2udbSYQ044RjYmxoTSly+oM4NX//JQ/t0fvDUQv3anIV5rkJ
kqWhfdg5o81FI17v0AoC2WjOkQTVzld+LREOb0OoYx2LtGECaHYnoP9oIAEz0uu0
iGNXNv1SrLjdayWSbOrUCr1POhiBCW+H0wS7YPvze/UVeCnH3cV41xIN/U8SruNA
e6/e0bPIm3VOybRTYuvfScc3TZ9m8vdqAKiMF567CF853gZSt27eUB1D8gK+165W
T1GjxZsDS/ke0YVliysaAm3SGbcYaLXcq7TWl89Cg8ucsYDVWO9sGIZSIQt1MaND
dC2MdF2gSaFQyoAgMR4nFW9nwwj7ew/sYPAVSPIiJDWXdd+bjG9FLN9SKiqf+2yD
0owyG4egD8V24nXiaSFdweE6MOWHyQKCg9Q+RYbsN0EGBzzUe8WNr+hEAxiYTRpW
cib/fWHWG/vK8EuIYj3UxdBVhZR4zbGPGrMeRou64jO9BLz7qwcHzscZGRg69kos
3BzIYznYFuUodzrHS/pWIDNhJFuGjAsuF9Nwkn7DWaztRI20LeM=
=axIE
-----END PGP SIGNATURE-----

--Sig_/59YR5Udn9lEsdlpWfEsPJrT--


