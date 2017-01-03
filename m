Received: from eggs.gnu.org ([2001:4830:134:3::10]:52422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cOXKZ-0004ex-GR
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 17:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cOXKV-0000VC-GP
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 17:13:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cOXKV-0000Uy-AT
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 17:13:15 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DD8D68B2
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 22:13:14 +0000 (UTC)
Date: Wed, 4 Jan 2017 00:13:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170104001239-mutt-send-email-mst@kernel.org>
References: <20161230104130.29ff671b@x240.lan>
	<4eda1813-d732-5dfc-e6ff-29ac95fe22d8@redhat.com>
	<8aae955f-44ff-134e-818f-31b0bd510ba1@redhat.com>
	<20170103153312.083ef692@x240.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170103153312.083ef692@x240.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-user breaks after 96a3d98.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Flavio Leitner <fbl@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Jan 03, 2017 at 03:33:12PM -0200, Flavio Leitner wrote:
> On Tue, 3 Jan 2017 18:28:18 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>=20
> > On 2017=E5=B9=B401=E6=9C=8803=E6=97=A5 11:09, Jason Wang wrote:
> > >
> > >
> > > On 2016=E5=B9=B412=E6=9C=8830=E6=97=A5 20:41, Flavio Leitner wrote:=
 =20
> > >> Hi,
> > >>
> > >> While I was testing vhost-user using OVS 2.5 and DPDK 2.2.0 in the
> > >> host and testpmd dpdk 2.2.0 in the guest, I found that the commit
> > >> below breaks the environment and no packets gets into the guest.
> > >>
> > >> dpdk port --> OVS --> vhost-user --> guest --> testpmd
> > >>                           ^--- drops here         ^--- no packets =
here.
> > >>
> > >> commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665
> > >> Author: Jason Wang <jasowang@redhat.com>
> > >> Date:   Mon Aug 1 16:07:58 2016 +0800
> > >>
> > >>      vhost: don't set vring call if no vector
> > >>           We used to set vring call fd unconditionally even if gue=
st=20
> > >> driver does
> > >>      not use MSIX for this vritqueue at all. This will cause lots =
of
> > >>      unnecessary userspace access and other checks for drivers doe=
s=20
> > >> not use
> > >>      interrupt at all (e.g virtio-net pmd). So check and clean vri=
ng=20
> > >> call
> > >>      fd if guest does not use any vector for this virtqueue at
> > >>      all.
> > >> [...]
> > >>
> > >> Thanks, =20
> > >
> > > Hi Flavio:
> > >
> > > Thanks for reporting this issue, could this be a bug of vhost-user?=
 (I=20
> > > believe virito-net pmd does not use interrupt for rx/tx at all)
> > >
> > > Anyway, will try to reproduce it.
> > > =20
> >=20
> > Could not reproduce this issue on similar setups (the only difference=
 is=20
> > I don't create dpdk port) with dpdk 16.11 and ovs.git HEAD. Suspect a=
n=20
> > issue dpdk. Will try OVS 2.5 + DPDK 2.2.0.
>=20
> Yeah, that's the combo I am testing and seeing the issue.  I found the
> commit after bisecting qemu and then confirmed by testing up to the
> previous commit (works okay) and then the commit above (fails).
>=20
> I still have my test environment available, so I would be able to test
> any patch you might have.
>=20
> Thanks,
> --=20
> Flavio

Could you pls try to test dpdk git head and bisect that to find
what fixes the issue?

--=20
MST
