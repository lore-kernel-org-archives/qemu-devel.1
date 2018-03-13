Received: from eggs.gnu.org ([2001:4830:134:3::10]:34067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evmlg-0000zu-6X
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evmlc-0008Vy-Uz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:27:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evmlc-0008VM-Ia
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:27:12 -0400
Date: Tue, 13 Mar 2018 16:27:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313162708.GB3784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312201305.16972-1-berrange@redhat.com>
	<CAFEAcA-AHbzvbaxNeMRakB-gA_w3ZnD1x50dLx_hD+3-L9yuTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-AHbzvbaxNeMRakB-gA_w3ZnD1x50dLx_hD+3-L9yuTg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/9] Socket next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Mar 13, 2018 at 04:20:19PM +0000, Peter Maydell wrote:
> On 12 March 2018 at 20:12, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > The following changes since commit 819fd4699c7b36d574292bcbd8bc25e9d7=
16c84b:
> >
> >   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-=
20180309a' into staging (2018-03-12 13:21:53 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/berrange/qemu tags/socket-next-pull-request
> >
> > for you to fetch changes up to f4d2a296de2ccf5ff80ddd343c09f0075d1058=
3a:
> >
> >   char: allow passing pre-opened socket file descriptor at startup (2=
018-03-12 17:50:52 +0000)
> >
> > ----------------------------------------------------------------
> >
> > ----------------------------------------------------------------
> >
> > Daniel P. Berrang=C3=A9 (9):
> >   char: don't silently skip tn3270 protocol init when TLS is enabled
> >   cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int
> >     types
> >   sockets: pull code for testing IP availability out of specific test
> >   sockets: strengthen test suite IP protocol availability checks
> >   sockets: move fd_is_socket() into common sockets code
> >   sockets: check that the named file descriptor is a socket
> >   sockets: allow SocketAddress 'fd' to reference numeric file
> >     descriptors
> >   char: refactor parsing of socket address information
> >   char: allow passing pre-opened socket file descriptor at startup
> >
>=20
> Test failure, 32-bit arm:
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> gtester -k --verbose -m=3Dquick tests/test-c
> utils
> TEST: tests/test-cutils... (pid=3D21029)
>   /cutils/parse_uint/null:                                             =
OK
> [etc]
>   /cutils/parse_uint_full/trailing:                                    =
**
> ERROR:/home/peter.maydell/qemu/tests/test-cutils.c:715:test_qemu_strtou=
i_underflow:
> assertion failed (err =3D
> =3D -ERANGE): (0 =3D=3D -34)

This will be a genuine bug. Not sure if its in the test case or code
yet....

> OK
>   /cutils/parse_uint_full/correct:                                     =
OK
>=20
> Test failure, x86-64 Linux:
>=20
> TEST: tests/boot-serial-test... (pid=3D11205)
>   /sparc64/boot-serial/sun4u:                                          =
**
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:13=
7:check_guest_output:
> assertion failed: (output_ok)
> FAIL
> GTester: last random seed: R02S99166ae475faeb3280608eeed6d61c4f
> (pid=3D15216)

This feels unrelated to the series, so possibly a non-deterministic
failure

>=20
> Test failure, 64-bit arm:
>=20
> ERROR:/home/pm215/qemu/tests/test-aio-multithread.c:365:test_multi_fair=
_mutex:
> assertion failed (counter =3D=3D
>  atomic_counter): (59827 =3D=3D 59828)

I'm sure I've seen this non-deterministic failure before, unrelated to
this series.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
