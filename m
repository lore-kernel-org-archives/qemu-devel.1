Received: from eggs.gnu.org ([2001:4830:134:3::10]:58873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1exr3r-0007oP-D3
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1exr3m-0006Gs-DO
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:26:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1exr3m-0006Go-6a
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:26:30 -0400
Date: Mon, 19 Mar 2018 17:26:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180319092618.GF2477@xz-mi>
References: <20180316140508.863778-1-eblake@redhat.com>
	<CAFEAcA85KuXQ7afcAQWJcBeh6ghpnxnGnZWDph51XgQhxPNN4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA85KuXQ7afcAQWJcBeh6ghpnxnGnZWDph51XgQhxPNN4Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, Mar 17, 2018 at 12:10:35PM +0000, Peter Maydell wrote:
> On 16 March 2018 at 14:04, Eric Blake <eblake@redhat.com> wrote:
> > The following changes since commit 3788c7b6e56fa34ee2a73e41706eb2a244=
7ba75a:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' in=
to staging (2018-03-16 11:05:03 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12-v2
> >
> > for you to fetch changes up to 75eb57e3ed3682f011a6694863044e8b143a98=
21:
> >
> >   qapi: Pass '-u' when doing non-silent diff (2018-03-16 09:00:07 -05=
00)
> >
> > v2: rebase on Paolo's queue (should fix tests that failed on v1),
> > fix rebase conflicts, add two more related patches
> > Sending only the changed patches from v1
> >
> > ----------------------------------------------------------------
> > qapi patches for 2018-03-12, 2.12 softfreeze
> >
> > - Marc-Andr=C3=A9 Lureau: 0/4 qapi: generate a literal qobject for in=
trospection
> > - Max Reitz: 0/7 block: Handle null backing link
> > - Daniel P. Berrange: chardev: tcp: postpone TLS work until machine d=
one
> > - Peter Xu: 00/23 QMP: out-of-band (OOB) execution support
> > - Vladimir Sementsov-Ogievskiy: 0/2 block latency histogram
> > - Eric Blake: qapi: Pass '-u' when doing non-silent diff
> >
> > ----------------------------------------------------------------
>=20
> Hi. I get a bunch of test assertion failures with this:
>=20
> ppc64 host:
>=20
> QTEST_QEMU_BINARY=3Dnios2-softmmu/qemu-system-nios2
> QTEST_QEMU_IMG=3Dqemu-img MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((
> ${RANDOM:-0} % 255 + 1)
> )} gtester -k --verbose -m=3Dquick  tests/qmp-test
> tests/device-introspect-test tests/qom-test tests/test-hmp
> TEST: tests/qmp-test... (pid=3D49431)
>   /nios2/qmp/protocol:                                                 =
OK
>   /nios2/qmp/oob:                                                      =
OK
>   /nios2/qmp/query-status:                                             =
OK
>   /nios2/qmp/query-block:                                              =
OK
>   /nios2/qmp/query-blockstats:                                         =
OK
>   /nios2/qmp/query-block-jobs:                                         =
OK
>   /nios2/qmp/query-named-block-nodes:
> qemu-system-nios2: /home/pm215/qemu/chardev/char-io.c:91: io_watc
> h_poll_finalize: Assertion `iwp->src =3D=3D ((void *)0)' failed.
> Broken pipe
> FAIL
>=20
> FreeBSD host:
>=20
> TEST: tests/qmp-test... (pid=3D68428)
>   /aarch64/qmp/protocol:                                               =
OK
>   /aarch64/qmp/oob:                                                    =
OK
> [...]
>   /aarch64/qmp/query-iothreads:
> Assertion failed: (iwp->src =3D=3D NULL), function io_watch_poll_finali=
ze,
> file /root/qemu/chardev/char-io.c, line 91.
> Broken pipe
> FAIL
> GTester: last random seed: R02S60296bacb6aea7a3d748811fc486c71e
> (pid=3D68462)
>=20
> OpenBSD host:
>   /cris/qmp/qom-list-types:
> assertion "iwp->src =3D=3D NULL" failed: file "/home/qemu/chardev/cha
> r-io.c", line 91, function "io_watch_poll_finalize"
> Broken pipe
> FAIL
>=20
>=20
> NetBSD host:
>=20
> TEST: tests/tpm-crb-test... (pid=3D21337)
>   /i386/tpm-crb/test:                                                  =
OK
> Unexpected error in qio_channel_socket_readv() at
> /root/qemu/io/channel-socket.c:494:
> FAIL: tests/tpm-crb-test
> TEST: tests/tpm-tis-test... (pid=3D14763)
>   /i386/tpm-tis/test_check_localities:                                 =
OK
>   /i386/tpm-tis/test_check_access_reg:                                 =
OK
>   /i386/tpm-tis/test_check_access_reg_seize:                           =
OK
>   /i386/tpm-tis/test_check_access_reg_release:                         =
OK
>   /i386/tpm-tis/test_check_transmit:                                   =
OK
> Unexpected error in qio_channel_socket_readv() at
> /root/qemu/io/channel-socket.c:494:
> FAIL: tests/tpm-tis-test
>=20
> SPARC host:
>=20
>   /cris/qmp/query-memory-size-summary:
> qemu-system-cris: /srv/pm215/qemu/chardev/char-io.c:91: io_watch_
> poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.
> Broken pipe
> FAIL
>=20
>=20
> x86/Linux host:
>   /hppa/qmp/query-memdev:
> qemu-system-hppa: /home/petmay01/linaro/qemu-for-merges/chardev/c
> har-io.c:91: io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' f=
ailed.
> Broken pipe
> FAIL
>=20
> aarch64 host:
> qemu-system-alpha: /home/pm215/qemu/chardev/char-io.c:91:
> io_watch_poll_finalize: Assertion `iwp->src =3D=3D ((void *)0)' failed.
>=20
> One or two of the build hosts did pass, so that plus the varying
> tests which failed suggests that the iwp->src assert is an
> intermittent or timing based one. The tpm error on NetBSD
> is probably a separate issue.

I think I still need this to be squashed into "monitor: allow using IO
thread for parsing", which I dropped during respin from v7 to v8:

diff --git a/monitor.c b/monitor.c
index f9ef3e5266..121194111f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4556,6 +4556,11 @@ void monitor_init(Chardev *chr, int flags)
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
         if (mon->use_io_thr) {
+            /*
+             * Make sure the old iowatch be gone.  It's possible when
+             * e.g. the chardev is in client mode, with wait=3Don.
+             */
+            remove_fd_in_watch(chr);
             /*
              * We can't call qemu_chr_fe_set_handlers() directly here
              * since during the procedure the chardev will be active

I thought there should be no pending task on main thread after the QIO
and CHARDEV fixes, but I missed the most general io watch and we still
possibly need the line.

We should fix the assertion problem with above, but not sure about
whether it can fix the QIO issue since I haven't seen that before (and
I can't reproduce that too in my environment).

I hope the fix can work for us.  But in all cases, please feel free to
drop the series if needed.  Sorry for the trouble.

--=20
Peter Xu
