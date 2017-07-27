Received: from eggs.gnu.org ([2001:4830:134:3::10]:53287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daiXQ-00017M-Pr
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daiXN-0004cL-IM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:09:12 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:50905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daiXN-0004b2-BI
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:09:09 -0400
Received: from player759.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id F182A8923B
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 15:09:06 +0200 (CEST)
Date: Thu, 27 Jul 2017 15:09:03 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170727150903.7b906977@bahia.lan>
In-Reply-To: <1501115502-15185-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1501115502-15185-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Uw6sW/3_PjteLajJmWhZEu6";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] fsdev: fix memory leak in main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: qemu-devel@nongnu.org

--Sig_/Uw6sW/3_PjteLajJmWhZEu6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jul 2017 08:31:42 +0800
ZhiPeng Lu <lu.zhipeng@zte.com.cn> wrote:
> @rpath and @ sock_name are not freed and leaked.
>=20

The leak is harmless since the process is expected to terminate when main()
returns. So, even if I fully agree that we should always take care of alloc=
ated
memory, I will push it to my 9p-next branch and wait for 2.11 before pushin=
g it
upstream.

> Signed-off-by: Zhipeng Lu lu.zhipeng@zte.com.cn
> ---
>  fsdev/virtfs-proxy-helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 6c066ec..8e48500 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -1162,6 +1162,8 @@ int main(int argc, char **argv)
> =20
>      process_requests(sock);
>  error:
> +    g_free(rpath);
> +    g_free(sock_name);
>      do_log(LOG_INFO, "Done\n");
>      closelog();
>      return 0;


--Sig_/Uw6sW/3_PjteLajJmWhZEu6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEUEARECAAYFAll55e8ACgkQAvw66wEB28LcAACaAhOSJXpKAXLgOZl8ycqgeIGV
DysAl1Kz0D+8sNaSvP0FOPHoGllRcdY=
=tfC6
-----END PGP SIGNATURE-----

--Sig_/Uw6sW/3_PjteLajJmWhZEu6--
