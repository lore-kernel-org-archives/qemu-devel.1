Received: from eggs.gnu.org ([2001:4830:134:3::10]:49339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOnas-0003JM-7b
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOnao-0005vK-VI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:12:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOnao-0005uT-Nm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:11:58 -0400
References: <20180601165750.25420-1-chen_han_xiao@126.com>
	<20180601165750.25420-2-chen_han_xiao@126.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <478a831b-bf3d-8bcf-92d2-bc710f2d6bc2@redhat.com>
Date: Fri, 1 Jun 2018 12:11:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180601165750.25420-2-chen_han_xiao@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5.1 1/2] qga: add mountpoint usage info to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>

On 06/01/2018 11:57 AM, Chen Hanxiao wrote:
> From: Chen Hanxiao <chenhanxiao@gmail.com>
>=20
> This patch adds support for getting the usage of mounted
> filesystem.
> The usage of fs stored as used_bytes and total_bytes.
> It's very useful when we try to monitor guest's filesystem.
>=20
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---
> +++ b/qga/commands-posix.c
> @@ -46,6 +46,7 @@ extern char **environ;
>   #include <arpa/inet.h>
>   #include <sys/socket.h>
>   #include <net/if.h>
> +#include <sys/statvfs.h>
>  =20
>   #ifdef FIFREEZE
>   #define CONFIG_FSFREEZE
> @@ -1072,6 +1073,8 @@ static GuestFilesystemInfo *build_guest_fsinfo(st=
ruct FsMount *mount,
>                                                  Error **errp)
>   {
>       GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));

Because this is 0-initialized,

> +    struct statvfs buf;
> +    unsigned long used, nonroot_total, fr_size;
>       char *devpath =3D g_strdup_printf("/sys/dev/block/%u:%u",
>                                       mount->devmajor, mount->devminor)=
;
>  =20
> @@ -1079,7 +1082,22 @@ static GuestFilesystemInfo *build_guest_fsinfo(s=
truct FsMount *mount,
>       fs->type =3D g_strdup(mount->devtype);
>       build_guest_fsinfo_for_device(devpath, fs, errp);
>  =20
> +    if (statvfs(fs->mountpoint, &buf)) {
> +        fs->has_total_bytes =3D false;
> +        fs->has_used_bytes =3D false;

this branch is dead assignments.  You could simplify to just 'if=20
(statvfs(...) =3D=3D 0)' with no 'else' branch needed.

> +    } else {
> +        fr_size =3D buf.f_frsize;
> +        used =3D buf.f_blocks - buf.f_bfree;
> +        nonroot_total =3D used + buf.f_bavail;
> +        fs->used_bytes =3D used * fr_size;
> +        fs->total_bytes =3D nonroot_total * fr_size;
> +
> +        fs->has_total_bytes =3D true;
> +        fs->has_used_bytes =3D true;
> +    }
> +
>       g_free(devpath);
> +
>       return fs;
>   }
>  =20
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 17884c7c70..56ce2d08e2 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -846,6 +846,8 @@
>   # @name: disk name
>   # @mountpoint: mount point path
>   # @type: file system type string
> +# @used-bytes: file system used bytes (since 3.0)
> +# @total-bytes: nonroot file system total bytes (since 3.0)

s/nonroot/non-root/

>   # @disk: an array of disk hardware information that the volume lies o=
n,
>   #        which may be empty if the disk type is not supported
>   #
> @@ -853,6 +855,7 @@
>   ##
>   { 'struct': 'GuestFilesystemInfo',
>     'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
> +           '*used-bytes': 'uint64', '*total-bytes': 'uint64',
>              'disk': ['GuestDiskAddress']} }
>  =20
>   ##
>=20

Both those changes are minor, so at this point, I'm comfortable with:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
