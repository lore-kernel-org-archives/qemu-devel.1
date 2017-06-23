Received: from eggs.gnu.org ([2001:4830:134:3::10]:47751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOP1n-0005vR-9j
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOP1k-0001EG-4u
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:53:39 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:34653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOP1j-0001Dz-UX
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:53:36 -0400
Received: by mail-qk0-x229.google.com with SMTP id d78so2431718qkb.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:53:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170602185630.5059-1-f4bug@amsat.org> <87o9thtojo.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b8451b3-d443-4ea7-9b4f-244fc2a7be95@amsat.org>
Date: Fri, 23 Jun 2017 10:53:32 -0300
MIME-Version: 1.0
In-Reply-To: <87o9thtojo.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/24] docker/shippable: cross-build
 mipsel and powerpc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On 06/21/2017 11:15 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> This patchset add 2 more architectures to the cross-build farm.
>>
>> There is still some issue trying to cross-build mips64el-softmmu, it seems the
>> cross tools use the system outdated libfdt instead of the one checkouted in the
>> dtc submodule. I disabled this target for now.
> 
> While I was rolling the pullreq I discovered the latest Debian release
> Stretch had broken a bunch of things. Fortunately most things where
> easily fixed.

I didn't notice Debian Stretch release day. Thank you to fix this series 
so quickly!

> 
>> Philippe Mathieu-Daudé (24):
>>    docker: let _copy_with_mkdir() sub_path argument be optional
>>    docker: add --include-files argument to 'build' command
>>    docker: rebuild image if 'extra files' checksum does not match
>>    docker: add 'apt-fake' script which generate fake debian packages
> 
> dropped for now, no longer needed in mipsel
> 
>>    docker: install ca-certificates package in base image
>>    docker: create deb-src entry and setup Emdebian in the same layer
>>    docker: use better regex to generate deb-src entries
>>    docker: use eatmydata, install common build packages in base image
>>    docker: use eatmydata in debian armhf image
>>    docker: use eatmydata in debian arm64 image
>>    docker: add extra libs to armhf target to extend codebase coverage
>>    docker: add extra libs to arm64 target to extend codebase coverage
>>    docker: add extra libs to s390x target to extend codebase coverage
>>    docker: add mipsel build target
>>    docker: add powerpc build target
> 
> dropped as powerpc was dropped in stretch. This will need re-rolling
> with its own jessie based dockerfile.

I think it is safer our images follow a specific release tag instead of 
'stable', this way we don't miss an upstream release until all our 
builds fail.

I'll purpose that in my next Docker series, changing current debian 
images to use debian:stretch base, then restore powerpc using debian:jessie.

>>    shippable: use C locale to simplify console output
>>    shippable: build using all available cpus
>>    shippable: do not initialize submodules automatically
>>    shippable: be verbose while building docker images
>>    shippable: add armeb-linux-user target
>>    shippable: add powerpc target
> 
> dropped as above
> 
>>    shippable: add mipsel target
>>    MAINTAINERS: add Shippable automation platform URL
>>    MAINTAINERS: self-appoint me as reviewer in build/test automation
>>
>>   .shippable.yml                                     | 23 +++++++++--
>>   MAINTAINERS                                        |  2 +
>>   tests/docker/Makefile.include                      |  8 ++++
>>   tests/docker/docker.py                             | 30 ++++++++++----
>>   tests/docker/dockerfiles/debian-apt-fake.sh        | 46 ++++++++++++++++++++++
>>   tests/docker/dockerfiles/debian-arm64-cross.docker | 18 ++++++++-
>>   tests/docker/dockerfiles/debian-armhf-cross.docker | 18 ++++++++-
>>   .../docker/dockerfiles/debian-mipsel-cross.docker  | 41 +++++++++++++++++++
>>   .../docker/dockerfiles/debian-powerpc-cross.docker | 40 +++++++++++++++++++
>>   tests/docker/dockerfiles/debian-s390x-cross.docker | 10 +++++
>>   tests/docker/dockerfiles/debian.docker             | 18 +++++----
>>   11 files changed, 232 insertions(+), 22 deletions(-)
>>   create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>>   create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker
>>   create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker
> 
> I'll send the pull req once I have a clean run on my branch.
> 
> --
> Alex Bennée
> 
