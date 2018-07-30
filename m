Received: from eggs.gnu.org ([2001:4830:134:3::10]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk3Qc-0007m1-26
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk3QX-0007lX-4G
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:21:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fk3QW-0007l9-Td
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:21:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id g6-v6so11843455wrp.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 01:21:12 -0700 (PDT)
References: <20180718100505.7546-1-alex.bennee@linaro.org>
	<20180727082614.GD19416@lemon.usersys.redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180727082614.GD19416@lemon.usersys.redhat.com>
Date: Mon, 30 Jul 2018 09:21:10 +0100
Message-ID: <874lgh9ls9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 00/10] docker on non-x86 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Wed, 07/18 11:04, Alex Benn=C3=A9e wrote:
>> Hi,
>>
>> Our existing support for docker is fairly x86 centric. While docker
>> itself has support for multiple architectures not all architectures
>> are equal. For example Debian only packages the widest range of
>> cross-compilers in it's x86 images (although for example armhf is
>> available on aarch64 based images).
>>
>> As the binfmt support is getting more solid we always have that fall
>> back option and I've converted a number of the guests that way.
>> Unfortunately I've overloaded the meaning of DOCKER_PARTIAL_IMAGES but
>> I was loathed to throw in yet another magic variable without some
>> discussion first. I'm not sure if my current path will end up with a
>> maze of twisty if/else statements all subtly alike.
>
> Just my two cents.  So far it looks reasonable. Though I guess we could g=
ive
> DOCKER_PARTIAL_IMAGES a better name or at least better documentation.
>
> Would a per-arch variable list look cleaner? Like
>
>     DOCKER_IMAGES_GENERIC =3D debian
>     DOCKER_IMAGES_X86_64 =3D ubuntu fedora centos7
>     DOCKER_PARTIAL_IMAGES_X86_64 =3D ...
>     DOCKER_IMAGES_AARCH64 =3D ...
>     DOCKER_PARTIAL_IMAGES_AARCH64 =3D ...
>
> Then the actual host arch can be used to expand rules:
>
>     docker-all-images: $(DOCKER_IMAGES_GENERIC)
>     docker-all-images: $(DOCKER_IMAGES_$(shell uname -m | tr '[a-z]'
>     '[A-Z]))

That might work better... I'll give that a go on v2

>
> Fam
>
>>
>> Thoughts?
>>
>> Alex Benn=C3=A9e (10):
>>   docker: rename docker-amd64 to docker-host
>>   docker: change docker-image to docker-all-images target
>>   docker: add a placeholder for handling non-x86 hosts
>>   docker: don't include docker-arm64-cross on aarch64 hosts
>>   docker: fall-back to binfmt_misc debian-mips64el-user-cross on non-x86
>>   docker: fall-back to binfmt_misc debian-ppc64el-user-cross on non-x86
>>   docker: fall-back to binfmt_misc debian-s390x-user-cross on non-x86
>>   docker: disable additional non-x86 images
>>   tests: tcg skip docker images we can't build
>>   tests/tcg: debian-mips64el-user-cross fallback
>>
>>  Makefile                                      |  4 +-
>>  tests/docker/Makefile.include                 | 58 +++++++++++++++++--
>>  ...debian-amd64.docker =3D> debian-host.docker} |  4 +-
>>  .../debian-mips64el-user-cross.docker         | 16 +++++
>>  .../debian-ppc64el-user-cross.docker          | 16 +++++
>>  .../debian-s390x-user-cross.docker            | 16 +++++
>>  tests/tcg/Makefile.include                    |  3 +
>>  tests/tcg/Makefile.probe                      |  2 +-
>>  tests/tcg/mips/Makefile.include               |  5 ++
>>  9 files changed, 116 insertions(+), 8 deletions(-)
>>  rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian-host.d=
ocker} (91%)
>>  create mode 100644 tests/docker/dockerfiles/debian-mips64el-user-cross.=
docker
>>  create mode 100644 tests/docker/dockerfiles/debian-ppc64el-user-cross.d=
ocker
>>  create mode 100644 tests/docker/dockerfiles/debian-s390x-user-cross.doc=
ker
>>
>> --
>> 2.17.1
>>


--
Alex Benn=C3=A9e
