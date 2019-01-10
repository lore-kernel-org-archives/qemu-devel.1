Received: from eggs.gnu.org ([209.51.188.92]:58408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghb4w-0006SG-O8
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghb4v-0001lg-3R
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:13:02 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghb4t-0001kc-Io
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:13:00 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so9991589otm.13
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 06:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20190109220942.23822-1-pbonzini@redhat.com>
In-Reply-To: <20190109220942.23822-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 14:12:47 +0000
Message-ID: <CAFEAcA9v3v3k_cFZCwvD5WD4FmiuFT=0UAjCBHEwpO+LuQWjAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v6 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 9 Jan 2019 at 22:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit c102d9471f8f02d9fbea72ec4505d7089173f4=
70:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90107' into staging (2019-01-07 16:56:33 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5eddc84292736dc57db341f9724395a29d3614f7:
>
>   avoid TABs in files that only contain a few (2019-01-09 23:01:14 +0100)
>
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo)
> * QTAILQ rewrite (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)
>
> ----------------------------------------------------------------

This almost all works fine (there are some annoying intermittents
which mean that most of my full test runs fail somewhere for some
reason, but they aren't issues with this pullreq as far as I can
see[*]), but...

...'make check-tcg' fails:

e104462:xenial:all-linux-static$ make check-tcg
  BUILD   debian9
The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata
apt install -y --no-install-recommends         bison
build-essential         ca-certificates         clang         flex
    gettext         git         libtest-harness-perl
pkg-config         psmisc         python         texinfo
$(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\
-f2)' returned a non-zero code: 100
Traceback (most recent call last):
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 563, in <module>
    sys.exit(main())
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 560, in main
    return args.cmdobj.run(args, argv)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 376, in run
    extra_files_cksum=3Dcksum)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 254, in build_image
    quiet=3Dquiet)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 181, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t',
'qemu:debian9', '-f', '/tmp/docker_build_cViZ6/tmpsvY3Oz.docker',
'/tmp/docker_build_cViZ6']' returned non-zero exit status 100
/home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
recipe for target 'docker-image-debian9' failed
make: *** [docker-image-debian9] Error 1

This seems to happen reliably with this pullreq merged
in, but master is OK.

[*] intermittents I've seen recently (ie over the last
month or two):
 + failures in the rcu torture-test
 + the netbsd VM sometimes fails to start and the "wait 300
   seconds while trying to ssh into it" timeout expires;
   this might be load-related but it is always netbsd that
   fails like this, never the openbsd or freebsd VMs
 + test-filter-mirror sometimes seems to hang
 + the migration test hangs sometimes with TCG

thanks
-- PMM
