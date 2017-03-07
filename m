Received: from eggs.gnu.org ([2001:4830:134:3::10]:39825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cl92C-00062d-RV
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cl928-0008Gs-4U
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:55:48 -0500
Received: from [45.249.212.187] (port=2996 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cl927-0008FL-I3
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 01:55:44 -0500
Message-ID: <58BE590E.4070202@huawei.com>
Date: Tue, 7 Mar 2017 14:54:06 +0800
From: hangaohuai <hangaohuai@huawei.com>
MIME-Version: 1.0
References: <20170306140541.10600-1-hangaohuai@huawei.com>
	<a3354e81-8671-6951-42a3-ff5c1dc5b55a@redhat.com>
In-Reply-To: <a3354e81-8671-6951-42a3-ff5c1dc5b55a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Fix the vm state after vm migration when
 vm panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com

debugging the migration step with the same steps.
with
libvirt version:1.3.4
qemu version:2.8.50

I found qemu held the right state.
But libvirt will send cont at the end of the migration, it will rewrite the vm's state.

after migration
HOSTA                             |               HOSTB
virsh list   vm crashed           ->    virsh list   vm running

I will check the new libvirt about handling the state.

Thanks

On 2017/3/7 2:11, Paolo Bonzini wrote:
>
> On 06/03/2017 15:05, hangaohuai wrote:
>> Bug steps:
>> 1. windows VM with pvpanic device:<panic model='isa'/>in xml
>> 2. inject the panic in windows, the vm state is paused (guest-panicked)
>> 3. migrate the vm to other host, vm state is running
>>
>> Check the vmstate before runstate_set(RUN_STATE_RUNNING)
> What's the backtrace for runstate_set(RUN_STATE_RUNNING)?
>
> This should be triggered:
>
>     if (!global_state_received() ||
>         global_state_get_runstate() == RUN_STATE_RUNNING) {
>         if (autostart) {
>             vm_start();
>         } else {
>             runstate_set(RUN_STATE_PAUSED);
>         }
>     } else {
>         runstate_set(global_state_get_runstate());   /* <<<< */
>     }
>
> I also suggest a testcase to tests/pvpanic-test.c.
>
> Paolo
>
>> Signed-off-by: hangaohuai <hangaohuai@huawei.com>
>> ---
>>  cpus.c                  | 3 +++
>>  include/sysemu/sysemu.h | 1 +
>>  vl.c                    | 5 +++++
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/cpus.c b/cpus.c
>> index c857ad2..37b93aa 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1734,6 +1734,9 @@ int vm_prepare_start(void)
>>      if (runstate_is_running()) {
>>          qapi_event_send_stop(&error_abort);
>>          res = -1;
>> +    } else if (runstate_is_paniced()) {
>> +        qemu_system_guest_panicked(NULL);
>> +        res = -1;
>>      } else {
>>          replay_enable_events();
>>          cpu_enable_ticks();
> .
>
