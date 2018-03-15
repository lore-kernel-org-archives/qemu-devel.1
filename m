Received: from eggs.gnu.org ([2001:4830:134:3::10]:32832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewVDA-0003UB-Q0
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewVD8-0002NA-7P
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:54:36 -0400
Date: Thu, 15 Mar 2018 16:54:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180315155415.GA3876@localhost.localdomain>
References: <20180314173213.18563-1-kwolf@redhat.com>
	<20180314173213.18563-2-kwolf@redhat.com>
	<4ab6eff1-f4c2-1e04-5fa8-cc71c3bf308d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4ab6eff1-f4c2-1e04-5fa8-cc71c3bf308d@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] multiboot: Reject kernels exceeding
 the address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, anatol.pomozov@gmail.com, ppandit@redhat.com

Am 15.03.2018 um 06:19 hat Jack Schwartz geschrieben:
> Hi Kevin.
>=20
> My comments are inline...
>=20
> On 2018-03-14 10:32, Kevin Wolf wrote:
> > The code path with a manually set mh_load_addr in the Multiboot heade=
r
> > checks that load_end_addr <=3D load_addr, but the path where load_end=
_addr
> > is automatically detected if 0 is given in the header misses the
> > corresponding check.
> 1) The code checks that load_end_addr >=3D load_addr (before letting it
> through).
>=20
> 2) load_end_addr is used only when it is read in as non-zero, so no che=
ck is
> needed if zero.=A0 (It gets debug-printed even when zero, but is used o=
nly to
> calculate mb_load_size and only when non-zero.)

Oops, good point. I'll change the start of the commit message as follows:

    The code path with a manually set mh_load_end_addr in the Multiboot
    header checks that mh_load_end_addr >=3D mh_load_addr, but the path w=
here
    mh_load_end_addr is 0 in the header and therefore automatically
    calculated from the file size misses the corresponding check.

Does this look better?

> > If the kernel binary size is larger than can fit in
> > the address space after load_addr, we ended up with a kernel_size tha=
t
> > is smaller than load_size, which means that we read the file into a t=
oo
> > small buffer.
> >=20
> > Add a check to reject kernel files with such Multiboot headers.
> Code itself looks fine.
>=20
> Modulo above comments:
> =A0=A0=A0 Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>

Thanks for your review of the series!

Kevin
