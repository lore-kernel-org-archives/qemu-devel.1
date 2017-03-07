Received: from eggs.gnu.org ([2001:4830:134:3::10]:60422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clDZ3-0008C4-Bs
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clDZ0-0004dh-6p
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:46:01 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clDZ0-0004cp-2h
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:45:58 -0500
Received: by mail-qk0-x243.google.com with SMTP id n141so27982893qke.3
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 03:45:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170306112848.659-1-alex.bennee@linaro.org>
	<20170307103744.GA6117@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6e49aedc-acab-44fb-a4b5-94e51117da2c@amsat.org>
Date: Tue, 7 Mar 2017 08:45:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170307103744.GA6117@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

Hi Alex, Fam.

I tested this way but got an error:

qemu (docker_alex)$ make docker-test-clang@debian-s390x-cross
   BUILD   debian-s390x-cross
make[1]: Entering directory 'qemu'
   ARCHIVE qemu.tgz
   ARCHIVE dtc.tgz
   ARCHIVE pixman.tgz
   COPY    RUNNER
     RUN test-clang in qemu:debian-s390x-cross
Prerequisite 'clang' not present, skip
make[1]: Leaving directory 'qemu'

am I missing something? like a FEATURES/clang.tgz?

qemu (docker_alex)$ docker run qemu:debian-s390x-cross which clang
/usr/bin/clang

On 03/07/2017 07:37 AM, Fam Zheng wrote:
> On Mon, 03/06 11:28, Alex Bennée wrote:
>> It's a silly little limitation on Shippable that is looks for clang
>> in the container even though we won't use it. The arm/aarch64 cross
>> builds inherit this from debian.docker but as we needed to use
>> debian-testing for this we add it here. We also collapse the update
>> step into one RUN line to remove and intermediate layer of the docker
>> build.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
>> index bbb21ed088..3a687feda0 100644
>> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
>> @@ -13,8 +13,8 @@ RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>>  RUN dpkg --add-architecture s390x
>>
>>  # Grab the updated list of packages
>> -RUN apt update
>> -RUN apt dist-upgrade -yy
>> +RUN apt update && apt dist-upgrade -yy

^ good!

>> +RUN apt install -yy build-essential clang
>>  RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
>>  RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
>>
>> --
>> 2.11.0
>>
>
> Looks sane. Is this for 2.9?
>
> Fam
>
