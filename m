Received: from eggs.gnu.org ([2001:4830:134:3::10]:56878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGmfw-00081r-Ra
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGmfr-0000TQ-Uy
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:03:52 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:42418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eGmfr-0000T1-Nk
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:03:47 -0500
Received: by mail-wm0-x244.google.com with SMTP id 5so17917937wmk.1
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 06:03:47 -0800 (PST)
Date: Mon, 20 Nov 2017 14:03:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120140344.GE4516@stefanha-x1.localdomain>
References: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
	<20171117135409.GA3669@stefanha-x1.localdomain>
	<20171120084141.GA6622@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <20171120084141.GA6622@yangzhon-Virtual>
Subject: Re: [Qemu-devel] [PATCH] rcu: reduce half heap memory size by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com, wangxinxin.wang@huawei.com, stone.xulei@huawei.com, qemu-devel@nongnu.org, anthony.xu@intel.com, arei.gonglei@huawei.com, pbonzini@redhat.com


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 04:41:41PM +0800, Zhong Yang wrote:
> On Fri, Nov 17, 2017 at 01:54:09PM +0000, Stefan Hajnoczi wrote:
> > On Fri, Nov 17, 2017 at 02:23:34PM +0800, Yang Zhong wrote:
> > > @@ -272,6 +273,9 @@ static void *call_rcu_thread(void *opaque)
> > >              node->func(node);
> > >          }
> > >          qemu_mutex_unlock_iothread();
> > > +#ifdef CONFIG_LINUX
> > > +        malloc_trim(0);
> > > +#endif
> >=20
> > It is important that the rcu thread isn't overzealous in minimizing heap
> > size if that means ordinary malloc(3) calls will experience latency
> > spikes.  Please leave a few MB free so that malloc(3) doesn't take the
> > slow path.
> >=20
>   Hello Stefan,
>=20
>   From the Qemu bootup procedure, the qemu malloc chunk memory from OS, n=
ot
>   from glibc free list which is freed before by Qemu. Maybe there are som=
e=20
>   issues in glibc memory mechanism. I will continue to fine this parameter
>   to get better balance, Many thanks!

I was suggesting malloc_trim(4 * 1024 * 1024) or similar instead of
malloc_trim(0).

Stefan

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEuDAAAoJEJykq7OBq3PIa0kH/3DJBoulNz3ekMvqUcNMXU2S
jrOhgtWBnm4dWoAki4szJUiM5sfHZR6248ekhT31mf6MjoObqc8U1Pa73w/BOJ7N
mc53Sn2oZ5joYQN83rJRewWWhtQrCGC0CDko2pPEyrj2eItBHH17gdARjLcSQEt1
3GJrTtITf9MjEGxd+FEmb/BpL3f+rR7gIATq0aSNfbZkLIk0YjjIzcXIytFNRUBA
VlqzzsqwDkWXF004//8hThVGVKtDMZstCSdPPbxaPKYODWfwcW1pNOEds3tyq4wJ
y/degKhucbvpttZmWvWqsSVqsysMgLeaFHS6boM676tTxzWqt0HWGjte34/oCiE=
=Wuq2
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
