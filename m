Received: from eggs.gnu.org ([2001:4830:134:3::10]:58619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOpC-0005rH-DX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOpB-0006Q0-Dk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:11:02 -0500
Date: Mon, 27 Feb 2017 17:10:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170227171052.GI10201@stefanha-x1.localdomain>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-3-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Content-Disposition: inline
In-Reply-To: <1484884080-28836-3-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] replication: add shared-disk and
 shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, Eric Blake <eblake@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2017 at 11:47:56AM +0800, zhanghailiang wrote:
> @@ -119,12 +136,31 @@ static int replication_open(BlockDriverState *bs, QDict *options,
>                     "The option mode's value should be primary or secondary");
>          goto fail;
>      }
> +    s->is_shared_disk = qemu_opt_get_bool(opts, REPLICATION_SHARED_DISK,
> +                                          false);
> +    if (s->is_shared_disk && (s->mode == REPLICATION_MODE_PRIMARY)) {
> +        shared_disk_id = qemu_opt_get(opts, REPLICATION_SHARED_DISK_ID);
> +        if (!shared_disk_id) {
> +            error_setg(&local_err, "Missing shared disk blk option");
> +            goto fail;
> +        }
> +        s->shared_disk_id = g_strdup(shared_disk_id);
> +        blk = blk_by_name(s->shared_disk_id);
> +        if (!blk) {
> +            error_setg(&local_err, "There is no %s block", s->shared_disk_id);
> +            goto fail;
> +        }
> +        /* We can't access root member of BlockBackend directly */
> +        tmp_bs = blk_bs(blk);
> +        s->primary_disk = QLIST_FIRST(&tmp_bs->parents);

Why is this necessary?

We already have the BlockBackend for the primary disk.  I'm not sure why
the BdrvChild is needed.

Stefan

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtF2cAAoJEJykq7OBq3PIgbgH/2Ach1D3USwRWIgWaInOHjUO
AlTqq60O7dEYZSDguLQG0BJ8S//VsmyZCjy8jxuCRCx24XEuUJWxbd5Z5T1a9KYY
nuK2ibJZ0WhYwU3RuaApqRPeUDzt3oxPN2MgHs9ZMHVOHiY8H+2vN3zn0VGMyg1v
DoFqYygD8MOqIRPYUWn+Oz+yNG7120JsfKKaDSolKMdtlP4DySB+IV9Rt8PhJFeG
aH/9FqYUmqWYheQgzJ5ehavqnOo6jva+lmFmFhN8WfCmPKzGW8Kul/Egx3U6K8ee
SzjkZ68LHaRZIgSx6mzeoV67NJtOAK84pgP9Q5s+p/g5PGf+uSLPCC7+guFuKFs=
=OKTl
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
