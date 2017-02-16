Received: from eggs.gnu.org ([2001:4830:134:3::10]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceRuv-0001Ov-MQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceRus-0002Bu-85
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:40:37 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:32947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ceRur-0002BS-Vr
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:40:34 -0500
Received: by mail-wr0-x235.google.com with SMTP id i10so18707335wrb.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 11:40:33 -0800 (PST)
References: <20170216123456.28621-1-alex.bennee@linaro.org>
	<20170216123456.28621-4-alex.bennee@linaro.org>
	<20170216133109.GD8817@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170216133109.GD8817@lemon.lan>
Date: Thu, 16 Feb 2017 19:40:32 +0000
Message-ID: <871suxc4b3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 3/4] .shippable.yml: new CI provider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Thu, 02/16 12:34, Alex Bennée wrote:
>> Ostensibly Shippable offers a similar set of services as Travis.
>> However they are focused on Docker container based work-flows so we
>> can use our existing containers to run a few extra builds - in this
>> case a bunch of cross-compiled targets on a Debian multiarch system.
>
> Out of curiosity, what are the forms of build report from shippable
> service?

It sends out emails and there is the web status page:

https://app.shippable.com/runs/58a596c4266ed80f003a9385/summary

There is also support for build badges a.la Travis.

>
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v3
>>   - reduce matrix to armhf/arm64 which currently work
>>   - use the make docker-image-* build stanzas
>>   - add TARGET_LIST to each build
>> ---
>>  .shippable.yml | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 .shippable.yml
>>
>> diff --git a/.shippable.yml b/.shippable.yml
>> new file mode 100644
>> index 0000000000..4de8daf341
>> --- /dev/null
>> +++ b/.shippable.yml
>> @@ -0,0 +1,21 @@
>> +language: c
>> +env:
>> +  matrix:
>> +    - IMAGE=debian-armhf-cross
>> +      TARGET_LIST=arm-softmmu,arm-linux-user
>> +    - IMAGE=debian-arm64-cross
>> +      TARGET_LIST=aarch64-softmmu,aarch64-linux-user
>> +    - IMAGE=centos6
>> +      TARGET_LIST=i386-softmmu,x86_64-softmmu
>> +build:
>> +  pre_ci:
>> +    - make docker-image-${IMAGE}
>> +  pre_ci_boot:
>> +    image_name: qemu
>> +    image_tag: ${IMAGE}
>> +    pull: false
>> +    options: "-e HOME=/root"
>> +  ci:
>> +    - unset CC
>> +    - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
>> +    - make -j2
>
> It's a good surprise that our docker infrastructure fits in the shippable
> framework pretty nicely. :)
>
> Looks good to me without cross checking the shippable API:
>
> Reviewed-by: Fam Zheng <famz@redhat.com>


--
Alex Bennée
