Received: from eggs.gnu.org ([2001:4830:134:3::10]:53218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDw03-0001Hx-1k
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDvzx-00070U-OO
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:24:51 -0500
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:44703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDvzx-00070Q-IT
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:24:45 -0500
Received: by mail-qk0-x231.google.com with SMTP id v137so17226890qkb.1
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 09:24:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171110194935.17541-1-laurent@vivier.eu>
	<20171112075627.5798b8b9@thl530.multi.box>
	<6f6213f1-40e6-2761-ec5a-2cd77e76ba5c@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <598100b7-8bf1-5871-7690-1004c1482fd0@amsat.org>
Date: Sun, 12 Nov 2017 14:24:43 -0300
MIME-Version: 1.0
In-Reply-To: <6f6213f1-40e6-2761-ec5a-2cd77e76ba5c@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user,
 s390x: ignore OS ABI value in ELF header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 11/12/2017 06:23 AM, Laurent Vivier wrote:
> Le 12/11/2017 à 07:56, Thomas Huth a écrit :
>> Am Fri, 10 Nov 2017 20:49:35 +0100
>> schrieb Laurent Vivier <laurent@vivier.eu>:
>>
>>> I have this error:
>>> bash: /sbin/ldconfig: cannot execute binary file: Exec format error
>>>
>>> because /sbin/ldconfig is:
>>> ELF 64-bit MSB executable, IBM S/390, version 1 (GNU/Linux),
>>> statically linked, for GNU/Linux 3.2.0,
>>> BuildID[sha1]=90b64604014aafac9c1a0623b1cf447281d1a382, stripped
>>>
>>> OS ABI is GNU/linux
>>>
>>> "/bin/ls" works well:
>>>
>>> ELF 64-bit MSB shared object, IBM S/390, version 1 (SYSV),
>>> dynamically linked, interpreter /lib/ld64.so.1, for GNU/Linux 3.2.0,
>>> BuildID[sha1]=be9b19143d4657678846f6e5277383071fc1059a, stripped
>>>
>>> OS ABI is SYSV
>>>
>>> To be able to execute ldconfig, this patch modifies s390x binfmt mask
>>> to ignore the OS ABI value (EI_OSABI, byte 7).
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>  scripts/qemu-binfmt-conf.sh | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
>>> index 8afc3eb5bb..e2e1b7544d 100755
>>> --- a/scripts/qemu-binfmt-conf.sh
>>> +++ b/scripts/qemu-binfmt-conf.sh
>>> @@ -85,7 +85,7 @@
>>> sh4eb_mask='\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff
>>> sh4eb_family=sh4 
>>>  s390x_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x16'
>>> -s390x_mask='\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>>> +s390x_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>>
>> If I've got that right, the OSABI field should either be 0 for
>> "No extensions or unspecified" (which is then printed  by "file"
>> as SYSV) or 3 for "GNU/Linux".
>> Thus wouldn't it be better to use a mask of 0xfc here instead, so
>> that we refuse at least everything with a value > 3 here?
> No, because with this mask you allow HPUX and NetBSD (See
> /usr/include/elf.h), I don't think it's really better. The simplest way
> to manage this is to ignore the field. A better way should be to have
> two binfmt entries, one for SYSV and one for GNU/Linux, but as our goal
> is to run linux binaries on linux system, is it worth it?

This was my first thought when I reviewed your patch, this indeed looks
cleaner and would be self-explanatory.

Regards,

Phil.
