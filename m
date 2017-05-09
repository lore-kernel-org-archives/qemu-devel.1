Received: from eggs.gnu.org ([2001:4830:134:3::10]:38277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7zq1-0001mC-FT
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7zpy-00084F-C5
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:45:41 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7zpy-000849-4z
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:45:38 -0400
Received: by mail-wr0-x233.google.com with SMTP id z52so62445019wrc.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 00:45:37 -0700 (PDT)
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-6-f4bug@amsat.org>
	<20170509040438.GB18973@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170509040438.GB18973@lemon.lan>
Date: Tue, 09 May 2017 08:46:21 +0100
Message-ID: <87k25q8oc2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/21] docker: compact debian base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Mon, 05/08 19:17, Philippe Mathieu-Daudé wrote:
>> - install common/basic tools at once
>> - use eatmydata and remove apt cache to save space
>> - add bison and flex and git
>> - create deb-src entry and setup Emdebian in the same layer
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/docker/dockerfiles/debian.docker | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>> index d08def6a8d..dcded3ce84 100644
>> --- a/tests/docker/dockerfiles/debian.docker
>> +++ b/tests/docker/dockerfiles/debian.docker
>> @@ -9,17 +9,17 @@
>>  #
>>  FROM debian:stable-slim
>>
>> -# Setup some basic tools we need
>> -RUN apt update
>> -RUN apt install -yy aptitude ca-certificates curl
>> +# Install some basic tools and common build utilities
>> +RUN apt-get update && \
>> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
>> +        eatmydata && \
>> +    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
>> +        aptitude ca-certificates curl \
>> +        build-essential clang git \
>> +        bison flex && \
>> +    apt-get clean
>
> Any particular reason to make multiple "RUN" directives into one?

It reduces the number of layers you generate during the building
process. I'm not sure how much space that saves in the long run though
(disk space is pretty cheap ;-).

>
> Fam
>
>>
>> -# Setup Emdebian
>> -RUN echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list
>> -RUN curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
>> -
>> -# Duplicate deb line as deb-src
>> -RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
>> -
>> -# Install common build utilities
>> -RUN apt update
>> -RUN apt install -yy build-essential clang
>> +# Duplicate deb line as deb-src, setup Emdebian
>> +RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list && \
>> +    echo "deb http://emdebian.org/tools/debian/ jessie main" >> /etc/apt/sources.list && \
>> +    curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add -
>> --
>> 2.11.0
>>


--
Alex Bennée
