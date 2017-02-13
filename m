Received: from eggs.gnu.org ([2001:4830:134:3::10]:49901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJva-0007co-PC
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJvX-0005Ev-Lm
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:56:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdJvX-0005Ep-F6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:56:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C86C64D5
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 16:56:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170203112402.GD3208@work-vm> (David Alan Gilbert's message of
	"Fri, 3 Feb 2017 11:24:02 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-15-git-send-email-quintela@redhat.com>
	<20170203112402.GD3208@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 17:56:26 +0100
Message-ID: <87o9y63u85.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/17] migration: Create thread
 infrastructure for multifd recv side
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
>> We make the locking and the transfer of information specific, even if we
>> are still receiving things through the main thread.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 67 insertions(+), 10 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index ca94704..4e530ea 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -523,7 +523,7 @@ void migrate_multifd_send_threads_create(void)
>>      }
>>  }
>> 
>> -static int multifd_send_page(uint8_t *address)
>> +static uint16_t multifd_send_page(uint8_t *address, bool last_page)
>>  {
>>      int i, j, thread_count;
>>      bool found = false;
>> @@ -538,8 +538,10 @@ static int multifd_send_page(uint8_t *address)
>>      pages.address[pages.num] = address;
>>      pages.num++;
>> 
>> -    if (pages.num < (pages.size - 1)) {
>> -        return UINT16_MAX;
>> +    if (!last_page) {
>> +        if (pages.num < (pages.size - 1)) {
>> +            return UINT16_MAX;
>> +        }
>>      }
>
> This should be in the previous patch?
> (and the place that adds the last_page parameter below)?

ok.

>> @@ -2920,10 +2980,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>> 
>>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
>>              fd_num = qemu_get_be16(f);
>> -            if (fd_num != 0) {
>> -                /* this is yet an unused variable, changed later */
>> -                fd_num = fd_num;
>> -            }
>> +            multifd_recv_page(host, fd_num);
>
> This is going to be quite tricky to fit into ram_load_postcopy
> in this form; somehow it's going to have to find addresses to use for place page
> and with anything with a page size != target page size it gets messy.

What do you have in mind?

Later, Juan.
