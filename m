Received: from eggs.gnu.org ([2001:4830:134:3::10]:47185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXmYg-0002vx-53
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXmYf-0001qK-Al
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:27:10 -0500
Date: Fri, 14 Dec 2018 13:26:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181214122659.GB4341@dhcp-200-186.str.redhat.com>
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
	<20181213144914.GH5427@linux.fritz.box>
	<db4f1763-e28f-387c-2652-ba71c29e97ff@redhat.com>
	<DB6PR07MB3333BA55F6C06E1DB3388D55AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<CAMRbyyug2e_MK+Nzdzso9RheENVzuTba5nYzjBNZbrXCaB2hrw@mail.gmail.com>
	<VI1PR07MB3344412C5DE71936F9689909AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
	<VI1PR07MB334400B255A91277D3597F79AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <VI1PR07MB334400B255A91277D3597F79AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Request for clarification on qemu-img
 convert behavior zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "De Backer, Fred (Nokia - BE/Antwerp)" <fred.de_backer@nokia.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, "Aamir T, Owais (Nokia - IN/Chennai)" <owais.aamir_t@nokia.com>

Am 14.12.2018 um 11:59 hat De Backer, Fred (Nokia - BE/Antwerp) geschrieb=
en:
> >>> Indeed, performance traces are important for issues like this.
> >>See strace of both FC27 and FC29 attached
>=20
> >Looks like you traced only the main thread. All the I/O is done in oth=
er threads.
> >These flags would be useful:
> >
> >=A0 =A0 strace -o log -f -T -tt
>=20
> New straces attached with mentioned flags.  Both truncated due to file
> size at what I believe to be the same position in the "write-phase".
> FC29 has the "zeroing-phase" in front.

So this is indeed using BLKZEROOUT, which has a slow fallback in the
kernel (slow means ~12 seconds for each 2 GB chunk).

We need to avoid calling BLKZEROOUT in the context of pre-zeroing the
image for qemu-img convert.

Of course, we should also think about the other problem you mentioned,
related to copying a smaller image to a larger block device. Does this
require zeroing the parts after the image or should we leave them alone?

I'd tend to say that since you're passing the whole block device as a
target to 'qemu-img convert', and the whole block device will be visible
to a guest run with the same block device configuration, we should
indeed zero out the whole device. But then we would declare the F27
behaviour buggy and this case would stay slow (it would become slightly
faster because we avoid the double writes, but we wouldn't save the
writes to the unused space).

Or we could just refuse to convert if source and target aren't the same
size. Then you would have to use a raw filter driver to select a part
from the target image with the offset/size options. But this would break
backwards compatibility, and its use is not very intuitive either.

Unfortunately, this is just the kind of problems that raw images give
you. :-/

Kevin
