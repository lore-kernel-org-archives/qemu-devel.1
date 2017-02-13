Received: from eggs.gnu.org ([2001:4830:134:3::10]:44195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJby-0002bA-BP
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJbt-0008Np-H3
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:36:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdJbt-0008Ne-BB
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:36:17 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7027C80F8E
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 16:36:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170127180255.GI3323@work-vm> (David Alan Gilbert's message of
	"Fri, 27 Jan 2017 18:02:56 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-11-git-send-email-quintela@redhat.com>
	<20170127180255.GI3323@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 17:36:03 +0100
Message-ID: <8760ke59qk.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/17] migration: create ram_multifd_page
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
>> The function still don't use multifd, but we have simplified
>> ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
>> counter and a new flag for this type of pages.


>> +static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
>> +                            bool last_stage, uint64_t *bytes_transferred)
>> +{
>> +    int pages;
>> +    uint8_t *p;
>> +    RAMBlock *block = pss->block;
>> +    ram_addr_t offset = pss->offset;
>> +
>> +    p = block->host + offset;
>> +
>> +    if (block == last_sent_block) {
>> +        offset |= RAM_SAVE_FLAG_CONTINUE;
>> +    }
>> +    pages = save_zero_page(f, block, offset, p, bytes_transferred);
>> +    if (pages == -1) {
>> +        *bytes_transferred +=
>> +            save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
>> +        qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
>> +        *bytes_transferred += TARGET_PAGE_SIZE;
>> +        pages = 1;
>> +        acct_info.norm_pages++;
>> +        acct_info.multifd_pages++;
>> +    }
>> +
>> +    return pages;
>> +}
>> +
>>  static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>>                                  ram_addr_t offset)
>>  {
>> @@ -1427,6 +1461,8 @@ static int ram_save_target_page(MigrationState *ms, QEMUFile *f,
>>              res = ram_save_compressed_page(f, pss,
>>                                             last_stage,
>>                                             bytes_transferred);
>> +        } else if (migrate_use_multifd()) {
>> +            res = ram_multifd_page(f, pss, last_stage, bytes_transferred);
>
> I'm curious whether it's best to pick the destination fd at this level or one level
> higher; for example would it be good to keep all the components of a
> host page or huge
> page together on the same fd? If so then it would be best to pick the fd
> at ram_save_host_page level.

my plan here would be to change the migration code to be able to call
with a bigger sizes, not page by page, and then the problem is solved by
itself?

Later, Juan.
