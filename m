Received: from eggs.gnu.org ([209.51.188.92]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghQgJ-0005sp-JB
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghQgI-000187-NE
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:06:55 -0500
MIME-Version: 1.0
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
	<1540876720-9574-4-git-send-email-liq3ea@gmail.com>
	<d5bb8eea-bbcf-ccb6-98ac-742ad3511f81@redhat.com>
In-Reply-To: <d5bb8eea-bbcf-ccb6-98ac-742ad3511f81@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Jan 2019 11:06:15 +0800
Message-ID: <CAKXe6SL54RAJMLPgn6BuQOntSNvfB53jKZj84m9oNC42ipKZkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] nvme: check msix_init_exclusive_bar
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Max Reitz <mreitz@redhat.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:52=E5=86=99=E9=81=93=EF=BC=9A

> On 30.10.18 06:18, Li Qiang wrote:
> > As this function can fail.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/block/nvme.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 72c9644..a406c23 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1250,7 +1250,10 @@ static void nvme_realize(PCIDevice *pci_dev,
> Error **errp)
> >      pci_register_bar(&n->parent_obj, 0,
> >          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
> >          &n->iomem);
> > -    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);
> > +    if (msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4,
> NULL)) {
> > +        error_setg(errp, "msix_init_exclusive_bar failed");
> > +        return;
> > +    }
>
> Commit ee640c625e1 which last touched this function stated that creating
> this device won't fail if this function fails, so I suppose it's
> intential that the error isn't checked.
>

OK, got. I will drop this patch later.

Thanks,
Li Qiang


>
>
> But if you think the error should be checked and device creation should
> be aborted if this function failed, then I suppose there'd be some
> cleaning up to instead of just returning.
>
> Also, we should just pass errp to that function (as its last parameter,
> instead of NULL).
>
> Max
>
> >
> >      id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
> >      id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf +
> PCI_SUBSYSTEM_VENDOR_ID));
> >
>
>
>
