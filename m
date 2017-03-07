Received: from eggs.gnu.org ([2001:4830:134:3::10]:60952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clFLv-0001eZ-VQ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clFLt-00062X-Bs
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:40:36 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clFLt-00062L-5K
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:40:33 -0500
Received: by mail-wr0-x230.google.com with SMTP id u108so1518176wrb.3
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 05:40:32 -0800 (PST)
References: <20170306112848.659-1-alex.bennee@linaro.org>
	<20170307103744.GA6117@lemon.lan>
	<6e49aedc-acab-44fb-a4b5-94e51117da2c@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6e49aedc-acab-44fb-a4b5-94e51117da2c@amsat.org>
Date: Tue, 07 Mar 2017 13:40:39 +0000
Message-ID: <87efy9i4rs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] docker/dockerfiles/debian-s390-cross:
 include clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Hi Alex, Fam.
>
> I tested this way but got an error:
>
> qemu (docker_alex)$ make docker-test-clang@debian-s390x-cross
>   BUILD   debian-s390x-cross
> make[1]: Entering directory 'qemu'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   ARCHIVE pixman.tgz
>   COPY    RUNNER
>     RUN test-clang in qemu:debian-s390x-cross
> Prerequisite 'clang' not present, skip
> make[1]: Leaving directory 'qemu'
>
> am I missing something? like a FEATURES/clang.tgz?
>
> qemu (docker_alex)$ docker run qemu:debian-s390x-cross which clang
> /usr/bin/clang
>
> On 03/07/2017 07:37 AM, Fam Zheng wrote:
>> On Mon, 03/06 11:28, Alex Bennée wrote:
>>> It's a silly little limitation on Shippable that is looks for clang
>>> in the container even though we won't use it. The arm/aarch64 cross

The clang is only to keep shippable happy. It scans for compilers
despite the fact our actual build is using the cross-compiler. AFAIK
Debian don't package cross-built versions of clang. It would be nice if
they did by currently all our cross-build containers use GCC.

>>> builds inherit this from debian.docker but as we needed to use
>>> debian-testing for this we add it here. We also collapse the update
>>> step into one RUN line to remove and intermediate layer of the docker
>>> build.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
>>> index bbb21ed088..3a687feda0 100644
>>> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
>>> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
>>> @@ -13,8 +13,8 @@ RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>>>  RUN dpkg --add-architecture s390x
>>>
>>>  # Grab the updated list of packages
>>> -RUN apt update
>>> -RUN apt dist-upgrade -yy
>>> +RUN apt update && apt dist-upgrade -yy
>
> ^ good!
>
>>> +RUN apt install -yy build-essential clang
>>>  RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
>>>  RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
>>>
>>> --
>>> 2.11.0
>>>
>>
>> Looks sane. Is this for 2.9?
>>
>> Fam
>>


--
Alex Bennée
