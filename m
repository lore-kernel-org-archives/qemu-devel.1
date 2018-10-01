Received: from eggs.gnu.org ([2001:4830:134:3::10]:36619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g6u8e-0003qN-Mt
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g6u8a-0007mX-88
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:05:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g6u8Z-0007lz-Ot
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:05:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id f10-v6so13018448wrs.0
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 02:05:07 -0700 (PDT)
References: <20180911140631.18481-1-alex.bennee@linaro.org>
	<20180911140631.18481-3-alex.bennee@linaro.org>
	<6ef6c4bb-7f29-efef-f8b9-478880c78c8f@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6ef6c4bb-7f29-efef-f8b9-478880c78c8f@amsat.org>
Date: Mon, 01 Oct 2018 10:05:05 +0100
Message-ID: <87murykpfi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/4] docker: add buildroot-nios2-cross
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, 1791796@bugs.launchpad.net, thuth@redhat.com, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 9/11/18 4:06 PM, Alex Benn=C3=A9e wrote:
>> Build a buildroot toolchain for the nios2 target.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/Makefile.include                         |  4 ++++
>>  tests/docker/dockerfiles/buildroot-nios2-cross.docker | 10 ++++++++++
>>  2 files changed, 14 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/buildroot-nios2-cross.docker
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index 74a82de48a..a8dfde8ed5 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -120,6 +120,10 @@ docker-image-debian-riscv64-cross: docker-image-deb=
ian-sid
>>  docker-image-debian-powerpc-cross: docker-image-debian-sid
>>  docker-image-travis: NOUSER=3D1
>>
>> +# Buildroot base images
>> +# These involve building the toolchains and can take some time
>> +docker-image-buildroot-nios2-cross: docker-image-debian-buildroot-base
>> +
>>  # Specialist build images, sometimes very limited tools
>>  docker-image-tricore-cross: docker-image-debian9
>>
>> diff --git a/tests/docker/dockerfiles/buildroot-nios2-cross.docker b/tes=
ts/docker/dockerfiles/buildroot-nios2-cross.docker
>> new file mode 100644
>> index 0000000000..e573f0fa55
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/buildroot-nios2-cross.docker
>> @@ -0,0 +1,10 @@
>> +#
>> +# NIOS II toolchain
>> +#
>> +FROM qemu:debian-buildroot-base
>> +
>> +RUN cd /opt/buildroot-${BUILDROOT_VERSION} && make qemu_nios2_10m50_def=
config
>
> Simply:
>
>   RUN make -C /opt/buildroot-${BUILDROOT_VERSION} qemu_nios2_10m50_defcon=
fig
>
>> +RUN cd /opt/buildroot-${BUILDROOT_VERSION} && make toolchain
>
>    RUN make -C /opt/buildroot-${BUILDROOT_VERSION} toolchain
>
>> +# The toolchain is in /opt/buildroot-${BUILDROOT_VERSION}/output/host/b=
in/nios2-*
>> +RUN ln -s /opt/buildroot-${BUILDROOT_VERSION}/output/host/bin/nios2-* /=
usr/bin
>
> Similarly:
>
>    ENV PATH $PATH:/opt/buildroot-${BUILDROOT_VERSION}/output/host/bin
>
> Once build this image takes a bit more than 3GB (this took me 30min to
> build).
>
> With changes:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Apparently multi-stage builds are meant to help:

  https://docs.docker.com/develop/develop-images/multistage-build/#name-you=
r-build-stages

It's still a little sub-optimal compared to binary builds but it will do
if we care about supporting every guest architecture with tests. I only
picked nios2 as a random example.

--
Alex Benn=C3=A9e
