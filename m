Received: from eggs.gnu.org ([2001:4830:134:3::10]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aI-0002W5-UH
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83ZX-0000PC-8w
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83ZW-0000Gq-Qf
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:42 -0400
Received: by mail-io1-f65.google.com with SMTP id t7-v6so7825643ioj.13
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<a6f46215ee85cc76a74d06ce14b628861fb9bab5.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <a6f46215ee85cc76a74d06ce14b628861fb9bab5.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:21:27 +0400
Message-ID: <CAMxuvaxx8TcfSQHeuJzriExzt7tx-8iujUnkcU1JHmQ98a3H-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/11] qga-win: handle NULL values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomas Golembiovsky <tgolembi@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>, sjubran@redhat.com, okrishtal@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi
On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com> wrote:
>
> Handle returned NULLs properly to:
> - avoid crashes in serialization.
> - properly report errors to the caller
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 9c959122d9..49fc747298 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -735,6 +735,12 @@ static GuestFilesystemInfo *build_guest_fsinfo(char =
*guid, Error **errp)
>      }
>      fs->type =3D g_strdup(fs_name);
>      fs->disk =3D build_guest_disk_info(guid, errp);
> +    if (fs->disk =3D=3D NULL) {
> +        g_free(fs);

I'd use qapi_free_GuestFilesystemInfo()

> +        fs =3D NULL;
> +        goto free;
> +    }
> +
>  free:
>      g_free(mnt_point);
>      return fs;
> @@ -755,7 +761,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error *=
*errp)
>      do {
>          GuestFilesystemInfo *info =3D build_guest_fsinfo(guid, errp);
>          if (info =3D=3D NULL) {
> -            continue;
> +            goto out;
>          }
>          new =3D g_malloc(sizeof(*ret));
>          new->value =3D info;
> @@ -767,6 +773,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error *=
*errp)
>          error_setg_win32(errp, GetLastError(), "failed to find next volu=
me");
>      }
>
> +out:
>      FindVolumeClose(vol_h);
>      return ret;
>  }
> --
> 2.19.0
>
