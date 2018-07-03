Received: from eggs.gnu.org ([2001:4830:134:3::10]:58878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faRGW-0004X7-1Q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faRGT-0000y8-VG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:47:08 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faRGT-0000wm-O6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:47:05 -0400
Received: by mail-wr0-x241.google.com with SMTP id f18-v6so3083364wre.10
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 12:47:05 -0700 (PDT)
References: <20180703101444.23778-1-alex.bennee@linaro.org>
	<7e1408cf-b16e-771f-c896-f62b5a934079@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <7e1408cf-b16e-771f-c896-f62b5a934079@redhat.com>
Date: Tue, 03 Jul 2018 20:45:46 +0100
Message-ID: <874lhg9k7p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/20] Travis,
 Code Coverage and Cross Build updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, agraf@suse.de, richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, famz@redhat.com, aurelien@aurel32.net


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/07/2018 12:14, Alex Benn=C3=A9e wrote:
>> The following changes since commit 46d0885adff9b99622d72f23a8b04c298a8bf=
91d:
>>
>>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stag=
ing (2018-07-03 09:49:20 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-code-coverage-and-build-=
tweaks-030718-1
>>
>> for you to fetch changes up to e84a4f16f0fd67e5e503ceb50a9d069f7b76fcb3:
>>
>>   docker: add linux-user powered cross builder for QEMU (2018-07-03 11:0=
9:56 +0100)
>>
>> ----------------------------------------------------------------
>> Code coverage and other build tweaks
>>
>>   - some travis speed-ups
>>   - modernise code coverage support
>>   - docker image cleanups
>>   - clean-up binfmt_misc docker infrastructure
>>   - add debian-powerpc-user-cross image for ppc32 build
>>
>> ----------------------------------------------------------------
>> Alex Benn=C3=A9e (14):
>>       build-system: remove per-test GCOV reporting
>>       .gitignore: add .gcov files
>>       docker: add gcovr to travis image
>>       travis: add gcovr summary for GCOV build
>>       build-system: add clean-coverage target
>>       build-system: add coverage-report target
>>       linux-user: introduce preexit_cleanup
>>       linux-user: add gcov support to preexit_cleanup
>>       docker: filter out linux-user builds for mingw
>>       docker: drop QEMU build-dep from bootstrap
>>       docker: debian-bootstrap.pre allow customising of variant/url
>>       docker: add special handling for FROM:debian-%-user targets
>>       docker: add special rule for deboostrapped images
>>       docker: add linux-user powered cross builder for QEMU
>>
>> Philippe Mathieu-Daud=C3=A9 (6):
>>       travis: do not waste time cloning unused submodules
>>       travis: test out-of-tree builds
>>       docker: ubuntu: Update the package list before installing new ones
>>       docker: ubuntu: Use SDL2
>>       docker: Clean the MXE base image
>>       docker: Do not run tests in 'intermediate' images
>>
>>  .gitignore                                         |  1 +
>>  .travis.yml                                        | 14 +++-
>>  MAINTAINERS                                        |  1 +
>>  Makefile                                           | 24 +++++++
>>  docs/devel/testing.rst                             | 21 ++++--
>>  linux-user/Makefile.objs                           |  2 +-
>>  linux-user/exit.c                                  | 35 ++++++++++
>>  linux-user/qemu.h                                  |  8 +++
>>  linux-user/syscall.c                               | 10 +--
>>  scripts/travis/coverage-summary.sh                 | 27 ++++++++
>>  tests/Makefile.include                             | 10 ---
>>  tests/docker/Makefile.include                      | 74 +++++++++++++++=
+++++--
>>  tests/docker/docker.py                             |  4 ++
>>  tests/docker/dockerfiles/debian-bootstrap.docker   |  2 -
>>  tests/docker/dockerfiles/debian-bootstrap.pre      | 11 +++-
>>  .../dockerfiles/debian-powerpc-user-cross.docker   | 15 +++++
>>  tests/docker/dockerfiles/debian8-mxe.docker        |  2 +-
>>  tests/docker/dockerfiles/travis.docker             |  2 +-
>>  tests/docker/dockerfiles/ubuntu.docker             |  8 +--
>>  19 files changed, 228 insertions(+), 43 deletions(-)
>>  create mode 100644 linux-user/exit.c
>>  create mode 100755 scripts/travis/coverage-summary.sh
>>  create mode 100644 tests/docker/dockerfiles/debian-powerpc-user-cross.d=
ocker
>>
>> --
>> 2.17.1
>>
>>
>
> A bit too fast perhaps...  Can we just revert the offending patch
> instead of patch 11?

OK, I'll re-base and regen the PULL REQ.

--
Alex Benn=C3=A9e
