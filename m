Received: from eggs.gnu.org ([2001:4830:134:3::10]:46191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcCNf-0006e8-Ex
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcCNe-0001Cv-En
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:13:15 -0400
Date: Mon, 31 Jul 2017 17:13:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170731151300.GC12064@localhost.localdomain>
References: <20170731125111.28052-1-kwolf@redhat.com>
	<20170731143809.GC22129@localhost.localdomain>
	<5e788182-b778-e027-2250-8e7c643786ae@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5e788182-b778-e027-2250-8e7c643786ae@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/qapi: Remove redundat NULL
 check to silence Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Jeff Cody <jcody@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 31.07.2017 um 16:54 hat Philippe Mathieu-Daud=E9 geschrieben:
> On 07/31/2017 11:38 AM, Jeff Cody wrote:
> > On Mon, Jul 31, 2017 at 02:51:11PM +0200, Kevin Wolf wrote:
> > > When skipping implicit nodes in bdrv_block_device_info(), we know t=
hat
> > > bs0 is always non-NULL; initially, because it's taken from a BdrvCh=
ild
> >=20
> > Not to mention, we deference bs0 in the chunk of code right above thi=
s, so
> > we'd segfault anyway if the initial value was NULL.

Not really. The last use of bs0 before the loop is:

    bs0 =3D bs0->backing->bs;bs0 =3D bs0->backing->bs;

So we're pointing to a different BDS now.

> Yes, please move your assert before:
>=20
> 137:    if (bs0->drv && bs0->backing) {

That would assert something completely different and much more obvious.
(And apart from that, bdrv_query_image_info() in line 130 already
dereferences bs0, so it would be too late, too.)

What I want to assert here is that every implicit image has a backing
file.

Kevin
