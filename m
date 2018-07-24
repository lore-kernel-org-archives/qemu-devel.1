Received: from eggs.gnu.org ([2001:4830:134:3::10]:39031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzpo-0006yp-Nr
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzpk-0000Yi-31
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:06:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhzpj-0000XK-Sf
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:06:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A2BF7C6CA
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 16:06:43 +0000 (UTC)
References: <20180720034713.11711-1-peterx@redhat.com>
	<20180724155912.GB48553@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4a02331-1d06-4200-7918-ac2732845f2a@redhat.com>
Date: Tue, 24 Jul 2018 11:06:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180724155912.GB48553@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: fix potential overflow in
 multifd send
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On 07/24/2018 10:59 AM, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
>> I would guess it won't happen normally, but this should ease Coverity.
>>

>> +++ b/migration/ram.c
>> @@ -851,7 +851,7 @@ static void multifd_send_pages(void)
>>       p->pages->block = NULL;
>>       multifd_send_state->pages = p->pages;
>>       p->pages = pages;
>> -    transferred = pages->used * TARGET_PAGE_SIZE + p->packet_len;
>> +    transferred = ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packet_len;

The outer () are not strictly necessary, as casts bind tighter than 
multiply.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
