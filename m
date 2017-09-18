Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsaf-0008DA-Op
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsac-0005be-LW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:43:45 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:44071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtsac-0005bO-CR
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:43:42 -0400
Received: by mail-wm0-x231.google.com with SMTP id 189so12333334wmh.1
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 02:43:42 -0700 (PDT)
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-13-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170918024402.3265-13-famz@redhat.com>
Date: Mon, 18 Sep 2017 10:43:39 +0100
Message-ID: <87d16ojq9g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 12/13] tests: Add README for vm tests
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

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/README | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 tests/vm/README
>
> diff --git a/tests/vm/README b/tests/vm/README
> new file mode 100644
> index 0000000000..fa30a79ea7
> --- /dev/null
> +++ b/tests/vm/README
> @@ -0,0 +1,85 @@
> +=== VM test suite to run build in guests ===
> +
> +== Intro ==
> +
> +This test suite contains scripts that bootstrap various guest images that have
> +necessary packages to build QEMU. The basic usage is documented in Makefile
> +help which is displayed with "make vm-test".
> +
> +== Quick start ==
> +
> +Run "make vm-test" to list available make targets. Invoke a specific make
> +command to run build test in an image. For example, "make vm-build-freebsd"
> +will build the source tree in the FreeBSD image. The command can be executed
> +from either the source tree or the build dir; if the former, ./configure is not
> +needed. The command will then generate the test image in ./tests/vm/ under the
> +working directory.
> +
> +== QEMU binary ==
> +
> +By default, qemu-system-x86_64 is searched in $PATH to run the guest. If there
> +isn't one, or if it is older than 2.10, the test won't work. In this case,
> +provide the QEMU binary in env var: QEMU=/path/to/qemu-2.10+.
> +
> +== Make jobs ==
> +
> +The "-j$X" option in the make command line is not propagated into the VM,
> +specify "J=$X" to control the make jobs in the guest.
> +
> +== Debugging ==
> +
> +Add "DEBUG=1" and/or "V=1" to the make command to allow interactive debugging
> +and verbose output. If this is not enough, see the next section.
> +
> +== Manual invocation ==
> +
> +Each guest script is an executable script with the same command line options.
> +For example to work with the netbsd guest, use $QEMU_SRC/tests/vm/netbsd:
> +
> +    $ cd $QEMU_SRC/tests/vm
> +
> +    # To bootstrap the image
> +    $ ./netbsd --build-image --image /var/tmp/netbsd.img
> +    <...>
> +
> +    # To run an arbitrary command in guest (the output will not be echoed unless
> +    # --debug is added)
> +    $ ./netbsd --debug --image /var/tmp/netbsd.img uname -a
> +
> +    # To build QEMU in guest
> +    $ ./netbsd --debug --image /var/tmp/netbsd.img --build-qemu
> $QEMU_SRC

This doesn't work:

10:41:38 [alex@zen:~/l/q/q/t/vm] review/fam-vmbuild-v8(+2/-2) ± ./netbsd --debug --image netbsd.img --build-qemu /home/alex/lsrc/qemu/qemu.git/
DEBUG:root:Creating archive ./vm-test-9yVAeh.tmp/data-9b5f9.tar for src_dir dir: /home/alex/lsrc/qemu/qemu.git/
./scripts/archive-source.sh: 27: ./scripts/archive-source.sh: cannot create ./vm-test-9yVAeh.tmp/data-9b5f9.tar.list: Directory nonexistent
Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 234, in main
    vm.add_source_dir(args.build_qemu)
  File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 140, in add_source_dir
    stdout=self._stdout, stderr=self._stderr)
  File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
    raise CalledProcessError(retcode, cmd)
CalledProcessError: Command '['./scripts/archive-source.sh', './vm-test-9yVAeh.tmp/data-9b5f9.tar']' returned non-zero exit status 2

Either adjust the call to be from QEMU_SRC or make the call to
archive-source smarter.

> +
> +    # To get to an interactive shell
> +    $ ./netbsd --interactive --image /var/tmp/netbsd.img sh
> +
> +== Adding new guests ==
> +
> +Please look at existing guest scripts for how to add new guests.
> +
> +Most importantly, create a subclass of BaseVM and implement build_image()
> +method and define BUILD_SCRIPT, then finally call basevm.main() from the
> +script's main().
> +
> +  - Usually in build_image(), a template image is downloaded from a predefined
> +    URL. BaseVM._download_with_cache() takes care of the cache and the
> +    checksum, so consider using it.
> +
> +  - Once the image is downloaded, users, SSH server and QEMU build deps should
> +    be set up:
> +
> +    * Root password set to BaseVM.ROOT_PASS
> +    * User BaseVM.GUEST_USER is created, and password set to BaseVM.GUEST_PASS
> +    * SSH service is enabled and started on boot,
> +      $QEMU_SRC/tests/keys/id_rsa.pub is added to ssh's "authorized_keys" file
> +      of both root and the normal user
> +    * DHCP client service is enabled and started on boot, so that it can
> +      automatically configure the virtio-net-pci NIC and communicate with QEMU
> +      user net (10.0.2.2)
> +    * Necessary packages are installed to untar the source tarball and build
> +      QEMU
> +
> +  - Write a proper BUILD_SCRIPT template, which should be a shell script that
> +    untars a raw virtio-blk block device, which is the tarball data blob of the
> +    QEMU source tree, then configure/build it. Running "make check" is also
> +    recommended.
> +


--
Alex Bennée
