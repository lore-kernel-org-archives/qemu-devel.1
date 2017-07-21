Received: from eggs.gnu.org ([2001:4830:134:3::10]:51231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYMzc-0001r6-Da
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYMzb-0007PQ-0v
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:44:36 -0400
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:37557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dYMza-0007P8-OR
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:44:34 -0400
Received: by mail-ua0-x233.google.com with SMTP id f9so35785586uaf.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 18:44:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170720091224.GD21566@redhat.com>
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
From: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Date: Fri, 21 Jul 2017 09:44:33 +0800
Message-ID: <CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

I re-build qemu from the https://github.com/qemu/qemu, and it didn't show
any errors.

I tried the cmd you suggested below:

> qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>            -c /dev/nbd0 \
>            --image-opts driver=3Dqcow2,file.filename=3D
> demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0

but it shows unrecognized option '--object '
why?I missed to install something?

2017-07-20 17:12 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Thu, Jul 20, 2017 at 05:07:49PM +0800, =E9=99=B3=E5=9F=B9=E6=B3=93 wro=
te:
> > oh~ I don't know can expose the LUKS encryption. I'm sure the older(AES=
)
> > can't be mounted by qemu-nbd.
>
> It can be mounted, with current git master (all the commands I show
> below are for git master btw).
>
> You should, however, *never* use the old AES format any more. It is
> broken by design and not considered secure.
>
> > If I encrypt by the command you recommended:
> >
> > > qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
> > >              --image-opts driver=3Dqcow2,file.filename=3D
> > > demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0
>
> This *is* exposing the encrypted file -  not creating it. If you
> want to connect to a host nbd device then you use the command
> above, with the -c arg
>
> $ qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>            -c /dev/nbd0 \
>            --image-opts driver=3Dqcow2,file.filename=3D
> demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0
>
>
> If you have a legacy AES qcow2 file the syntax is very similar
>
> $ qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>            -c /dev/nbd0 \
>            --image-opts driver=3Dqcow2,file.filename=3D
> demo.qcow2,encrypt.format=3Daes,encrypt.key-secret=3Dsec0
>
> Note we just changed the encrypt.format parameter there.
>
>
> To actually create an encrypted file in the first place you need the
> qemu-img command
>
> $ qemu-img create --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Dra=
w \
>            -f qcow2 -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0 \
>            demo.qcow2 1G
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
