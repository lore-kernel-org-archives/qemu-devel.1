Received: from eggs.gnu.org ([2001:4830:134:3::10]:48130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fKtNx-0002se-1z
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fKtNv-0002ra-TX
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:34:33 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:46040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fKtNv-0002oO-M0
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:34:31 -0400
Received: by mail-lf0-x244.google.com with SMTP id w202-v6so26150029lff.12
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 15:34:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180521031620.GE17725@lemon.usersys.redhat.com>
References: <a220810d5e1bcdfb789fbe1b2972550a311fa933.1526668271.git.alistair.francis@wdc.com>
	<20180521031620.GE17725@lemon.usersys.redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 May 2018 15:33:58 -0700
Message-ID: <CAKmqyKNJk2SbjXO3kR04u=xx8wCpoAjMjCC-m01=8PnPH2eoGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] tests/docker: Add a Avocado Docker
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

On Sun, May 20, 2018 at 8:16 PM, Fam Zheng <famz@redhat.com> wrote:
> On Fri, 05/18 11:34, Alistair Francis wrote:
>> Avocado is not trivial to setup on non-Fedora systems. To simplfying
>> future testing add a docker test image that runs Avocado tests.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>> v2:
>>  - Add a seperate fedora-avocado Docker image
>>  - Move the avocado vt-bootstrap into the Docker file
>>
>>  tests/docker/Makefile.include                 |  1 +
>>  .../docker/dockerfiles/fedora-avocado.docker  | 25 +++++++++++++++++
>>  tests/docker/test-avocado                     | 28 +++++++++++++++++++
>>  3 files changed, 54 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/fedora-avocado.docker
>>  create mode 100755 tests/docker/test-avocado
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index ef1a3e62eb..0e3d108dde 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -60,6 +60,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>>  docker-image-debian-s390x-cross: docker-image-debian9
>>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>>  docker-image-debian-win64-cross: docker-image-debian8-mxe
>> +docker-image-fedora-avocado: docker-image-fedora
>>  docker-image-travis: NOUSER=1
>>
>>  # Expand all the pre-requistes for each docker image and test combination
>> diff --git a/tests/docker/dockerfiles/fedora-avocado.docker b/tests/docker/dockerfiles/fedora-avocado.docker
>> new file mode 100644
>> index 0000000000..55b19eebbf
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/fedora-avocado.docker
>> @@ -0,0 +1,25 @@
>> +FROM qemu:fedora
>> +
>> +ENV PACKAGES \
>> +    libvirt-devel \
>> +    nc \
>> +    python-avocado \
>> +    python2-devel python3-devel \
>> +    qemu-kvm \
>> +    tcpdump \
>> +    xz
>> +ENV PIP_PACKAGES \
>> +    avocado-qemu \
>> +    avocado-framework-plugin-runner-remote \
>> +    avocado-framework-plugin-runner-vm \
>> +    avocado-framework-plugin-vt
>> +
>> +ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>
> I think this is inherited from qemu:fedora, no?

It is, I have removed it.

>
>> +
>> +RUN dnf install -y $PACKAGES
>> +RUN pip install $PIP_PACKAGES
>> +RUN avocado vt-bootstrap --yes-to-all --vt-type qemu
>> +
>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>
> Can you keep the parent image's list with ">>" or appending to the old $PACKAGES
> in the above "ENV" directive?
>
>> +
>> +ENV FEATURES mingw clang pyyaml asan avocado
>
> Similarly, is it possible to append to the parent list instead of overriding?

I have changed both of these to append to the original variables.

>
>> diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
>> new file mode 100755
>> index 0000000000..40474db2ce
>> --- /dev/null
>> +++ b/tests/docker/test-avocado
>> @@ -0,0 +1,28 @@
>> +#!/bin/bash -e
>> +#
>> +# Avocado tests on Fedora, as these are a real pain on Debian systems
>
> Shouldn't pip packages work just well on Debian too? What are the pain?
> (Cc'ing Cleber who may want to know this).

There is no debian package at the moment.

Alistair

>
> Fam
>
>> +#
>> +# Copyright (c) 2018 Western Digital.
>> +#
>> +# Authors:
>> +#  Alistair Francis <alistair.francis@wdc.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2
>> +# or (at your option) any later version. See the COPYING file in
>> +# the top-level directory.
>> +#
>> +# Run this test: NOUSER=1 make docker-test-avocado@fedora-avocado
>> +
>> +. common.rc
>> +
>> +requires avocado
>> +
>> +cd "$BUILD_DIR"
>> +
>> +DEF_TARGET_LIST="x86_64-softmmu"
>> +TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>> +build_qemu
>> +install_qemu
>> +
>> +export PATH="${PATH}:$(pwd)"
>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
>> --
>> 2.17.0
>>
