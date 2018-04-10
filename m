Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5je5-0007UM-Fn
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5je0-0003Yg-F5
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:08:33 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5je0-0003YP-8K
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:08:28 -0400
Received: by mail-pf0-x244.google.com with SMTP id p6so3489189pfn.4
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:08:28 -0700 (PDT)
Date: Tue, 10 Apr 2018 11:08:23 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180410030823.GC11203@stefanha-x1.localdomain>
References: <20180403050115.6037-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <20180403050115.6037-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 01:01:15PM +0800, Peter Xu wrote:

I have changed my mind about this: this patch is necessary.  It is
needed in QEMU 2.12.

> Eric Auger reported the problem days ago that OOB broke ARM when running
> with libvirt:
>=20
> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>=20
> This patch fixes the problem.

The general problem is that the monitor should only dispatch commands
=66rom main_loop_wait().  That's how the code worked before OOB.  After
OOB commands are also dispatched from aio_poll().  This causes
unexpected behavior.

Here is another scenario that this patch fixes:

If the monitor IOThread parses a command while a monitor command is in
aio_poll() then qmp_dispatch() is re-entered.  Monitor command code is
not designed to handle this!

> It's not really needed now since we have turned OOB off now, but it's
> still a bug fix, and it'll start to work when we turn OOB on for ARM.

No, it is needed even when OOB is disabled.  Consider the case where the
chardev handler is invoked by main_loop_wait() and command parsing
completes.  qmp_dispatcher_bh will be marked scheduled=3D1.

Before qmp_dispatcher_bh executes another fd handler runs and invokes
aio_poll().  Now qmp_dispatcher_bh runs from aio_poll() instead of from
main_loop_wait().  Before OOB this was impossible and it's likely to
hang or crash.

> The problem was that the monitor dispatcher bottom half was bound to
> qemu_aio_context, but that context seems to be for block only.

s/but that context seems to be for block only/which is used for nested
event loops/

It's not true that qemu_aio_context is used for block only.  All
qemu_bh_new() users (many emulated devices, for example) use
qemu_aio_context, as well as TPM and 9p.

> For the
> rest of the QEMU world we should be using iohandler context.  So
> assigning monitor dispatcher bottom half to that context.

TPM and 9p also use nested event loops, they need to use
qemu_aio_context.

The choice depends on whether or not nested event loops are needed.
Code that isn't designed for nested event loops has to use iohandler_ctx
(usually via qemu_set_fd_handler()).  Code that is designed for nested
event loops has to use qemu_aio_context.

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazCqnAAoJEJykq7OBq3PI1yoH/iAZrFDZLbSbKP5onMzCA6nO
b3wo7b3mtTUwqL6wSo4ApzkVMoB0AC09tsbvwr6d3TbpY3eRfOqjgGWHyMBL76oN
lCQN8S+sThWystgtDAhn2+mDAiSYssc6TgT/C3NmgZO0OlU/Zo2JwyRj0H//tanb
uJ5LrMFUYbBlCv7dLX5noMvSeZsxdZ3EGSQMXVItoAxCA739XuOYFc5C6xIaPsav
Ll2fJI0F/GGqr/lnv1TwzHjcDYmN0G/L2BXjllR45VPZiCd1b8Ixex8QyKFF6Qo8
8anVNuV7ZJyx7XIxUqGVMVbHxfHKjQkiYyuGpkFJ0+0LuQo5G9GTF9gN/chmovQ=
=XbxK
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
