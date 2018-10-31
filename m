Received: from eggs.gnu.org ([2001:4830:134:3::10]:49696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHo4Z-0001xx-MG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHo4V-0007nn-KB
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:50:03 -0400
Date: Wed, 31 Oct 2018 11:49:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181031114954.5e51d0c2.cohuck@redhat.com>
In-Reply-To: <494ff50b-8b0f-1393-fbc5-bf5033a246ce@linux.ibm.com>
References: <20181022090255.19671-1-zyimin@linux.ibm.com>
	<698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
	<20181023232517.6b93085b.cohuck@redhat.com>
	<494ff50b-8b0f-1393-fbc5-bf5033a246ce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.ibm.com, qemu-s390x@nongnu.org

On Wed, 24 Oct 2018 11:58:33 +0800
Yi Min Zhao <zyimin@linux.ibm.com> wrote:

> =E5=9C=A8 2018/10/24 =E4=B8=8A=E5=8D=885:25, Cornelia Huck =E5=86=99=E9=
=81=93:
> > On Mon, 22 Oct 2018 13:17:34 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> > =20
> >> On 2018-10-22 10:02, Yi Min Zhao wrote: =20
> >>> Common function measurement block is used to report counters of
> >>> successfully issued pcilg/stg/stb and rpcit instructions. This patch
> >>> introduces a new struct ZpciFmb and schedules a timer callback to
> >>> copy fmb to the guest memory at a interval time which is set to
> >>> 4s by default. While attemping to update fmb failed, an event error
> >>> would be generated. After pcilg/stg/stb and rpcit interception
> >>> handlers issue successfully, increase the related counter. The guest
> >>> could pass null address to switch off FMB and stop corresponding
> >>> timer.
> >>>
> >>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> >>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> >>> --- =20
> >> [...] =20
> >>> +static int fmb_do_update(S390PCIBusDevice *pbdev, uint8_t offset, in=
t len)
> >>> +{
> >>> +    MemTxResult ret;
> >>> +
> >>> +    ret =3D address_space_write(&address_space_memory,
> >>> +                              pbdev->fmb_addr + (uint64_t)offset,
> >>> +                              MEMTXATTRS_UNSPECIFIED,
> >>> +                              (uint8_t *)&pbdev->fmb + offset,
> >>> +                              len);
> >>> +    if (ret) {
> >>> +        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbd=
ev->fid,
> >>> +                                      pbdev->fmb_addr, 0);
> >>> +        fmb_timer_free(pbdev);
> >>> +    }
> >>> +
> >>> +    return ret;
> >>> +}
> >>> +
> >>> +static void fmb_update(void *opaque)
> >>> +{
> >>> +    S390PCIBusDevice *pbdev =3D opaque;
> >>> +    int64_t t =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> >>> +    uint8_t offset =3D offsetof(ZpciFmb, last_update);
> >>> +
> >>> +    /* Update U bit */
> >>> +    pbdev->fmb.last_update |=3D UPDATE_U_BIT;
> >>> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    /* Update FMB counters */
> >>> +    pbdev->fmb.sample++;
> >>> +    if (fmb_do_update(pbdev, 0, sizeof(ZpciFmb))) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    /* Clear U bit and update the time */
> >>> +    pbdev->fmb.last_update =3D time2tod(qemu_clock_get_ns(QEMU_CLOCK=
_VIRTUAL));
> >>> +    pbdev->fmb.last_update &=3D ~UPDATE_U_BIT;
> >>> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
> >>> +} =20
> >> Sorry for noticing this in v1 already, but is this code endianess-safe?
> >> I.e. can this also work with qemu-system-s390x running with TCG on a x=
86
> >> host? I think you might have to use something like this here instead:
> >>
> >>    pbdev->fmb.sample =3D cpu_to_be32(be32_to_cpu(pbdev->fmb.sample) + =
1);
> >>
> >> etc. =20
> > Agreed, that may need some endianness handling.
> >
> > I would test this with tcg on a LE host, but how can I verify this? Yi
> > Min, do you have some kind of test tooling you can share?
> >
> > =20
> There's no tool now. You could startup a guest. And then in the guest,=20
> install
> PCI driver and read FMB values from /sys/kernel/debug/pci/****/statistics.
>=20
> If endianness has error, I think the values must looks wrong.
> The right thing is that values increase from 0 and intervally.
>=20

Thanks for pointing me to that file; when I run under tcg, the values
indeed look like they have an endianness issue:

Update interval: 4000 ms
Samples: 637534208
Last update TOD: f4c01d0098000000
           Load operations:	10520408729537478656
          Store operations:	5980780305148018688
    Store block operations:	0
        Refresh operations:	0
           Allocated pages:	0
              Mapped pages:	0
            Unmapped pages:	0

(virtio-net-pci device on a just-booted guest)
