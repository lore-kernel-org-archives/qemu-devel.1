Received: from eggs.gnu.org ([2001:4830:134:3::10]:48822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1foluo-0006rE-86
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 04:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1folul-0003wW-4T
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 04:39:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1foluk-0003vS-Ph
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 04:39:55 -0400
Date: Sun, 12 Aug 2018 11:39:20 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180812083918.GA3004@lap1>
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
	<80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
	<d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
	<1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
	<5434c03d-7d03-8255-ea0f-d85ec96ac844@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5434c03d-7d03-8255-ea0f-d85ec96ac844@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Rebecca Cran <rebecca@bluestop.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>

On Sat, Aug 11, 2018 at 07:47:49PM +0300, Marcel Apfelbaum wrote:
> Hi,
>=20
> On 08/06/2018 11:51 AM, Thomas Huth wrote:
> > On 07/28/2018 05:50 AM, Rebecca Cran wrote:
> > > On 7/25/18 5:14 AM, Thomas Huth wrote:
> > >=20
> > > > Note that the error has been reported to happen on FreeBSD - so I=
 doubt
> > > > that this <linux/types.h> header should be here.
> > > >=20
> > > > Anyway, our include/standard-headers/linux/types.h is also empty =
... so
> > > > could you try whether it compiles if you simply remove this #incl=
ude
> > > > line, Rebecca?
> > >=20
> > > Sorry for the delay, I'm just getting back to this. Removing the in=
clude
> > > causes it to fail later on, with:
> > >=20
> > > /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning:
> > > implicit declaration of function 'mremap' is invalid in C99
> > > [-Wimplicit-function-declaration]
> > >  =A0=A0=A0 host_virt =3D mremap(curr_page, 0, length, MREMAP_MAYMOV=
E);
> > OK, thanks for checking. According to
> >=20
> >   https://www.freebsd.org/cgi/man.cgi?query=3Dmremap&manpath=3DNetBSD=
+5.0
> >=20
> > that syscall should also be available on FreeBSD. So could you please=
 do
> > one more test and see whether it works when you add the following lin=
e
> > somewhere at the beginning of the file:
> >=20
> >    #include <sys/mman.h>
>=20
> It took some time, but I finally have a FreeBSD VM with RDMA enabled.
>=20
> My findings:
> - The RDMA libraries are there, so the flag=A0 "RDMA"=3Dyes is set corr=
ectly.
> - include of <linux/types.h> is not needed, I will remove it.
> - In FreeBSD mremap is not implemented in all configurations, it depend=
s
> =A0 on some SANITIZER_LINUX flag (Linux emulation?), I think;
> =A0 so pvrdma cannot be compiled.=A0 I think we should have a different=
 QEMU
> configuration
> =A0 flag --enable-pvrdma that will specifically check it is not a "bsd"
> platform.

A good idea.

So, do i get it right that you will "revert back" the things we did
to--enable-rdma and do all our stuff in new --enable-pvrdma section?

> =A0 I'll send a patch for that too.
>=20
> Thanks,
> Marcel
>=20
>=20
> >=20
> >   Thanks,
> >    Thomas
>=20
