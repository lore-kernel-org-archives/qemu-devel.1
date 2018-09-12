Received: from eggs.gnu.org ([2001:4830:134:3::10]:54842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08Nn-0006U8-8Q
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g08Nj-0006WH-6q
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:52:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g08Nj-0006Vv-0j
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:52:47 -0400
References: <1536729461-2692-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+nhYjE1qCjJBuxePJ2LQkjGfoQF4=J=AdRF9EfJRVnWg@mail.gmail.com>
	<CAKXe6S+OHNaxaDBORcDno1Wf3WTevgyNRJQTr6SVAXLV7-rFVA@mail.gmail.com>
	<84da6f02-1f60-4bc7-92da-6a7f74deded3@redhat.com>
	<CAKXe6SJjxne34PvxrbLKE3mz+XCowLxo_MSngPTazsVkPRqJUg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6973b8ab-ab3a-d320-0080-4171d8bce427@redhat.com>
Date: Wed, 12 Sep 2018 11:52:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJjxne34PvxrbLKE3mz+XCowLxo_MSngPTazsVkPRqJUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg_mem: add read memory region callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com, mst@redhat.com, richard.henderson@linaro.org, Qemu Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

On 9/12/18 7:33 AM, Li Qiang wrote:
>>>>
>>>> Do you have a reproducer and/or a backtrace?
>>>> memory_region_dispatch_write() checks if ops->write != NULL.
>>>>

>> FWIW, looking at the codebase, there's a good number of static
>> MemoryRegionOps structures for which the "read_with_attrs" and "read"
>> members are default-initialized to NULL. It seems unlikely they are all
>> wrong.
>>
>>
> I uses the debugexit.
> 
> QEMU command: gdb --args qemu-system-x86_64  -m 2048 -hda
> /home/liqiang02/ubuntu1801.img -enable-kvm  -vnc :100 -device isa-debug-exit
> 
> guest: inw(0x501)
> 
> We can get the following backtrack.
> 
> Starting program: /usr/local/bin/qemu-system-x86_64 -m 2048 -hda
> /home/liqiang02/ubuntu1801.img -enable-kvm -vnc :100 -device isa-debug-exit

> Thread 4 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffcca3c700 (LWP 52826)]
> 0x0000000000000000 in ?? ()
> (gdb) bt
> #0  0x0000000000000000 in ?? ()
> #1  0x00005555557c1f81 in memory_region_oldmmio_read_accessor
> (mr=0x5555577b32b0, addr=0, value=0x7fffcca39568, size=2, shift=0,
> mask=65535, attrs=...) at /home/liqiang02/qemu_max_cpu/qemu-2.8/memory.c:409

Doesn't that mean we should fix memory_region_oldmmio_read_accessor() to 
deal with a NULL callback, rather than hacking up a large number of 
devices to supply a no-op callback?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
