Received: from eggs.gnu.org ([2001:4830:134:3::10]:45105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJeR-0005AI-Cn
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJeN-0000fX-Gf
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:38:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdJeN-0000f8-Ao
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:38:51 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 729AF61D1E
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 16:38:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <3547173f-cd36-58fa-4d66-12dd16f1e71c@redhat.com> (Paolo
	Bonzini's message of "Thu, 26 Jan 2017 13:38:30 +0100")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-12-git-send-email-quintela@redhat.com>
	<3547173f-cd36-58fa-4d66-12dd16f1e71c@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 17:38:42 +0100
Message-ID: <871sv259m5.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/17] migration: Create thread
 infrastructure for multifd send side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/01/2017 22:32, Juan Quintela wrote:
>> We make the locking and the transfer of information specific, even if we
>> are still transmiting things through the main thread.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 52 insertions(+), 1 deletion(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c71929e..9d7bc64 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -392,17 +392,25 @@ void migrate_compress_threads_create(void)
>>  /* Multiple fd's */
>> 
>>  struct MultiFDSendParams {
>> +    /* not changed */
>>      QemuThread thread;
>>      QIOChannel *c;
>>      QemuCond cond;
>>      QemuMutex mutex;
>> +    /* protected by param mutex */
>>      bool quit;
>>      bool started;
>> +    uint8_t *address;
>> +    /* protected by multifd mutex */
>> +    bool done;
>>  };
>>  typedef struct MultiFDSendParams MultiFDSendParams;
>> 
>>  static MultiFDSendParams *multifd_send;
>> 
>> +QemuMutex multifd_send_mutex;
>> +QemuCond multifd_send_cond;
>
> Having n+1 semaphores instead of n+1 cond/mutex pairs could be more
> efficient.  See thread-pool.c for an example.

Did that.  See next version.

Only partial success.   It goes faster, and code is somehow easier.
But on reception, I end having to add 3 sems for thread (ok, I could
move to only two reusing them, but indeed).  On send side, I got
speedups, on reception side no, but I haven't still found the cause.

Thanks, Juan.
