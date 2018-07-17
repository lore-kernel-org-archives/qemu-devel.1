Received: from eggs.gnu.org ([2001:4830:134:3::10]:42649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRHP-00030R-BC
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRHK-0007Zy-Mf
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:48:43 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:46883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRHK-0007Zk-Fs
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:48:38 -0400
Received: by mail-ua0-x241.google.com with SMTP id r18-v6so833396ual.13
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:48:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180717022924.25428-1-f4bug@amsat.org>
	<20180717022924.25428-4-f4bug@amsat.org> <8736wh6huk.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <25305c41-59ac-dd8c-31c9-bacb65abe407@amsat.org>
Date: Tue, 17 Jul 2018 11:48:33 -0300
MIME-Version: 1.0
In-Reply-To: <8736wh6huk.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] docker: Rename 'amd64' image as
 'host-cross'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 07/17/2018 11:45 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .shippable.yml                                           | 4 ++--
>>  tests/docker/Makefile.include                            | 2 +-
>>  .../{debian-amd64.docker => debian-host-cross.docker}    | 9
>> ++++++---
> 
> I'd prefer debian-amd64->debian-host as it's not really a cross
> compiler.

This sounds better, indeed.

> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> 
>>  3 files changed, 9 insertions(+), 6 deletions(-)
>>  rename tests/docker/dockerfiles/{debian-amd64.docker => debian-host-cross.docker} (82%)
>>
>> diff --git a/.shippable.yml b/.shippable.yml
>> index f74a3de3ff..7625ba8f27 100644
>> --- a/.shippable.yml
>> +++ b/.shippable.yml
>> @@ -5,8 +5,8 @@ env:
>>    global:
>>      - LC_ALL=C
>>    matrix:
>> -    - IMAGE=debian-amd64
>> -      TARGET_LIST=x86_64-softmmu,x86_64-linux-user
>> +    - IMAGE=debian-host-cross
>> +      TARGET_LIST=aarch64-softmmu,x86_64-softmmu,x86_64-linux-user

This line might be tuned a bit.

>>      - IMAGE=debian-win32-cross
>>        TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
>>      - IMAGE=debian-win64-cross
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index b2a7e761cc..2db4190b4c 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -83,7 +83,7 @@ endif
>>  # Enforce dependencies for composite images
>>  docker-image-debian: docker-image-debian9
>>  docker-image-debian8-mxe: docker-image-debian8
>> -docker-image-debian-amd64: docker-image-debian9
>> +docker-image-debian-host-cross: docker-image-debian9
>>  docker-image-debian-armel-cross: docker-image-debian9
>>  docker-image-debian-armhf-cross: docker-image-debian9
>>  docker-image-debian-arm64-cross: docker-image-debian9
>> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-host-cross.docker
>> similarity index 82%
>> rename from tests/docker/dockerfiles/debian-amd64.docker
>> rename to tests/docker/dockerfiles/debian-host-cross.docker
>> index d79a599a0d..17d937efc9 100644
>> --- a/tests/docker/dockerfiles/debian-amd64.docker
>> +++ b/tests/docker/dockerfiles/debian-host-cross.docker
>> @@ -1,8 +1,11 @@
>>  #
>> -# Docker x86_64 target
>> +# Docker 'host' target (same architecture than the host)
>>  #
>> -# This docker target builds on the debian Stretch base image. Further
>> -# libraries which are not widely available are installed by hand.
>> +# This docker target builds on the debian Stretch base image.
>> +#
>> +# It is intented to build the host architecture, with as much
>> +# features as possible (libraries which are not widely available
>> +# are installed by hand).
>>  #
>>  FROM qemu:debian9
>>  MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> 
> --
> Alex Bennée
> 
