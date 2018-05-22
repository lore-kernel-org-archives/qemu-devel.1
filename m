Received: from eggs.gnu.org ([2001:4830:134:3::10]:46984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lookkas@gmail.com>) id 1fLDfc-0004A6-N1
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lookkas@gmail.com>) id 1fLDfW-0003nZ-TA
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:14:08 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lookkas@gmail.com>) id 1fLDfW-0003mt-Ii
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:14:02 -0400
Received: by mail-wr0-x242.google.com with SMTP id p3-v6so3591813wrn.7
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:14:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <69644776-0a9b-c7a8-a399-0454e82b683c@redhat.com>
References: <a220810d5e1bcdfb789fbe1b2972550a311fa933.1526668271.git.alistair.francis@wdc.com>
	<20180521031620.GE17725@lemon.usersys.redhat.com>
	<CAKmqyKNJk2SbjXO3kR04u=xx8wCpoAjMjCC-m01=8PnPH2eoGQ@mail.gmail.com>
	<07cc80b5-e25f-052c-bae9-7d948774e1af@amsat.org>
	<69644776-0a9b-c7a8-a399-0454e82b683c@redhat.com>
From: Lucas Meneghel Rodrigues <lookkas@gmail.com>
Date: Tue, 22 May 2018 22:14:00 +0200
Message-ID: <CAJnY6jrmyNgDzA2KhvWAGQdKYzCYrnQRcQqZza00+Dx+JwpXnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Amador Pahim <amador@pahim.org>

