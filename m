Received: from eggs.gnu.org ([2001:4830:134:3::10]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKuFZ-0000q8-1z
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKuFV-00015g-Rw
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:29:57 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:46731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fKuFV-00014x-M0
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:29:53 -0400
Received: by mail-qk0-x244.google.com with SMTP id s70-v6so13157879qks.13
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 16:29:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <a220810d5e1bcdfb789fbe1b2972550a311fa933.1526668271.git.alistair.francis@wdc.com>
	<20180521031620.GE17725@lemon.usersys.redhat.com>
	<26e052ac-47d4-2777-6791-d4a99c9a75cc@amsat.org>
	<CAKmqyKMmm3aRfktpooY_K8ZoOHXUGLPSBQAgcOgd0rAg9U_kHg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83057995-46a2-b102-9011-5f6cf7a46d91@amsat.org>
Date: Mon, 21 May 2018 20:29:46 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMmm3aRfktpooY_K8ZoOHXUGLPSBQAgcOgd0rAg9U_kHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Alistair Francis <alistair23@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>

On 05/21/2018 07:37 PM, Alistair Francis wrote:
> On Mon, May 21, 2018 at 10:26 AM, Philippe Mathieu-Daudé
> <f4bug@amsat.org> wrote:
>> Hi Alistair, Fam,
>>
>> On 05/21/2018 12:16 AM, Fam Zheng wrote:
>>> On Fri, 05/18 11:34, Alistair Francis wrote:
>>>> Avocado is not trivial to setup on non-Fedora systems. To simplfying
>>>> future testing add a docker test image that runs Avocado tests.
>>
>> Can you add an entry in the "make docker" help menu?
> 
> The one in tests/docker/Makefile.include? It seems like it's mostly
> auto generated. What do you think I should add?

Ah you right, that's fine then:

$ make docker
[...]
Available tests:
    test-block test-debug test-clang test-build test-full test-avocado
test-mingw test-quick

> 
>>
>>>>
>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>> ---
>>>> v2:
>>>>  - Add a seperate fedora-avocado Docker image
>>>>  - Move the avocado vt-bootstrap into the Docker file
>>>>
>>>>  tests/docker/Makefile.include                 |  1 +
>>>>  .../docker/dockerfiles/fedora-avocado.docker  | 25 +++++++++++++++++
>>>>  tests/docker/test-avocado                     | 28 +++++++++++++++++++
>>>>  3 files changed, 54 insertions(+)
>>>>  create mode 100644 tests/docker/dockerfiles/fedora-avocado.docker
>>>>  create mode 100755 tests/docker/test-avocado
>>>>
>>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>>>> index ef1a3e62eb..0e3d108dde 100644
>>>> --- a/tests/docker/Makefile.include
>>>> +++ b/tests/docker/Makefile.include
>>>> @@ -60,6 +60,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
>>>>  docker-image-debian-s390x-cross: docker-image-debian9
>>>>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>>>>  docker-image-debian-win64-cross: docker-image-debian8-mxe
>>>> +docker-image-fedora-avocado: docker-image-fedora
>>>>  docker-image-travis: NOUSER=1
>>>>
>>>>  # Expand all the pre-requistes for each docker image and test combination
>>>> diff --git a/tests/docker/dockerfiles/fedora-avocado.docker b/tests/docker/dockerfiles/fedora-avocado.docker
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
>>>> +    python2-devel python3-devel \
>>>> +    qemu-kvm \
>>>> +    tcpdump \
>>>> +    xz
>>>> +ENV PIP_PACKAGES \
>>>> +    avocado-qemu \
>>>> +    avocado-framework-plugin-runner-remote \
>>>> +    avocado-framework-plugin-runner-vm \
>>>> +    avocado-framework-plugin-vt
>>>> +
>>>> +ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
>>>
>>> I think this is inherited from qemu:fedora, no?
>>
>> Yes.
>>
>>>
>>>> +
>>>> +RUN dnf install -y $PACKAGES
>>>> +RUN pip install $PIP_PACKAGES
>>>> +RUN avocado vt-bootstrap --yes-to-all --vt-type qemu
>>>> +
>>>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>>>
>>> Can you keep the parent image's list with ">>" or appending to the old $PACKAGES
>>> in the above "ENV" directive?
>>
>> Appending looks cleaner to me.
>>
>>>
>>>> +
>>>> +ENV FEATURES mingw clang pyyaml asan avocado
>>>
>>> Similarly, is it possible to append to the parent list instead of overriding?
>>>
>>>> diff --git a/tests/docker/test-avocado b/tests/docker/test-avocado
>>>> new file mode 100755
>>>> index 0000000000..40474db2ce
>>>> --- /dev/null
>>>> +++ b/tests/docker/test-avocado
>>>> @@ -0,0 +1,28 @@
>>>> +#!/bin/bash -e
>>>> +#
>>>> +# Avocado tests on Fedora, as these are a real pain on Debian systems
>>>
>>> Shouldn't pip packages work just well on Debian too? What are the pain?
>>> (Cc'ing Cleber who may want to know this).
>>
>> Avocado isn't packaged (yet?) on Debian.
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
>>>> +# Run this test: NOUSER=1 make docker-test-avocado@fedora-avocado
>>>> +
>>>> +. common.rc
>>>> +
>>>> +requires avocado
>>>> +
>>>> +cd "$BUILD_DIR"
>>>> +
>>>> +DEF_TARGET_LIST="x86_64-softmmu"
>>>> +TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>>>> +build_qemu
>>>> +install_qemu
>>>> +
>>>> +export PATH="${PATH}:$(pwd)"
>>>> +avocado run boot --vt-qemu-bin ./x86_64-softmmu/qemu-system-x86_64
>>
>> This failed when testing (I suppose due to too old corporate proxy...):
>>
>> Step 7/11 : RUN avocado vt-bootstrap --yes-to-all --vt-type qemu
>>  ---> Running in 008e494971c7
>> [...]
>> 8 - Verifying (and possibly downloading) guest image
>> Verifying expected SHA1 sum from
>> http://avocado-project.org/data/assets/jeos/27/SHA1SUM_JEOS_27_64
>> Failed to get SHA1 from file: HTTP Error 403: Forbidden file type or
>> location: http://avocado-project.org/data/assets/jeos/27/SHA1SUM_JEOS_27_64
>> File /var/lib/avocado/data/avocado-vt/images/jeos-27-x86_64.qcow2.xz not
>> found
>> Check your internet connection: HTTP Error 403: Forbidden file type or
>> location: http://avocado-project.org/data/assets/jeos/27/jeos-27-64.qcow2.xz
>> Uncompressing
>> /var/lib/avocado/data/avocado-vt/images/jeos-27-x86_64.qcow2.xz ->
>> /var/lib/avocado/data/avocado-vt/images/jeos-27-x86_64.qcow2
>> Bootstrap command failed
>> Command: xz -cd
>> /var/lib/avocado/data/avocado-vt/images/jeos-27-x86_64.qcow2.xz >
>> /var/lib/avocado/data/avocado-vt/images/jeos-27-x86_64.qcow2
>> stderr output:
>> xz: /var/lib/avocado/data/avocado-vt/images/jeos-27-x86_64.qcow2.xz:
>> File format not recognized
>>
>> The command '/bin/sh -c avocado vt-bootstrap --yes-to-all --vt-type
>> qemu' returned a non-zero code: 1
>> Traceback (most recent call last):
>>   File "./tests/docker/docker.py", line 407, in <module>
>>     sys.exit(main())
>>   File "./tests/docker/docker.py", line 404, in main
>>     return args.cmdobj.run(args, argv)
>>   File "./tests/docker/docker.py", line 326, in run
>>     extra_files_cksum=cksum)
>>   File "./tests/docker/docker.py", line 209, in build_image
>>     quiet=quiet)
>>   File "./tests/docker/docker.py", line 147, in _do_check
>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>   File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
>>     raise CalledProcessError(retcode, cmd)
>> make: *** [tests/docker/Makefile.include:37:
>> docker-image-fedora-avocado] Error 1
> 
> Yep, this is a proxy problem.
> 
> I had the same problem, I had to open the page in my browser to click
> through the proxy warning before it would work.
> 
> On the plus side we worked with Palo Alto Networks to unblock the
> link. Hopefully you can do the same with whatever your company uses.
> 
>>
>> We said we should use some userdir volume to cache the data/assets/,
>> 1/ to avoid to keep downloading this file again and again,
>> 2/ to share it between different docker instances,
>> 3/ so I can download it via another way and put it there (proxy).
> 
> Ok! How do you think this should be done?

