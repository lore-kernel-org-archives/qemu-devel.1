Received: from eggs.gnu.org ([2001:4830:134:3::10]:54800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cizAr-0003bm-Fq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cizAq-0007d7-6l
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:59:49 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cizAp-0007ct-S1
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 02:59:48 -0500
Received: by mail-lf0-x241.google.com with SMTP id y193so1434370lfd.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 23:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-29-marcandre.lureau@redhat.com>
	<304c6066-fea0-f5e4-9c6f-384afa9ff5f2@redhat.com>
In-Reply-To: <304c6066-fea0-f5e4-9c6f-384afa9ff5f2@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 01 Mar 2017 07:59:34 +0000
Message-ID: <CAJ+F1CJzf7wre3r3EQxEV76cima8Bp5KRPwBcRVxeFyoxqsFNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 28/30] tests: add specialized
 device_find function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 1, 2017 at 3:22 AM Eric Blake <eblake@redhat.com> wrote:

> On 02/21/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Allows to specify which slot to look for the device.
>
> "Allow[s] to ${verb}" is not idiomatic; it's missing a subject.  But
> "Allows $subject to" (as in "allows someone to" or "allows me to") is
> wordy, compared to just saying "Allows ${verb}ing".  I'd suggest:
>
> Allow specifying which slot to favor when looking for the device.
>
> >
> > This will be used in the following patch to avoid leaking when multiple
> > devices exists and we want to lookup the hotplug one.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/libqos/virtio-pci.h |  4 ++--
> >  tests/libqos/virtio-pci.c | 31 ++++++++++++++++++++++++++-----
> >  2 files changed, 28 insertions(+), 7 deletions(-)
> >
>
> > @@ -55,10 +57,11 @@ static void qvirtio_pci_foreach_callback(
> >      QVirtioPCIForeachData *d =3D data;
> >      QVirtioPCIDevice *vpcidev =3D qpcidevice_to_qvirtiodevice(dev);
> >
> > -    if (vpcidev->vdev.device_type =3D=3D d->device_type) {
> > +    if (vpcidev->vdev.device_type =3D=3D d->device_type &&
> > +        (!d->has_slot || vpcidev->pdev->devfn =3D=3D d->slot << 3)) {
> >          d->func(&vpcidev->vdev, d->user_data);
> >      } else {
> > -        g_free(vpcidev);
> > +        qvirtio_pci_device_free(vpcidev);
>
> Is this an unmentioned leak plug?  Either it should be mentioned, or
> squashed into the leak fix of 29.
>

I'll move it there, thanks

>
> With those cleanups,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266 <+1%20919-301-3266>
> Libvirt virtualization library http://libvirt.org
>
> --
Marc-Andr=C3=A9 Lureau
