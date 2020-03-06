Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1A9C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DC820714
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jm3Lzp7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DC820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAI1M-0004Fr-BD
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 13:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jAI0l-0003r6-5K
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jAI0k-0002tG-2W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:47:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jAI0j-0002se-Ug
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583520469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dC8TFn1haynLQIuroZWzu6bKe9rnM3Kg3497UchSogk=;
 b=Jm3Lzp7Eg55bZnhLpJp4Vo0ViSL7AULmcujJ4frdAP8fkYa6ITtnU31aNp9jy8noQ833YA
 uGMMi4vvGdLdeAjc166b8es2QpGKe2EnnIkXF6xWbPlJlJfW0MELz9jWJ3QEWgdI5m0J0P
 npA6FGZUDIHTyVp8KPvOJz/qHi9Bo+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-qB9apytrMraL7jKakZQDVQ-1; Fri, 06 Mar 2020 13:47:45 -0500
X-MC-Unique: qB9apytrMraL7jKakZQDVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 760AC18C43D5;
 Fri,  6 Mar 2020 18:47:44 +0000 (UTC)
Received: from [10.36.117.101] (ovpn-117-101.ams2.redhat.com [10.36.117.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00E7C9078E;
 Fri,  6 Mar 2020 18:47:40 +0000 (UTC)
Subject: Re: [PATCH v3 08/13] migration/ram: Simplify host page handling in
 ram_load_postcopy()
From: David Hildenbrand <david@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-9-david@redhat.com> <20200306160538.GE3033@work-vm>
 <29ffaf0b-55e6-53c4-2fd7-b3f0676c1412@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <bfc208f7-bf3c-f7d0-33e0-b864163b61fd@redhat.com>
Date: Fri, 6 Mar 2020 19:47:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <29ffaf0b-55e6-53c4-2fd7-b3f0676c1412@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.03.20 17:20, David Hildenbrand wrote:
> On 06.03.20 17:05, Dr. David Alan Gilbert wrote:
>> * David Hildenbrand (david@redhat.com) wrote:
>>> Add two new helper functions. This will in come handy once we want to
>>> handle ram block resizes while postcopy is active.
>>>
>>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>> Cc: Juan Quintela <quintela@redhat.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  migration/ram.c | 54 ++++++++++++++++++++++++++++---------------------
>>>  1 file changed, 31 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index d5a4d69e1c..f815f4e532 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -2734,6 +2734,20 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
>>>      return block->host + offset;
>>>  }
>>>  
>>> +static void *host_page_from_ram_block_offset(RAMBlock *block,
>>> +                                             ram_addr_t offset)
>>> +{
>>> +    /* Note: Explicitly no check against offset_in_ramblock(). */
>>> +    return (void *)QEMU_ALIGN_DOWN((uintptr_t)block->host + offset,
>>> +                                   block->page_size);
>>> +}
>>> +
>>> +static ram_addr_t host_page_offset_from_ram_block_offset(RAMBlock *block,
>>> +                                                         ram_addr_t offset)
>>> +{
>>> +    return ((uintptr_t)block->host + offset) & (block->page_size - 1);
>>> +}
>>> +
>>>  static inline void *colo_cache_from_block_offset(RAMBlock *block,
>>>                                                   ram_addr_t offset)
>>>  {
>>> @@ -3111,13 +3125,12 @@ static int ram_load_postcopy(QEMUFile *f)
>>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>>      /* Temporary page that is later 'placed' */
>>>      void *postcopy_host_page = mis->postcopy_tmp_page;
>>> -    void *this_host = NULL;
>>> +    void *host_page = NULL;
>>>      bool all_zero = false;
>>>      int target_pages = 0;
>>>  
>>>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>>>          ram_addr_t addr;
>>> -        void *host = NULL;
>>>          void *page_buffer = NULL;
>>>          void *place_source = NULL;
>>>          RAMBlock *block = NULL;
>>> @@ -3143,9 +3156,12 @@ static int ram_load_postcopy(QEMUFile *f)
>>>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>>>                       RAM_SAVE_FLAG_COMPRESS_PAGE)) {
>>>              block = ram_block_from_stream(f, flags);
>>> +            if (!block) {
>>> +                ret = -EINVAL;
>>
>> Could we have an error_report there, at the moment it would trigger
>> the one below.
> 
> Makes sense, I'll add one!

My memory kicks in: This was dropped on purpose. ram_block_from_stream()
will print proper errors already.

Cheers!


-- 
Thanks,

David / dhildenb


