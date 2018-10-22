Received: from eggs.gnu.org ([2001:4830:134:3::10]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gEPju-0007jj-Li
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 22:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gEPU2-0002fJ-O2
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 21:58:19 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gEPU2-0002eZ-7w
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 21:58:18 -0400
Received: by mail-io1-xd42.google.com with SMTP id z16-v6so26120857iol.6
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 18:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
	<1539926412-21831-8-git-send-email-liq3ea@gmail.com>
	<95818941-44e4-c9fa-6d54-57c909732432@redhat.com>
In-Reply-To: <95818941-44e4-c9fa-6d54-57c909732432@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 22 Oct 2018 09:57:41 +0800
Message-ID: <CAKXe6SLaS26Amv7cryLkNRfyoFjFofjBsn7yfbVHsr16C9uhtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] vfio: platform: destory mutex in error
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com
Cc: alex.williamson@redhat.com, philmd@redhat.com, Qemu Developers <qemu-devel@nongnu.org>

Hello Auger,

Auger Eric <eric.auger@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8820=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:41=E5=86=99=E9=81=93=EF=BC=9A

> Hi Li,
>
> On 10/19/18 7:20 AM, Li Qiang wrote:
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/vfio/platform.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> > index ba19143..e9d9e80 100644
> > --- a/hw/vfio/platform.c
> > +++ b/hw/vfio/platform.c
> > @@ -668,7 +668,7 @@ static void vfio_platform_realize(DeviceState *dev,
> Error **errp)
> >              error_setg(errp, "%s", gerr->message);
> >              g_error_free(gerr);
> >              g_free(path);
> > -            return;
> > +            goto out;
> You must set ret to !=3D 0 otherwise the qemu_mutex_destroy will not be
> reached I think.

Also this will fix the fact we are not prepending the
> vfio error prefix in that case, as we should.
>
> Besides I am unsure about the cleanup strategy in case or error in
> vfio_platform_realize(). The qemu process should always exit in case of
> failure in vfio_platform_realize(). Platform devices can only be
> cold-plugged through the qemu CLI.


Got this.


> Cleaning all the allocated resources
> may add a substantial amount of code.


Agree.


Thanks,
Li Qiang


> For instance resources allocated
> in vfio_base_device_init() are not freed either. Comprehensive free in
> realize() functions may only be needed in case of hotplug I think.
>
> Thanks
>
> Eric
> >          }
> >          g_free(path);
> >          vdev->compat =3D contents;
> > @@ -691,6 +691,8 @@ out:
> >          return;
> >      }
> >
> > +    qemu_mutex_destroy(&vdev->intp_mutex);
> > +
> >      if (vdev->vbasedev.name) {
> >          error_prepend(errp, ERR_PREFIX, vdev->vbasedev.name);
> >      } else {
> >
>
