Received: from eggs.gnu.org ([2001:4830:134:3::10]:42628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFq5K-0001ra-OK
	for qemu-devel@nongnu.org; Mon, 07 May 2018 20:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFq5F-0002QZ-Sc
	for qemu-devel@nongnu.org; Mon, 07 May 2018 20:02:26 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fFq5F-0002QI-NP
	for qemu-devel@nongnu.org; Mon, 07 May 2018 20:02:21 -0400
Received: by mail-qt0-x243.google.com with SMTP id f13-v6so29020768qtp.10
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 17:02:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <90990df8024b287004e771ebd2370cc390e49106.1525723355.git.alistair.francis@wdc.com>
	<828d2efb-6cee-f4f5-138a-5fd7da3de675@amsat.org>
Message-ID: <5d0f62c3-cfab-bd64-ee75-d0ce5e064e2d@amsat.org>
Date: Mon, 7 May 2018 21:02:16 -0300
MIME-Version: 1.0
In-Reply-To: <828d2efb-6cee-f4f5-138a-5fd7da3de675@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, alex.bennee@linaro.org, alistair23@gmail.com

On 05/07/2018 07:44 PM, Philippe Mathieu-Daudé wrote:
> Hi Alistair,
> 
> On 05/07/2018 05:09 PM, Alistair Francis wrote:
>> Avocado is not trivial to setup on non-Fedora systems. To simplfying
>> future testing add a docker test image that runs Avocado tests.
> 
> How big is the image with the new packages?

Before: 1.7GB
After: 2.18GB

> 
> If not everybody is interested in using Avocado and Python 3 as default.
> You might use the fedora as a base image for a 'fedora-avocado' one via
> 'FROM qemu:fedora' and adding a 'docker-image-fedora-avocado:
> docker-image-fedora' dependency in Makefile.include.
> 
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  tests/docker/dockerfiles/fedora.docker | 12 +++++++++--
>>  tests/docker/test-avocado              | 28 ++++++++++++++++++++++++++
>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>  create mode 100755 tests/docker/test-avocado
>>
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>> index b706f42405..5c23f6e459 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -18,9 +18,17 @@ ENV PACKAGES \
>>      mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL mingw64-pkg-config \
>>      mingw64-gtk2 mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
>>      mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
>> -    mingw64-bzip2
>> +    mingw64-bzip2 \
>> +    xz tcpdump nc \
>> +    python2-devel python3-devel python-avocado \
>> +    libvirt-devel qemu-kvm
> 
> I'd personally prefer a commit that sort this list alphabetically (one
> package per line), and another commit only adding the Avocado packages;
> but this is up to Fam.
> 
>>  ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>> +ENV PIP_PACKAGES \
>> +    avocado-framework avocado-qemu \
>> +    avocado-framework-plugin-vt avocado-framework-plugin-runner-vm \
>> +    avocado-framework-plugin-runner-remote avocado-framework-plugin-result-html
> 
> Ditto, alphabetically sorted one per line.
> 
>>  
>>  RUN dnf install -y $PACKAGES
>> +RUN pip install $PIP_PACKAGES
>>  RUN rpm -q $PACKAGES | sort > /packages.txt
>> -ENV FEATURES mingw clang pyyaml asan
>> +ENV FEATURES mingw clang pyyaml asan avocado
>> diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
>> new file mode 100755
>> index 0000000000..8da7bc10a2
>> --- /dev/null
>> +++ b/tests/docker/test-avocado
>> @@ -0,0 +1,28 @@
>> +#!/bin/bash -e
>> +#
>> +# Avocado tests on Fedora, as these are a real pain on Debian systems
> 
> Have been here... Then used the git version :/
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
>> +# Run this test: NETWORK=1 make docker-test-avocado@fedora
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
>> +export PATH="${PATH}:$(pwd)"
>> +avocado vt-bootstrap --yes-to-all --vt-type qemu

Can we do the bootstrapping in the Dockerfile?

Testing your image it download big files (i.e. JeOS image) in my
~avocado/data/avocado-vt/images which is internal to the volatile docker
instance, so I have to download again each time I run the tests...

We need to pass this cache path to the docker instance.
For example the vm-test use ~/.cache/qemu-vm/download.

>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
> 
> So this script is for the VT version, specific to x86. I'd rather name
> the script accordingly "test-avocado-vt".
> 
> Regards,
> 
> Phil.
