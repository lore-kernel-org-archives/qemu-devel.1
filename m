Received: from eggs.gnu.org ([2001:4830:134:3::10]:56253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exAfq-0004Te-JQ
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 08:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exAfp-0001YE-9U
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 08:10:58 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:37610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exAfp-0001XQ-4l
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 08:10:57 -0400
Received: by mail-ot0-x22f.google.com with SMTP id t2-v6so3731095otj.4
	for <qemu-devel@nongnu.org>; Sat, 17 Mar 2018 05:10:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180316140508.863778-1-eblake@redhat.com>
References: <20180316140508.863778-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Mar 2018 12:10:35 +0000
Message-ID: <CAFEAcA85KuXQ7afcAQWJcBeh6ghpnxnGnZWDph51XgQhxPNN4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2018 at 14:04, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 3788c7b6e56fa34ee2a73e41706eb2a2447ba7=
5a:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-03-16 11:05:03 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12-v2
>
> for you to fetch changes up to 75eb57e3ed3682f011a6694863044e8b143a9821:
>
>   qapi: Pass '-u' when doing non-silent diff (2018-03-16 09:00:07 -0500)
>
> v2: rebase on Paolo's queue (should fix tests that failed on v1),
> fix rebase conflicts, add two more related patches
> Sending only the changed patches from v1
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-12, 2.12 softfreeze
>
> - Marc-Andr=C3=A9 Lureau: 0/4 qapi: generate a literal qobject for intros=
pection
> - Max Reitz: 0/7 block: Handle null backing link
> - Daniel P. Berrange: chardev: tcp: postpone TLS work until machine done
> - Peter Xu: 00/23 QMP: out-of-band (OOB) execution support
> - Vladimir Sementsov-Ogievskiy: 0/2 block latency histogram
> - Eric Blake: qapi: Pass '-u' when doing non-silent diff
>
> ----------------------------------------------------------------

Hi. I get a bunch of test assertion failures with this:

ppc64 host:

QTEST_QEMU_BINARY=3Dnios2-softmmu/qemu-system-nios2
QTEST_QEMU_IMG=3Dqemu-img MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((
${RANDOM:-0} % 255 + 1)
)} gtester -k --verbose -m=3Dquick  tests/qmp-test
tests/device-introspect-test tests/qom-test tests/test-hmp
TEST: tests/qmp-test... (pid=3D49431)
  /nios2/qmp/protocol:                                                 OK
  /nios2/qmp/oob:                                                      OK
  /nios2/qmp/query-status:                                             OK
  /nios2/qmp/query-block:                                              OK
  /nios2/qmp/query-blockstats:                                         OK
  /nios2/qmp/query-block-jobs:                                         OK
  /nios2/qmp/query-named-block-nodes:
qemu-system-nios2: /home/pm215/qemu/chardev/char-io.c:91: io_watc
h_poll_finalize: Assertion `iwp->src =3D=3D ((void *)0)' failed.
Broken pipe
FAIL

FreeBSD host:

TEST: tests/qmp-test... (pid=3D68428)
  /aarch64/qmp/protocol:                                               OK
  /aarch64/qmp/oob:                                                    OK
[...]
  /aarch64/qmp/query-iothreads:
Assertion failed: (iwp->src =3D=3D NULL), function io_watch_poll_finalize,
file /root/qemu/chardev/char-io.c, line 91.
Broken pipe
FAIL
GTester: last random seed: R02S60296bacb6aea7a3d748811fc486c71e
(pid=3D68462)

OpenBSD host:
  /cris/qmp/qom-list-types:
assertion "iwp->src =3D=3D NULL" failed: file "/home/qemu/chardev/cha
r-io.c", line 91, function "io_watch_poll_finalize"
Broken pipe
FAIL


NetBSD host:

TEST: tests/tpm-crb-test... (pid=3D21337)
  /i386/tpm-crb/test:                                                  OK
Unexpected error in qio_channel_socket_readv() at
/root/qemu/io/channel-socket.c:494:
FAIL: tests/tpm-crb-test
TEST: tests/tpm-tis-test... (pid=3D14763)
  /i386/tpm-tis/test_check_localities:                                 OK
  /i386/tpm-tis/test_check_access_reg:                                 OK
  /i386/tpm-tis/test_check_access_reg_seize:                           OK
  /i386/tpm-tis/test_check_access_reg_release:                         OK
  /i386/tpm-tis/test_check_transmit:                                   OK
Unexpected error in qio_channel_socket_readv() at
/root/qemu/io/channel-socket.c:494:
FAIL: tests/tpm-tis-test

SPARC host:

  /cris/qmp/query-memory-size-summary:
qemu-system-cris: /srv/pm215/qemu/chardev/char-io.c:91: io_watch_
poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.
Broken pipe
FAIL


x86/Linux host:
  /hppa/qmp/query-memdev:
qemu-system-hppa: /home/petmay01/linaro/qemu-for-merges/chardev/c
har-io.c:91: io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' faile=
d.
Broken pipe
FAIL

aarch64 host:
qemu-system-alpha: /home/pm215/qemu/chardev/char-io.c:91:
io_watch_poll_finalize: Assertion `iwp->src =3D=3D ((void *)0)' failed.

One or two of the build hosts did pass, so that plus the varying
tests which failed suggests that the iwp->src assert is an
intermittent or timing based one. The tpm error on NetBSD
is probably a separate issue.

thanks
-- PMM
