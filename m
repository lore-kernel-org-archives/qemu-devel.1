Received: from eggs.gnu.org ([2001:4830:134:3::10]:44198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eF9rp-0001Ds-Tk
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eF9rm-0006nK-KD
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:25:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eF9rl-0006SN-VR
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:25:22 -0500
References: <212a9227-5a56-7a0e-1149-2d1bc884b4f0@huawei.com>
	<CAJ+F1CJcdTHe-_ZK1YEgobwMx7jEH4kVB0BFeCpZWV-dY2tH5g@mail.gmail.com>
	<bbabe94a-bcb3-5ad5-7dfb-72327f8178b4@huawei.com>
	<20171115193943.GA14688@work-vm>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <79e0d1bf-5884-0c00-2c17-83f2c6f33be4@huawei.com>
Date: Thu, 16 Nov 2017 10:23:21 +0800
MIME-Version: 1.0
In-Reply-To: <20171115193943.GA14688@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] QEMU abort when network serivce is restarted
 during live migration with vhost-user as the network backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


在 2017/11/16 3:39, Dr. David Alan Gilbert 写道:
> * Yori Fang (fangying1@huawei.com) wrote:
>>
>>
>> 在 2017/11/14 19:40, Marc-André Lureau 写道:
>>> Hi
>>>
>>> On Tue, Nov 14, 2017 at 8:09 AM, fangying <fangying1@huawei.com> wrote:
>>>> Hi all,
>>>>
>>>> We have a vm running migration with vhost-user as network backend, we notice that qemu will abort when openvswitch is restarted
>>>> when MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward) is called. The reasion is clear that vhost_dev_set_log returns -1 because
>>>> the network connection is temporarily lost due to the restart of openvswitch service.
>>>>
>>>> Below is the trace of the call stack.
>>>>
>>>> #0  0x00007f868ed971d7 in raise() from /usr/lib64/libc.so.6
>>>> #1  0x00007f868ed988c8 in abort() from /usr/lib64/libc.so.6
>>>> #2  0x00000000004d0d35 in vhost_log_global_start (listener=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/hw/virtio/vhost.c:794
>>>> #2  0x0000000000486bd2 in memory_global_dirty_log_start at /usr/src/debug/qemu-kvm-2.8.1/memory.c:2304
>>>> #3  0x0000000000486dcd in ram_save_init_globals at /usr/src/debug/qemu-kvm-2.8.1/migration/ram.c:2072
>>>> #4  0x000000000048c185 in ram_save_setup (f=0x25e6ac0, opaque=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/migration/ram.c:2093
>>>> #5  0x00000000004fbee2 in qemu_savevm_state_begin at /usr/src/debug/qemu-kvm-2.8.1/migration/savevm.c:956
>>>> #6  0x000000000083d8f8 in migration_thread at migration/migration.c:2198
>>>>
>>>> static void vhost_log_global_start(MemoryListener *listener)
>>>> {
>>>>     int r;
>>>>
>>>>     r = vhost_migration_log(listener, true);
>>>>     if (r < 0) {
>>>>         abort();   /* branch taken */
>>>>     }
>>>> }
>>>>
>>>> What confuse me is that
>>>> 1. do we really need to abort here ?
>>>
>>> Not if we have a sane way to handle the situation. It make sense
>>> though to not want to support that use case (restarting the vhost-user
>>> process during migration).
>>>
>>>> 2. all member of callbacks in MemoryListener returned with type void, we cannot judge in any upper function on the call stack.
>>>> Can we just cancel migration here instead of calling abort ? like:
>>>
>>> That would be acceptable to me, but there should be a better way than
>>> calling qmp_migrate_cancel() (we need to give a reason for cancelling,
>>> and report it to user). Juan should be able to help.
>>
>> I agree with you, we'd better give more details here instead of passing NULL in qmp_migrate_cancel.
> 
> This is an unfortunate place to want to kill the migration; cancel is
> the wrong call to use though (it's for users to cancel it).
> I think the only way to do it is to call
> migrate_fd_error(migrate_get_current(),...)
> 
> It's not nice though, but the only one I can think of from here.

Thanks, we should use migrate_fd_error(migrate_get_current(),...) instead.
Actually, this kind of error is better handled in upper level of migration_thread.
However, the current MEMORY_LISTENER_CALL_xxx doesn't take care of the return value of MemoryListener callbacks.

> 
> Dave
> 
>>>
>>>>
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index ddc42f0..27ae4a2 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include "hw/virtio/virtio-access.h"
>>>>  #include "migration/blocker.h"
>>>>  #include "sysemu/dma.h"
>>>> +#include "qmp-commands.h"
>>>>
>>>>  /* enabled until disconnected backend stabilizes */
>>>>  #define _VHOST_DEBUG 1
>>>> @@ -885,7 +886,7 @@ static void vhost_log_global_start(MemoryListener *listener)
>>>>
>>>>      r = vhost_migration_log(listener, true);
>>>>      if (r < 0) {
>>>> -        abort();
>>>> +        qmp_migrate_cancel(NULL);
>>>>      }
>>>>  }
>>>>
>>>> @@ -895,7 +896,7 @@ static void vhost_log_global_stop(MemoryListener *listener)
>>>>
>>>>      r = vhost_migration_log(listener, false);
>>>>      if (r < 0) {
>>>> -        abort();
>>>> +        qmp_migrate_cancel(NULL);
>>>>      }
>>>>  }
>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> .
> 
