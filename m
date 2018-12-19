Received: from eggs.gnu.org ([2001:4830:134:3::10]:47418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gZT8L-0003t3-4O
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gZT8G-0007hR-9Z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:06:57 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gZT8F-0007fz-VF
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:06:52 -0500
Received: by mail-pf1-x443.google.com with SMTP id y126so9187568pfb.4
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 20:06:51 -0800 (PST)
References: <20181214015520.20467-1-aik@ozlabs.ru>
	<20181217062133.GK5597@umbus.fritz.box>
	<20181218020924.GB23604@umbus.fritz.box>
	<1e2449a7-d89b-3ca5-db66-7da34ff59a35@ozlabs.ru>
	<20181218034910.GF23604@umbus.fritz.box>
	<cae378d2-29c8-556b-8833-713fa95db3da@ozlabs.ru>
	<c7e3ab4b-adbf-5a26-f057-c64eedfc6c0b@ozlabs.ru>
	<20181218104033.5d619c1b@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d88799af-da3c-66a4-eb95-407146632a25@ozlabs.ru>
Date: Wed, 19 Dec 2018 15:06:42 +1100
MIME-Version: 1.0
In-Reply-To: <20181218104033.5d619c1b@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v3] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, gkurz@linux.ibm.com



On 18/12/2018 20:40, Greg Kurz wrote:
> On Tue, 18 Dec 2018 18:54:33 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 18/12/2018 15:30, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 18/12/2018 14:49, David Gibson wrote:  
>>>> On Tue, Dec 18, 2018 at 02:04:54PM +1100, Alexey Kardashevskiy wrote:  
>>>>>
>>>>>
>>>>> On 18/12/2018 13:09, David Gibson wrote:  
>>>>>> On Mon, Dec 17, 2018 at 05:21:33PM +1100, David Gibson wrote:  
>>>>>>> On Fri, Dec 14, 2018 at 12:55:20PM +1100, Alexey Kardashevskiy wrote:  
>>>>>>>> SLOF receives a device tree and updates it with various properties
>>>>>>>> before switching to the guest kernel and QEMU is not aware of any changes
>>>>>>>> made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
>>>>>>>> sense to pass the SLOF final device tree to QEMU to let it implement
>>>>>>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
>>>>>>>>
>>>>>>>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
>>>>>>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
>>>>>>>> assisted NMI - FWNMI).
>>>>>>>>
>>>>>>>> This stores the initial DT blob in the sPAPR machine and replaces it
>>>>>>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
>>>>>>>>
>>>>>>>> This adds an @update_dt_enabled machine property to allow backward
>>>>>>>> migration.
>>>>>>>>
>>>>>>>> SLOF already has a hypercall since
>>>>>>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
>>>>>>>>
>>>>>>>> This makes use of the new fdt_check_full() helper. In order to allow
>>>>>>>> the configure script to pick the correct DTC version, this adjusts
>>>>>>>> the DTC presense test.
>>>>>>>>
>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
>>>>>>>
>>>>>>> Applied, thanks.  
>>>>>>
>>>>>> And now, unapplied.
>>>>>>
>>>>>> I don't know quite how, but somehow this patch is causing aarch64
>>>>>> tests to SEGV.  
>>>>>
>>>>>
>>>>> /home/aik/p/qemu/configure --target-list=aarch64-softmmu
>>>>> --source-path=/home/aik/p/qemu/ --disable-git-update --with-git=false
>>>>>    --enable-trace-backend=log
>>>>>
>>>>> and
>>>>>
>>>>> make -C /home/aik/pbuild/qemu-localhost-aarch64-rel/ -j24 check
>>>>>
>>>>> did not produce segv. I am running this all on a power8 box + ubuntu
>>>>> 1804, what is your config?  
>>>>
>>>> Hm, curious.  I'm using Fedora 29 on an x86 host.  
>>>
>>>
>>> Fedora 27 on x86_64 is all right too :-/ Let's upgrade...  
>>
>> Upgraded, bad experience - usb ethernet module did not load, and now it
>> does not remember the screen configuration - when the external monitor
>> is detached - all windows jump to the laptop screen and never come back
>> to the external one when reattached :(
>>
>>
>> Aaaaand the latest QEMU does not compile with gcc 8.2.1 from fc28:
>>
>> /home/aik/p/qemu-dwg/util/memfd.c:38:12: error: static declaration of
>> ‘memfd_create’ follows non-static declaration
>>  static int memfd_create(const char *name, unsigned int flags)
>>             ^~~~~~~~~~~~
>> In file included from /usr/include/bits/mman-linux.h:117,
>>                  from /usr/include/bits/mman.h:49,
>>                  from /usr/include/sys/mman.h:41,
>>                  from /home/aik/p/qemu-dwg/include/sysemu/os-posix.h:29,
>>                  from /home/aik/p/qemu-dwg/include/qemu/osdep.h:119,
>>                  from /home/aik/p/qemu-dwg/util/memfd.c:28:
>> /usr/include/bits/mman-shared.h:46:5: note: previous declaration of
>> ‘memfd_create’ was here
>>  int memfd_create (const char *__name, unsigned int __flags) __THROW;
>>      ^~~~~~~~~~~~
>>
>>
>> /home/aik/p/qemu-dwg/block/file-posix.c:1585:14: error: static
>> declaration of ‘copy_file_range’ follows non-static declaration
>>  static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>>               ^~~~~~~~~~~~~~~
>> In file included from /home/aik/p/qemu-dwg/include/qemu/osdep.h:90,
>>                  from /home/aik/p/qemu-dwg/block/file-posix.c:25:
>> /usr/include/unistd.h:1107:9: note: previous declaration of
>> ‘copy_file_range’ was here
>>  ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
>>          ^~~~~~~~~~~~~~~
>>
>>
>> after fixing these, there is still no segv anyway. Hm :(
>>
>>
> 
> Weird... Unlike you, no compile problems for me with gcc-8.2.1-5.fc28.x86_64, but
> same as you, no segv...


Ah, "make clean" fixed that, somehow switching before this patch and
back did not trigger some reconfiguration/recompile, weird because the
patch is not related to aarch64 in any way. With that fixed, no segv.



-- 
Alexey
