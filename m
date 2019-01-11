Received: from eggs.gnu.org ([209.51.188.92]:50885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ghmt7-00041J-Lt
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ghmt2-0001M0-UD
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:49:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ghmsr-0001J7-7q
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:49:23 -0500
Date: Fri, 11 Jan 2019 10:49:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190111024911.GA24343@xz-x1>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-10-fli@suse.com>
	<87a7kcml5i.fsf@dusky.pond.sub.org>
	<36097839-654b-6d1f-b79e-f9bc174ec126@suse.cz>
	<20190108065159.GA20511@xz-x1> <87o98ree00.fsf@dusky.pond.sub.org>
	<8e592b32-7984-7a02-10e9-45fb9eb248ef@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e592b32-7984-7a02-10e9-45fb9eb248ef@126.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jiri Slaby <jslaby@suse.cz>, shirley17fei@gmail.com, qemu-devel@nongnu.org

On Thu, Jan 10, 2019 at 09:29:38PM +0800, Fei Li wrote:
>=20
> =E5=9C=A8 2019/1/8 =E4=B8=8B=E5=8D=884:43, Markus Armbruster =E5=86=99=E9=
=81=93:
> > Peter Xu <peterx@redhat.com> writes:
> >=20
> > > On Tue, Jan 08, 2019 at 07:14:11AM +0100, Jiri Slaby wrote:
> > > > On 07. 01. 19, 18:29, Markus Armbruster wrote:
> > > > >     static void pci_edu_uninit(PCIDevice *pdev)
> > > > >     {
> > > > >         EduState *edu =3D EDU(pdev);
> > > > >=20
> > > > >         qemu_mutex_lock(&edu->thr_mutex);
> > > > >         edu->stopping =3D true;
> > > > >         qemu_mutex_unlock(&edu->thr_mutex);
> > > > >         qemu_cond_signal(&edu->thr_cond);
> > > > >         qemu_thread_join(&edu->thread);
> > > > >=20
> > > > >         qemu_cond_destroy(&edu->thr_cond);
> > > > >         qemu_mutex_destroy(&edu->thr_mutex);
> > > > >=20
> > > > >         timer_del(&edu->dma_timer);
> > > > >     }
> > > > >=20
> > > > > Preexisting: pci_edu_uninit() neglects to call msi_uninit().  J=
iri?\
> > > > I don't know, the MSI support was added in:
> > > > commit eabb5782f70b4a10975b24ccd7129929a05ac932
> > > > Author: Peter Xu <peterx@redhat.com>
> > > > Date:   Wed Sep 28 21:03:39 2016 +0800
> > > >=20
> > > >      hw/misc/edu: support MSI interrupt
> > > >=20
> > > > Hence CCing Peter.
> > > Hi, Jiri, Markus, Fei,
> > >=20
> > > IMHO msi_uninit() is optional since it only operates on the config
> > > space of the device to remove the capability or fix up the flags
> > > without really doing any real destruction of objects so nothing wil=
l
> > > be leaked (unlike msix_uninit, which should be required).
> > Michael, Marcel, is neglecting to call msi_uninit() okay, a harmless
> > bug, or a harmful bug?
>=20
> Kindly ping. :)
>=20
> If corresponding change is needed, I'd like to do the update in the nex=
t
> version.

Fei,

If you're going to post the edu patch, please post it as a standalone
patch.  More patches mean harder that the series could be accepted
quickly.  So it would be good to split patches sometimes especially if
they are irrelevant.

Regards,

--=20
Peter Xu
