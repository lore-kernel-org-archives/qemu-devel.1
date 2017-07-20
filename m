Received: from eggs.gnu.org ([2001:4830:134:3::10]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dY7R2-0001S6-Gc
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dY7R1-0006Yi-CN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:07:52 -0400
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:35383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dY7R1-0006YR-1U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:07:51 -0400
Received: by mail-ua0-x229.google.com with SMTP id d29so8799411uai.2
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:07:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170720085958.GC21566@redhat.com>
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
From: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Date: Thu, 20 Jul 2017 17:07:49 +0800
Message-ID: <CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
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

oh~ I don't know can expose the LUKS encryption. I'm sure the older(AES)
can't be mounted by qemu-nbd.

If I encrypt by the command you recommended:

> qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>              --image-opts driver=3Dqcow2,file.filename=3D
> demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0


Supposed the encrypted file called disk_encry.qcow2
Can I mount disk_encry.qcow2 by the cmd?

> qemu-nbd -c /dev/nbd0 disk_encry.qcow2




2017-07-20 16:59 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Thu, Jul 20, 2017 at 10:43:53AM +0800, =E9=99=B3=E5=9F=B9=E6=B3=93 wro=
te:
> > Can I mount encrypt qcow2 file through qemu-nbd?
>
> What encryption format are you referring to ?  The old AES encrypt, or th=
e
> new LUKS encrypt ? The latter is the only one people should be using, and
> you can expose it with
>
>    qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>              --image-opts driver=3Dqcow2,file.filename=3D
> demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0
>
> Note that 'passwd.txt' file must *not* contain a newline. eg create it
> with   'echo -n 123456 > passwd.txt' - the -n flag to omit the newline
>
> You should only do decrypt in qemu-nbd, if you are trying to interoperate
> with non-QEMU tools.  If you are exposing the NBD volume to a QEMU system
> emulator, you should make the NBD server expose the file as raw, and let
> the  QEMU client do the decryption instead, so data over the NBD socket
> is still secure.
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
