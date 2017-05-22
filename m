Received: from eggs.gnu.org ([2001:4830:134:3::10]:57914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dCpW9-00033G-9q
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dCpW4-00072V-EV
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:45:09 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dCpW4-00072E-8I
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:45:04 -0400
Received: by mail-wr0-x241.google.com with SMTP id 6so7363460wrb.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 08:45:04 -0700 (PDT)
Date: Mon, 22 May 2017 16:45:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170522154501.GA2925@stefanha-x1.localdomain>
References: <CAGKXQyeuP6Oqar4R3Yuy2Y2O=Bg-=wM+wsxmaZGLt9=7fdSmmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <CAGKXQyeuP6Oqar4R3Yuy2Y2O=Bg-=wM+wsxmaZGLt9=7fdSmmg@mail.gmail.com>
Subject: Re: [Qemu-devel] bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@gapps.redhat.com, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2017 at 06:00:12PM +0430, ali saeedi wrote:
> does this code 'atomic_rcu_read(&migration_bitmap_rcu)->bmap' return bitmap
> of dirty blocks or bitmap of pages?

This code changed recently.  Please refer to qemu.git/master when asking
questions on qemu-devel.

I think you're asking about what is now RAMBlock->bmap.  This bitmap
describes pages (each page is TARGET_PAGE_SIZE bytes).

This comment looks outdated, I don't think it returns a byte offset:

/**
 * migration_bitmap_find_dirty: find the next dirty page from start
 *
 * Called with rcu_read_lock() to protect migration_bitmap
 *
 * Returns the byte offset within memory region of the start of a dirty page
 *
 * @rs: current RAM state
 * @rb: RAMBlock where to search for dirty pages
 * @start: page where we start the search
 */
static inline
unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
                                          unsigned long start)

Evidence:

static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
{
    pss->page = migration_bitmap_find_dirty(rs, pss->block, pss->page);
    ...
    if ((pss->page << TARGET_PAGE_BITS) >= pss->block->used_length) {

Stefan

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZIwd9AAoJEJykq7OBq3PI6H4H/3niLNAaFi2Oygnbs6MH++/q
pDmnTCFRIMXUQFUeFFOKoQKSVpfefK9Qbi/nRjx2GC0lH/1lS22RMrHX7zQRCusR
kNn9A2gmQR5YYPXBnEb2XPjxHkEc09qbW29TqZloBwHZfGERvU8uvZYf1P4+3NoB
ShFzwIXawAaTKyZzSOlKE8RwnSoDO0NXra+sqgQQh3duxCla6XjwOPsnmw9bzmek
sEuRdHbXJ84x7NZcl7PqMSslawZ1VTW596ifapKqidVxLYO4j8zOjxfKyQbJf+5k
SBDnLdUnD4modZT5DmuCDlBBGMKQ3WP7qh25tRfvnzV3MJ+RYPoUk6K8ekx+YsY=
=T1tY
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
