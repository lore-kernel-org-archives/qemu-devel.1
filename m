Received: from eggs.gnu.org ([2001:4830:134:3::10]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cl695-00048Z-3j
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 22:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cl691-0004D1-V0
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 22:50:43 -0500
Received: from [59.151.112.132] (port=23604 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cl68z-0004Cf-R0
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 22:50:39 -0500
References: <20170202150530.1025-1-pbonzini@redhat.com>
	<20170203150050.GF642@stefanha-x1.localdomain>
	<55b46fa3-c861-9ba4-da65-25bc392d8900@redhat.com>
	<20170206115659.GC2524@work-vm>
	<58B970DD0200004800140A13@prv-mh.provo.novell.com>
	<20170306090759.GA2394@work-vm>
	<5bac684d-b80d-04cf-4558-dec67e4c246e@cn.fujitsu.com>
	<032603be-44a9-cdc6-7724-c98e0787914b@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <7c7375ac-f2e5-ccce-d069-f80407bd49ce@cn.fujitsu.com>
Date: Tue, 7 Mar 2017 11:50:02 +0800
MIME-Version: 1.0
In-Reply-To: <032603be-44a9-cdc6-7724-c98e0787914b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] configure: remove
 --enable-replication/--disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Bruce Rogers <brogers@suse.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org



On 03/06/2017 08:54 PM, Paolo Bonzini wrote:
>
> On 06/03/2017 11:03, Zhang Chen wrote:
>>
>> On 03/06/2017 05:08 PM, Dr. David Alan Gilbert wrote:
>>> * Bruce Rogers (brogers@suse.com) wrote:
>>>>>>> On 2/6/2017 at 4:57 AM, <dgilbert@redhat.com> wrote:
>>>>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>>>>> On 03/02/2017 07:00, Stefan Hajnoczi wrote:
>>>>>>> On Thu, Feb 02, 2017 at 07:05:30AM ‑0800, Paolo Bonzini wrote:
>>>>>>>> The replication feature is a small amount of code, does not
>>>>>>>> require any external library and unless used does not add
>>>>>>>> anything to the guest's attack surface.  Since any extra
>>>>>>>> configure option affects maintainability on the other hand
>>>>>>>> and is subject to bit rot, I think there is no need to
>>>>>>>> make it configurable.
>>>>>>> I think the current state is good: replication is enabled by
>>>>>>> default but
>>>>>>> can be compiled out if desired.
>>>>>>>
>>>>>>> Downstreams may not be comfortable supporting this feature yet since
>>>>>>> it's incomplete.  It's fair to offer an option to disable it,
>>>>>>> otherwise
>>>>>>> downstreams will have to patch this themselves.
>>>>>> I understand‑‑‑I just am not sure where to draw the line because
>>>>>> there's
>>>>>> plenty of other incomplete features, hence the RFC.  For example,
>>>>>> record/replay cannot be enabled or disabled on the configure command
>>>>>> line.  That was the case even in the beginning, where it didn't
>>>>>> support
>>>>>> either block or character device replay.
>>>>> The line is certainly fuzzy, but I think it's worth making the
>>>>> following
>>>>> type of things configurable:
>>>>>      Features that have a large chunk of code
>>>>>        ‑ dont lets try and configure tiny things on and off
>>>>>      That can be trivially configured
>>>>>        ‑ lets not put big chunks of code around making them configurable
>>>>> and   that are incomplete
>>>>>      or are unused by large chunks of the users
>>>>>
>>>>> Dave
>>>>>
>>>>>> ‑‑enable‑coroutine‑pool is a relic of when Windows builds needed
>>>>>> it, but
>>>>>> all other ‑‑enable‑* options require an external library or at least a
>>>>>> specific operating system.  See for example this patch:
>>>>>>
>>>>>>       commit 52b53c04faab9f7a9879c8dc014930649a3e698d
>>>>>>       Author: Fam Zheng <famz@redhat.com>
>>>>>>       Date:   Wed Sep 10 14:17:51 2014 +0800
>>>>>>
>>>>>>       block: Always compile virtio‑blk dataplane
>>>>>>
>>>>>>       Dataplane doesn't depend on linux‑aio any more, so we don't
>>>>>> need the
>>>>>>       compiling condition now.
>>>>>>
>>>>>>       Configure options are kept but just print a message.
>>>>>>
>>>>>>       Signed‑off‑by: Fam Zheng <famz@redhat.com>
>>>>>>       Reviewed‑by: Paolo Bonzini <pbonzini@redhat.com>
>>>>>>       Message‑id: 1410329871‑28885‑4‑git‑send‑email‑famz@redhat.com
>>>>>>       Signed‑off‑by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>
>>>>>>
>>>>>> I would actually prefer to remove many of the latter
>>>>>> (‑‑enable‑vhost‑net, ‑‑enable‑vhost‑scsi, ‑‑enable‑vhost‑socket) and
>>>>>> just use default‑configs.  We are already doing it for ivshmem for
>>>>>> example:
>>>>>>
>>>>>>       CONFIG_IVSHMEM=$(CONFIG_EVENTFD)
>>>>>>
>>>>>> Paolo
>>>>> ‑‑
>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>> Was there ever a conclusion here? The reason I ask is that I see that
>>>> currently
>>>> using --disable-replication fails for me as follows:
>>>>
>>>> # ./configure --disable-replication
>>>> ...
>>>> # make
>>>> ...
>>>> make  all-recursive
>>>> Making all in pixman
>>>> make[3]: Nothing to be done for 'all'.
>>>> Making all in demos
>>>> make[3]: Nothing to be done for 'all'.
>>>> Making all in test
>>>> make[3]: Nothing to be done for 'all'.
>>>>      CHK version_gen.h
>>>>     LINK    aarch64-softmmu/qemu-system-aarch64
>>>> ../migration/colo.o: In function `qmp_query_xen_replication_status':
>>>> /home/brogers/osr/git/qemu/migration/colo.c:181: undefined reference
>>>> to `replication_get_error_all'
>>>> ../migration/colo.o: In function `qmp_xen_set_replication':
>>>> /home/brogers/osr/git/qemu/migration/colo.c:172: undefined reference
>>>> to `replication_stop_all'
>>>> /home/brogers/osr/git/qemu/migration/colo.c:172: undefined reference
>>>> to `replication_stop_all'
>>>> /home/brogers/osr/git/qemu/migration/colo.c:167: undefined reference
>>>> to `replication_start_all'
>>>> ../migration/colo.o: In function `qmp_xen_colo_do_checkpoint':
>>>> /home/brogers/osr/git/qemu/migration/colo.c:196: undefined reference
>>>> to `replication_do_checkpoint_all'
>>>> collect2: error: ld returned 1 exit status
>>>> make[1]: *** [Makefile:208: qemu-system-aarch64] Error 1
>>>> make: *** [Makefile:322: subdir-aarch64-softmmu] Error 2
>>> We should fix that.
>> COLO needs replication enable.
>> So, should I add a new option enable/disable COLO ?
>> Then, If you disable replication, colo will be disabled automatically.
>> Like that:
>> # ./configure --disable-colo
> Then I would just define --enable-colo/--disable-colo which includes
> replication, the network filter and everything else.

OK, I'm happy to hear that.

Thanks
Zhang Chen

>
> Paolo
>
>
> .
>

-- 
Thanks
Zhang Chen
