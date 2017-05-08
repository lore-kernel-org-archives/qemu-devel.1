Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ibs-0000Yu-Pf
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ibn-00035g-Rl
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:21:56 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ibn-00035C-Mu
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:21:51 -0400
Received: by mail-qk0-x242.google.com with SMTP id u75so9966519qka.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:21:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-3-f4bug@amsat.org> <87bmr3aa8n.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1af51ae0-33be-6098-941f-318594b5a66d@amsat.org>
Date: Mon, 8 May 2017 10:21:47 -0300
MIME-Version: 1.0
In-Reply-To: <87bmr3aa8n.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/23] shippable: build using all available
 cpus
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

On 05/08/2017 07:55 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .shippable.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.shippable.yml b/.shippable.yml
>> index 231c29b620..5170486ff9 100644
>> --- a/.shippable.yml
>> +++ b/.shippable.yml
>> @@ -20,4 +20,4 @@ build:
>>    ci:
>>      - unset CC
>>      - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
>> -    - make -j2
>> +    - make -j$(getconf _NPROCESSORS_ONLN)
>
> Did you ever check what this generates on Shippable? AFAICT they only
> have one core for each docker image. I following the core+1 pattern
> although that may not make as much sense for low core counts.

 From the 'Job node info':

$ sudo docker info
Architecture: x86_64
CPUs: 2

Checking at 'ci' stage:

$ echo "container proc:" `getconf _NPROCESSORS_ONLN` `getconf 
_NPROCESSORS_CONF`
container proc: 2 2

I think the correct cores+1 pattern should instead be:

make -j$(($(getconf _NPROCESSORS_ONLN) + 1))

So we stay building at full speed if Shippable eventually upgrade/allow 
to use more cores.

Phil.

> --
> Alex Bennée
>
