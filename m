Received: from eggs.gnu.org ([2001:4830:134:3::10]:39614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoS1-0008DX-OU
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoRy-0002mL-H7
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:28:49 -0500
Received: from [45.249.212.187] (port=2493 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEoRx-0002b8-Qk
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:28:46 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 8 Dec 2016 02:28:27 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA156A93@DGGEMA505-MBX.china.huawei.com>
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
In-Reply-To: <09ca3210-e066-3937-1351-46b857a1dda7@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>

Hi Max,

>=20
> On 07.12.2016 03:29, Gonglei wrote:
> > Common practice with sensitive information (key material, passwords,
> > etc). Prevents sensitive information from being exposed by accident lat=
er in
> > coredumps, memory disclosure bugs when heap memory is reused, etc.
> >
> > Sensitive information is sometimes also held in mlocked pages to preven=
t
> > it being swapped to disk but that's not being done here.
> >
> > Let's zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> > for key material security.
> >
> > [v2: Stefan perfects the commit message, thanks]
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> As far as I'm aware, other projects usually have a special memset
> variation for doing this. That is because compilers may choose to
> "optimize" memset(p, ...) + free(p) to just the free(p). Having a

Actually, I googled this, but I didn't find a definite answer. And

The Linux kernel uses kzfree instead of memset + kfree (mm/slab_common.c).

void kzfree(const void *p)
{
	size_t ks;
	void *mem =3D (void *)p;

	if (unlikely(ZERO_OR_NULL_PTR(mem)))
		return;
	ks =3D ksize(mem);
	memset(mem, 0, ks);
	kfree(mem);
}

Which is very similar with glib memory management IMO.

> special zeroizing function that the compiler cannot drop would prevent
> this. (By the way, C11 provides this functionality with memset_s().)
>=20
> We are not using free() but g_free(), so the danger of a compiler
> detecting the pattern and "optimizing" it is probably much lower, but
> still, the possibility exists.
>=20
Do we need to think about the compiler optimization here ? Or follow
what the linux kernel does.

Regards,
-Gonglei
