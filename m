Received: from eggs.gnu.org ([2001:4830:134:3::10]:38614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqM1C-0005Bx-5G
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqM19-0003X5-0D
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:20:34 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqM18-0003Wt-Oz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:20:30 -0400
Received: by mail-wr0-x234.google.com with SMTP id o42so5545190wrb.3
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 09:20:30 -0700 (PDT)
References: <20170905021201.25684-1-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170905021201.25684-1-famz@redhat.com>
Date: Fri, 08 Sep 2017 17:20:27 +0100
Message-ID: <87shfxgo1g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 00/12] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> v6: Add license to new file. [Philippe]
>     Change tests/.gitignore. [Philippe]
>
> v5: Generate source tar file with a script.
>     Fix tmpdir, use pwd.
>     Reduce default -j to half cores.
>
> v4: Drop unused imports and parameters. [Cleber]
>     Use --exclude-vcs (still no --exclude-vcs-ignores because it's too new). [Philippe]
>     Use gtar if available. [Philippe, Kamil]
>     /dev/ld1a -> /dev/rld1a for netbsd. [Kamil]
>     Only use '-enable-kvm' if /dev/kvm is there. [Kamil]
>     Grammar fixes of README. [Stefan]
>     Rename image on the server to include version and arch. [Kamil]
>     Just ignore *.tmp. [Philippe]
>
> v3: Drop RFC.
>     Add Stefan's and Kamil's reviewed-bys.
>     Use optparse. [Stefan]
>     Drop the VGA patch. [Paolo, Stefan]
>     Improve exit/exit code/doc. [Stefan]
>     Drop unused line from basevm.py. [Stefan]
>     Drop "--target-list" form Makefile.
>     More intelligent '-j'.
>     Add README. [Stefan]
>
> v2: - Add docstring. [Stefan]
>     - Call self._load_io_lod. [Stefan]
>     - Use "info usernet" and dynamic ssh_port forwarding. [Stefan]
>     - Add image checksum.
>     - Use os.rename() and os.makedirs(). [Stefan]
>     - Fix NetBSD URL. [Kamil]
>
> Build tests in one 32 bit Linux guest and three BSD images are defined in this
> series. This is a more managable way than the manually maintained virtual
> machines in patchew. Also, one big advantage of ephemeral VMs over long running
> guests is the reduced RAM usage of host, which makes it possible to have one
> host test all these BSD variants and probably more.
>
> The BSD guest templates are manually prepared following
>
> https://wiki.qemu.org/Hosts/BSD
>
> as it is not easy to automate. (The ideal approach is like the ubuntu.i386
> script, which configures the guest on top of an official released image, fully
> automatically.)
>
> Need for help: "gmake check" in the added OpenBSD image fails with -ENOMEM
> errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? And there
> is a warning from ./configure about OpenBSD going to be unsupported in coming
> releases, is it still the case?

OK I can't boot any of the VMs so I need some more feedback from the
script when things run.

>
> Fam
>
> Fam Zheng (12):
>   gitignore: Ignore vm test images
>   qemu.py: Add "wait()" method
>   scripts: Add archive-source.sh
>   tests: Add vm test lib
>   tests: Add ubuntu.i386 image
>   tests: Add FreeBSD image
>   tests: Add NetBSD image
>   tests: Add OpenBSD image
>   Makefile: Add rules to run vm tests
>   MAINTAINERS: Add tests/vm entry
>   tests: Add README for vm tests
>   docker: Use archive-source.py
>
>  .gitignore                    |   1 +
>  MAINTAINERS                   |   1 +
>  Makefile                      |   2 +
>  configure                     |   2 +-
>  scripts/archive-source.sh     |  31 +++++
>  scripts/qemu.py               |   7 ++
>  tests/.gitignore              |   1 +
>  tests/docker/Makefile.include |  15 +--
>  tests/docker/run              |   8 +-
>  tests/vm/Makefile.include     |  42 +++++++
>  tests/vm/README               |  63 ++++++++++
>  tests/vm/basevm.py            | 276 ++++++++++++++++++++++++++++++++++++++++++
>  tests/vm/freebsd              |  42 +++++++
>  tests/vm/netbsd               |  42 +++++++
>  tests/vm/openbsd              |  43 +++++++
>  tests/vm/ubuntu.i386          |  88 ++++++++++++++
>  16 files changed, 643 insertions(+), 21 deletions(-)
>  create mode 100755 scripts/archive-source.sh
>  create mode 100644 tests/vm/Makefile.include
>  create mode 100644 tests/vm/README
>  create mode 100755 tests/vm/basevm.py
>  create mode 100755 tests/vm/freebsd
>  create mode 100755 tests/vm/netbsd
>  create mode 100755 tests/vm/openbsd
>  create mode 100755 tests/vm/ubuntu.i386


--
Alex Bennée
