Received: from eggs.gnu.org ([2001:4830:134:3::10]:52165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ee08r-0004yO-Od
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ee08h-0001mU-TJ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:05:41 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180123145222.2487-1-f4bug@amsat.org>
	<f3ef3c07-33cd-bafc-635d-13c66732ffe2@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <42af52b1-12e3-cc4c-6fbf-c58d82bf2f02@amsat.org>
Date: Tue, 23 Jan 2018 12:05:15 -0300
MIME-Version: 1.0
In-Reply-To: <f3ef3c07-33cd-bafc-635d-13c66732ffe2@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/syscall: let recvfrom(struct
 sockaddr *) use abi_ulong
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 01/23/2018 12:00 PM, Laurent Vivier wrote:
> Le 23/01/2018 à 15:52, Philippe Mathieu-Daudé a écrit :
>> Currently recvfrom() is restricted to handle 32-bit pointers,
>> remove this limit for 64-bit hosts.
>>
>> This fixes:
>>
>>   31572 socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT) = 3
>>   ...
>>   31572 sendto(3, {{len=124, type=0x454 /* NLMSG_??? */, flags=NLM_F_REQUEST|NLM_F_ACK, seq=1, pid=0}, "op=test:message acct=\"?\" exe=\"/tmp/nl-bad-addr\" hostname=localhost addr=? terminal=/dev/pts/2 res=success\0\0\0"}, 124, 0, 0xfffffa3897d0, 0) = 124
>>   31572 ppoll([{fd=3, events=POLLIN}], 1, {tv_sec=0, tv_nsec=500000000}, NULL, 0) = 1 ([{fd=3, revents=POLLIN}], left {tv_sec=0, tv_nsec=499993180})
>>   31572 recvfrom(3, 0x112a50eb4, 8988, MSG_PEEK|MSG_DONTWAIT, 0xfffffa3897e0, 0x42) = -1 EFAULT (Bad address)
>>
>> Reported-by: Guido Günther <agx@sigxcpu.org>
>> Message-id: 20180123120541.GA14216@bogon.m.sigxcpu.org
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  linux-user/syscall.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 11c9116c4a..28805b1785 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -4032,7 +4032,7 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
>>      if (!host_msg)
>>          return -TARGET_EFAULT;
>>      if (target_addr) {
>> -        if (get_user_u32(addrlen, target_addrlen)) {
>> +        if (get_user_ual(addrlen, target_addrlen)) {
>>              ret = -TARGET_EFAULT;
>>              goto fail;
>>          }
>> @@ -4053,7 +4053,7 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
>>          }
>>          if (target_addr) {
>>              host_to_target_sockaddr(target_addr, addr, addrlen);
>> -            if (put_user_u32(addrlen, target_addrlen)) {
>> +            if (put_user_ual(addrlen, target_addrlen)) {
>>                  ret = -TARGET_EFAULT;
>>                  goto fail;
>>              }
>>
> 
> I think there are more problems like that (accept4(), do_getpeername(),
> do_getsockname()).
> 
> Could you check and fix?

I'm currently reviewing those ;)

I sent this patch first so Guido could start trying.

> 
> Thanks,
> Laurent
> 
