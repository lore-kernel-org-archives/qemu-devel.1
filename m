Received: from eggs.gnu.org ([2001:4830:134:3::10]:37610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ezLwG-0007Tz-7E
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ezLwF-000350-55
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:36:56 -0400
References: <d29ae6aa-5758-277b-b754-4e6fe7666e6b@redhat.com>
	<CAFEAcA9dHPLj6aF=JsS8dXaDWf_ONQ_A+SD1xXQO7DdsWK3yAw@mail.gmail.com>
	<6b4fbb94-2c28-27c2-17e4-b3ce593eb04d@redhat.com>
	<CAFEAcA_rJ_=-dKauAmrJPGRJ6C09_9CQzRdXK53va4NB_xXKpg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0d6f5f6d-bf28-ffc0-4d7c-b2c73912057e@redhat.com>
Date: Fri, 23 Mar 2018 13:36:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rJ_=-dKauAmrJPGRJ6C09_9CQzRdXK53va4NB_xXKpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Regression on KVM qemu-system-aarch64 since
 "monitor: enable IO thread for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu list <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

On 23/03/18 13:11, Peter Maydell wrote:
> On 23 March 2018 at 12:01, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi,
>>
>> On 23/03/18 11:26, Peter Maydell wrote:
>>> On 23 March 2018 at 10:24, Auger Eric <eric.auger@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> I observe a regression on KVM accelerated qemu-system-aarch64:
>>>>
>>>> Unexpected error in kvm_device_access() at
>>>> /home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164:
>>>> 2018-03-23T09:59:59.629439Z qemu-system-aarch64: KVM_GET_DEVICE_ATTR
>>>> failed: Group 6 attr 0x000000000000c664: Device or resource busy
>>>> 2018-03-23 10:00:00.085+0000: shutting down, reason=crashed
>>>
>>> Can you get a backtrace for this? (I guess you'd need to fiddle
>>> with the kvm_device_access() code to make it assert rather
>>> than passing back the error).
>>
>> OK. I will try to do so. As I could have expected, I cannot reproduce on
>> a standalone qemu command line. The problem observed above is seen with
>> libvirt launch which may be doing some other QMP stuff concurrently?
> 
> Hmm, that could be a bit painful to debug. I dunno if libvirt
> has a "launch QEMU under gdb" option. If not, you could try
> something like:
>    if (condition we want to get a backtrace on) {
>        printf("hit condition, attach gdb to process %d\n", (int)getpid());
>        for (;;) { }
>    }

Thanks for the hint. Here is the stack I get.

#0  kvm_device_access (fd=31, group=6, attr=50788, val=0x5937c88, write=false, errp=0x16984a8 <error_abort>) at /home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164
#1  0x00000000004f8ce4 in arm_gicv3_icc_reset (env=0xffffa1fc8330, ri=0x597f910) at /home/augere/UPSTREAM/qemu/hw/intc/arm_gicv3_kvm.c:632
#2  0x00000000006351ac in cp_reg_reset (key=0x597f730, value=0x597f910, opaque=0xffffa1fc0010) at /home/augere/UPSTREAM/qemu/target/arm/cpu.c:78
#3  0x0000ffffa47edce4 in g_hash_table_foreach () from /lib64/libglib-2.0.so.0
#4  0x0000000000635394 in arm_cpu_reset (s=0xffffa1fc0010) at /home/augere/UPSTREAM/qemu/target/arm/cpu.c:130
#5  0x000000000090c888 in cpu_reset (cpu=0xffffa1fc0010) at qom/cpu.c:249
#6  0x00000000005793d8 in do_cpu_reset (opaque=0xffffa1fc0010) at /home/augere/UPSTREAM/qemu/hw/arm/boot.c:665
#7  0x000000000073095c in qemu_devices_reset () at hw/core/reset.c:69
#8  0x00000000006976e0 in qemu_system_reset (reason=SHUTDOWN_CAUSE_NONE) at vl.c:1731
#9  0x000000000069fd60 in main (argc=69, argv=0xffffe877d1a8, envp=0xffffe877d3d8) at vl.c:4697

Thanks

Eric
> 
> and then QEMU will sit in a loop waiting for you to do a
>   gdb path/to/qemu <pid>
> 
> thanks
> -- PMM
> 
