Received: from eggs.gnu.org ([2001:4830:134:3::10]:46944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cORw8-0003sB-Jr
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cORw4-0005Mn-JA
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:27:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cORw4-0005MP-Ci
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:27:40 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 814B461B83
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 16:27:39 +0000 (UTC)
Date: Tue, 3 Jan 2017 18:27:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170103182332-mutt-send-email-mst@kernel.org>
References: <20161230104130.29ff671b@x240.lan>
	<4eda1813-d732-5dfc-e6ff-29ac95fe22d8@redhat.com>
	<8aae955f-44ff-134e-818f-31b0bd510ba1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8aae955f-44ff-134e-818f-31b0bd510ba1@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: Flavio Leitner <fbl@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Jan 03, 2017 at 06:28:18PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8803=E6=97=A5 11:09, Jason Wang wrote:
> >=20
> >=20
> > On 2016=E5=B9=B412=E6=9C=8830=E6=97=A5 20:41, Flavio Leitner wrote:
> > > Hi,
> > >=20
> > > While I was testing vhost-user using OVS 2.5 and DPDK 2.2.0 in the
> > > host and testpmd dpdk 2.2.0 in the guest, I found that the commit
> > > below breaks the environment and no packets gets into the guest.
> > >=20
> > > dpdk port --> OVS --> vhost-user --> guest --> testpmd
> > >                           ^--- drops here         ^--- no packets h=
ere.
> > >=20
> > > commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665
> > > Author: Jason Wang <jasowang@redhat.com>
> > > Date:   Mon Aug 1 16:07:58 2016 +0800
> > >=20
> > >      vhost: don't set vring call if no vector
> > >           We used to set vring call fd unconditionally even if gues=
t
> > > driver does
> > >      not use MSIX for this vritqueue at all. This will cause lots o=
f
> > >      unnecessary userspace access and other checks for drivers does
> > > not use
> > >      interrupt at all (e.g virtio-net pmd). So check and clean vrin=
g
> > > call
> > >      fd if guest does not use any vector for this virtqueue at
> > >      all.
> > > [...]
> > >=20
> > > Thanks,
> >=20
> > Hi Flavio:
> >=20
> > Thanks for reporting this issue, could this be a bug of vhost-user? (=
I
> > believe virito-net pmd does not use interrupt for rx/tx at all)
> >=20
> > Anyway, will try to reproduce it.
> >=20
>=20
> Could not reproduce this issue on similar setups (the only difference i=
s I
> don't create dpdk port) with dpdk 16.11 and ovs.git HEAD. Suspect an is=
sue
> dpdk. Will try OVS 2.5 + DPDK 2.2.0.
>=20
> Thanks

Possibly dpdk assumed that call fd must be present unconditionally.
Limit this patch to when protocol is updated? add a new protocol flag?

--=20
MST