On Tue, May 22, 2018 at 9:50 PM, Cleber Rosa <crosa@redhat.com> wrote:
>
>
> On 05/21/2018 07:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 05/21/2018 07:33 PM, Alistair Francis wrote:
>>> On Sun, May 20, 2018 at 8:16 PM, Fam Zheng <famz@redhat.com> wrote:
>>>> On Fri, 05/18 11:34, Alistair Francis wrote:
>>>>> Avocado is not trivial to setup on non-Fedora systems. To simplfying
>>>>> future testing add a docker test image that runs Avocado tests.
>>>>>
>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>>> ---
>>>>> v2:
>>>>>  - Add a seperate fedora-avocado Docker image
>>>>>  - Move the avocado vt-bootstrap into the Docker file
>>>>>
>>>>>  tests/docker/Makefile.include                 |  1 +
>>>>>  .../docker/dockerfiles/fedora-avocado.docker  | 25 +++++++++++++++++
>>>>>  tests/docker/test-avocado                     | 28 +++++++++++++++++=
++
>>>>>  3 files changed, 54 insertions(+)
>>>>>  create mode 100644 tests/docker/dockerfiles/fedora-avocado.docker
>>>>>  create mode 100755 tests/docker/test-avocado
>>>>>
>>>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.in=
clude
>>>>> index ef1a3e62eb..0e3d108dde 100644
>>>>> --- a/tests/docker/Makefile.include
>>>>> +++ b/tests/docker/Makefile.include
>>>>> @@ -60,6 +60,7 @@ docker-image-debian-ppc64el-cross: docker-image-deb=
ian9
>>>>>  docker-image-debian-s390x-cross: docker-image-debian9
>>>>>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>>>>>  docker-image-debian-win64-cross: docker-image-debian8-mxe
>>>>> +docker-image-fedora-avocado: docker-image-fedora
>>>>>  docker-image-travis: NOUSER=3D1
>>>>>
>>>>>  # Expand all the pre-requistes for each docker image and test combin=
ation
>>>>> diff --git a/tests/docker/dockerfiles/fedora-avocado.docker b/tests/d=
ocker/dockerfiles/fedora-avocado.docker
>>>>> new file mode 100644
>>>>> index 0000000000..55b19eebbf
>>>>> --- /dev/null
>>>>> +++ b/tests/docker/dockerfiles/fedora-avocado.docker
>>>>> @@ -0,0 +1,25 @@
>>>>> +FROM qemu:fedora
>>>>> +
>>>>> +ENV PACKAGES \
>>>>> +    libvirt-devel \
>>>>> +    nc \
>>>>> +    python-avocado \
>
> python-avocado is a "Provides" of python2-avocado, but that may may go
> away soon (as soon as Fedora 29).  I'd recommend using python2-avocado,
> which is the proper package name available on Fedora.
>
>>>>> +    python2-devel python3-devel \
>>>>> +    qemu-kvm \
>>>>> +    tcpdump \
>>>>> +    xz
>>>>> +ENV PIP_PACKAGES \
>>>>> +    avocado-qemu \
>
> +CC: Amador Pahim
>
> This pip package was created by Amador Pahim, but was intended for demo
> purposes only.  Upon finding about this, he (cc'ed here) said that the
> package is going to be removed to avoid further confusion.
>
> BTW, the intention is to have this supporting code for QEMU tests in the
> QEMU tree itself.  Myself and Eduardo are working on a new version of
> that supporting code.  Also, based on what I see on the test-avocado
> file, this code is not needed at this point.
>
>>>>> +    avocado-framework-plugin-runner-remote \
>>>>> +    avocado-framework-plugin-runner-vm \
>
> These two plugins are only needed if you intend to run tests on remote
> machines.  Given "test-avocado" is not making use of those features,
> there's no need to install them.
>
> As a side note, plugins are also available on Fedora as RPM packages, so
> if I failed to understand the requirements for these plugins here, they
> could still be installed as the python2-avocado-plugins-runner-remote
> and python2-avocado-plugins-runner-vm RPM packages.
>
>>>>> +    avocado-framework-plugin-vt
>>>>> +
>
> +CC: Lucas Rodrigues
>
> This is a pip package created by Lucas Rodrigues, and this code is
> certainly used in the "test-avocado" file.  He told me he's using it to
> run Avocado-VT tests in a venv on Ubuntu, Amazon Linux, etc, and he's
> willing to maintain and update it.

I'd suggest to look into virtual environments to run avocado-vt.
virtual environments are more lightweight than using a docker
container to run things and achieve similar functionality. Since I
mostly never install python libraries and projects system wide these
days, I didn't test this install mode in a docker container. Here's
what I'd do on my Ubuntu 16.04 development laptop:

$ virtualenv avocado_vt_demo
Running virtualenv with interpreter /usr/bin/python2
New python executable in /home/lmr/avocado_vt_demo/bin/python2
Also creating executable in /home/lmr/avocado_vt_demo/bin/python
Installing setuptools, pkg_resources, pip, wheel...done.

$ source avocado_vt_demo/bin/activate

(avocado_vt_demo) $ pip install avocado-framework-plugin-vt
... output trimmed ...
Successfully built avocado-framework-plugin-vt autotest aexpect simplejson
Installing collected packages: pbr, six, stevedore, avocado-framework,
autotest, aexpect, simplejson, netaddr, netifaces,
avocado-framework-plugin-vt
Successfully installed aexpect-1.4.0 autotest-0.16.4
avocado-framework-61.0 avocado-framework-plugin-vt-57.4 netaddr-0.7.19
netifaces-0.10.7 pbr-4.0.3 simplejson-3.15.0 six-1.11.0
stevedore-1.28.0

(avocado_vt_demo) $ avocado vt-bootstrap --yes-to-all --vt-type qemu
Failed to load plugin from module "avocado_vt.plugins.vt_list":
EnvironmentError("Bootstrap missing. Execute 'avocado vt-bootstrap' or
disable this plugin to get rid of this message",)
Failed to load plugin from module "avocado_vt.plugins.vt":
EnvironmentError("Bootstrap missing. Execute 'avocado vt-bootstrap' or
disable this plugin to get rid of this message",)
Running bootstrap for qemu

1 - Checking the mandatory programs and headers
/usr/bin/xz OK
/usr/sbin/tcpdump OK
/bin/nc OK
/bin/ip OK
/usr/bin/arping OK
/usr/bin/gcc OK
/usr/include/python2.7/Python.h OK
/usr/include/linux/types.h OK
/usr/include/linux/unistd.h OK
/usr/include/linux/socket.h OK

... output trimmed ...

9 - Checking for modules kvm, kvm-intel
Module kvm loaded
Module kvm-intel loaded

VT-BOOTSTRAP FINISHED
You may take a look at the following online docs for more info:
 - http://avocado-vt.readthedocs.org/
 - http://avocado-framework.readthedocs.org/

(avocado_vt_demo) $ avocado run boot
JOB ID     : 2ffba3965cd327e768bd8dadf4f82d6416a4f293
JOB LOG    : /home/lmr/avocado/job-results/job-2018-05-22T22.09-2ffba39/job=
.log
 (1/1) io-github-autotest-qemu.boot: PASS (31.31 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0
| CANCEL 0
JOB TIME   : 33.25 s

I can maintain the pip package mostly in sync with the other avocado
releases. Just keep in mind that my bandwidth for maintenance tasks
outside of my job @Amazon is limited, so you will have to nudge me if
you need something urgently.

Cheers,

Lucas

>>>>> +ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
>
> OK, "python3-avocado" is not yet available on Fedora, because it still
> tracks the 52.x (LTS) series.  So, if Python 3 is the version chosen, it
> maybe a good idea to remove "python-avocado" from "PACKAGES" completely
> and use "avocado-framework" instead on "PIP_PACKAGES".
>
>>>>
>>>> I think this is inherited from qemu:fedora, no?
>>>
>>> It is, I have removed it.
>>>
>>>>
>>>>> +
>>>>> +RUN dnf install -y $PACKAGES
>>>>> +RUN pip install $PIP_PACKAGES
>>>>> +RUN avocado vt-bootstrap --yes-to-all --vt-type qemu
>>>>> +
>>>>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>>>>
>>>> Can you keep the parent image's list with ">>" or appending to the old=
 $PACKAGES
>>>> in the above "ENV" directive?
>>>>
>>>>> +
>>>>> +ENV FEATURES mingw clang pyyaml asan avocado
>>>>
>>>> Similarly, is it possible to append to the parent list instead of over=
riding?
>>>
>>> I have changed both of these to append to the original variables.
>>
>> Feel free to add my R-b then:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> I'll wait your respin to try again, hoping I got my proxy issues solved.
>>
>>>>
>>>>> diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
>>>>> new file mode 100755
>>>>> index 0000000000..40474db2ce
>>>>> --- /dev/null
>>>>> +++ b/tests/docker/test-avocado
>>>>> @@ -0,0 +1,28 @@
>>>>> +#!/bin/bash -e
>>>>> +#
>>>>> +# Avocado tests on Fedora, as these are a real pain on Debian system=
s
>>>>
>>>> Shouldn't pip packages work just well on Debian too? What are the pain=
?
>>>> (Cc'ing Cleber who may want to know this).
>>>
>>> There is no debian package at the moment.
>>>
>
> That's why Fam said *pip* packages.  In my experience with pip packages
> on Debian:
>
>  * avocado-framework: installation and general usage works well.  Found
> one issue though when running on containers, though, with an easy
> workaround[1]
>
>  * avocado-framework-plugins-vt: currently at version 57.x, and when
> used outside of venvs, doesn't get the "test-providers" directory
> right[2].  Same happened with latest master (using pip install -e
> git+https://github.com/avocado-framework/avocado-vt.git#egg=3Davocado-plu=
gins-vt)
>
> [1] -
> https://trello.com/c/yEH8ixps/1328-avocado-crashes-on-systems-without-les=
s
>
> [2] -
> https://trello.com/c/0BZZE4CR/1329-avocado-vt-bootstrap-from-pip-package-=
fails-to-find-test-providers-dir
>
> - Cleber.
>
>>> Alistair
>>>
>>>>
>>>> Fam
>>>>
>>>>> +#
>>>>> +# Copyright (c) 2018 Western Digital.
>>>>> +#
>>>>> +# Authors:
>>>>> +#  Alistair Francis <alistair.francis@wdc.com>
>>>>> +#
>>>>> +# This work is licensed under the terms of the GNU GPL, version 2
>>>>> +# or (at your option) any later version. See the COPYING file in
>>>>> +# the top-level directory.
>>>>> +#
>>>>> +# Run this test: NOUSER=3D1 make docker-test-avocado@fedora-avocado
>>>>> +
>>>>> +. common.rc
>>>>> +
>>>>> +requires avocado
>>>>> +
>>>>> +cd "$BUILD_DIR"
>>>>> +
>>>>> +DEF_TARGET_LIST=3D"x86_64-softmmu"
>>>>> +TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>>>>> +build_qemu
>>>>> +install_qemu
>>>>> +
>>>>> +export PATH=3D"${PATH}:$(pwd)"
>>>>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
>>>>> --
>>>>> 2.17.0
>>>>>
>>



--=20
Lucas
