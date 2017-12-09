Received: from eggs.gnu.org ([2001:4830:134:3::10]:57522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNbRG-0003BO-AQ
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 04:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNbRF-000834-6s
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 04:28:54 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-3-vsementsov@virtuozzo.com>
	<20171208173321.GR2403@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <98eaefdc-222c-4a9e-847c-bed30dbfa626@virtuozzo.com>
Date: Sat, 9 Dec 2017 12:28:40 +0300
MIME-Version: 1.0
In-Reply-To: <20171208173321.GR2403@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: add name parameter to
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

08.12.2017 20:33, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> Allow user to specify name for new export, to not reuse internal
>> node name and to not show it to clients.
>>
>> This also allows creating several exports per device.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block.json |  9 +++++++--
>>   blockdev-nbd.c  | 14 +++++++++-----
>>   hmp.c           |  5 +++--
>>   3 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index f093fa3f27..503d4b287b 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -213,14 +213,19 @@
>>   #
>>   # @device: The device name or node name of the node to be exported
>>   #
>> +# @name: Export name. If unspecified @device parameter used as export name.
>> +#        (Since 2.12)
>> +#
>>   # @writable: Whether clients should be able to write to the device via the
>>   #     NBD connection (default false).
>>   #
>> -# Returns: error if the device is already marked for export.
>> +# Returns: error if the server is not running, or export with the same name
>> +#          already exists.
>>   #
>>   # Since: 1.3.0
>>   ##
>> -{ 'command': 'nbd-server-add', 'data': {'device': 'str', '*writable': 'bool'} }
>> +{ 'command': 'nbd-server-add',
>> +  'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
>>   
>>   ##
>>   # @nbd-server-stop:
>> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
>> index 28f551a7b0..46c885aa35 100644
>> --- a/blockdev-nbd.c
>> +++ b/blockdev-nbd.c
>> @@ -158,8 +158,8 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
>>       qapi_free_SocketAddress(addr_flat);
>>   }
>>   
>> -void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
>> -                        Error **errp)
>> +void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>> +                        bool has_writable, bool writable, Error **errp)
>>   {
>>       BlockDriverState *bs = NULL;
>>       BlockBackend *on_eject_blk;
>> @@ -170,8 +170,12 @@ void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
>>           return;
>>       }
>>   
>> -    if (nbd_export_find(device)) {
>> -        error_setg(errp, "NBD server already exporting device '%s'", device);
>> +    if (!has_name) {
>> +        name = device;
>> +    }
>> +
>> +    if (nbd_export_find(name)) {
>> +        error_setg(errp, "NBD server already has export named '%s'", name);
>>           return;
>>       }
>>   
>> @@ -195,7 +199,7 @@ void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
>>           return;
>>       }
>>   
>> -    nbd_export_set_name(exp, device);
>> +    nbd_export_set_name(exp, name);
>>   
>>       /* The list of named exports has a strong reference to this export now and
>>        * our only way of accessing it is through nbd_export_find(), so we can drop
>> diff --git a/hmp.c b/hmp.c
>> index 35a7041824..0ea9c09b58 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -2203,7 +2203,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
>>               continue;
>>           }
>>   
>> -        qmp_nbd_server_add(info->value->device, true, writable, &local_err);
>> +        qmp_nbd_server_add(info->value->device, false, NULL,
>> +                           true, writable, &local_err);
>>   
>>           if (local_err != NULL) {
>>               qmp_nbd_server_stop(NULL);
>> @@ -2223,7 +2224,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
>>       bool writable = qdict_get_try_bool(qdict, "writable", false);
>>       Error *local_err = NULL;
>>   
>> -    qmp_nbd_server_add(device, true, writable, &local_err);
>> +    qmp_nbd_server_add(device, false, NULL, true, writable, &local_err);
> I wont insist, but it would be nice if you wired up an optional
> parameter on HMP as well.
>
> Dave

Hmm.. Honestly, I don't see real usage of it.

>
>>       if (local_err != NULL) {
>>           hmp_handle_error(mon, &local_err);
>> -- 
>> 2.11.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


-- 
Best regards,
Vladimir
