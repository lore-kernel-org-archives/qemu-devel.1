Received: from eggs.gnu.org ([2001:4830:134:3::10]:36642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7nFs-00077U-Ej
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7nFp-0000he-8Z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:19:32 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7nFp-0000hU-4c
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:19:29 -0400
Received: by mail-qt0-x244.google.com with SMTP id l39so10659134qtb.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 11:19:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-5-f4bug@amsat.org> <878tm7a9uc.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97659c3f-a907-ddf1-e7fa-993ac5692603@amsat.org>
Date: Mon, 8 May 2017 15:19:25 -0300
MIME-Version: 1.0
In-Reply-To: <878tm7a9uc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/23] docker: compact debian base
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

On 05/08/2017 08:04 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> - install common/basic tools at once
>> - one-line Emdebian setup
>> - use eatmydata and remove apt cache to save space
>> - add bison and flex and git
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/dockerfiles/debian.docker | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>> index 52bd79938e..694f8d3b63 100644
>> --- a/tests/docker/dockerfiles/debian.docker
>> +++ b/tests/docker/dockerfiles/debian.docker
>> @@ -9,17 +9,19 @@
>>  #
>>  FROM debian:stable-slim
>>
>> -# Setup some basic tools we need
>> -RUN apt update
>> -RUN apt install -yy curl aptitude
>> -
>> -# Setup Emdebian
>> -RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
>> -RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
>> +# Install some basic tools and common build utilities
>> +RUN apt-get update && \
>> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
>> +        eatmydata && \
>
> I wonder if we should just use ENV instead to set DEBIAN_FRONTEND?

In https://github.com/moby/moby/issues/4032#issuecomment-34597177 Tianon 
Gravi commented:

[...] setting it via ENV should be actively discouraged. [...]
The reason it's not a good default is that if I docker run -i -t ... 
bash, I'm now interactive, and this variable being set is very, very wrong.

>
>> +    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
>> +        curl aptitude \
>> +        build-essential clang git \
>> +        bison flex && \
>> +    rm -rf /var/lib/apt
>
> Use apt clean to do this.

Ok.

>>
>>  # Duplicate deb line as deb-src
>>  RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>>
>> -# Install common build utilities
>> -RUN apt update
>> -RUN apt install -yy build-essential clang
>> +# Setup Emdebian
>> +RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
>> +    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
>
> Why move this to the end? Once we have curl installed it would be nice
> to do just one update step and have emdebian synced up in the base
> image.

In the first apt-get can install curl + build-essential clang in the 
same call, and there is no need to fetch emdebian.org index.

Using 'apt clean' at the end of a layer keeps smaller layer but the next 
layer have to call `apt-get update` again. Since this base image is used 
to cross-compile, the child image will have to call `dpkg 
--add-architecture ...` before fetching emdebian.org arch index again 
(apt-get update) to be able to install the `crossbuild-essential-$arch` 
package.
So there is no need to update right after adding this repo, the 'child' 
will do it (and have to do it).

>
> --
> Alex Bennée
>
