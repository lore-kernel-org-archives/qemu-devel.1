Received: from eggs.gnu.org ([2001:4830:134:3::10]:55787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewWWE-0004S0-Le
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewWWD-0005FS-NS
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:18:22 -0400
Date: Thu, 15 Mar 2018 18:18:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180315171811.GF3876@localhost.localdomain>
References: <20180314173213.18563-1-kwolf@redhat.com>
	<20180314173213.18563-2-kwolf@redhat.com>
	<4ab6eff1-f4c2-1e04-5fa8-cc71c3bf308d@oracle.com>
	<20180315155415.GA3876@localhost.localdomain>
	<821bfa6e-9ad5-f486-49a1-f306696992ec@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <821bfa6e-9ad5-f486-49a1-f306696992ec@oracle.com>
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

Am 15.03.2018 um 17:55 hat Jack Schwartz geschrieben:
> On 03/15/18 08:54, Kevin Wolf wrote:
> > Am 15.03.2018 um 06:19 hat Jack Schwartz geschrieben:
> > > Hi Kevin.
> > >=20
> > > My comments are inline...
> > >=20
> > > On 2018-03-14 10:32, Kevin Wolf wrote:
> > > > The code path with a manually set mh_load_addr in the Multiboot h=
eader
> > > > checks that load_end_addr <=3D load_addr, but the path where load=
_end_addr
> > > > is automatically detected if 0 is given in the header misses the
> > > > corresponding check.
> > > 1) The code checks that load_end_addr >=3D load_addr (before lettin=
g it
> > > through).
> > >=20
> > > 2) load_end_addr is used only when it is read in as non-zero, so no=
 check is
> > > needed if zero.=A0 (It gets debug-printed even when zero, but is us=
ed only to
> > > calculate mb_load_size and only when non-zero.)
> > Oops, good point. I'll change the start of the commit message as foll=
ows:
> >=20
> >      The code path with a manually set mh_load_end_addr in the Multib=
oot
> >      header checks that mh_load_end_addr >=3D mh_load_addr, but the p=
ath where
> >      mh_load_end_addr is 0 in the header and therefore automatically
> >      calculated from the file size misses the corresponding check.
> >=20
> > Does this look better?
>=20
> mb_load_size is calculated from the file size, not mh_load_end_addr, so
> I think you mean mb_load_size rather than mh_load_end_addr.=A0 Do you i=
ntend
> to say:
>=20
> =A0 The code path where mh_load_end_addr is non-zero in the Multiboot
> =A0 header checks that mh_load_end_addr >=3D mh_load_addr and so
> =A0 mb_load_size ischecked.=A0 However, mb_load_size is not checked whe=
n
> =A0 calculated from thefile size, when mh_load_end_addr is 0.

Ok, technically that's more accurate.

> Also, if this is what you intend to say, would the following code chang=
e be
> more ofwhat you want:
>=20
> Remove this:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mb_load_size =3D kernel_file_size - m=
b_kernel_text_offset;
> =A0=A0=A0=A0=A0=A0=A0 }
> -=A0=A0=A0=A0=A0=A0 if (mb_load_size > UINT32_MAX - mh_load_addr) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("kernel does not fit in ad=
dress space");
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(1);
> -=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0 if (mh_bss_end_addr) {
>=20
> and instead do this a few lines further down:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mb_kernel_size =3D mh_bss_end_addr - mh_=
load_addr;
> =A0=A0=A0=A0=A0=A0=A0 } else {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mb_kernel_size =3D mb_load_size;
> =A0=A0=A0=A0=A0=A0=A0 }
>=20
> +=A0=A0=A0=A0=A0=A0 if (mb_kernel_size > UINT32_MAX - mh_load_addr) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("kernel does not fit in ad=
dress space");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(1);
> +=A0=A0=A0=A0=A0=A0 }
>=20
> =A0=A0=A0=A0=A0=A0=A0 mb_debug("multiboot: header_addr =3D %#x", mh_hea=
der_addr);
> =A0=A0=A0=A0=A0=A0=A0 mb_debug("multiboot: load_addr =3D %#x", mh_load_=
addr);
>=20
> The reason would be to include the bss area in the calculation, when
> mh_bss_end_addr is non-zero.

Ultimately, mb_load_size > mb_kernel_size is what kills us, so maybe we
could add an assertion for that.

But the reason why this condition could ever be true is the integer
overflow in this line:

    if (mh_bss_end_addr < (mh_load_addr + mb_load_size))

It's generally better to check for integer overflows before they happen
than trying to infer them from the result. In fact, your condition
wouldn't catch the error of test scenario 9:

    kernel_file_size        =3D 0x2035
    mh_header_addr          =3D 0xfffff000
    mh_load_addr            =3D 0xfffff000
    mh_load_end_addr        =3D 0
    mh_bss_end_addr         =3D 0xfffff001

    mb_kernel_text_offset   =3D i - (mh_header_addr - mh_load_addr)
                            =3D 0

    mb_load_size            =3D kernel_file_size - mb_kernel_text_offset
                            =3D 0x2035
                            > UINT32_MAX - mh_load_addr

    mb_kernel_size          =3D mh_bss_end_addr - mh_load_addr
                            =3D 1
                            < UINT32_MAX - mh_load_addr

Kevin
