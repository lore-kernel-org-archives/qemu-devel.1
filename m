Received: from eggs.gnu.org ([2001:4830:134:3::10]:43879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT6b2-00006V-Se
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT6b0-0007vt-2u
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:18:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fT6az-0007uj-SQ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:17:57 -0400
Date: Wed, 13 Jun 2018 16:17:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613161754.61ffa57f@redhat.com>
In-Reply-To: <B526101FCAB4654DB0892B650DEFC555903F82@dggemm501-mbs.china.huawei.com>
References: <20180608094324.23288-1-liujunjie23@huawei.com>
	<20180612154026.59a0f1fd@redhat.com>
	<B526101FCAB4654DB0892B650DEFC555903F82@dggemm501-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] cpu hot-del: leak fix by free the
 relevant members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "liujunjie (A)" <liujunjie23@huawei.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, linzhecheng <linzhecheng@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Wed, 13 Jun 2018 13:15:37 +0000
"liujunjie (A)" <liujunjie23@huawei.com> wrote:

> Hi
> 
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Tuesday, June 12, 2018 9:40 PM
> > To: liujunjie (A) <liujunjie23@huawei.com>
> > Cc: pbonzini@redhat.com; rth@twiddle.net; crosthwaite.peter@gmail.com;
> > linzhecheng <linzhecheng@huawei.com>; Huangweidong (C)
> > <weidong.huang@huawei.com>; wangxin (U)
> > <wangxinxin.wang@huawei.com>; qemu-devel@nongnu.org; Gonglei (Arei)
> > <arei.gonglei@huawei.com>
> > Subject: Re: [Qemu-devel] [PATCH v2] cpu hot-del: leak fix by free the relevant
> > members
> > 
> > On Fri, 8 Jun 2018 17:43:24 +0800
> > liujunjie <liujunjie23@huawei.com> wrote:
> >   
> > > THese leaks are found by ASAN with CPU hot-add and hot-del actions,
> > > such as:  
> > it would be better to split patch into several, 1 leak per patch
> >   
> > > ==14127==ERROR: LeakSanitizer: detected memory leaks
> > >
> > > Direct leak of 4096 byte(s) in 1 object(s) allocated from:
> > >     #0 0x7fc321cb6ec0 in posix_memalign  
> > (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7ec0)  
> > >     #1 0xf756b9 in qemu_try_memalign util/oslib-posix.c:110
> > >     #2 0xf7575b in qemu_memalign util/oslib-posix.c:126
> > >     #3 0x7769cb in kvm_arch_init_vcpu  
> > /root/qemu/target/i386/kvm.c:1103  
> > >     #4 0x4cc4e6 in qemu_kvm_cpu_thread_fn /root/qemu/cpus.c:1201
> > >     #5 0x7fc31cb28dc4 in start_thread
> > > (/usr/lib64/libpthread.so.0+0x7dc4)
> > >
> > > Direct leak of 4096 byte(s) in 1 object(s) allocated from:
> > >     #0 0x7fc321cb6560 in calloc  
> > (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7560)  
> > >     #1 0x7fc31cf944d6 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x4f4d6)
> > >     #2 0x4cc4e6 in qemu_kvm_cpu_thread_fn /root/qemu/cpus.c:1201
> > >     #3 0x7fc31cb28dc4 in start_thread
> > > (/usr/lib64/libpthread.so.0+0x7dc4)
> > >
> > > Direct leak of 184 byte(s) in 1 object(s) allocated from:
> > >     #0 0x7fc321cb6560 in calloc  
> > (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7560)  
> > >     #1 0x7fc31cf944d6 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x4f4d6)
> > >     #2 0x4cda83 in qemu_init_vcpu /root/qemu/cpus.c:1993
> > >     #3 0x6aedbd in x86_cpu_realizefn /root/qemu/target/i386/cpu.c:4739
> > >     #4 0x8edfc8 in device_set_realized hw/core/qdev.c:826
> > >     #5 0xcff60c in property_set_bool qom/object.c:1928
> > >     #6 0xd09bd2 in object_property_set_qobject qom/qom-qobject.c:27
> > >     #7 0xd048e3 in object_property_set_bool qom/object.c:1188
> > >     #8 0x79ad83 in qdev_device_add /root/qemu/qdev-monitor.c:627
> > >     #9 0x79b50c in qmp_device_add /root/qemu/qdev-monitor.c:807
> > >     #10 0xf4ca5d in do_qmp_dispatch qapi/qmp-dispatch.c:119
> > >     #11 0xf4ce3c in qmp_dispatch qapi/qmp-dispatch.c:168
> > >     #12 0x4e2a5a in monitor_qmp_dispatch_one  
> > /root/qemu/monitor.c:4088  
> > >     #13 0x4e2baf in monitor_qmp_bh_dispatcher  
> > /root/qemu/monitor.c:4146  
> > >     #14 0xf67ad1 in aio_bh_poll util/async.c:118
> > >     #15 0xf724a3 in aio_dispatch util/aio-posix.c:436
> > >     #16 0xf67270 in aio_ctx_dispatch util/async.c:261
> > >     #17 0x7fc31cf8e999 in g_main_context_dispatch
> > > (/usr/lib64/libglib-2.0.so.0+0x49999)
> > >
> > > Direct leak of 64 byte(s) in 2 object(s) allocated from:
> > >     #0 0x7fc321cb6560 in calloc  
> > (/usr/local/gcc-6-4/lib64/libasan.so.3+0xc7560)  
> > >     #1 0x7fc31cf944d6 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x4f4d6)
> > >     #2 0x4cda1f in qemu_init_vcpu /root/qemu/cpus.c:1997
> > >     #3 0x6aedbd in x86_cpu_realizefn /root/qemu/target/i386/cpu.c:4739
> > >     #4 0x8edfc8 in device_set_realized hw/core/qdev.c:826
> > >     #5 0xcff60c in property_set_bool qom/object.c:1928
> > >     #6 0xd09bd2 in object_property_set_qobject qom/qom-qobject.c:27
> > >     #7 0xd048e3 in object_property_set_bool qom/object.c:1188
> > >     #8 0x79ad83 in qdev_device_add /root/qemu/qdev-monitor.c:627
> > >     #9 0x79b50c in qmp_device_add /root/qemu/qdev-monitor.c:807
> > >     #10 0xf4ca5d in do_qmp_dispatch qapi/qmp-dispatch.c:119
> > >     #11 0xf4ce3c in qmp_dispatch qapi/qmp-dispatch.c:168
> > >     #12 0x4e2a5a in monitor_qmp_dispatch_one  
> > /root/qemu/monitor.c:4088  
> > >     #13 0x4e2baf in monitor_qmp_bh_dispatcher  
> > /root/qemu/monitor.c:4146  
> > >     #14 0xf67ad1 in aio_bh_poll util/async.c:118
> > >     #15 0xf724a3 in aio_dispatch util/aio-posix.c:436
> > >     #16 0xf67270 in aio_ctx_dispatch util/async.c:261
> > >     #17 0x7fc31cf8e999 in g_main_context_dispatch
> > > (/usr/lib64/libglib-2.0.so.0+0x49999)  
> > back trace (including line numbers) is a moving target so it's only useful for
> > concrete copy.
> > I'd drop it and cite offending hunk in commit message instead.
> > 
> >   
> > > SUMMARY: AddressSanitizer: 8440 byte(s) leaked in 5 allocation(s).
> > >
> > > The relevant members in CPU Structure are freed to fix leak.
> > > Meanwhile, although the VMChangeStateEntry added in kvm_arch_init_vcpu
> > > does not be reportd by ASAN since it still in vm_change_state_head, it's not  
> > longer used after hot-del, so free it, too.  
> > >
> > > Signed-off-by: liujunjie <liujunjie23@huawei.com>
> > > Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> > > ---
> > >  accel/kvm/kvm-all.c  |  3 +++
> > >  cpus.c               |  6 ++++++
> > >  include/sysemu/kvm.h |  1 +
> > >  target/i386/cpu.h    |  2 ++
> > >  target/i386/kvm.c    | 19 ++++++++++++++++++-
> > >  5 files changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
> > > ffee68e..a0491dc 100644
> > > --- a/accel/kvm/kvm-all.c
> > > +++ b/accel/kvm/kvm-all.c
> > > @@ -305,6 +305,9 @@ int kvm_destroy_vcpu(CPUState *cpu)
> > >      vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> > >      vcpu->kvm_fd = cpu->kvm_fd;
> > >      QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> > > +#ifdef TARGET_I386
> > > +    kvm_arch_destroy_vcpu(cpu);
> > > +#endif
> > >  err:
> > >      return ret;
> > >  }
> > > diff --git a/cpus.c b/cpus.c
> > > index d1f1629..cbe28d6 100644
> > > --- a/cpus.c
> > > +++ b/cpus.c
> > > @@ -1842,6 +1842,12 @@ void cpu_remove_sync(CPUState *cpu)
> > >      qemu_mutex_unlock_iothread();
> > >      qemu_thread_join(cpu->thread);
> > >      qemu_mutex_lock_iothread();
> > > +    g_free(cpu->thread);
> > > +    cpu->thread = NULL;
> > > +    g_free(cpu->halt_cond);
> > > +    cpu->halt_cond = NULL;  
> > could you check if it's save to free thread/halt_cond when running in plain TCG
> > mode
> >   
> > > +    g_free(cpu->cpu_ases);
> > > +    cpu->cpu_ases = NULL;  
> > consider TCG usecase, cpu_ases is registered with tcg_as_listener, is it really
> > safe to free?
> >   
> > >  }
> > >  
> > [...]  
> 
> 
> 1. Since all these leaks are sit in two locations, one is in the common CPUState structure, the other is in the specific X86CPU structure. It is a good idea to split the whole patch into two patches.

It's easier to review in-depended and self sufficient patches with one change and
revert it in case it causes trouble. 

> 2. I look back to the commit history and find the way to fix memory leak may be like commit ab105cc138, so I try to use the same way. And I do not know what "cite offending hunk in commit message" means. Can you explain more or is there an example?
I've meant backtrace with linenumbers is meaning-less as lines change depending on
version and it skips on inlined finctions , so while it point to exact place in
your copy of source, the same line could point to another code in other source copy.
Hence it might be problematic to find code that causes leak.

something like this might be more useful:

   x86_cpu_realizefn
       qemu_init_vcpu
           qemu_kvm_start_vcpu
               cpu->thread = g_malloc0(sizeof(QemuThread))


> 3. I am not familiar with the plain TCG mode and can not find out whether is safe to free in this mode. I need some time to check it or is there anyone can figure it out?
Look for single_tcg_halt_cond/single_tcg_cpu_thread and how they are used.

I'm not sure about tcg_as_listener usage, but it looks rather suspicious to delete memory that might be referenced. We might have an actual bug here but if you find a place where
listener is unregistered on unplug and mention it in commit message then it should be fine to delete
this memory.
