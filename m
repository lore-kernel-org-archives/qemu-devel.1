Received: from eggs.gnu.org ([2001:4830:134:3::10]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1g85te-00045B-PK
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1g85td-0003wa-70
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1g85tc-0003vC-TC
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:50:37 -0400
References: <1538164055-23719-1-git-send-email-wei@redhat.com>
	<81006285-7644-c03e-a2a8-7458cfd064b8@redhat.com>
	<bb1a3136-c381-52c6-4ef3-d56ff4320226@redhat.com>
	<989263ca-b990-ca5d-1ffa-231e848c4da9@redhat.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <74cf547c-0dbe-b76e-377a-2f0f3a3e235b@redhat.com>
Date: Thu, 4 Oct 2018 10:50:04 -0500
MIME-Version: 1.0
In-Reply-To: <989263ca-b990-ca5d-1ffa-231e848c4da9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] tests: Add migration test for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: lvivier@redhat.com, peter.maydell@linaro.org, drjones@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com



On 10/04/2018 10:30 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 04/10/2018 17:27, Wei Huang wrote:
>> On 10/04/2018 10:07 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 28/09/2018 21:47, Wei Huang wrote:
>>> [...]> +++ b/tests/migration/aarch64/Makefile
>>>> @@ -0,0 +1,20 @@
>>>> +# To specify cross compiler prefix, use CROSS_PREFIX=3D
>>>> +#   $ make CROSS_PREFIX=3Daarch64-linux-gnu-
>>>> +
>>>> +.PHONY: all clean
>>>> +all: a-b-kernel.h
>>>> +
>>>> +a-b-kernel.h: aarch64.kernel
>>>> +	echo "$$__note" > header.tmp
>>>
>>> This won't work on a read-only fs.
>>
>> Under which setting? If tmp file can't be generated on a read-only fs,
>> wouldn't $@ have the same problem?
>=20
> Yes you are right :)
>=20
>>>
>>> Why don't you use $@ directly?
>=20
> What about this?

Yes, I can address it with the following, along with $(RM) as Drew
pointed it out.

a-b-kernel.h: aarch64.kernel
       echo "$$__note" > $@
       xxd -i $< | sed -e 's/.*int.*//' >> $@


>=20
>>>
>>>> +	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
>>>
>>> Please use:
>>>
>>> xxd -g4 ...
>>
>> This option doesn't work with -i (the include file style output) which
>> is what we want. From xxd manual:
>>
>> "-g bytes | -groupsize bytes
>>     separate the output of every <bytes> bytes (two hex characters or
>>     eight bit-digits each) by a whitespace. Specify -g 0 to suppress
>>     grouping.  <Bytes> defaults to 2 in normal mode and 1 in bits
>>     mode. Grouping does not apply to postscript or include style."
>=20
> Indeed, too bad.
>=20
>>>
>>> xxd might not be installed on the host.
>>
>> xxd is provided by vim packages. So it should be available in most dis=
tros.
>>
>>>
>>> That said we should however install it on the docker cross images.
>>
>> Agreed.
>>
>>>
>>>> +	mv header.tmp $@
>>>> +
>>>> +aarch64.kernel: aarch64.elf
>>>> +	$(CROSS_PREFIX)objcopy -O binary $< $@
>>>> +
>>>> +aarch64.elf: a-b-kernel.S
>>>> +	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=3Dnone $<
>>>> +
>>>> +clean:
>>>> +	@rm -rf *.kernel *.elf
>>>
