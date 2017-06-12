Received: from eggs.gnu.org ([2001:4830:134:3::10]:56685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMoW-0002ve-T6
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKMoV-0007xf-TU
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dKMoV-0007wm-N8
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:43:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B65E84DAF8
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 10:43:14 +0000 (UTC)
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-3-quintela@redhat.com>
	<15fa6b0a-e0de-250b-1df2-e96c98c845f8@redhat.com>
	<87ink1lciy.fsf@secure.mitica>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <9dce33b8-0273-f4ba-8321-f1ea4e3f26f1@redhat.com>
Date: Mon, 12 Jun 2017 12:43:12 +0200
MIME-Version: 1.0
In-Reply-To: <87ink1lciy.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/11] migration: Move
 self_announce_delay() to misc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On 12/06/2017 12:35, Juan Quintela wrote:
> Laurent Vivier <lvivier@redhat.com> wrote:
>> On 01/06/2017 23:29, Juan Quintela wrote:
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>  hw/net/virtio-net.c         |  1 +
>>>  include/migration/misc.h    | 10 ++++++++++
>>>  include/migration/vmstate.h | 10 ----------
>>>  migration/savevm.c          |  1 +
>>>  4 files changed, 12 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 9a3d769..91eddaf 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -25,6 +25,7 @@
>>>  #include "qapi/qmp/qjson.h"
>>>  #include "qapi-event.h"
>>>  #include "hw/virtio/virtio-access.h"
>>> +#include "migration/misc.h"
>>>  
>>>  #define VIRTIO_NET_VM_VERSION    11
>>>  
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index d7892b7..60486d4 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -26,4 +26,14 @@ void blk_mig_init(void);
>>>  static inline void blk_mig_init(void) {}
>>>  #endif
>>>  
>>> +#define SELF_ANNOUNCE_ROUNDS 5
>>> +
>>> +static inline
>>> +int64_t self_announce_delay(int round)
>>> +{
>>> +    assert(round < SELF_ANNOUNCE_ROUNDS && round > 0);
>>> +    /* delay 50ms, 150ms, 250ms, ... */
>>> +    return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
>>> +}
>>> +
>>
>> It seems it is not used in a migration purpose by virtio-net, so it
>> should be moved out of include/migration, perhaps in include/qemu/timer.h ?
> 
> There are some series from Vlad that touched this, but I need to move it
> _anyways_ because I move migration.h to be internal to migration/.
> 
> I already asked him to move them to net/<anywhere>
> 
> Later, Juan.
> 

ok, so:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
