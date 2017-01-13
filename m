Received: from eggs.gnu.org ([2001:4830:134:3::10]:45137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS27M-0006OA-Qg
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS27L-0002Ll-UT
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:42:08 -0500
Date: Fri, 13 Jan 2017 13:41:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170113134148.GC10706@stefanha-x1.localdomain>
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-2-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <1480926904-17596-2-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/6] docs/block-replication: Add
 description for shared-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 05, 2016 at 04:34:59PM +0800, zhanghailiang wrote:
> +Issue qmp command:
> +  { 'execute': 'blockdev-add',
> +    'arguments': {
> +        'driver': 'replication',
> +        'node-name': 'rep',
> +        'mode': 'primary',
> +        'shared-disk-id': 'primary_disk0',
> +        'shared-disk': true,
> +        'file': {
> +            'driver': 'nbd',
> +            'export': 'hidden_disk0',
> +            'server': {
> +                'type': 'inet',
> +                'data': {
> +                    'host': 'xxx.xxx.xxx.xxx',
> +                    'port': 'yyy'
> +                }
> +            }

block/nbd.c does have good error handling and recovery in case there is
a network issue.  There are no reconnection attempts or timeouts that
deal with a temporary loss of network connectivity.

This is a general problem with block/nbd.c and not something to solve in
this patch series.  I'm just mentioning it because it may affect COLO
replication.

I'm sure these limitations in block/nbd.c can be fixed but it will take
some effort.  Maybe block/sheepdog.c, net/socket.c, and other network
code could also benefit from generic network connection recovery.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYeNkcAAoJEJykq7OBq3PIQcIIAKKltIomBGBGW0B0+nPoGC5d
6YSy35octsRRUwESE81ZlUVEQl4Nw6xj/EsA7Di/ivgikLUDS7jXEUFjHPFRjgXV
LYpxqd7qpMjEFC/Lk/+efYpW82154544nnLCuzWUDt0PuB7GTYEBsZ0t4kUtZxwW
xREKatugPGngf5cFTraLuEaueNqagu69ZcN5y8Ka00xrg4EiqldE1UsSQh+Df/M0
FKUyeGpSDk9mAVu7s/gq3igz456WWAlz9535eCd0cc5GKL1h+AG8luagMVsUxJnH
uT/vmRaMdylN+6cyb/MDNIJZaUB6TY/EbsGFx7Qgu1ER86CM7eFBtHIF9c67UpY=
=8iMB
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
