Received: from eggs.gnu.org ([2001:4830:134:3::10]:49415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1faIfT-0006Dn-DL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1faIfO-0002Yk-9H
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:36:19 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1faIfN-0002YL-Ve
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:36:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id h40-v6so1432089wrh.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:36:13 -0700 (PDT)
Date: Tue, 3 Jul 2018 12:36:10 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180703123610.75b498f1@fiorina>
In-Reply-To: <CAJ+F1CJeui7YXrH35ObNBbasoduRKeJW8W=O+nW3P2rEHLAdPg@mail.gmail.com>
References: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
	<CAJ+F1CJeui7YXrH35ObNBbasoduRKeJW8W=O+nW3P2rEHLAdPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: report disk size and free space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, 3 Jul 2018 12:01:55 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Tue, Jul 3, 2018 at 10:31 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgole=
mbi@redhat.com> wrote:
> > Report total file system size and free space in output of command
> > "guest-get-fsinfo". Values are optional and it is not an error if they =
cannot
> > be retrieved for some reason.
> > =20
>=20
> I am afraid this will miss 3.0, since it's a new feature

I kind of expected this.

> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-posix.c | 18 ++++++++++++++++++
> >  qga/commands-win32.c | 16 ++++++++++++++++
> >  qga/qapi-schema.json |  5 ++++-
> >  3 files changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index eae817191b..1f2fb25b91 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -13,6 +13,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include <sys/ioctl.h>
> > +#include <sys/statvfs.h>
> >  #include <sys/utsname.h>
> >  #include <sys/wait.h>
> >  #include <dirent.h>
> > @@ -1074,11 +1075,28 @@ static GuestFilesystemInfo *build_guest_fsinfo(=
struct FsMount *mount,
> >      GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));
> >      char *devpath =3D g_strdup_printf("/sys/dev/block/%u:%u",
> >                                      mount->devmajor, mount->devminor);
> > +    struct statvfs vfs_stats;
> >
> >      fs->mountpoint =3D g_strdup(mount->dirname);
> >      fs->type =3D g_strdup(mount->devtype);
> >      build_guest_fsinfo_for_device(devpath, fs, errp);
> >
> > +    g_debug(" get filesystem statistics for '%s'", mount->dirname);
> > +    if (statvfs(mount->dirname, &vfs_stats) !=3D 0) {
> > +        /* This is not fatal, just log this incident */
> > +        Error *local_err =3D NULL;
> > +        error_setg_errno(&local_err, errno, "statfs(\"%s\")", =20
>=20
> statvfs()
>=20
> > +            mount->dirname);
> > +        slog("failed to stat filesystem: %s",
> > +            error_get_pretty(local_err));
> > +        error_free(local_err); =20
>=20
> The usage of Error is a bit overkill, perhaps you may juste use slog()
> / strerror() directly.
>=20
> > +    } else {
> > +        fs->size =3D vfs_stats.f_frsize * vfs_stats.f_blocks;
> > +        fs->has_size =3D true;
> > +        fs->free =3D vfs_stats.f_frsize * vfs_stats.f_bfree;
> > +        fs->has_free =3D true;
> > +    }
> > +
> >      g_free(devpath);
> >      return fs;
> >  }
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 70ee5379f6..6d6ca05281 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -706,6 +706,22 @@ static GuestFilesystemInfo *build_guest_fsinfo(cha=
r *guid, Error **errp)
> >      }
> >      fs->type =3D g_strdup(fs_name);
> >      fs->disk =3D build_guest_disk_info(guid, errp);
> > +
> > +    if (len > 0) {
> > +        if (GetDiskFreeSpaceEx(mnt_point, 0, (PULARGE_INTEGER)&fs->siz=
e,
> > +                (PULARGE_INTEGER)&fs->free) !=3D 0) { =20
>=20
> I would rather use some local ULARGE_INTEGER and access the QuadPart
> to avoid the cast, but it should work.

I tried that, but the returned values were nonsensical. Maybe I did
something wrong along the way. I'll give it one more try.

Thanks for quick response,

    Tomas

>=20
> > +            /* This is not fatal, just log this incident */
> > +            Error *local_err =3D NULL;
> > +            error_setg_win32(&local_err, GetLastError(),
> > +                "failed to get free space on volume \"%s\"", mnt_point=
);
> > +            slog("%s", error_get_pretty(local_err));
> > +            error_free(local_err);
> > +        } else {
> > +            fs->has_size =3D true;
> > +            fs->has_free =3D true;
> > +        }
> > +    }
> > +
> >  free:
> >      g_free(mnt_point);
> >      return fs;
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 17884c7c70..28a32444d3 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -848,12 +848,15 @@
> >  # @type: file system type string
> >  # @disk: an array of disk hardware information that the volume lies on,
> >  #        which may be empty if the disk type is not supported
> > +# @size: total number of bytes on the file system (Since 2.13)
> > +# @free: number of bytes available on the file system (Since 2.13) =20
>=20
> "Since 3.1", most probably
>=20
> >  #
> >  # Since: 2.2
> >  ##
> >  { 'struct': 'GuestFilesystemInfo',
> >    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> > -           'disk': ['GuestDiskAddress']} }
> > +           'disk': ['GuestDiskAddress'], '*size': 'uint64',
> > +           '*free': 'uint64'} }
> >
> >  ##
> >  # @guest-get-fsinfo:
> > --
> > 2.17.1
> >
> > =20
>=20
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
