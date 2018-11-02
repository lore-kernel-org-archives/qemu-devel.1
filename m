Received: from eggs.gnu.org ([2001:4830:134:3::10]:42948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIbal-00065f-Mx
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIbak-0002uG-M8
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:42:35 -0400
Date: Fri, 2 Nov 2018 16:42:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181102154217.GJ7521@dhcp-200-186.str.redhat.com>
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<20181102105421.GC7521@dhcp-200-186.str.redhat.com>
	<CAKXe6SK6bqfFeRd=DdbVXZ8PAijewoLv-jDhbt2_jmDaTFRv7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXe6SK6bqfFeRd=DdbVXZ8PAijewoLv-jDhbt2_jmDaTFRv7w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: keith.busch@intel.com, mreitz@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Am 02.11.2018 um 16:22 hat Li Qiang geschrieben:
> Hello Kevin,
>=20
> Kevin Wolf <kwolf@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:54=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Am 02.11.2018 um 02:22 hat Li Qiang geschrieben:
> > > Currently, the nvme_cmb_ops mr doesn't check the addr and size.
> > > This can lead an oob access issue. This is triggerable in the guest=
.
> > > Add check to avoid this issue.
> > >
> > > Fixes CVE-2018-16847.
> > >
> > > Reported-by: Li Qiang <liq3ea@gmail.com>
> > > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > > ---
> > >  hw/block/nvme.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index fc7dacb..d097add 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -1175,6 +1175,10 @@ static void nvme_cmb_write(void *opaque, hwa=
ddr
> > addr, uint64_t data,
> > >      unsigned size)
> > >  {
> > >      NvmeCtrl *n =3D (NvmeCtrl *)opaque;
> > > +
> > > +    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
> >
> > What prevents a guest from moving the device to the end of the addres=
s
> > space and causing an integer overflow in addr + size?
> >
> >
> This can't happen as the addr can't be any value, it just can be in the
> Memory Region n->ctrl_mem defines.

Yes, but can't the guest map that memory region whereever it wants?

(As Keith confirmed, the integer overflow doesn't seem to have any bad
consequences here, but anyway.)

Kevin
