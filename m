Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ee1bP-0002nE-A2
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ee1bK-0004kv-9C
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:39:15 -0500
References: <20180123145222.2487-1-f4bug@amsat.org>
	<20180123152339.GA23245@bogon.m.sigxcpu.org>
	<6d55a3e7-9d70-1ea1-2d22-65e136bda06b@vivier.eu>
	<20180123162718.GA9252@bogon.m.sigxcpu.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ed79d5f8-20da-6ec6-f26f-3bfb9736483b@vivier.eu>
Date: Tue, 23 Jan 2018 17:38:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180123162718.GA9252@bogon.m.sigxcpu.org>
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
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Le 23/01/2018 à 17:27, Guido Günther a écrit :
> Hi,
> On Tue, Jan 23, 2018 at 05:12:26PM +0100, Laurent Vivier wrote:
>> Le 23/01/2018 à 16:23, Guido Günther a écrit :
>>> Hi,
>>> Thanks for having a look!
>>>
>>> On Tue, Jan 23, 2018 at 11:52:22AM -0300, Philippe Mathieu-Daudé wrote:
>>>> Currently recvfrom() is restricted to handle 32-bit pointers,
>>>> remove this limit for 64-bit hosts.
>>>>
>>>> This fixes:
>>>>
>>>>   31572 socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT) = 3
>>>>   ...
>>>>   31572 sendto(3, {{len=124, type=0x454 /* NLMSG_??? */, flags=NLM_F_REQUEST|NLM_F_ACK, seq=1, pid=0}, "op=test:message acct=\"?\" exe=\"/tmp/nl-bad-addr\" hostname=localhost addr=? terminal=/dev/pts/2 res=success\0\0\0"}, 124, 0, 0xfffffa3897d0, 0) = 124
>>>>   31572 ppoll([{fd=3, events=POLLIN}], 1, {tv_sec=0, tv_nsec=500000000}, NULL, 0) = 1 ([{fd=3, revents=POLLIN}], left {tv_sec=0, tv_nsec=499993180})
>>>>   31572 recvfrom(3, 0x112a50eb4, 8988, MSG_PEEK|MSG_DONTWAIT, 0xfffffa3897e0, 0x42) = -1 EFAULT (Bad address)
...
>> Could you try:
>>
>> strace -f chroot . /usr/bin/qemu-arm-static tmp/nl-bad-addr
>>
>> to see if the fault comes from the kernel or from QEMU.
> 
> Full strace is attached of
> 
>     strace -f -s2048 -onl-bad-addr.strace chroot armhf-chroot/ tmp/qemu-arm-static tmp/a.out
> 
> is attched. The error is at the very end.
...
> 9559  socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT) = 3
> 9559  fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
...
> 9559  sendto(3, {{len=120, type=0x454 /* NLMSG_??? */, flags=NLM_F_REQUEST|NLM_F_ACK, seq=1, pid=0}, "op=test:message acct=\"?\" exe=\"/tmp/a.out\" hostname=localhost addr=::1 terminal=/dev/pts/2 res=success\0\0\0"}, 120, 0, 0xffffcdb29840, 0) = 120
> 9559  ppoll([{fd=3, events=POLLIN}], 1, {tv_sec=0, tv_nsec=500000000}, NULL, 0) = 1 ([{fd=3, revents=POLLIN}], left {tv_sec=0, tv_nsec=499951056})
> 9559  recvfrom(3, 0xffff9404ae84, 8988, MSG_PEEK|MSG_DONTWAIT, 0xffffcdb29850, 0x42) = -1 EFAULT (Bad address)

So the problem seems to be with the pointer/buffer we pass to the kernel
(either host_msg or addr). It's weird...

Thanks,
Laurent
