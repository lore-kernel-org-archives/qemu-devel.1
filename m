Received: from eggs.gnu.org ([2001:4830:134:3::10]:55429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdZyc-0003yQ-Ql
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdZya-0001FZ-Jw
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:41:38 -0400
Date: Thu, 12 Jul 2018 13:41:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180712114124.GD4541@localhost.localdomain>
References: <1531235146-6048-1-git-send-email-pl@kamp.de>
	<20180710153155.GM5852@localhost.localdomain>
	<73DCB217-9027-4248-8C81-A83AD4512927@kamp.de>
	<20180711082526.GA4266@localhost.localdomain>
	<7eaf47f6-c536-0c13-b81e-f5f8f75f440a@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7eaf47f6-c536-0c13-b81e-f5f8f75f440a@kamp.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 12.07.2018 um 11:26 hat Peter Lieven geschrieben:
> Am 11.07.2018 um 10:25 schrieb Kevin Wolf:
> > Am 10.07.2018 um 22:16 hat Peter Lieven geschrieben:
> > >=20
> > > > Am 10.07.2018 um 17:31 schrieb Kevin Wolf <kwolf@redhat.com>:
> > > >=20
> > > > Am 10.07.2018 um 17:05 hat Peter Lieven geschrieben:
> > > > > We currently don't enforce that the sparse segments we detect d=
uring convert are
> > > > > aligned. This leads to unnecessary and costly read-modify-write=
 cycles either
> > > > > internally in Qemu or in the background on the storage device a=
s nearly all
> > > > > modern filesystems or hardware have a 4k alignment internally.
> > > > >=20
> > > > > This patch modifies is_allocated_sectors so that its *pnum resu=
lt will always
> > > > > end at an alignment boundary. This way all requests will end at=
 an alignment
> > > > > boundary. The start of all requests will also be aligned as lon=
g as the results
> > > > > of get_block_status do not lead to an unaligned offset.
> > > > >=20
> > > > > The number of RMW cycles when converting an example image [1] t=
o a raw device that
> > > > > has 4k sector size is about 4600 4k read requests to perform a =
total of about 15000
> > > > > write requests. With this path the additional 4600 read request=
s are eliminated while
> > > > > the number of total write requests stays constant.
> > > > >=20
> > > > > [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubun=
tu-16.04-server-cloudimg-amd64-disk1.vmdk
> > > > >=20
> > > > > Signed-off-by: Peter Lieven <pl@kamp.de>
> > > > It looked convincing, but I'm afraid this is still not correct.
> > > > qemu-iotests 122 fails for me with this patch.
> > > I will have a look, where and why exactly it fails, but the allocat=
ion
> > > pattern might be slightly different due to the alignment. What coun=
ts
> > > is that the output is byte identical or not?
> > Right, I noticed only after sending this email that it's qemu-img map
> > output that changes and this might actually be okay. I didn't check,
> > however, if the exact changes are what is expected and whether we nee=
d
> > to add more test cases to cover what the test originally wanted to
> > cover.
> >=20
> > So after all, there's a good chance that all that's missing is just a=
n
> > update to the test case.
> >=20
> > Kevin
>=20
> I checked the output of test 122 and what happens is exactly what is ex=
pected.
> The zero areas align to 4k or 8k respectively. If they don't align they=
 are reported
> as allocated. I would just go ahead and include the test update and sen=
d V6 if there
> are no objections.

Sounds good to me.

Kevin

> If someone feels that the behaviour is undesired we can also just go ah=
ead
> with a light version of the patch and use only bs->request_alignment as=
 target
> alignment and ignore the value of min_sparse.
>=20
> In this case we could even think about as treating this as a bug fix as=
 it
> avoids these ugly RMW cycles that we were seeing and this is why we cre=
ated this
> patch.
>=20
> Best,
> Peter
>=20
> --=20
>=20
> Mit freundlichen Gr=FC=DFen
>=20
> Peter Lieven
>=20
> ...........................................................
>=20
>   KAMP Netzwerkdienste GmbH
>   Vestische Str. 89-91 | 46117 Oberhausen
>   Tel: +49 (0) 208.89 402-50 | Fax: +49 (0) 208.89 402-40
>   pl@kamp.de | http://www.kamp.de
>=20
>   Gesch=E4ftsf=FChrer: Heiner Lante | Michael Lante
>   Amtsgericht Duisburg | HRB Nr. 12154
>   USt-Id-Nr.: DE 120607556
>=20
> ...........................................................
>=20
>=20