Look at tests/vm/basevm.py _download_with_cache(), Fam uses:

    ...
    cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
    if not os.path.exists(cache_dir):
        os.makedirs(cache_dir)
    fname = os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
    ...

Avocado already has a caching API:
http://avocado-framework.readthedocs.io/en/57.0/WritingTests.html#fetching-asset-files

We could add something like this in tests/docker/Makefile.include:

docker-image-fedora-avocado: EXTRA_VOLUMES +=
~/.cache/qemu-vm/download:/avocado/data/cache

(we already use $DOCKER_CCACHE_DIR).

This is a follow up patch anyway.

> 
> Alistair
> 
>>
>> BTW Fam (unrelated) when building the intermediary Fedora image I hit:
>>
>> [...]
>> (562/563): man-pages-4.12-1.fc27.noarch.rpm     270 kB/s | 5.9 MB
>> 00:22
>> (563/563): glibc-common-2.26-27.fc27.x86_64.rpm  62 kB/s | 789 kB
>> 00:12
>> --------------------------------------------------------------------------------
>> Total                                            10 kB/s | 425 MB
>> 709:02
>> Running transaction check
>> Transaction check succeeded.
>> [...]
>> Error: Transaction check error:
>>   installing package glibc-common-2.26-27.fc27.x86_64 needs 4MB on the /
>> filesystem
>>   installing package dconf-0.26.1-1.fc27.x86_64 needs 2016MB on the /
>> filesystem
>>   installing package man-pages-4.12-1.fc27.noarch needs 2018MB on the /
>> filesystem
>> Error Summary
>> -------------
>> Disk Requirements:
>>    At least 2018MB more space needed on the / filesystem.
>> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
>> 'qemu:fedora', '-f', '/tmp/docker_buildd0ajZ0/tmp1jgnS6.docker',
>> '/tmp/docker_buildd0ajZ0']' returned non-zero exit status 1
>> make: *** [tests/docker/Makefile.include:37: docker-image-fedora] Error 1
>>
>> I wonder if we should add an estimated size of image, to avoid (like in
>> my case, wait another night to test this due to my ****** internet
>> connection).
>>
>> Regards,
>>
>> Phil.
