Received: from eggs.gnu.org ([2001:4830:134:3::10]:38481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gor@linux.ibm.com>) id 1fXT7T-0001fJ-AZ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gor@linux.ibm.com>) id 1fXT7P-0001UT-9m
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35538
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gor@linux.ibm.com>) id 1fXT7P-0001UM-4L
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:09:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PF4HHB057917
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:09:26 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ju2q6g74s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:09:26 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <gor@linux.ibm.com>;
	Mon, 25 Jun 2018 16:09:24 +0100
Date: Mon, 25 Jun 2018 17:09:17 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
Message-Id: <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Mon, Jun 25, 2018 at 06:35:30AM -0700, Guenter Roeck wrote:
> On 06/25/2018 05:26 AM, Christian Borntraeger wrote:
> >=20
> >=20
> > On 06/25/2018 10:49 AM, Cornelia Huck wrote:
> > > On Mon, 25 Jun 2018 10:36:33 +0200
> > > Vasily Gorbik <gor@linux.ibm.com> wrote:
> > >=20
> > > > This change has been done on purpose. Uncompressed image is not g=
oing
> > > > to be bootable any more. In future the decompressor phase would g=
et
> > > > more function (early memory detection as an example) and there is=
 no
> > > > chance to duplicate that code in uncompressed image as well (to k=
eep it
> > > > bootable on its own). The patch series commit messages contain mo=
re
> > > > technical details.
> > > >=20
> > > > For qemu either bzImage or arch/s390/boot/compressed/vmlinux shou=
ld be
> > > > used, which are bootable images.
> > > >=20
> > > > But that's really confusing that uncompressed vmlinux is still ki=
nd
> > > > of booting. May be we should discuss how to avoid this confusion
> > > > (may be change uncompressed image enty point to a function doing
> > > > disabled wait with badb007 or smth) and how to encourage people t=
o use
> > > > arch/s390/boot/compressed/vmlinux instead.
> > >=20
>=20
> If an image is not expected to be bootable, a message such as "This ima=
ge does
> not boot. Please use <correct image>" would be nice. Unfortunately, whi=
ch image
> to boot under qemu is pretty much undocumented, and it is guesswork for=
 each
> architecture/platform.
>=20
> Guenter
>=20
> > I talked to Vasily and the vmlinux file in the linux source path is j=
ust an
> > intermediate file. Future changes will happen that will make that ELF=
 file
> > unsuitable for direct boot anyway (e.g. think about potential ASLR or=
 Kasan
> > changes).
> >=20
> >   If yes, it would make sense to explicitly fence it. But I'm
> > > worried that it would break previously working setups (did we docum=
ent
> > > the purpose of the images anywhere?
> > >=20

To avoid confusion with trying to boot uncompressed vmlinux under qemu
we could detect it and print "nice" message in the kernel.

Please consider the following patch.

Vasily Gorbik (1):
  s390/boot: block uncompressed vmlinux booting attempts

 arch/s390/boot/head.S         |  4 ++--
 arch/s390/include/asm/setup.h |  3 ++-
 arch/s390/kernel/early.c      | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

--=20
=E2=A3=94=E2=A2=BB=E2=A3=9F=E2=A2=A2 2.18.0.rc2.13.g4da9a5d
=E2=A3=BF=E2=A2=BF=E2=A1=BF=E2=A3=BF pacman edition
