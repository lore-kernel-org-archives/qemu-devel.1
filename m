Received: from eggs.gnu.org ([2001:4830:134:3::10]:32807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGsgO-00068q-DP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGsgN-0006aF-Am
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:01:00 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGsgN-0006Zg-03
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:00:59 -0400
Received: by mail-lf0-x241.google.com with SMTP id p85-v6so4900617lfg.7
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 14:00:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5d0f62c3-cfab-bd64-ee75-d0ce5e064e2d@amsat.org>
References: <90990df8024b287004e771ebd2370cc390e49106.1525723355.git.alistair.francis@wdc.com>
	<828d2efb-6cee-f4f5-138a-5fd7da3de675@amsat.org>
	<5d0f62c3-cfab-bd64-ee75-d0ce5e064e2d@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 May 2018 14:00:26 -0700
Message-ID: <CAKmqyKMQR=EzkHS8=rdYcvMbhK1ZJHPei7nngmKfO+10yhuy_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] tests/docker: Add a Avocado Docker
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, May 7, 2018 at 5:02 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On 05/07/2018 07:44 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Alistair,
>>
>> On 05/07/2018 05:09 PM, Alistair Francis wrote:
>>> Avocado is not trivial to setup on non-Fedora systems. To simplfying
>>> future testing add a docker test image that runs Avocado tests.
>>
>> How big is the image with the new packages?
>
> Before: 1.7GB
> After: 2.18GB
>
>>
>> If not everybody is interested in using Avocado and Python 3 as default.
>> You might use the fedora as a base image for a 'fedora-avocado' one via
>> 'FROM qemu:fedora' and adding a 'docker-image-fedora-avocado:
>> docker-image-fedora' dependency in Makefile.include.

Ok, will do in v2.

>>
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>  tests/docker/dockerfiles/fedora.docker | 12 +++++++++--
>>>  tests/docker/test-avocado              | 28 ++++++++++++++++++++++++++
>>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>>  create mode 100755 tests/docker/test-avocado
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dock=
erfiles/fedora.docker
>>> index b706f42405..5c23f6e459 100644
>>> --- a/tests/docker/dockerfiles/fedora.docker
>>> +++ b/tests/docker/dockerfiles/fedora.docker
>>> @@ -18,9 +18,17 @@ ENV PACKAGES \
>>>      mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-c=
onfig \
>>>      mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-li=
btasn1 \
>>>      mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 =
\
>>> -    mingw64-bzip2
>>> +    mingw64-bzip2 \
>>> +    xz tcpdump nc \
>>> +    python2-devel python3-devel python-avocado \
>>> +    libvirt-devel qemu-kvm
>>
>> I'd personally prefer a commit that sort this list alphabetically (one
>> package per line), and another commit only adding the Avocado packages;
>> but this is up to Fam.

Will fix in v2 as well.

>>
>>>  ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
>>> +ENV PIP_PACKAGES \
>>> +    avocado-framework avocado-qemu \
>>> +    avocado-framework-plugin-vt avocado-framework-plugin-runner-vm \
>>> +    avocado-framework-plugin-runner-remote avocado-framework-plugin-re=
sult-html
>>
>> Ditto, alphabetically sorted one per line.
>>
>>>
>>>  RUN dnf install -y $PACKAGES
>>> +RUN pip install $PIP_PACKAGES
>>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>>> -ENV FEATURES mingw clang pyyaml asan
>>> +ENV FEATURES mingw clang pyyaml asan avocado
>>> diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
>>> new file mode 100755
>>> index 0000000000..8da7bc10a2
>>> --- /dev/null
>>> +++ b/tests/docker/test-avocado
>>> @@ -0,0 +1,28 @@
>>> +#!/bin/bash -e
>>> +#
>>> +# Avocado tests on Fedora, as these are a real pain on Debian systems
>>
>> Have been here... Then used the git version :/
>>
>>> +#
>>> +# Copyright (c) 2018 Western Digital.
>>> +#
>>> +# Authors:
>>> +#  Alistair Francis <alistair.francis@wdc.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2
>>> +# or (at your option) any later version. See the COPYING file in
>>> +# the top-level directory.
>>> +#
>>> +# Run this test: NETWORK=3D1 make docker-test-avocado@fedora
>>> +
>>> +. common.rc
>>> +
>>> +requires avocado
>>> +
>>> +cd "$BUILD_DIR"
>>> +
>>> +DEF_TARGET_LIST=3D"x86_64-softmmu"
>>> +TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>>> +build_qemu
>>> +install_qemu
>>> +export PATH=3D"${PATH}:$(pwd)"
>>> +avocado vt-bootstrap --yes-to-all --vt-type qemu
>
> Can we do the bootstrapping in the Dockerfile?

We can, but it only works if you run the test with NOUSER=3D1 set. Is
this acceptable?

>
> Testing your image it download big files (i.e. JeOS image) in my
> ~avocado/data/avocado-vt/images which is internal to the volatile docker
> instance, so I have to download again each time I run the tests...
>
> We need to pass this cache path to the docker instance.
> For example the vm-test use ~/.cache/qemu-vm/download.

Is this still required if it's moved into the Dockerfile?

>
>>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
>>
>> So this script is for the VT version, specific to x86. I'd rather name
>> the script accordingly "test-avocado-vt".

It doesn't have to be. Ideally this will run all the Avocado tests.
It's the only test I could find on the wiki at the moment.

Alistair

>>
>> Regards,
>>
>> Phil.
