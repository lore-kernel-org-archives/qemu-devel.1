Received: from eggs.gnu.org ([2001:4830:134:3::10]:55550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fikX6-0007Te-7v
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fikX3-00066I-7a
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:58:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fikX2-00065B-Mw
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:58:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id j5-v6so2567622wrr.8
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 10:58:32 -0700 (PDT)
References: <20180726132947.28538-1-alex.bennee@linaro.org>
	<20180726132947.28538-2-alex.bennee@linaro.org>
	<a2dd4939-3fd3-31dd-7763-c96b1b627c21@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a2dd4939-3fd3-31dd-7763-c96b1b627c21@vivier.eu>
Date: Thu, 26 Jul 2018 18:58:30 +0100
Message-ID: <87va91swu1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for 3.0 1/2] linux-user/mmap.c: handle
 len = 0 maps correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, umarcor <1783362@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 26/07/2018 =C3=A0 15:29, Alex Benn=C3=A9e a =C3=A9crit:
>> I've slightly re-organised the check to more closely match the
>> sequence that the kernel uses in do_mmap().
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: umarcor <1783362@bugs.launchpad.net>
>> ---
>>  linux-user/mmap.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index d0c50e4888..3ef69fa2d0 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -391,14 +391,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong le=
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
>>      len =3D TARGET_PAGE_ALIGN(len);
>> -    if (len =3D=3D 0)
>> -        goto the_end;
>> +    if (!len) {
>> +        errno =3D EINVAL;
>> +        goto fail;
>> +    }
>
> Why do you check twice len?
> TARGET_PAGE_ALIGN() rounds up the value, so if it was not 0, it cannot
> be now.

I was trying to follow the kernel style but I realise TARGET_PAGE_ALIGN
might be a different test compared to the kernel's PAGE_ALIGN(len) for
overflows:

	if (!len)
		return -EINVAL;

	/*
	 * Does the application expect PROT_READ to imply PROT_EXEC?
	 *
	 * (the exception is when the underlying filesystem is noexec
	 *  mounted, in which case we dont add PROT_EXEC.)
	 */
	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
		if (!(file && path_noexec(&file->f_path)))
			prot |=3D PROT_EXEC;

	/* force arch specific MAP_FIXED handling in get_unmapped_area */
	if (flags & MAP_FIXED_NOREPLACE)
		flags |=3D MAP_FIXED;

	if (!(flags & MAP_FIXED))
		addr =3D round_hint_to_min(addr);

	/* Careful about overflows.. */
	len =3D PAGE_ALIGN(len);
	if (!len)
		return -ENOMEM;


>
> Thanks,
> Laurent


--
Alex Benn=C3=A9e
