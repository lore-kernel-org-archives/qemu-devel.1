Received: from eggs.gnu.org ([209.51.188.92]:55816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZeq-0002gm-Ac
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZeo-0008Td-CV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:20 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
	<aaebd05c-b1a6-a93e-222d-ede76633c07d@vivier.eu>
Message-ID: <555e5b87-0918-35d9-f7d1-6cb0dd11cc85@vivier.eu>
Date: Tue, 30 Apr 2019 22:46:56 +0200
MIME-Version: 1.0
In-Reply-To: <aaebd05c-b1a6-a93e-222d-ede76633c07d@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Le 30/04/2019 à 22:30, Laurent Vivier a écrit :
> Le 30/04/2019 à 22:09, Alistair Francis a écrit :
>> Fix this warning when building with GCC9 on Fedora 30:
>> In function ‘strncpy’,
>>     inlined from ‘sys_uname’ at /home/alistair/qemu/linux-user/uname.c:94:3:
>> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Werror=stringop-truncation]
>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  linux-user/uname.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/linux-user/uname.c b/linux-user/uname.c
>> index 313b79dbad..293b2238f2 100644
>> --- a/linux-user/uname.c
>> +++ b/linux-user/uname.c
>> @@ -90,6 +90,11 @@ int sys_uname(struct new_utsname *buf)
>>     * struct linux kernel uses).
>>     */
>>  
>> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wstringop-truncation"
>> +#endif
>> +
>>    memset(buf, 0, sizeof(*buf));
>>    COPY_UTSNAME_FIELD(buf->sysname, uts_buf.sysname);
>>    COPY_UTSNAME_FIELD(buf->nodename, uts_buf.nodename);
>> @@ -101,6 +106,9 @@ int sys_uname(struct new_utsname *buf)
>>  #endif
>>    return (0);
>>  
>> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
>> +#pragma GCC diagnostic pop
>> +#endif
>>  #undef COPY_UTSNAME_FIELD
>>  }
>>  
>>
> 
> You should use PRAGMA_DISABLE_PACKED_WARNING and
> PRAGMA_REENABLE_PACKED_WARNING from linux-user/qemu.h.

Ok, I should read correctly, the pragma here is not related to them

Thanks,
Laurent
