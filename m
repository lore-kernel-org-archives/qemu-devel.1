Received: from eggs.gnu.org ([2001:4830:134:3::10]:39213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fLDId-0003DQ-V7
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fLDIa-0001LC-6H
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:50:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fLDIa-0001KS-0h
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:50:20 -0400
References: <a220810d5e1bcdfb789fbe1b2972550a311fa933.1526668271.git.alistair.francis@wdc.com>
	<20180521031620.GE17725@lemon.usersys.redhat.com>
	<CAKmqyKNJk2SbjXO3kR04u=xx8wCpoAjMjCC-m01=8PnPH2eoGQ@mail.gmail.com>
	<07cc80b5-e25f-052c-bae9-7d948774e1af@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <69644776-0a9b-c7a8-a399-0454e82b683c@redhat.com>
Date: Tue, 22 May 2018 15:50:18 -0400
MIME-Version: 1.0
In-Reply-To: <07cc80b5-e25f-052c-bae9-7d948774e1af@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Amador Pahim <amador@pahim.org>, Lucas Meneghel Rodrigues <lookkas@gmail.com>



On 05/21/2018 07:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/21/2018 07:33 PM, Alistair Francis wrote:
>> On Sun, May 20, 2018 at 8:16 PM, Fam Zheng <famz@redhat.com> wrote:
>>> On Fri, 05/18 11:34, Alistair Francis wrote:
>>>> Avocado is not trivial to setup on non-Fedora systems. To simplfying
>>>> future testing add a docker test image that runs Avocado tests.
>>>>
>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>> ---
>>>> v2:
>>>>  - Add a seperate fedora-avocado Docker image
>>>>  - Move the avocado vt-bootstrap into the Docker file
>>>>
>>>>  tests/docker/Makefile.include                 |  1 +
>>>>  .../docker/dockerfiles/fedora-avocado.docker  | 25 ++++++++++++++++=
+
>>>>  tests/docker/test-avocado                     | 28 ++++++++++++++++=
+++
>>>>  3 files changed, 54 insertions(+)
>>>>  create mode 100644 tests/docker/dockerfiles/fedora-avocado.docker
>>>>  create mode 100755 tests/docker/test-avocado
>>>>
>>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.i=
nclude
>>>> index ef1a3e62eb..0e3d108dde 100644
>>>> --- a/tests/docker/Makefile.include
>>>> +++ b/tests/docker/Makefile.include
>>>> @@ -60,6 +60,7 @@ docker-image-debian-ppc64el-cross: docker-image-de=
bian9
>>>>  docker-image-debian-s390x-cross: docker-image-debian9
>>>>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>>>>  docker-image-debian-win64-cross: docker-image-debian8-mxe
>>>> +docker-image-fedora-avocado: docker-image-fedora
>>>>  docker-image-travis: NOUSER=3D1
>>>>
>>>>  # Expand all the pre-requistes for each docker image and test combi=
nation
>>>> diff --git a/tests/docker/dockerfiles/fedora-avocado.docker b/tests/=
docker/dockerfiles/fedora-avocado.docker
>>>> new file mode 100644
>>>> index 0000000000..55b19eebbf
>>>> --- /dev/null
>>>> +++ b/tests/docker/dockerfiles/fedora-avocado.docker
>>>> @@ -0,0 +1,25 @@
>>>> +FROM qemu:fedora
>>>> +
>>>> +ENV PACKAGES \
>>>> +    libvirt-devel \
>>>> +    nc \
>>>> +    python-avocado \

python-avocado is a "Provides" of python2-avocado, but that may may go
away soon (as soon as Fedora 29).  I'd recommend using python2-avocado,
which is the proper package name available on Fedora.

>>>> +    python2-devel python3-devel \
>>>> +    qemu-kvm \
>>>> +    tcpdump \
>>>> +    xz
>>>> +ENV PIP_PACKAGES \
>>>> +    avocado-qemu \

+CC: Amador Pahim

This pip package was created by Amador Pahim, but was intended for demo
purposes only.  Upon finding about this, he (cc'ed here) said that the
package is going to be removed to avoid further confusion.

BTW, the intention is to have this supporting code for QEMU tests in the
QEMU tree itself.  Myself and Eduardo are working on a new version of
that supporting code.  Also, based on what I see on the test-avocado
file, this code is not needed at this point.

>>>> +    avocado-framework-plugin-runner-remote \
>>>> +    avocado-framework-plugin-runner-vm \

These two plugins are only needed if you intend to run tests on remote
machines.  Given "test-avocado" is not making use of those features,
there's no need to install them.

As a side note, plugins are also available on Fedora as RPM packages, so
if I failed to understand the requirements for these plugins here, they
could still be installed as the python2-avocado-plugins-runner-remote
and python2-avocado-plugins-runner-vm RPM packages.

>>>> +    avocado-framework-plugin-vt
>>>> +

+CC: Lucas Rodrigues

This is a pip package created by Lucas Rodrigues, and this code is
certainly used in the "test-avocado" file.  He told me he's using it to
run Avocado-VT tests in a venv on Ubuntu, Amazon Linux, etc, and he's
willing to maintain and update it.

>>>> +ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3

OK, "python3-avocado" is not yet available on Fedora, because it still
tracks the 52.x (LTS) series.  So, if Python 3 is the version chosen, it
maybe a good idea to remove "python-avocado" from "PACKAGES" completely
and use "avocado-framework" instead on "PIP_PACKAGES".

>>>
>>> I think this is inherited from qemu:fedora, no?
>>
>> It is, I have removed it.
>>
>>>
>>>> +
>>>> +RUN dnf install -y $PACKAGES
>>>> +RUN pip install $PIP_PACKAGES
>>>> +RUN avocado vt-bootstrap --yes-to-all --vt-type qemu
>>>> +
>>>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>>>
>>> Can you keep the parent image's list with ">>" or appending to the ol=
d $PACKAGES
>>> in the above "ENV" directive?
>>>
>>>> +
>>>> +ENV FEATURES mingw clang pyyaml asan avocado
>>>
>>> Similarly, is it possible to append to the parent list instead of ove=
rriding?
>>
>> I have changed both of these to append to the original variables.
>=20
> Feel free to add my R-b then:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> I'll wait your respin to try again, hoping I got my proxy issues solved=
.
>=20
>>>
>>>> diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
>>>> new file mode 100755
>>>> index 0000000000..40474db2ce
>>>> --- /dev/null
>>>> +++ b/tests/docker/test-avocado
>>>> @@ -0,0 +1,28 @@
>>>> +#!/bin/bash -e
>>>> +#
>>>> +# Avocado tests on Fedora, as these are a real pain on Debian syste=
ms
>>>
>>> Shouldn't pip packages work just well on Debian too? What are the pai=
n?
>>> (Cc'ing Cleber who may want to know this).
>>
>> There is no debian package at the moment.
>>

That's why Fam said *pip* packages.  In my experience with pip packages
on Debian:

 * avocado-framework: installation and general usage works well.  Found
one issue though when running on containers, though, with an easy
workaround[1]

 * avocado-framework-plugins-vt: currently at version 57.x, and when
used outside of venvs, doesn't get the "test-providers" directory
right[2].  Same happened with latest master (using pip install -e
git+https://github.com/avocado-framework/avocado-vt.git#egg=3Davocado-plu=
gins-vt)

[1] -
https://trello.com/c/yEH8ixps/1328-avocado-crashes-on-systems-without-les=
s

[2] -
https://trello.com/c/0BZZE4CR/1329-avocado-vt-bootstrap-from-pip-package-=
fails-to-find-test-providers-dir

- Cleber.

>> Alistair
>>
>>>
>>> Fam
>>>
>>>> +#
>>>> +# Copyright (c) 2018 Western Digital.
>>>> +#
>>>> +# Authors:
>>>> +#  Alistair Francis <alistair.francis@wdc.com>
>>>> +#
>>>> +# This work is licensed under the terms of the GNU GPL, version 2
>>>> +# or (at your option) any later version. See the COPYING file in
>>>> +# the top-level directory.
>>>> +#
>>>> +# Run this test: NOUSER=3D1 make docker-test-avocado@fedora-avocado
>>>> +
>>>> +. common.rc
>>>> +
>>>> +requires avocado
>>>> +
>>>> +cd "$BUILD_DIR"
>>>> +
>>>> +DEF_TARGET_LIST=3D"x86_64-softmmu"
>>>> +TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>>>> +build_qemu
>>>> +install_qemu
>>>> +
>>>> +export PATH=3D"${PATH}:$(pwd)"
>>>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
>>>> --
>>>> 2.17.0
>>>>
>=20
