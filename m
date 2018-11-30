Received: from eggs.gnu.org ([2001:4830:134:3::10]:38750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gSijE-0006Bd-Gn
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gSij9-0002Ow-Mc
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:21:08 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:60559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gSij9-0002L8-AH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:21:03 -0500
References: <20181031115242.6558-1-d.csapak@proxmox.com>
	<20181031115242.6558-3-d.csapak@proxmox.com>
	<87sgzilx6e.fsf@dusky.pond.sub.org>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <c38bb4f9-54cf-9348-a607-b8f0e9506904@proxmox.com>
Date: Fri, 30 Nov 2018 14:20:37 +0100
MIME-Version: 1.0
In-Reply-To: <87sgzilx6e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi: split host-qmp into quit and
 system-reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, pbonzini@redhat.com

On 11/30/18 10:41 AM, Markus Armbruster wrote:
> Cc: Pavel to assess possible impact on replay.
> 
> Cc: Eric to give him a chance to correct misunderstandings of
> ShutdownCause.
> 
> Dominik Csapak <d.csapak@proxmox.com> writes:
> 
>> it is interesting to know whether the shutdown cause was 'quit' or
>> 'reset', especially when using --no-reboot
> 
> Are you sure it *is* interesting?  I suspect it *will be* only after the
> next patch.
> 
> Please start your sentences with a capital letter and end them with
> punctuation.
> 
>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
>> ---
>>   qapi/run-state.json | 10 ++++++----
>>   qmp.c               |  4 ++--
>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index 883bed167c..c215b6ef83 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -68,7 +68,9 @@
>>   #
>>   # @host-error: An error prevented further use of guest
>>   #
>> -# @host-qmp: Reaction to a QMP command, like 'quit'
>> +# @host-qmp-quit: Reaction to the QMP command 'quit'
>> +#
>> +# @host-qmp-system-reset: Reaction to the QMP command 'system_reset'
>>   #
>>   # @host-signal: Reaction to a signal, such as SIGINT
>>   #
>> @@ -88,9 +90,9 @@
>>   #
>>   ##
>>   { 'enum': 'ShutdownCause',
>> -  'data': [ 'none', 'host-error', 'host-qmp', 'host-signal', 'host-ui',
>> -            'guest-shutdown', 'guest-reset', 'guest-panic',
>> -            'subsystem-reset'] }
>> +  'data': [ 'none', 'host-error', 'host-qmp-quit', 'host-qmp-system-reset',
>> +            'host-signal', 'host-ui', 'guest-shutdown', 'guest-reset',
>> +            'guest-panic', 'subsystem-reset'] }
>>   
>>   ##
>>   # @StatusInfo:
>> diff --git a/qmp.c b/qmp.c
>> index e7c0a2fd60..82298f6cb0 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -88,7 +88,7 @@ UuidInfo *qmp_query_uuid(Error **errp)
>>   void qmp_quit(Error **errp)
>>   {
>>       no_shutdown = 0;
>> -    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP);
>> +    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP_QUIT);
>>   }
>>   
>>   void qmp_stop(Error **errp)
>> @@ -109,7 +109,7 @@ void qmp_stop(Error **errp)
>>   
>>   void qmp_system_reset(Error **errp)
>>   {
>> -    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
>> +    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
>>   }
>>   
>>   void qmp_system_powerdown(Error **erp)
> 
> Let's see how these guys are used.
> 
> qemu_system_shutdown_request() and qemu_system_reset_request() put their
> argument in @shutdown_requested or @reset_requested.  There's some
> replay magic going on in qemu_system_shutdown_request().
> 
> main_loop_should_exit() retrieves them with qemu_shutdown_requested()
> and qemu_reset_requested().  @shutdown_requested is only passed to
> shutdown_caused_by_guest().  @reset_requested is only passed to
> qemu_system_reset().  None of these functions is affected by your
> change.  There's some replay magic going on in
> qemu_system_reset_requested().
> 
> Xen's cpu_handle_ioreq() retrieves them with
> qemu_shutdown_requested_get() and qemu_reset_requested_get().  None of
> these functions is affected by your change.
> 
> Looks like ShutdownCause is overengineered[*]: we're only ever
> interested in none, host, guest.  Your PATCH 3 will change that.  Okay,
> but your commit message is misleading: this patch has no interesting
> effect now.  The change becomes visible only after PATCH 3.
> 
> I'd swap PATCH 2 and 3, because that would make writing non-misleading
> commit messages easier for me.
> 
> 
> [*] Goes back to Eric's commit 7af88279e49..08fba7ac9b6, which were
> surely done for a reason.  Perhaps I'm just confused.
> 
> 


hi,

yeah switching 2 and 3 makes sense, i guess i did it this way so that
i only have to touch the iotests one time

should i fix the iotests in both 2 and 3 when i switch them ?
(with 2 the reason gets added there, and 3 changes the reason)
or should i send an extra patch (4/4) that fixes only the iotests?
or only change them in 3/3 ?

when this is clear, i will send a v2 with all your remarks fixed
