Received: from eggs.gnu.org ([2001:4830:134:3::10]:37916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dZu0D-0001BO-V3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dZu09-0007kV-75
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:11:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dZu08-0007gQ-G8
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:11:29 -0400
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm> <5971F246.5080000@huawei.com>
	<20170724153521.GD2127@work-vm>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <5976EE99.5050401@huawei.com>
Date: Tue, 25 Jul 2017 15:09:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170724153521.GD2127@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, aarcange@redhat.com


On 2017/7/24 23:35, Dr. David Alan Gilbert wrote:
> * Jay Zhou (jianjay.zhou@huawei.com) wrote:
>> Hi Dave,
>>
>> On 2017/7/21 17:49, Dr. David Alan Gilbert wrote:
>>> * Jay Zhou (jianjay.zhou@huawei.com) wrote:
>>>> Qemu_savevm_state_cleanup() takes about 300ms in my ram migration tests
>>>> with a 8U24G vm(20G is really occupied), the main cost comes from
>>>> KVM_SET_USER_MEMORY_REGION ioctl when mem.memory_size = 0 in
>>>> kvm_set_user_memory_region(). In kmod, the main cost is
>>>> kvm_zap_obsolete_pages(), which traverses the active_mmu_pages list to
>>>> zap the unsync sptes.
>>>
>>> Hi Jay,
>>>     Is this actually increasing the real downtime when the guest isn't
>>> running, or is it just the reported time? I see that the s->downtime
>>> value is calculated right after where we currently call
>>> qemu_savevm_state_cleanup.
>>
>> It actually increased the real downtime, I used the "ping" command to
>> test. Reason is that the source side libvirt sends qmp to qemu to query
>> the status of migration, which needs the BQL. qemu_savevm_state_cleanup
>> is done with BQL, qemu can not handle the qmp if qemu_savevm_state_cleanup
>> has not finished. And the source side libvirt delays about 300ms to notify
>> the destination side libvirt to send the "cont" command to start the vm.
>>
>> I think the value of s->downtime is not accurate enough, maybe we could
>> move the calculation of end_time after qemu_savevm_state_cleanup has done.
>
> I'm copying in Paolo, Radim and Andrea- is there anyway we can make the
> teardown of KVMs dirty tracking not take so long? 300ms is a silly long time
> on only a small VM.
>
>>>     I guess the biggest problem is that 300ms happens before we restart
>>> the guest on the source if a migration fails.
>>
>> 300ms happens even if a migration succeeds.
>
> Hmm, OK, this needs fixing then - it does explain a result I saw a while
> ago where the downtime was much bigger with libvirt than it was with
> qemu on it's own.
>
>>>> I think it can be optimized:
>>>> (1) source vm will be destroyed if the migration is successfully done,
>>>>       so the resources will be cleanuped automatically by the system
>>>> (2) delay the cleanup if the migration failed
>>>
>>> I don't like putting it in qmp_cont; that shouldn't have migration magic
>>> in it.
>>
>> Yes, it is not a ideal place. :(
>>
>>> I guess we could put it in migrate_fd_cleanup perhaps? It gets called on
>>> a bh near the end -  or could we just move it closer to the end of
>>> migration_thread?
>>
>> I have tested putting it in migrate_fd_cleanup, but the downtime is not
>> optimized. So I think it is the same to move it closer to the end of
>> migration_thread if it holds the BQL.
>> Could we put it in migrate_init?
>
> Your explanation above hints as to why migrate_fd_cleanup doesn't help;
> it's because we're still going to be doing it with the BQL taken.

Yes, it is.

> Can you tell me which version of libvirt you're using?

I'm using 1.3.4

> I thought the newer ones were supposed to use events so they did't
> have to poll qemu.

After checking the codes of the newest libvirt, I think it is the same
in the qemuMigrationWaitForCompletion function, which is used to poll
qemu every 50ms.

Thanks,
Jay

>   If we move qemu_savevm_state_cleanup is it still safe? Are there
> some things we're supposed to do at that point which are wrong if
> we don't.
>
> I wonder about something like;  take a mutex in
> memory_global_dirty_log_start, release it in
> memory_global_dirty_log_stop.  Then make ram_save_cleanup start
> a new thread that does the call to memory_global_dirty_log_stop.
>
> Dave
>
