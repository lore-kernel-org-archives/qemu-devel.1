Received: from eggs.gnu.org ([2001:4830:134:3::10]:51606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJKUf-0007lt-Ck
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJKUc-0001Fa-8J
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:34:45 -0500
Date: Mon, 27 Nov 2017 15:34:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171127153436.200a01c7.cohuck@redhat.com>
In-Reply-To: <20171127120255.2d36c8f3.cohuck@redhat.com>
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<3acc6fdb-5638-97b2-2dc7-bce34d22cd1f@redhat.com>
	<20171123104903.24424b40.cohuck@redhat.com>
	<a3655016-0e6b-b80f-2282-f6efbff9e1f9@redhat.com>
	<20171123110844.4649f3b1.cohuck@redhat.com>
	<58a08c1d-3935-42e7-cdc0-7bc45c08d2d3@redhat.com>
	<20171123113326.3b2c5281.cohuck@redhat.com>
	<6ab0d29e-1af0-888a-c932-a0a294ea225d@linux.vnet.ibm.com>
	<d59edb51-71ba-7b75-83df-e4be246d2fce@redhat.com>
	<4000596f-d2a0-c32e-7683-7e074e8132e2@linux.vnet.ibm.com>
	<37aa6eb3-cbdf-39af-2068-7d0e5949e601@linux.vnet.ibm.com>
	<2ab76ab0-b20a-9eaf-cafb-195e1621edd6@redhat.com>
	<20171127120255.2d36c8f3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/7] s390x/pci: factor out
 endianess conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On Mon, 27 Nov 2017 12:02:55 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 27 Nov 2017 07:59:36 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > On 25.11.2017 14:49, Pierre Morel wrote: =20
> > > On 24/11/2017 07:19, Yi Min Zhao wrote:   =20
> > >>
> > >>
> > >> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=888:18, Thomas Huth =E5=86=99=
=E9=81=93:   =20
> > >>> On 23.11.2017 13:07, Yi Min Zhao wrote:   =20
>=20
> > >>>> Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu() mea=
n the
> > >>>> host endianess?   =20
> > >>> Yes, the "cpu" in cpu_to_le or le_to_cpu means the host, indeed. It=
's
> > >>> confusing :-/
> > >>>   =20
> > >>>> If the answers to upper two questions are yes, we actually need ha=
ndle
> > >>>> two cases.
> > >>>> 1) For pcilg, we need to translate the data to little-endian, thus
> > >>>> cpu_to_le**().
> > >>>> 2) For pcistg, we need to translate the data to host endianess, th=
us
> > >>>> le**_to_cpu().   =20
> > >>> I think we've got to byte-swap if the host is big endian (s390x), b=
ut
> > >>> not if the host is little endian (x86 with TCG).   =20
> > >=20
> > > Here is my comprehension of this funny swapping:
> > >=20
> > > - TCG for a BE guest and a le host swap bytes because if we do (regis=
ter
> > > & 0x01) in the zPCI interception code it must work what ever the
> > > endianess is.   =20
> >=20
> > Uhhh, I might have missed that the value has already been byte-swapped
> > once by TCG for env->regs[r1] ...
> > Now I'm pretty much completely confused ... sorry for the noise if I was
> > wrong... I think it's best you ignore my comment for now (i.e. go with
> > bswapXX() instead of le_to_cpuXX()), and if we later wire up zPCI with
> > TCG, we still can fix this if necessary. =20
>=20
> I'll try my current pci/tcg patches on LPAR with this (or a v4) on top.
> If it works there (it doesn't yet on my laptop), we do have a
> endianness issue... (unfortunately, the reverse isn't true.)

It does not look too bad: I can get a nice enP1p0s0 device from a
virtio-net-pci with my tcg patches on my laptop (with these patches as
well, of course). So, endianness is likely mostly fine.

>=20
> I'll post my pci/tcg patches once I get it mostly working (and it does
> not look like a horror from the crypt anymore).

Time to get out the make up kit for these.
