Received: from eggs.gnu.org ([209.51.188.92]:43926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw805-0006F9-6z
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw804-00020u-HO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:12:05 -0500
References: <20190219125044.5416-1-berrange@redhat.com>
	<20190219125044.5416-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42f0ea75-99c6-6e6d-2fd5-b3b59f4a781c@redhat.com>
Date: Tue, 19 Feb 2019 10:11:58 -0600
MIME-Version: 1.0
In-Reply-To: <20190219125044.5416-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: mark image as corrupt if
 failing during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2/19/19 6:50 AM, Daniel P. Berrang=C3=A9 wrote:
> During creation we write a minimal qcow2 header and then update it with
> extra features. If the updating fails for some reason we might still be
> left with a valid qcow2 image that will be mistakenly used for I/O. We
> cannot delete the image, since we don't know if we created the
> underlying storage or not. Thus we mark the header as corrupt to
> prevents its later usage.

Should we unconditionally mark the image as corrupt at the time we write
the minimal qcow2 header, and then update the image to non-corrupt on
the final update?

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/qcow2.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index ecc577175f..338513e652 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3104,6 +3104,9 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
> =20
>      ret =3D 0;
>  out:
> +    if (ret < 0) {
> +        qcow2_mark_corrupt(blk_bs(blk));
> +    }

If ret < 0 because of an EIO error, this may also fail to write the
change to the header. Hence my question as to whether this is too late.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
