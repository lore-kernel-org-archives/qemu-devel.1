Received: from eggs.gnu.org ([2001:4830:134:3::10]:50961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsPkv-0008TS-QA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsPkt-0001EG-Rx
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dsPkt-0001Dj-M1
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:44:15 -0400
Message-ID: <1505378653.31557.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Sep 2017 10:44:13 +0200
In-Reply-To: <5678da9e-ddea-1d31-77ff-8ea52ee30ca9@linux.vnet.ibm.com>
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<0a156f413f67b1bf55c5516d8263a15db3ec42c3.1505225353.git.alifm@linux.vnet.ibm.com>
	<1505290435.22749.3.camel@redhat.com>
	<5678da9e-ddea-1d31-77ff-8ea52ee30ca9@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/2] virtio_gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com

On Wed, 2017-09-13 at 11:53 -0400, Farhan Ali wrote:
>=20
> On 09/13/2017 04:13 AM, Gerd Hoffmann wrote:
> > Please move this to a helper function, maybe by updating the
> > VIRTIO_GPU_FILL_CMD macro.
> >=20
> > The header fields should be byteswapped too.=C2=A0=C2=A0As most struc=
ts have
> > 32bit fields only (with the exception of hdr.fence_id) you should
> > be
> > able to create a generic byteswap function which only needs the
> > struct
> > size as argument and handles all structs without addresses/offsets
> > (which are 64bit fields).
>=20
> I am not sure if I understand what you mean here. Since struct=C2=A0
> virtio_gpu_ctrl_hdr is part of every struct, so any such function
> would also need to handle the case of hdr.fence_id, right?

Yes, but that is common in all structs.  You can have one function to
handle the header, one generic function (calls the header function for
the header and just does 32bit byteswaps for everything else), one
specific function for each operation which has a 64bit address
somewhere in the struct (which again can use the header function for
the header).

cheers,
  Gerd
