Received: from eggs.gnu.org ([2001:4830:134:3::10]:46006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmcLq-0005Ph-56
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmcLn-0002o9-3K
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmcLm-0002no-Qe
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:58:23 -0400
Date: Tue, 29 Aug 2017 10:58:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170829105818.7c4d4393.cohuck@redhat.com>
In-Reply-To: <9ff42cd0-8767-5f6b-8291-3d1520f59551@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-2-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828165122.041b62b2.cohuck@redhat.com>
	<aac61d9b-4d56-2fd1-b35b-407f17cf9bd4@linux.vnet.ibm.com>
	<20170829100025.639b0ebb.cohuck@redhat.com>
	<2b9494d6-c2d4-5a3f-b8f8-62b63ef42e2c@linux.vnet.ibm.com>
	<20170829102241.1274cf84.cohuck@redhat.com>
	<9ff42cd0-8767-5f6b-8291-3d1520f59551@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] s390x/pci: fixup trap_msix()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Tue, 29 Aug 2017 16:33:52 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=884:22, Cornelia Huck =E5=86=99=E9=81=
=93:
> > On Tue, 29 Aug 2017 16:12:26 +0800
> > Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> > =20
> >> =E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=884:00, Cornelia Huck =E5=86=99=E9=
=81=93: =20
> >>> On Tue, 29 Aug 2017 12:32:17 +0800
> >>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> >>>    =20
> >>>> =E5=9C=A8 2017/8/28 =E4=B8=8B=E5=8D=8810:51, Cornelia Huck =E5=86=99=
=E9=81=93: =20
> >>>>> On Mon, 28 Aug 2017 10:04:44 +0200
> >>>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> >>>>>       =20
> >>>>>> The function trap_msix() is to check if pcistg instruction would a=
ccess
> >>>>>> msix table entries. The correct boundary condition should be
> >>>>>> [table_offset, table_offset+entries*entry_size). But the current
> >>>>>> condition calculated misses the last entry. So let's fixup it.
> >>>>>>
> >>>>>> Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >>>>>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >>>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >>>>>> ---
> >>>>>>     hw/s390x/s390-pci-inst.c | 4 ++--
> >>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> >>>>>> index b7beb8c36a..eba9ffb5f2 100644
> >>>>>> --- a/hw/s390x/s390-pci-inst.c
> >>>>>> +++ b/hw/s390x/s390-pci-inst.c
> >>>>>> @@ -440,8 +440,8 @@ static int trap_msix(S390PCIBusDevice *pbdev, =
uint64_t offset, uint8_t pcias)
> >>>>>>     {
> >>>>>>         if (pbdev->msix.available && pbdev->msix.table_bar =3D=3D =
pcias &&
> >>>>>>             offset >=3D pbdev->msix.table_offset &&
> >>>>>> -        offset <=3D pbdev->msix.table_offset +
> >>>>>> -                  (pbdev->msix.entries - 1) * PCI_MSIX_ENTRY_SIZE=
) {
> >>>>>> +        offset < (pbdev->msix.table_offset +
> >>>>>> +                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
> >>>>>>             return 1;
> >>>>>>         } else {
> >>>>>>             return 0; =20
> >>>>> What happened before due to the miscalculation? Write to wrong memo=
ry
> >>>>> region?
> >>>>>
> >>>>>       =20
> >>>> We tried to plug virtio-net pci device but failed. After inspected, =
we
> >>>> found that the device uses two msix entries but the last one was
> >>>> missed. Then we cannot register interrupt successfully because we
> >>>> should call trap_msixi() in order to save some useful and arch
> >>>> information into msix message. But what about wrong memory region
> >>>> didn't happen. =20
> >>> So, the guest just was not able to use the second msix entry, but did
> >>> not get any exception?
> >>>
> >>>    =20
> >> Forget one thing. The zpci idx is saved in msix message. The second ms=
ix
> >> entry has not been
> >> trapped so that no idx has been saved, on the other hand idx 0 is save=
d. So
> >> kvm_arch_fixup_msi_route() will update irq route according to the zpci
> >> device whose idx is 0.
> >> So the wrong logic in trap_msix() will result that flic mixes different
> >> pci devices' adapter interrupts. =20
> > Ouch. So this only ever worked for the small subset of pci devices we
> > can passthrough (assuming none of them use more than one msix entry)? =
=20
> Because any passthroughed pci devices which I tested has more than 2=20
> msix entries. And not all
> entries will be used. I find that the last entry is never touched. But=20
> virtio pci is much fancy and only
> uses two entries. So I encountered the issue when I tested virtio-pci=20
> device.

So that really sounds to me like "we've been lucky"...

> >
> > I'm tempted to have this cc:ed to stable so we can fixup 2.10 (which is
> > the first version with usable zpci support).

...and I'll add cc:stable, as we don't really have any control from
qemu which kind of devices are handled by vfio.
