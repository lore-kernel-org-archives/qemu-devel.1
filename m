Received: from eggs.gnu.org ([2001:4830:134:3::10]:40687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq3dP-0002co-Ag
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq3dK-0007mB-B3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cq3dK-0007lo-5h
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:10:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8AF8811D8
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 20:10:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170317095149.GA2396@work-vm> (David Alan Gilbert's message of
	"Fri, 17 Mar 2017 09:51:49 +0000")
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-24-quintela@redhat.com>
	<20170317095149.GA2396@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 20 Mar 2017 21:10:23 +0100
Message-ID: <877f3jaevk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 23/31] ram: Move migration_bitmap_rcu into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Once there, rename the type to be shorter.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 79 ++++++++++++++++++++++++++++++---------------------------
>>  1 file changed, 42 insertions(+), 37 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c14293c..d39d185 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -132,6 +132,19 @@ out:
>>      return ret;
>>  }
>>  
>> +struct RAMBitmap {
>> +    struct rcu_head rcu;
>> +    /* Main migration bitmap */
>> +    unsigned long *bmap;
>> +    /* bitmap of pages that haven't been sent even once
>> +     * only maintained and used in postcopy at the moment
>> +     * where it's used to send the dirtymap at the start
>> +     * of the postcopy phase
>> +     */
>> +    unsigned long *unsentmap;
>> +};
>> +typedef struct RAMBitmap RAMBitmap;
>> +
>
> I'm OK with this; although I can see the idea of naming it BitmapRcu,
> given that the actual bmap is inside that and most of the rest of the type
> is just the rcu wrapper.

It is the type, and now it also has the unsentmap.

  atomic_rcu_read(&ram_state.bitmap_rcu)->bmap)

ends  getting really long quite fast "p"

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks, Juan.
