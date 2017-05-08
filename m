Received: from eggs.gnu.org ([2001:4830:134:3::10]:54357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7hH8-0003wj-Et
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7hH4-0001um-BH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:56:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7hH4-0001ui-7V
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:56:22 -0400
Received: by mail-qk0-x243.google.com with SMTP id u75so9624801qka.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:56:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-4-f4bug@amsat.org> <87a86naa4n.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7c8a094-a600-960d-da47-026336f16949@amsat.org>
Date: Mon, 8 May 2017 08:56:17 -0300
MIME-Version: 1.0
In-Reply-To: <87a86naa4n.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 03/23] shippable: ignore SSL
 verification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Hi Alex,

On 05/08/2017 07:58 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> shippable logs:
>> --------------
>> git_sync
>> - ssh-agent bash -c 'ssh-add /tmp/ssh/01_deploy; git clone https://github.com/philmd/qemu.git /root/src/github.com/philmd/qemu'
>> Identity added: /tmp/ssh/01_deploy (rsa w/o comment)
>> Cloning into '/root/src/github.com/philmd/qemu'...
>> fatal: unable to access 'https://github.com/philmd/qemu.git/': Problem with the SSL CA cert (path? access rights?)
>> retrying 1 of 3 times...
>
> I've not seen this before but which git_sync stage is it. The host or
> the container? If it is the container that probably just means we are
> missing the CA Cert package.

You are right! Adding the ca-certificates package in the docker image 
solves this issue I had in container's git_sync stage :)

Thank for the review,

Phil.

>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .shippable.yml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/.shippable.yml b/.shippable.yml
>> index 5170486ff9..b661e667b3 100644
>> --- a/.shippable.yml
>> +++ b/.shippable.yml
>> @@ -2,6 +2,10 @@ language: c
>>  env:
>>    global:
>>      - LC_ALL=C
>> +    # sometimes Shippable fails to clone from github (git_sync stage):
>> +    # "Problem with the SSL CA cert (path? access rights?)"
>> +    # for now disable SSL verification.
>> +    - GIT_SSL_NO_VERIFY=1
>>    matrix:
>>      - IMAGE=debian-armhf-cross
>>        TARGET_LIST=arm-softmmu,arm-linux-user
>
>
> --
> Alex Bennée
>
