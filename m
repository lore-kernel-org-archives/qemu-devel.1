Received: from eggs.gnu.org ([2001:4830:134:3::10]:37005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tZC-0000XI-47
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8tZ8-0004yc-Q9
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:16:02 -0400
Date: Thu, 11 May 2017 15:15:55 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511191555.GB24584@stefanha-x1.localdomain>
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492005921-15664-6-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <1492005921-15664-6-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/6] replication: Implement block
 replication for shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2017 at 10:05:20PM +0800, zhanghailiang wrote:
> @@ -612,6 +644,16 @@ static void replication_do_checkpoint(ReplicationState *rs, Error **errp)
>                  error_propagate(errp, local_err);
>                  break;
>              }
> +        } else {
> +            /*
> +             * For shared disk, we need to force SVM to re-read metadata
> +             * that is loaded in memory, or there will be inconsistent.
> +             */
> +            bdrv_invalidate_cache(s->secondary_disk->bs, &local_err);

I'm not sure this call has any effect:

    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
        return;
    }

Is BDRV_O_INACTIVE set?

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFLhrAAoJEJykq7OBq3PIPBgH/i+39CU6gWF13nZXJ57StOvb
mDLfuwU64TA2f8WwCSQWjHPudi6d/cR5/bVwzm4mDnYKHycd0s2gcgE94BaG7Lxl
PtPTePeZOZEwcYbl2N0toH00CA41fPM8UzRagC/hOy6UvkY9kYbSNQJeAeIhR9uh
iKrUdY+3YB1LZj1iTbUxf7aPYw8p1ZHIutwcPn+yMTCi6n/l+/OnvM8Byg4CoEt2
VXxF0cF0wqIVl/qPz0VZXVoUiOM+A3nA27RMh2fkiUUb/S6Q8wMgFJUa93gE0txT
zrmE571QZqBYNBAfSJUy+VLj9saqHwQI4GL00iBh8F1QpOjVzEDDI9KYCc9WrV8=
=vekF
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
