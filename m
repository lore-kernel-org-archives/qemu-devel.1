Received: from eggs.gnu.org ([2001:4830:134:3::10]:53214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1faIwp-0003nb-Cz
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1faIwm-0005E0-8d
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:54:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1faIwm-0005Cu-1g
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:54:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so1833331wme.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:54:11 -0700 (PDT)
Date: Tue, 3 Jul 2018 12:54:08 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180703125408.623d77fc@fiorina>
In-Reply-To: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
References: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue,  3 Jul 2018 10:31:20 +0200
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 70ee5379f6..6d6ca05281 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -706,6 +706,22 @@ static GuestFilesystemInfo *build_guest_fsinfo(char =
*guid, Error **errp)
>      }
>      fs->type =3D g_strdup(fs_name);
>      fs->disk =3D build_guest_disk_info(guid, errp);
> +
> +    if (len > 0) {
> +        if (GetDiskFreeSpaceEx(mnt_point, 0, (PULARGE_INTEGER)&fs->size,
> +                (PULARGE_INTEGER)&fs->free) !=3D 0) {

Btw, it seems to me that checkpatch.pl returns some false positives
here. See:

    ERROR: spaces required around that '&' (ctx:VxV)                       =
                                                                           =
                         =20
    #72: FILE: qga/commands-win32.c:711:
    +        if (GetDiskFreeSpaceEx(mnt_point, 0, (PULARGE_INTEGER)&fs->siz=
e,
                                                                ^

    ERROR: spaces required around that '&' (ctx:VxV)
    #73: FILE: qga/commands-win32.c:712:
    +                (PULARGE_INTEGER)&fs->free) !=3D 0) {
                                    ^

Seems that & is mistakenly interpreted as bitwise-AND operator.=20
Or am I expected to format that as

  ..., (PULARGE_INTEGER) & fs->size, ...

because that looks... weird.


Also, checkpatch.pl itself suggest to look into MAINTAINERS to find out
whom to report false positives, but there is no maintainer there. :)

    Tomas


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
