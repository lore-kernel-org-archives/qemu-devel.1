Received: from eggs.gnu.org ([209.51.188.92]:34641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gn6mL-0002a7-8C
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gn6mF-0003K5-6R
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:04:33 -0500
Received: from speedy.comstyle.com ([206.51.28.2]:45781 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gn6m2-0003DI-Ff
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:04:20 -0500
References: <20190115200252.25911-1-mst@redhat.com>
	<20190115200252.25911-8-mst@redhat.com>
	<690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <b5a2251d-d992-47b8-012f-1257476752c8@comstyle.com>
Date: Fri, 25 Jan 2019 14:04:15 -0500
MIME-Version: 1.0
In-Reply-To: <690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 07/49] util: check the return value of
 fcntl in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>

On 1/25/2019 1:53 PM, Philippe Mathieu-Daud=C3=A9 wrote:

> Hi,
>
> On 1/15/19 9:04 PM, Michael S. Tsirkin wrote:
>> From: Li Qiang <liq3ea@163.com>
>>
>> Assert that the return value is not an error. This is like commit
>> 7e6478e7d4f for qemu_set_cloexec.
>>
>> Signed-off-by: Li Qiang <liq3ea@163.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   util/oslib-posix.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index c1bee2a581..4ce1ba9ca4 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
>>   {
>>       int f;
>>       f =3D fcntl(fd, F_GETFL);
>> -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
>> +    assert(f !=3D -1);
>> +    f =3D fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
>> +    assert(f !=3D -1);
>>   }
>>  =20
>>   void qemu_set_nonblock(int fd)
>>   {
>>       int f;
>>       f =3D fcntl(fd, F_GETFL);
>> -    fcntl(fd, F_SETFL, f | O_NONBLOCK);
>> +    assert(f !=3D -1);
>> +    f =3D fcntl(fd, F_SETFL, f | O_NONBLOCK);
>> +    assert(f !=3D -1);
> This commit breaks OpenBSD, when trying to start QEMU I get:
> assertion "f !=3D -1" failed: file "util/oslib-posix.c", line 247,
> function "qemu_set_nonblock"
>
> Having a quick look at gdb, the last device opened is /dev/null, and
> when fcntl() fails we have errno =3D ENODEV.
>
>      19 ENODEV Operation not supported by device.
>      An attempt was made to apply an inappropriate function to a device=
,
>      for example, trying to read a write-only device such as a printer.
>
> Digging further I found a recent commit which could fix this problem:
> https://github.com/openbsd/src/commit/c2a35b387f9d3c
> "fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
> the memory devices (/dev/null, /dev/zero, etc) need to permit them."
>
> Brad: Do you think this might be the fix? If so, any idea what is the
> first release to contain this fix? I don't know OpenBSD and can't figur=
e
> this out... Also, what would be the cleaner QEMU fix?

I don't know. But that commit was included with 6.3 or newer.
