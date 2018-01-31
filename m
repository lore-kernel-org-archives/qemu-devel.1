Received: from eggs.gnu.org ([2001:4830:134:3::10]:56757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egisc-0005p6-UL
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egisZ-0005U2-PU
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:16:10 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1egisZ-0005Tb-Fl
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:16:07 -0500
Received: by mail-wm0-f49.google.com with SMTP id f71so5190506wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 19:16:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <944b5ec8-4037-479f-ac8e-f1c3a601d77a@redhat.com>
References: <20180129033133.31288-1-famz@redhat.com>
	<944b5ec8-4037-479f-ac8e-f1c3a601d77a@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 31 Jan 2018 11:15:35 +0800
Message-ID: <CAK1Eb9k+u8S8V4yBF2Uvjt-JXrjvke9Nf=Y4avf6iD3eDxe4MA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jan 29, 2018 at 10:51 PM, Eric Blake <eblake@redhat.com> wrote:
> On 01/28/2018 09:31 PM, Fam Zheng wrote:
>> To make our efforts on QEMU testing easier to consume by contributors,
>> let's add a document. For example, Patchew reports build errors on
>> patches that should be relativly easy to reproduce with a few steps, and
>
> s/relativly/relatively/
>
>> it is much nicer if there is such a documentation that it can refer to.
>>
>> This focues on how to run existing tests and how to write new test
>
> s/focues/focuses/
>
>> cases, without going into the frameworks themselves.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>> ---
>>
>
> I'll try not to repeat comments made by others...
>
>> +This document describes the testing infrastructure in QEMU.
>> +
>> +"Make check" testings
>> +=====================
>
> s/testings/tests/, or 'Testing with "make check"'

Sounds good, it will put "make" back to lower case again. :)

>
>> +
>> +The "make check" testing family includes most of the C based tests in QEMU. For
>> +a quick help, run ``make check-help`` from the source tree.
>> +
>> +The usual way to run these tests is:
>> +
>> +.. code::
>> +
>> +  make check
>> +
>> +which includes QAPI schema tests, unit tests, and QTests. Different sub-types
>> +of "make check" testings will be explained below.
>
> s/testings/tests/
>
>> +
>> +Before running tests, it is best to build QEMU programs first. Some tests
>> +expect the executables to exist and will fail with obscure messages if cannot
>> +find them.
>
> Should we fix 'make check' to depend on 'make all', so that we don't
> have to require this?

Maybe. We should try.

>
>> +
>> +Unit tests
>> +----------
>> +
>> +Unit tests, which can be invoked with ``make check-unit``, are simple C tests
>> +that typically link to individual QEMU objects and exercise them by calling
>> +into the modules.
>> +
>> +If you are writing new code in QEMU, consider adding a unit test, especially
>> +for utility modules that are relatively stateless or have few dependencies. To
>> +add a new unit test:
>> +
>> +1. Create a new source file. For example, ``tests/test-foo.c``.
>> +
>> +2. Write the test. Normally you would include the headers file which exports
>> +   the module API, then verify the interface behaves as expected from your
>> +   test. The test code should be organized with the glib testing framework.
>> +   Copy and modify an existing test is usually a good idea.
>> +
>> +3. Add the test to ``tests/Makefile.include``. First, name the unit test
>> +   program and add it to ``$(check-unit-y)``; then add a rule to build the
>> +   executable. Optionally, you can add a magical variable to support ``gcov``.
>> +   For example:
>> +
>> +.. code::
>> +
>> +  check-unit-y += tests/test-foo$(EXESUF)
>> +  tests/test-foo$(EXESUF): tests/test-foo.o $(test-util-obj-y)
>> +  ...
>> +  gcov-files-test-foo-y = util/foo.c
>
> Is it worth documenting that you can often run 'gdb ./test-foo' after
> the fact for a failing test?  (Most unit tests don't require any magic
> environment variables to be set)

Good point!

I'll also add a paragraph about MALLOC_PERTURB_ then.

>
>> +
>> +QTest
>> +-----
>> +
>> +QTest is a testing framework that simplifies starting QEMU and interacting with
>> +the virtual machine just like a guest kernel does. It can be very useful to
>> +test hardware emulation, for example; it could also control certain aspects of
>> +QEMU (such as virtual clock stepping), with a specially purposed "qtest"
>> +protocol. Refer to the documentation in ``qtest.c`` file for more details of
>> +the protocol.
>> +
>> +QTest cases can be executed with
>> +
>> +.. code::
>> +
>> +   make check-qtest
>> +
>> +The QTest library is implemented by ``tests/libqtest.c`` and the API is defined
>> +in ``tests/libqtest.h``.
>> +
>> +Consider adding a new QTest case when you are introducing a new virtual
>> +hardware, or extending one if you are adding functionalities to an existing
>> +virtual device.
>> +
>> +On top of libqtest, a higher level library, ``libqos``, was created to
>> +encapsulate common tasks of device drivers, such as memory management and
>> +communicating with system buses or devices. Many virtual device tests use
>> +libqos instead of directly calling into libqos.
>> +
>> +Steps to add a new QTest case are:
>> +
>> +1. Create a new source file for the test. (More than one file can be added as
>> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write the test
>> +   code with the glib and libqtest/libqos API. See also existing tests and the
>> +   library headers for reference.
>> +
>> +3. Register the new test in ``tests/Makefile.include``. Add the test executable
>> +   name to an appropriate ``check-qtest-*-y`` variable. For example:
>> +
>> +   ``check-qtest-generic-y = tests/test-foo-device$(EXESUF)``
>> +
>> +4. Add object dependencies of the executable in the Makefile, including the
>> +   test source file(s) and other interesting objects. For example:
>> +
>> +   ``tests/test-foo-device$(EXESUF): tests/test-foo-device.o $(libqos-obj-y)``
>
> Is it worth documenting that 'make check-qtest' runs EVERY test unless
> you define magic environment variables; and if it fails, running 'make
> check-qtest V=1' can help identify which test failed?  Here, running a
> mere 'gdb foo-device-test' is prone to fail (because it is missing magic
> environment variables); it's possible to run individual tests under gdb
> but it requires more effort (among other things, the V=1 helps you learn
> what environment variables to set).

Yes, will add a paragraph here too.

>
>> +
>
>> +Docker based testing
>> +====================
>
> 'Docker based tests' or 'Testing with docker'
>
>> +
>> +Introduction
>> +------------
>> +
>> +Docker testing framework in QEMU utilizes the public Docker images to build and
>
> s/^Docker/The Docker/
> s/the public/public/
>
>> +test QEMU in predefined and widely accessible Linux environments.  This makes
>> +it possible to expand the test coverage across distros, toolchain flavors and
>> +library versions.
>> +
>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
