Received: from eggs.gnu.org ([2001:4830:134:3::10]:49237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eg6nt-0000V6-IF
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eg6np-0006tB-FG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:36:45 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:53395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eg6np-0006rc-3C
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:36:41 -0500
Received: by mail-wm0-x230.google.com with SMTP id t74so13227141wme.3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 02:36:40 -0800 (PST)
References: <20180129033133.31288-1-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180129033133.31288-1-famz@redhat.com>
Date: Mon, 29 Jan 2018 10:36:37 +0000
Message-ID: <87wp01x87e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, f4bug@amsat.org, mreitz@redhat.com, berrange@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com


Fam Zheng <famz@redhat.com> writes:

> To make our efforts on QEMU testing easier to consume by contributors,
> let's add a document. For example, Patchew reports build errors on
> patches that should be relativly easy to reproduce with a few steps, and
> it is much nicer if there is such a documentation that it can refer to.
>
> This focues on how to run existing tests and how to write new test
> cases, without going into the frameworks themselves.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
>
> ---
>
> To reviewers: though we don't have dedicate maintainers on tests or
> docs, there are a few sections that are closely related to maintained
> areas, such as block layer, QAPI, docker/vm based testings and image
> fuzzer (would fuzzier be more correct?). It is perfect if you review
> only the part you maintain or are interested in.
> ---
>  docs/devel/testing.rst | 449 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 449 insertions(+)
>  create mode 100644 docs/devel/testing.rst
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> new file mode 100644
> index 0000000000..16217e4fa2
> --- /dev/null
> +++ b/docs/devel/testing.rst
> @@ -0,0 +1,449 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Testing in QEMU
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document describes the testing infrastructure in QEMU.
> +
> +"Make check" testings
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The "make check" testing family includes most of the C based tests in QE=
MU. For
> +a quick help, run ``make check-help`` from the source tree.
> +
> +The usual way to run these tests is:
> +
> +.. code::
> +
> +  make check
> +
> +which includes QAPI schema tests, unit tests, and QTests. Different sub-=
types
> +of "make check" testings will be explained below.
> +
> +Before running tests, it is best to build QEMU programs first. Some tests
> +expect the executables to exist and will fail with obscure messages if c=
annot
> +find them.
> +
> +Unit tests
> +----------
> +
> +Unit tests, which can be invoked with ``make check-unit``, are simple C =
tests
> +that typically link to individual QEMU objects and exercise them by call=
ing
> +into the modules.
> +
> +If you are writing new code in QEMU, consider adding a unit test, especi=
ally
> +for utility modules that are relatively stateless or have few dependenci=
es. To
> +add a new unit test:
> +
> +1. Create a new source file. For example, ``tests/test-foo.c``.
> +
> +2. Write the test. Normally you would include the headers file which exp=
orts
> +   the module API, then verify the interface behaves as expected from yo=
ur
> +   test. The test code should be organized with the glib testing framewo=
rk.
> +   Copy and modify an existing test is usually a good idea.
> +
> +3. Add the test to ``tests/Makefile.include``. First, name the unit test
> +   program and add it to ``$(check-unit-y)``; then add a rule to build t=
he
> +   executable. Optionally, you can add a magical variable to support ``g=
cov``.
> +   For example:
> +
> +.. code::
> +
> +  check-unit-y +=3D tests/test-foo$(EXESUF)
> +  tests/test-foo$(EXESUF): tests/test-foo.o $(test-util-obj-y)
> +  ...
> +  gcov-files-test-foo-y =3D util/foo.c
> +
> +QTest
> +-----
> +
> +QTest is a testing framework that simplifies starting QEMU and interacti=
ng with
> +the virtual machine just like a guest kernel does. It can be very useful=
 to
> +test hardware emulation, for example; it could also control certain aspe=
cts of
> +QEMU (such as virtual clock stepping), with a specially purposed "qtest"
> +protocol. Refer to the documentation in ``qtest.c`` file for more detail=
s of
> +the protocol.
> +
> +QTest cases can be executed with
> +
> +.. code::
> +
> +   make check-qtest
> +
> +The QTest library is implemented by ``tests/libqtest.c`` and the API is =
defined
> +in ``tests/libqtest.h``.
> +
> +Consider adding a new QTest case when you are introducing a new virtual
> +hardware, or extending one if you are adding functionalities to an exist=
ing
> +virtual device.
> +
> +On top of libqtest, a higher level library, ``libqos``, was created to
> +encapsulate common tasks of device drivers, such as memory management and
> +communicating with system buses or devices. Many virtual device tests use
> +libqos instead of directly calling into libqos.
> +
> +Steps to add a new QTest case are:
> +
> +1. Create a new source file for the test. (More than one file can be add=
ed as
> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write the t=
est
> +   code with the glib and libqtest/libqos API. See also existing tests a=
nd the
> +   library headers for reference.
> +
> +3. Register the new test in ``tests/Makefile.include``. Add the test exe=
cutable
> +   name to an appropriate ``check-qtest-*-y`` variable. For example:
> +
> +   ``check-qtest-generic-y =3D tests/test-foo-device$(EXESUF)``
> +
> +4. Add object dependencies of the executable in the Makefile, including =
the
> +   test source file(s) and other interesting objects. For example:
> +
> +   ``tests/test-foo-device$(EXESUF): tests/test-foo-device.o $(libqos-ob=
j-y)``
> +
> +QAPI schema tests
> +-----------------
> +
> +The QAPI schema tests validate the QAPI parser used by QMP, by feeding
> +predefined input to the parser and compare the result with the reference
> +output.
> +
> +The input/output data is managed under the ``tests/qapi-schema`` directo=
ry.
> +Each test case includes four files that have a common base name:
> +
> +  * ``${casename}.json`` - the file contains the JSON input for feeding =
the
> +    parser
> +  * ``${casename}.out`` - the file contains the expected stdout from the=
 parser
> +  * ``${casename}.err`` - the file contains the expected stderr from the=
 parser
> +  * ``${casename}.exit`` - the expected error code
> +
> +Consider adding a new QAPI schema test when you are making a change on t=
he QAPI
> +parser (either fixing a bug or extending/modifying the syntax). To do th=
is:
> +
> +1. Add four files for the new case as explained above. For example:
> +
> +  ``$EDITOR tests/qapi-schema/foo.{json,out,err,exit}``.
> +
> +2. Add the new test in ``tests/Makefile.include``. For example:
> +
> +  ``qapi-schema +=3D foo.json``
> +
> +check-block
> +-----------
> +
> +``make check-block`` is a legacy command to invoke block layer iotests a=
nd is
> +rarely used. See "QEMU iotests" section below for more information.
> +
> +GCC gcov support
> +----------------
> +
> +``gcov`` is a GCC tool to analyze the testing coverage by instrumenting =
the
> +tested code. To use it, configure QEMU with ``--enable-gcov`` option and=
 build.
> +Then run ``make check`` as usual. There will be additional ``gcov`` outp=
ut as
> +the testing goes on, showing the test coverage percentage numbers per an=
alyzed
> +source file. More detailed reports can be obtained by running ``gcov`` c=
ommand
> +on the output files under ``$build_dir/tests/``, please read the ``gcov``
> +documentation for more information.
> +
> +QEMU iotests
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU iotests, under the directory ``tests/qemu-iotests``, is the testing
> +framework widely used to test block layer related features. It is higher=
 level
> +than "make check" tests and 99% of the code is written in bash or Python
> +scripts.  The testing success criteria is golden output comparison, and =
the
> +test files are named with numbers.
> +
> +To run iotests, make sure QEMU is built successfully, then switch to the
> +``tests/qemu-iotests`` directory under the build directory, and run ``./=
check``
> +with desired arguments from there.
> +
> +By default, "raw" format and "file" protocol is used; all tests will be
> +executed, except the unsupported ones. You can override the format and p=
rotocol
> +with arguments:
> +
> +.. code::
> +
> +  # test with qcow2 format
> +  ./check -qcow2
> +  # or test a different protocol
> +  ./check -nbd
> +
> +It's also possible to list test numbers explicitly:
> +
> +.. code::
> +
> +  # run selected cases with qcow2 format
> +  ./check -qcow2 001 030 153
> +
> +Cache mode can be selected with the "-c" option, which may help reveal b=
ugs
> +that are specific to certain cache mode.
> +
> +More options are supported by the ``./check`` script, run ``./check -h``=
 for
> +help.
> +
> +Writing a new test case
> +-----------------------
> +
> +Consider writing a tests case when you are making any changes to the blo=
ck
> +layer. An iotest case is usually the choice for that. There are already =
many
> +test cases, so it is possible that extending one of them may achieve the=
 goal
> +and save the boilerplate to create one.  (Unfortunately, there isn't a 1=
00%
> +reliable way to find a related one out of hundreds of tests.  One approa=
ch is
> +using ``git grep``.)
> +
> +Usually an iotest case consists of two files. One is an executable that
> +produces output to stdout and stderr, the other is the expected reference
> +output. They are given the same number in file names. E.g. Test script `=
`055``
> +and reference output ``055.out``.
> +
> +In rare cases, when outputs differ between cache mode ``none`` and other=
s, a
> +``.out.nocache`` file is added. In other cases, when outputs differ betw=
een
> +image formats, more than one ``.out`` files are created ending with the
> +respective format names, e.g. ``178.out.qcow2`` and ``178.out.raw``.
> +
> +There isn't a hard rule about how to write a test script, but a new test=
 is
> +usually a (copy and) modification of an existing case.  There are a few
> +commonly used ways to create a test:
> +
> +* A Bash script. It will make use of several environmental variables rel=
ated
> +  to the testing procedure, and could source a group of ``common.*`` lib=
raries
> +  for some common helper routines.
> +
> +* A Python unittest script. Import ``iotests`` and create a subclass of
> +  ``iotests.QMPTestCase``, then call ``iotests.main`` method. The downsi=
de of
> +  this approach is that the output is too scarce, and the script is cons=
idered
> +  harder to debug.
> +
> +* A simple Python script without using unittest module. This could also =
import
> +  ``iotests`` for launching QEMU and utilities etc, but it doesn't inher=
it
> +  from ``iotests.QMPTestCase`` therefore doesn't use the Python unittest
> +  execution. This is a combination of 1 and 2.
> +
> +Pick the language per your preference since both Bash and Python have
> +comparable library support for invoking and interacting with QEMU progra=
ms. If
> +you opt for Python, it is strongly recommended to write Python 3 compati=
ble
> +code.
> +
> +Docker based testing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +------------
> +
> +Docker testing framework in QEMU utilizes the public Docker images to bu=
ild and
> +test QEMU in predefined and widely accessible Linux environments.  This =
makes
> +it possible to expand the test coverage across distros, toolchain flavor=
s and
> +library versions.
> +
> +Prerequisites
> +-------------
> +
> +Install "docker" with the system package manager and start the Docker se=
rvice
> +on your development machine, then make sure you have the privilege to run
> +Docker commands. Typically it means setting up passwordless ``sudo docke=
r``
> +command or login as root.

The third option (which I run) is using group permissions so you can add
users to the docker group and make the socket group accessible via the
daemon.

It should be pointed out that both the sudo and group methods do open up
your machine to being exploited via docker's ability to bind mount
stuff. That is to say it's fine for developers on their own machine but
you might not want to do that on shared servers.

> For example:
> +
> +.. code::
> +
> +  $ sudo yum install docker
> +  $ # or `apt-get install docker` for Ubuntu, etc.
> +  $ sudo systemctl start docker
> +  $ sudo docker ps
> +
> +The last command should print an empty table, to verify the system is re=
ady.
> +
> +Quickstart
> +----------
> +
> +From source tree, type ``make docker`` to see the help. A typical Docker
> +testing can be started without configuring or building QEMU (``configure=
`` and
> +``make`` are done in the container, with parameters defined by the make
> +target):
> +
> +.. code::
> +
> +  make docker-test-build@min-glib
> +
> +This will create a container instance using the ``min-glib`` image (the =
image
> +is downloaded and initialized automatically), in which the ``test-build`=
` job
> +is executed.
> +
> +Images
> +------
> +
> +Along with many other images, the ``min-glib`` image is defined in a Doc=
kerfile
> +in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make dock=
er``
> +command will list all the available images.
> +
> +To add a new image, simply create a new ``.docker`` file under the
> +``tests/docker/dockerfiles/`` directory.
> +
> +A ``.pre`` script can be added beside the ``.docker`` file, which will be
> +executed before building the image under the build context directory. Th=
is is
> +mainly used to do necessary host side setup. One such setup is ``binfmt_=
misc``,
> +for example, to make qemu-user powered cross build containers work.
> +
> +Tests
> +-----
> +
> +Different tests are added to cover various configurations to build and t=
est
> +QEMU.  Docker tests are the executables under ``tests/docker`` named
> +``test-*``. They are typically shell scripts and are built on top of a s=
hell
> +library, ``tests/docker/common.rc``, which provides helpers to find the =
QEMU
> +source and build it.
> +
> +The full list of tests is printed in the ``make docker`` help.
> +
> +Tools
> +-----
> +
> +There are executables that are created to run in a specific Docker envir=
onment.
> +This makes it easy to write scripts that have heavy or special dependenc=
ies,
> +but are still very easy to use.
> +
> +Currently the only tool is ``travis``, which mimics the Travis-CI testin=
gs in a
> +container. It runs in the ``travis`` image:
> +
> +.. code::
> +
> +  make docker-travis@travis
> +
> +Debugging a Docker test failure
> +-------------------------------
> +
> +When CI tasks, maintainers or yourself report a Docker test failure, fol=
low the
> +below steps to debug it:
> +
> +1. Locally reproduce the failure with the reported command line. E.g. run
> +   ``make docker-test-mingw@fedora J=3D8``.
> +2. Add "V=3D1" to the command line, try again, to see the verbose output.
> +3. Further add "DEBUG=3D1" to the command line. This will pause in a she=
ll prompt
> +   in the container right before testing starts. You could either manual=
ly
> +   build QEMU and run tests from there, or press Ctrl-D to let the Docker
> +   testing continue.
> +4. If you press Ctrl-D, the same building and testing procedure will beg=
in, and
> +   will hopefully run into the error again. After that, you will be drop=
ped to
> +   the prompt for debug.
> +
> +Options
> +-------
> +
> +Various options can be used to affect how Docker testings are done. The =
full
> +list is in the ``make docker`` help text. The frequently used ones are:
> +
> +* ``V=3D1``: the same as in top level ``make``. It will be propagated to=
 the
> +  container and enable verbose output.
> +* ``J=3D$N``: the number of parallel tasks in make commands in the conta=
iner,
> +  similar to the ``-j $N`` option in top level ``make``. (The ``-j`` opt=
ion in
> +  top level ``make`` will not be propagated into the container.)
> +* ``DEBUG=3D1``: enables debug. See the previous "Debugging a Docker test
> +  failure" section.
> +
> +VM testing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This test suite contains scripts that bootstrap various guest images tha=
t have
> +necessary packages to build QEMU. The basic usage is documented in ``Mak=
efile``
> +help which is displayed with ``make vm-test``.
> +
> +Quick start
> +-----------
> +
> +Run ``make vm-test`` to list available make targets. Invoke a specific m=
ake
> +command to run build test in an image. For example, ``make vm-build-free=
bsd``
> +will build the source tree in the FreeBSD image. The command can be exec=
uted
> +from either the source tree or the build dir; if the former, ``./configu=
re`` is
> +not needed. The command will then generate the test image in ``./tests/v=
m/``
> +under the working directory.
> +
> +Note: images created by the scripts accept a well-known RSA key pair for=
 SSH
> +access, so they SHOULD NOT be exposed to external interfaces if you are
> +concerned about attackers taking control of the guest and potentially
> +exploiting a QEMU security bug to compromise the host.
> +
> +QEMU binary
> +-----------
> +
> +By default, qemu-system-x86_64 is searched in $PATH to run the guest. If=
 there
> +isn't one, or if it is older than 2.10, the test won't work. In this cas=
e,
> +provide the QEMU binary in env var: ``QEMU=3D/path/to/qemu-2.10+``.
> +
> +Make jobs
> +---------
> +
> +The ``-j$X`` option in the make command line is not propagated into the =
VM,
> +specify ``J=3D$X`` to control the make jobs in the guest.
> +
> +Debugging
> +---------
> +
> +Add ``DEBUG=3D1`` and/or ``V=3D1`` to the make command to allow interact=
ive
> +debugging and verbose output. If this is not enough, see the next sectio=
n.
> +
> +Manual invocation
> +-----------------
> +
> +Each guest script is an executable script with the same command line opt=
ions.
> +For example to work with the netbsd guest, use ``$QEMU_SRC/tests/vm/netb=
sd``:
> +
> +.. code::
> +
> +    $ cd $QEMU_SRC/tests/vm
> +
> +    # To bootstrap the image
> +    $ ./netbsd --build-image --image /var/tmp/netbsd.img
> +    <...>
> +
> +    # To run an arbitrary command in guest (the output will not be echoe=
d unless
> +    # --debug is added)
> +    $ ./netbsd --debug --image /var/tmp/netbsd.img uname -a
> +
> +    # To build QEMU in guest
> +    $ ./netbsd --debug --image /var/tmp/netbsd.img --build-qemu $QEMU_SRC
> +
> +    # To get to an interactive shell
> +    $ ./netbsd --interactive --image /var/tmp/netbsd.img sh
> +
> +Adding new guests
> +-----------------
> +
> +Please look at existing guest scripts for how to add new guests.
> +
> +Most importantly, create a subclass of BaseVM and implement ``build_imag=
e()``
> +method and define ``BUILD_SCRIPT``, then finally call ``basevm.main()`` =
from
> +the script's ``main()``.
> +
> +* Usually in ``build_image()``, a template image is downloaded from a
> +  predefined URL. ``BaseVM._download_with_cache()`` takes care of the ca=
che and
> +  the checksum, so consider using it.
> +
> +* Once the image is downloaded, users, SSH server and QEMU build deps sh=
ould
> +  be set up:
> +
> +  - Root password set to ``BaseVM.ROOT_PASS``
> +  - User ``BaseVM.GUEST_USER`` is created, and password set to
> +    ``BaseVM.GUEST_PASS``
> +  - SSH service is enabled and started on boot,
> +    ``$QEMU_SRC/tests/keys/id_rsa.pub`` is added to ssh's ``authorized_k=
eys``
> +    file of both root and the normal user
> +  - DHCP client service is enabled and started on boot, so that it can
> +    automatically configure the virtio-net-pci NIC and communicate with =
QEMU
> +    user net (10.0.2.2)
> +  - Necessary packages are installed to untar the source tarball and bui=
ld
> +    QEMU
> +
> +* Write a proper ``BUILD_SCRIPT`` template, which should be a shell scri=
pt that
> +  untars a raw virtio-blk block device, which is the tarball data blob o=
f the
> +  QEMU source tree, then configure/build it. Running "make check" is also
> +  recommended.
> +
> +Image fuzzier testing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An image fuzzier was added to exercise format drivers. Currently only qc=
ow2 is
> +supported. To start the fuzzier, run
> +
> +.. code::
> +
> +  tests/image-fuzzer/runner.py -c '[["qemu-img", "info", "$test_img"]]' =
/tmp/test qcow2
> +
> +Alternatively, some command different from "qemu-img info" can be tested=
, by
> +changing the ``-c`` option.


--
Alex Benn=C3=A9e
