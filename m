Received: from eggs.gnu.org ([2001:4830:134:3::10]:35229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPMZ-0001CA-Hp
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPMW-0000mI-Cp
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:07 -0500
Received: from [45.249.212.187] (port=2504 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPMU-0000jQ-Ka
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:04 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 9 Jan 2017 02:05:49 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1803BF@DGGEMA505-MBX.china.huawei.com>
References: <1479901791-144760-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1479901791-144760-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.8] qom: fix qemu_opts leak when hot
 unplug object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "afaerber@suse.de" <afaerber@suse.de>, "stefanha@redhat.com" <stefanha@redhat.com>

Ping...

Anybody can pick it up? Thanks!

Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Wednesday, November 23, 2016 7:50 PM
> To: qemu-devel@nongnu.org
> Cc: afaerber@suse.de; Gonglei (Arei)
> Subject: [PATCH for-2.8] qom: fix qemu_opts leak when hot unplug object
>=20
> If we assign the user crateable object in QEMU command
> line, then the correspeonding qemu_opts for the object
> doesn't be deleted, which will produce a wrong result.
>=20
> If we hot unplug the object by object_del, the qemu_opts
> will be leaked, ann then if we hot plug the object using
> the same id by object_add, we will get a error:
>  "Duplicate ID 'xxxx' for object"
>=20
> Let's del the qemu opts after the object created, just
> likes what the hmp_object_add function does.
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  qom/object_interfaces.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index ded4d84..b8fe9db 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -189,6 +189,10 @@ int user_creatable_add_opts_foreach(void *opaque,
> QemuOpts *opts, Error **errp)
>          return -1;
>      }
>      object_unref(obj);
> +
> +    qemu_opts_del(opts);
> +    opts =3D NULL;
> +
>      return 0;
>  }
>=20
> --
> 1.8.3.1
>=20
