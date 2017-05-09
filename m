Received: from eggs.gnu.org ([2001:4830:134:3::10]:39543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d83uj-0007ML-7S
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d83ug-0006UB-3h
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:06:49 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d83uf-0006U5-VO
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:06:46 -0400
Received: by mail-qk0-x242.google.com with SMTP id u75so14271923qka.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:06:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-6-f4bug@amsat.org>
	<20170509040438.GB18973@lemon.lan>
	<87k25q8oc2.fsf@linaro.org> <20170509080543.GD18973@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2f874a2e-bb34-7c1b-1b59-cc6b28366bf5@amsat.org>
Date: Tue, 9 May 2017 09:06:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170509080543.GD18973@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 05/09/2017 05:05 AM, Fam Zheng wrote:
> On Tue, 05/09 08:46, Alex Bennée wrote:
>>
>> Fam Zheng <famz@redhat.com> writes:
>>
>>> On Mon, 05/08 19:17, Philippe Mathieu-Daudé wrote:
>>>> - install common/basic tools at once
>>>> - use eatmydata and remove apt cache to save space
>>>> - add bison and flex and git
>>>> - create deb-src entry and setup Emdebian in the same layer
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  tests/docker/dockerfiles/debian.docker | 26 +++++++++++++-------------
>>>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>>>> index d08def6a8d..dcded3ce84 100644
>>>> --- a/tests/docker/dockerfiles/debian.docker
>>>> +++ b/tests/docker/dockerfiles/debian.docker
>>>> @@ -9,17 +9,17 @@
>>>>  #
>>>>  FROM debian:stable-slim
>>>>
>>>> -# Setup some basic tools we need
>>>> -RUN apt update
>>>> -RUN apt install -yy aptitude ca-certificates curl
>>>> +# Install some basic tools and common build utilities
>>>> +RUN apt-get update && \
>>>> +    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
>>>> +        eatmydata && \
>>>> +    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
>>>> +        aptitude ca-certificates curl \
>>>> +        build-essential clang git \
>>>> +        bison flex && \
>>>> +    apt-get clean
>>>
>>> Any particular reason to make multiple "RUN" directives into one?
>>
>> It reduces the number of layers you generate during the building
>> process. I'm not sure how much space that saves in the long run though
>> (disk space is pretty cheap ;-).
>
> I don't think it matters much, but refreshing an image gets slower due to
> coarser cache, for example when you add a package in the big "apt-get install"
> command.
>
> I don't see a strong reason why this is better. It clutters the file and is
> inconsistent.

I'm living in a remote place where Internet is pretty bad so it does 
save me some time to have reduced layer while using 'docker save | 
docker load', but no worry :)

I'll revert this patch and just add bison/flex/git packages, and 
eventually keep DEBIAN_FRONTEND=noninteractive to avoid harmless error 
messages.
