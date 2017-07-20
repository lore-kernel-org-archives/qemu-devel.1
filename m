Received: from eggs.gnu.org ([2001:4830:134:3::10]:47451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dY7VZ-0005Pr-LH
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dY7VW-0000Ke-DQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dY7VW-0000KM-6N
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:12:30 -0400
Date: Thu, 20 Jul 2017 10:12:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170720091224.GD21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Cc: qemu-devel@nongnu.org

On Thu, Jul 20, 2017 at 05:07:49PM +0800, =E9=99=B3=E5=9F=B9=E6=B3=93 wro=
te:
> oh~ I don't know can expose the LUKS encryption. I'm sure the older(AES=
)
> can't be mounted by qemu-nbd.

It can be mounted, with current git master (all the commands I show
below are for git master btw).

You should, however, *never* use the old AES format any more. It is
broken by design and not considered secure.

> If I encrypt by the command you recommended:
>=20
> > qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
> >              --image-opts driver=3Dqcow2,file.filename=3D
> > demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0

This *is* exposing the encrypted file -  not creating it. If you
want to connect to a host nbd device then you use the command
above, with the -c arg

$ qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
           -c /dev/nbd0 \
           --image-opts driver=3Dqcow2,file.filename=3Ddemo.qcow2,encrypt=
.format=3Dluks,encrypt.key-secret=3Dsec0


If you have a legacy AES qcow2 file the syntax is very similar

$ qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
           -c /dev/nbd0 \
           --image-opts driver=3Dqcow2,file.filename=3Ddemo.qcow2,encrypt=
.format=3Daes,encrypt.key-secret=3Dsec0

Note we just changed the encrypt.format parameter there.


To actually create an encrypted file in the first place you need the
qemu-img command

$ qemu-img create --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Dra=
w \
           -f qcow2 -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0 \
	   demo.qcow2 1G
 =20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
