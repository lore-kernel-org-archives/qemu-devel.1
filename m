Received: from eggs.gnu.org ([2001:4830:134:3::10]:39892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDRjZ-0006mw-NL
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDRjU-00063J-OQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dDRjU-00062u-Gp
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:33:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C23980E4A
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 08:33:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170524082511.GH3873@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 24 May 2017 16:25:11 +0800")
References: <20170524073719.22531-1-quintela@redhat.com>
	<20170524082511.GH3873@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 24 May 2017 10:33:24 +0200
Message-ID: <871sre7iy3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: Allow unregister of save_live
 handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Wed, May 24, 2017 at 09:37:19AM +0200, Juan Quintela wrote:
>> Migration non save_live handlers have an ops member that is
>> dinamically allocated by migration code.  Save_live handlers have it
>> passed as argument and are responsability of the caller.  Add a new
>> member is_allocated that remembers if ops has to be freed.  This
>> allows unregister_savevm() to work with save_live handlers.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/vmstate.h | 2 ++
>>  migration/savevm.c          | 5 ++++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index f97411d..1d20e30 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -57,6 +57,8 @@ typedef struct SaveVMHandlers {
>>                                uint64_t *non_postcopiable_pending,
>>                                uint64_t *postcopiable_pending);
>>      LoadStateHandler *load_state;
>> +    /* Has been allocated by migratation code */
>> +    bool is_allocated;
>>  } SaveVMHandlers;
>>  
>>  int register_savevm(DeviceState *dev,
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d971e5e..187f386 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -628,6 +628,7 @@ int register_savevm(DeviceState *dev,
>>      SaveVMHandlers *ops = g_new0(SaveVMHandlers, 1);
>>      ops->save_state = save_state;
>>      ops->load_state = load_state;
>> +    ops->is_allocated = true;
>>      return register_savevm_live(dev, idstr, instance_id, version_id,
>>                                  ops, opaque);
>>  }
>> @@ -651,7 +652,9 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
>>          if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
>>              QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
>>              g_free(se->compat);
>> -            g_free(se->ops);
>> +            if (se->ops->is_allocated) {
>
> Would it be good to check against (se->ops && se->ops->is_allocated)?
> Since I see that devices registered via
> vmstate_register_with_alias_id() won't have this se->ops. I just don't
> know whether that case will be allowed to be unregistered with current
> function.

good point.  I thought that not having ->ops was wrong, but I had
completely forgot about the alias case.  Fixing it.

Thanks, Juan.
