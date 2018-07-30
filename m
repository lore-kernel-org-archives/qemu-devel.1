Received: from eggs.gnu.org ([2001:4830:134:3::10]:59004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk92v-0003xs-I8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk92r-0004cs-GI
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:21:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fk92r-0004bj-8K
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:21:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id r16-v6so13083473wrt.11
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 07:21:09 -0700 (PDT)
References: <20180730134321.19898-1-alex.bennee@linaro.org>
	<20180730134321.19898-2-alex.bennee@linaro.org>
	<bb23514b-741c-bda3-309b-6bcedc071ab5@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <bb23514b-741c-bda3-309b-6bcedc071ab5@vivier.eu>
Date: Mon, 30 Jul 2018 15:21:06 +0100
Message-ID: <87zhy8954d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 1/2] linux-user/mmap.c: handle
 invalid len maps correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, 1783362@bugs.launchpad.net


Laurent Vivier <laurent@vivier.eu> writes:

> Le 30/07/2018 =C3=A0 15:43, Alex Benn=C3=A9e a =C3=A9crit:
>> I've slightly re-organised the check to more closely match the
>> sequence that the kernel uses in do_mmap(). We check for both the zero
>> case (EINVAL) and the overflow length case (ENOMEM).
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: umarcor <1783362@bugs.launchpad.net>
>>
>> ---
>> v2
>>   - add comment on overflow
>> ---
>>  linux-user/mmap.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index d0c50e4888..41e0983ce8 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -391,14 +391,23 @@ abi_long target_mmap(abi_ulong start, abi_ulong le=
n, int prot,
>>      }
>>  #endif
>>
>> -    if (offset & ~TARGET_PAGE_MASK) {
>> +    if (!len) {
>>          errno =3D EINVAL;
>>          goto fail;
>>      }
>>
>> +    /* Also check for overflows... */
>>      len =3D TARGET_PAGE_ALIGN(len);
>> -    if (len =3D=3D 0)
>> -        goto the_end;
>> +    if (!len) {
>> +        errno =3D ENOMEM;
>> +        goto fail;
>> +    }
>> +
>> +    if (offset & ~TARGET_PAGE_MASK) {
>> +        errno =3D EINVAL;
>> +        goto fail;
>> +    }
>> +
>>      real_start =3D start & qemu_host_page_mask;
>>      host_offset =3D offset & qemu_host_page_mask;
>>
>>
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Are you going to take this via your queue or do you want me to re-post
with the r-b?

--
Alex Benn=C3=A9e
