Received: from eggs.gnu.org ([2001:4830:134:3::10]:47591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJmq-0003c2-2I
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJmm-0002z7-5a
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:47:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdJml-0002yz-Sc
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:47:32 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA8107E9D9
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 16:47:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170203105430.GB3208@work-vm> (David Alan Gilbert's message of
	"Fri, 3 Feb 2017 10:54:30 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-13-git-send-email-quintela@redhat.com>
	<20170203105430.GB3208@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 17:47:22 +0100
Message-ID: <87shni3un9.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: really use multiple pages
 at a time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We now send several pages at a time each time that we wakeup a thread.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 44 ++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 38 insertions(+), 6 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 9d7bc64..1267730 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -391,6 +391,13 @@ void migrate_compress_threads_create(void)
>> 
>>  /* Multiple fd's */
>> 
>> +
>> +typedef struct {
>> +    int num;
>> +    int size;
>> +    uint8_t **address;
>> +} multifd_pages_t;
>
> The naming is odd for QEMU; should be MultiFDPages ?
> You might want to make num & size unsigned.

ok.

> I was trying to understand why you store 'size' - is that because you worry about
> someone changing the size parameter while we're running?  But given that we call
> init in a few places I'm not sure it covers it.

No.  I am planning to chang the code so I call:

ram_save_block(&multifd_pages, &size,...)

And it returns at most "size" pages, depending on whatever it is easy to
do.  Plan is not to change blocks, or do any expensive operation.  Just
return the next "size" pages available that are easy to pick.


>> +    pages->num = 0;
>> +    pages->size = migrate_multifd_group();
>> +    pages->address = g_malloc0(pages->size * sizeof(uint8_t *));
>
> g_new0(uint8_t *, pages->size)

changing it, I don't  really care O:-)

>> +}
>> +
>>  void migrate_multifd_send_threads_create(void)
>>  {
>>      int i, thread_count;
>> @@ -491,7 +505,7 @@ void migrate_multifd_send_threads_create(void)
>>          multifd_send[i].quit = false;
>>          multifd_send[i].started = false;
>>          multifd_send[i].done = true;
>> -        multifd_send[i].address = 0;
>> +        multifd_init_group(&multifd_send[i].pages);
>>          multifd_send[i].c = socket_send_channel_create();
>>          if(!multifd_send[i].c) {
>>              error_report("Error creating a send channel");
>> @@ -511,8 +525,22 @@ void migrate_multifd_send_threads_create(void)
>> 
>>  static int multifd_send_page(uint8_t *address)
>
> Can you comment multifd_send_page to explain what it returns.
>
> (Do we really need u16 for fd number? More than 256 streams would seem
> surprising).

I *guess*, (big guess) that people are going to use the same number of
threads than cpus.  And we are going to have more than 256 in the near
future, su it looked more future proof to use uint16_t.  I don't really
care though.

Thanks, Juan.
