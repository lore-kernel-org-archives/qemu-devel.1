Received: from eggs.gnu.org ([2001:4830:134:3::10]:59683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG2ys-0000Hl-7G
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG2yr-00007p-8G
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:48:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fG2yr-00007h-3x
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:48:37 -0400
Date: Tue, 8 May 2018 14:48:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180508134831.GV5967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tpm_emu_test_wait_cond: code should not be reached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, May 08, 2018 at 09:41:05AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi,
>=20
> Travis CI hit this error testing commit 853f8ca13cd6d256:
>=20
> $ clang --version
> Apple LLVM version 8.1.0 (clang-802.0.42)
> Target: x86_64-apple-darwin16.7.0
>=20
> $ ./configure
> C compiler        clang
> host CPU          x86_64
> ...
> TPM support       yes
> libssh2 support   no
> TPM passthrough   no
> TPM emulator      yes
>=20
>   GTESTER check-qtest-i386
> Unexpected error in qio_channel_socket_readv() at io/channel-socket.c:4=
94:
> **
> ERROR:tests/tpm-emu.c:27:tpm_emu_test_wait_cond: code should not be rea=
ched
> make: *** [check-qtest-i386] Error 1
> make: *** Waiting for unfinished jobs....

This test has a couple of threads running, and passes &error_abort to
the qio_channel_socket_readv() function. So I expect that one thread
is closing the socket connection, and the other thread has not yet
shutdown cleanly, so tries to readv on a dead socket triggering the
error_abort.  IOW,  qio_channel_socket_readv is likely just the symptom
of brokeness somewhere else in the test, not the cause.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
