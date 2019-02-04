Received: from eggs.gnu.org ([209.51.188.92]:46181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqdqE-0004Gr-7O
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqdqC-0008KY-7E
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:59:14 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gqdqC-0008JS-0O
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:59:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id m1so13083984wml.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 04:59:11 -0800 (PST)
References: <20190201171229.3361-1-alex.bennee@linaro.org>
	<3792ad53-69e1-e45e-1f0f-406288af0912@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3792ad53-69e1-e45e-1f0f-406288af0912@redhat.com>
Date: Mon, 04 Feb 2019 12:59:08 +0000
Message-ID: <87pns74smb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .travis.yml: separate tools and docs into
 another entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Alex,
>
> On 2/1/19 6:12 PM, Alex Benn=C3=A9e wrote:
>> Re-building the tools and documents by default is a little wasteful as
>> they are not really affected by the main build options. Split tools
>> and documents into their own task with a minimal softmmu and
>> linux-user target list just to check they don't interact badly.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 87d9fa971c..1c8effcf63 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -61,6 +61,7 @@ env:
>>    global:
>>      - SRC_DIR=3D"."
>>      - BUILD_DIR=3D"."
>> +    - BASE_CONFIG=3D"--disable-docs --disable-tools"
>>      - TEST_CMD=3D"make check -j3 V=3D1"
>>
>>
>> @@ -71,7 +72,7 @@ git:
>>
>>  before_script:
>>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>> -  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
>> +  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log &=
& exit 1; }
>>  script:
>>    - make -j3 && ${TEST_CMD}
>>
>> @@ -106,6 +107,15 @@ matrix:
>>          - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"
>>
>>
>> +    # Check we can build docs and tools
>> +    - env:
>> +        - BASE_CONFIG=3D""
>
> What about using explicit configure options?
>
>    BASE_CONFIG=3D"--enable-docs --enable-tools"

Will add for clarity (although not effect ;-)

>
> Regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>> +        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-linux-user"
>> +      addons:
>> +        apt:
>> +          packages:
>> +            - python-sphinx
>> +
>>      # Test out-of-tree builds
>>      - env:
>>          - CONFIG=3D"--enable-debug --enable-debug-tcg"
>> @@ -243,5 +253,5 @@ matrix:
>>
>>
>>      - env:
>> -        - CONFIG=3D"--disable-system --disable-docs"
>> +        - CONFIG=3D"--disable-system"
>>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>


--
Alex Benn=C3=A9e
