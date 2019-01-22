Received: from eggs.gnu.org ([209.51.188.92]:40590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm0zc-00086X-4T
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm0zZ-0001mS-Cq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm0zZ-0001df-0m
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA84C46202
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 17:23:46 +0000 (UTC)
Date: Tue, 22 Jan 2019 17:23:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122172333.GA13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-4-berrange@redhat.com>
	<c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
	<20190122143257.GR13143@redhat.com>
	<c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jan 22, 2019 at 11:19:42AM -0600, Eric Blake wrote:
> On 1/22/19 8:32 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
> >>> +++ b/hw/vfio/pci.c
> >>> @@ -2581,7 +2581,7 @@ static void vfio_populate_device(VFIOPCIDevic=
e *vdev, Error **errp)
> >>>      ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &ir=
q_info);
> >>>      if (ret) {
> >>>          /* This can fail for an old kernel or legacy PCI dev */
> >>> -        trace_vfio_populate_device_get_irq_info_failure();
> >>> +        trace_vfio_populate_device_get_irq_info_failure(errno);
> >>
> >> trace_vfio_populate_device_get_irq_info_failure(strerror(errno))
> >=20
> > The caveat is that 'strerror' is not required to be thread safe,
> > however, given that this is Linux only code I guess we can assume
> > the glibc impl which fortunately is thread safe.
>=20
> If we are going to worry about thread-safety of strerror(), we have a
> LOT of code to scrub (we are using it rather liberally throughout the
> code base).

Yes, indeed we do and it was something that always worried me a little
(as well as a few other non-reentrant APIs we used previously).

> > On this point though, does anyone know of any platforms we support[1]=
,
> > or are likely to support in future, where 'strerror' is *not* thread
> > safe ?
>=20
> I'm not coming up with one, and I think the problem is independent of
> this series (if we DO have a problem, it's a series all its own to
> eradicate the use of strerror() in favor of something safer, either
> picking strerror_l() or dealing with the glibc vs. BSD differences in
> strerror_r()).

Agree that its not really something for this series - this just
made me think of it again.

We went through the scrubbing in libvirt to use the sane, but still
tedious to call, variant of strerror_r() many years ago. With luck
though it is a worry that can be confined the dustbin of ancient
UNIX history....unless someone can point to evidence to the contrary ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
