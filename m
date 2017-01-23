Received: from eggs.gnu.org ([2001:4830:134:3::10]:57794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cViBU-0000ig-HM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cViBR-0003m1-B6
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:13:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cViBR-0003lt-4u
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:13:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32BA74E4F6
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 17:13:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20161026185053.GI6456@work-vm> (David Alan Gilbert's message of
	"Wed, 26 Oct 2016 19:50:53 +0100")
References: <1477078935-7182-1-git-send-email-quintela@redhat.com>
	<1477078935-7182-8-git-send-email-quintela@redhat.com>
	<20161026185053.GI6456@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 23 Jan 2017 18:13:29 +0100
Message-ID: <87lgu1bsxy.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/13] migration: create ram_multifd_page
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
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

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
>
> The acct_info is now updated simultaneously from multiple
> threads?

No.  This is still done from the migration thread.

Later, Juan.
