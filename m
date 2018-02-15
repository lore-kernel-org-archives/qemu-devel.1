Received: from eggs.gnu.org ([2001:4830:134:3::10]:37934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emMo1-0002gN-S0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emMnz-0007RP-AA
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:54:45 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emMny-0007Qw-VQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:54:43 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-2-f4bug@amsat.org>
	<c11eca2b-abba-63cd-c0da-f4bdb04304d2@vivier.eu>
	<cde5585e-a681-4eac-1777-b4850c191259@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6216b4e1-923a-86f4-2726-b476d74f9393@vivier.eu>
Date: Thu, 15 Feb 2018 17:54:38 +0100
MIME-Version: 1.0
In-Reply-To: <cde5585e-a681-4eac-1777-b4850c191259@amsat.org>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Le 15/02/2018 à 16:28, Philippe Mathieu-Daudé a écrit :
> Hi Laurent,
> 
> On 02/15/2018 12:17 PM, Laurent Vivier wrote:
>> Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> please double check __pad and ntohl()
>>>
>>>  linux-user/syscall_defs.h |  7 +++++++
>>>  linux-user/strace.c       | 34 ++++++++++++++++++++++++++++++++++
>>>  2 files changed, 41 insertions(+)
>>>
>>> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>>> index bec3680b94..550e7d2939 100644
>>> --- a/linux-user/syscall_defs.h
>>> +++ b/linux-user/syscall_defs.h
>>> @@ -151,6 +151,13 @@ struct target_sockaddr_un {
>>>      uint8_t sun_path[108];
>>>  };
>>>  
>>> +struct target_sockaddr_nl {
>>> +    uint16_t nl_family;     /* AF_NETLINK */
>>> +    int16_t __pad;
>>
>> netlink.h uses an unsigned type here.
> 
> This is padding, do you prefer char pad[2]?

kernel has:

struct sockaddr_nl {
        __kernel_sa_family_t    nl_family;      /* AF_NETLINK   */
        unsigned short  nl_pad;         /* zero         */
        __u32           nl_pid;         /* port ID      */
        __u32           nl_groups;      /* multicast groups mask */
};

so I prefer "uint16_t", but as you say, it is padding, so sign is
meaningless, if you prefer you can keep int16_t.

Now, it would be good to use target_sockaddr_nl in
host_to_target_sockaddr() as we define it.

Thanks,
Laurent
