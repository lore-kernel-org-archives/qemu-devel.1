Received: from eggs.gnu.org ([2001:4830:134:3::10]:55003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gAOW0-0001JU-5t
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gAOVw-0008Q8-F6
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:07:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gAOVv-0008Pb-SY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:07:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9B06NLh045820
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 20:07:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1t4jaxgh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 20:07:38 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 10 Oct 2018 20:07:37 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <a6f46215ee85cc76a74d06ce14b628861fb9bab5.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
	<a6f46215ee85cc76a74d06ce14b628861fb9bab5.1538652143.git.tgolembi@redhat.com>
Date: Wed, 10 Oct 2018 18:08:40 -0500
Message-Id: <153921292009.23852.3205416467001625029@sif>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] qga-win: handle NULL values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>

Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2018-10-04 06:22:29)
> Handle returned NULLs properly to:
> - avoid crashes in serialization.
> - properly report errors to the caller
> =

> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> =

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
> +        fs =3D NULL;
> +        goto free;
> +    }
> +

The QAPI schema defines fs->disk to be a list. In the current upstream
code (where CONFIG_NTDDSCSI is unset) we always set fs->disk to NULL
and that just results in an empty list, which works and doesn't violate
the schema, so I don't understand why that's needed here.

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

This fails the whole guest_get_fsinfo command for any case where we
can't retrieve the 'disk' list for a particular volume. I would consider
that a regression in functionality.

Can you confirm this is for fixing the current code? Or is it just
something you need for something later in this series? If the latter,
I suspect this is the wrong place to address it.

>          new =3D g_malloc(sizeof(*ret));
>          new->value =3D info;
> @@ -767,6 +773,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error *=
*errp)
>          error_setg_win32(errp, GetLastError(), "failed to find next volu=
me");
>      }
> =

> +out:
>      FindVolumeClose(vol_h);
>      return ret;
>  }
> -- =

> 2.19.0
>=20
