Received: from eggs.gnu.org ([2001:4830:134:3::10]:34628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cZhUQ-0004w3-Qo
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cZhUP-00083n-UY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:17:38 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cZhUP-00083W-P6
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:17:37 -0500
Received: by mail-oi0-x242.google.com with SMTP id j15so1883419oih.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 09:17:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <de4a92a9-b2b5-3f74-a57f-b361b90c20bb@redhat.com>
References: <1486118198-8965-1-git-send-email-ashijeetacharya@gmail.com>
	<de4a92a9-b2b5-3f74-a57f-b361b90c20bb@redhat.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri, 3 Feb 2017 22:47:36 +0530
Message-ID: <CAC2QTZZ-xymD7ciwpN3uHDnMO5YduhwRiDMTnDiiQQWxdoQwGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] migrate: Introduce zero RAM checks to
 skip RAM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Feb 3, 2017 at 10:44 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 03/02/2017 02:36, Ashijeet Acharya wrote:
>> Migration of a "none" machine with no RAM crashes abruptly as
>> bitmap_new() fails and thus aborts. Instead place zero RAM checks at
>> appropriate places to skip migration of RAM in this case and complete
>> migration successfully for devices only.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>> Changes in v2:
>> - try to migrate successfully by skipping RAM (Paolo, Greg)
>> - drop the idea of erroring out and failing nicely
>>  migration/ram.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index ef8fadf..2f19566 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1325,6 +1325,11 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
>>      ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page in
>>                                   ram_addr_t space */
>>
>> +    /* No dirty page as there is zero RAM */
>> +    if (!ram_bytes_total()) {
>> +        return pages;
>> +    }
>> +
>>      pss.block = last_seen_block;
>>      pss.offset = last_offset;
>>      pss.complete_round = false;
>> @@ -1912,14 +1917,17 @@ static int ram_save_init_globals(void)
>>      bytes_transferred = 0;
>>      reset_ram_globals();
>>
>> -    ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
>> -    migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
>> -    migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
>> -    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
>> +    /* Skip setting bitmap if there is no RAM */
>> +    if (ram_bytes_total()) {
>> +        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
>> +        migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
>> +        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
>> +        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
>>
>> -    if (migrate_postcopy_ram()) {
>> -        migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
>> -        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
>> +        if (migrate_postcopy_ram()) {
>> +            migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
>> +            bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
>> +        }
>>      }
>>
>>      /*
>>
>
> I didn't test it, but it looks good.

I did test it and it looks to be fine. Migration status shows
'complete' and transfers zero RAM as expected (I checked this with
'info migrate' on HMP) and Dave assured me that 'complete' means that
it completed successfully.

Ashijeet
>
> Paolo
