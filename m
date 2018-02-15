Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLSI-0007IW-G1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLSD-0002Iv-Da
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:28:14 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLSD-0002Ih-8H
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:28:09 -0500
Received: by mail-qk0-x243.google.com with SMTP id s198so15233315qke.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 07:28:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-2-f4bug@amsat.org>
	<c11eca2b-abba-63cd-c0da-f4bdb04304d2@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cde5585e-a681-4eac-1777-b4850c191259@amsat.org>
Date: Thu, 15 Feb 2018 12:28:05 -0300
MIME-Version: 1.0
In-Reply-To: <c11eca2b-abba-63cd-c0da-f4bdb04304d2@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/11] linux-user/strace: dump
 AF_NETLINK sockaddr content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

Hi Laurent,

On 02/15/2018 12:17 PM, Laurent Vivier wrote:
> Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> please double check __pad and ntohl()
>>
>>  linux-user/syscall_defs.h |  7 +++++++
>>  linux-user/strace.c       | 34 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>> index bec3680b94..550e7d2939 100644
>> --- a/linux-user/syscall_defs.h
>> +++ b/linux-user/syscall_defs.h
>> @@ -151,6 +151,13 @@ struct target_sockaddr_un {
>>      uint8_t sun_path[108];
>>  };
>>  
>> +struct target_sockaddr_nl {
>> +    uint16_t nl_family;     /* AF_NETLINK */
>> +    int16_t __pad;
> 
> netlink.h uses an unsigned type here.

This is padding, do you prefer char pad[2]?

> 
>> +    uint32_t nl_pid;
>> +    uint32_t nl_groups;
>> +};
>> +
>>  struct target_in_addr {
>>      uint32_t s_addr; /* big endian */
>>  };
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index bd897a3f20..7eb5e2ab48 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -8,6 +8,7 @@
>>  #include <arpa/inet.h>
>>  #include <netinet/tcp.h>
>>  #include <linux/if_packet.h>
>> +#include <linux/netlink.h>
>>  #include <sched.h>
>>  #include "qemu.h"
>>  
>> @@ -397,6 +398,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
>>              gemu_log("}");
>>              break;
>>          }
>> +        case AF_NETLINK: {
>> +            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
>> +            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
>> +                     ntohl(nl->nl_pid), ntohl(nl->nl_groups));
> 
> Both sides of the netlink pipe are local and have the same endianness,
> so I don't think we need the ntohl() here. Moreover, I didn't find any
> endianness change in the kernel for them.

I had the same feeling but didn't check the kernel :\ since I was unsure
I used ntohl(), I'll remove it and respin. Thanks to verify!

Regards,

Phil.

> 
> Thanks,
> Laurent
> 
