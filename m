Received: from eggs.gnu.org ([2001:4830:134:3::10]:49080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq8MP-0000Jf-JK
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq8MI-0002Eu-8G
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:50:02 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
	<4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8bb7ace1-9272-ae64-b2b4-e1060195d7d6@redhat.com>
Date: Wed, 15 Aug 2018 21:49:47 -0500
MIME-Version: 1.0
In-Reply-To: <4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, fullmanet@gmail.com, qemu-block@nongnu.org

On 08/15/2018 09:39 PM, Eric Blake wrote:

>> (My full opinion on the matter: dd has a horrible interface.=C2=A0 I d=
on't
>> quite see why we replicated that inside qemu-img.=C2=A0 Also, if you w=
ant to
>> use dd, why not use qemu-nbd + Linux nbd device + real dd?)
>=20
> Because of performance: qemu-nbd + Linux nbd device + real dd is one=20
> more layer of data copying (each write() from dd goes to kernel, then i=
s=20
> sent to qemu-nbd in userspace as a socket message before being sent bac=
k=20
> to the kernel to actually write() to the final destination) compared to=
=20
> just doing it all in one process (write() lands in the final destinatio=
n=20
> with no further user space bouncing).=C2=A0 And because the additional =
steps=20
> to set it up are awkward (see my other email where I rant about losing=20
> the better part of today to realizing that 'dd ...; qemu-nbd -d=20
> /dev/nbd1' loses data if you omit conv=3Dfdatasync).

Oh, and because the kernel NBD module still doesn't know how to do=20
sparse writes or expose the location of holes. In the kernel source, see=20
drivers/block/nbd.c and weep at how far it lags behind qemu-nbd features=20
that at least 'qemu-img convert' can take advantage of, but aren't=20
present via /dev/nbd*

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
