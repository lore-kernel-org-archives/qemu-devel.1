Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35C9C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF38206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRwgW8E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF38206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AdA-0004d5-Sf
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j5AcT-0004CU-9Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j5AcS-00036j-3A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:53:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j5AcR-00036T-Un
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582300415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V3U9asytv0dpGbVeXukpzsLeJWftxcVGLFEEaZ3VFDI=;
 b=jRwgW8E9eOcSOVRaq9dqQ3G+OgXcGbFwz7DA4ngQecjGeRa0O72696PYu1iApFMVK7rWbD
 z1HGJh7zfJu2S3JMUshehzlF42Mq5nIKxh/6Gdh16W3hwaXRRa81HN/ej3890EgUczLZ4/
 +jRlkGA0gSwRYDxfIvcOxa3GD9Tyk1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-ROj48KU_MXqdpUjkr8eLvA-1; Fri, 21 Feb 2020 10:53:33 -0500
X-MC-Unique: ROj48KU_MXqdpUjkr8eLvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE36F1005510;
 Fri, 21 Feb 2020 15:53:32 +0000 (UTC)
Received: from [10.36.117.197] (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 013F060FC1;
 Fri, 21 Feb 2020 15:53:26 +0000 (UTC)
Subject: Re: [PATCH v1 06/13] migrate/ram: Discard new RAM when growing RAM
 blocks and the VM is stopped
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-7-david@redhat.com>
 <85682e4d-956f-080d-7c22-bcb292e67adf@redhat.com>
 <20200221155113.GH2931@work-vm>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <3d7fd3a6-5481-f57a-2252-51fb50e68356@redhat.com>
Date: Fri, 21 Feb 2020 16:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221155113.GH2931@work-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On 21.02.20 16:51, Dr. David Alan Gilbert wrote:
> * David Hildenbrand (david@redhat.com) wrote:
>> On 19.02.20 17:17, David Hildenbrand wrote:
>>> In case we grow our RAM after ram_postcopy_incoming_init() (e.g., when
>>> synchronizing the RAM block state with the migration source), the resized
>>> part would not get discarded. Let's perform that when being notified
>>> about a resize while postcopy has been advised and the guest is not
>>> running yet.
>>>
>>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>> Cc: Juan Quintela <quintela@redhat.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  migration/ram.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 57f32011a3..cbd54947fb 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -3722,6 +3722,25 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
>>>          return;
>>>      }
>>>  
>>> +    /*
>>> +     * Especially at the start of precopy on the migration target, before
>>> +     * starting postcopy, we synchronize the RAM block sizes. Let's make sure
>>> +     * that any resizes before starting the guest are properly handled by
>>> +     * postcopy. Note: All other postcopy handling (e.g., registering handlers,
>>> +     * disabling THP) happens after all resizes (e.g., during precopy) were
>>> +     * performed.
>>> +     */
>>
>> I think it would be clearer to do a
>>
>> ps >= POSTCOPY_INCOMING_ADVISE && ps < POSTCOPY_INCOMING_RUNNING
>>
>> We really only want to do something when psotcopy has been advised but
>> the guest is not running yet.
>>
>> Will look into that as I find ways to actually test this :)
> 
> Should that be < POSTCOPY_INCOMING_LISTENING - i.e. before the
> userfaultfd has been enabled on the region?
> 

We can be even stricter. I have in my current patch:

diff --git a/migration/ram.c b/migration/ram.c
index 39c7d1c4a6..1ccb40970e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3714,6 +3714,7 @@ static SaveVMHandlers savevm_ram_handlers = {
 static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
                                       size_t old_size, size_t new_size)
 {
+    PostcopyState ps = postcopy_state_get();
     ram_addr_t offset;
     Error *err = NULL;
     RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
@@ -3734,6 +3735,34 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
         error_free(err);
         migration_cancel();
     }
+
+    switch (ps) {
+    case POSTCOPY_INCOMING_ADVISE:
+        /*
+         * Update what ram_postcopy_incoming_init()->init_range() does at the
+         * time postcopy was advised. Syncing RAM blocks with the source will
+         * result in RAM resizes.
+         */
+        if (old_size < new_size) {
+            if (ram_discard_range(rb->idstr, old_size, new_size - old_size)) {
+                error_report("RAM block '%s' discard of resized RAM failed",
+                             rb->idstr);
+            }
+        }
+        break;
+    case POSTCOPY_INCOMING_NONE:
+    case POSTCOPY_INCOMING_RUNNING:
+    case POSTCOPY_INCOMING_END:
+        /*
+         * Once our guest is running, postcopy does no longer care about
+         * resizes. When growing, the new memory was not available on the
+         * source, no handler needed.
+         */
+        break;
+    default:
+        error_report("Unexpected RAM resize during postcopy state: %d", ps);
+        exit(-1);
+    }
 }



-- 
Thanks,

David / dhildenb


