Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E74C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F91C2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1jBQoRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F91C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iItpt-0007Jl-P8
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1iItp6-0006q4-A9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1iItp5-000843-9R
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:15:08 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1iItp2-00082x-Jz; Fri, 11 Oct 2019 08:15:04 -0400
Received: by mail-ed1-x541.google.com with SMTP id y91so8468022ede.9;
 Fri, 11 Oct 2019 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1jvUSFGJn6ZlcuFaX2ZG2KrRC7f4GeFGq/rStR/ruD0=;
 b=J1jBQoRlNvvBaZFCpiFJVZoFpJXUvP+1VELomhCqzAcqqv8D+EIl6vc93ywaRIyUBe
 fQdLLWqFxoto4b7x4U0gBzhEzZ1XJkAaU0RP8P+qUdklrNw7FrfZSRQG3/U8+2uhYlIx
 Nr05TK2C+0qRiT4bj1yFIuruAzYY4lYOz1EIkwkpKqZeFkTh13sZo121O0fk9kHK07NX
 7LcKvGZMr5CYcqf0pjdhfCSNgGa+gAI/yqPcu7H+vnA7WoxxNRKDqZoeN+3BVGKv8OhX
 JKJERzbQ/G4IaIq2h8E54A7i5h/OV/St/bqXhpjAp8ahB+J/cl+Z4H6NrZQxrTSoht9a
 WY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=1jvUSFGJn6ZlcuFaX2ZG2KrRC7f4GeFGq/rStR/ruD0=;
 b=AQec2Ftwk6kTbKS0idza57FTkDd7+EI4uloYTQKRGz/qV9jA4Q9i7LH3RpxxE9uJsE
 lvFe/KMbm6AFajQOe3W9Mh4zMBsebk/jgXs/RHIxhvzFKbUqmZ+/rKtKn38xBPKuRc50
 35fkg0+BNkLNY0CSAOfyDRJPuPrM9SkZvQ6cb/DjSqzuNJT5UrbLJ577K4SqNeIcILJp
 Jj27huLVNnkKTOX03B3Jcfc3zhvSvcWRH7x6cGlqpd/bxRVZHP5hNGQltRYcwbWP8owj
 WYCECr9M9HaVfU0yArkmi/8lgl83qWk//dGu3LyVkiK0kKCw5GXTm92PMZIfECPrfqik
 Hoyw==
X-Gm-Message-State: APjAAAXTQjhs2bzVOuNNQypxFTLnyIkZfAyciRvPofJptIMjQqrZn4eU
 38HgCyiHelaYCdoqmjH96Z8=
X-Google-Smtp-Source: APXvYqwGJxhYziHoSjBKTqQ7Bcx4kpq23eAm6iXcPKzUKh07EYrJL0r+GsE31TIKEDXk5NxUfSZw6g==
X-Received: by 2002:a50:f744:: with SMTP id j4mr5750007edn.73.1570796102649;
 Fri, 11 Oct 2019 05:15:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id n12sm1411057edi.1.2019.10.11.05.15.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Oct 2019 05:15:01 -0700 (PDT)
Date: Fri, 11 Oct 2019 12:15:01 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PULL 5/5] multifd: Use number of channels as listen backlog
Message-ID: <20191011121501.d7bkbrl36kkgntot@master>
References: <20190904062915.6488-1-quintela@redhat.com>
 <20190904062915.6488-6-quintela@redhat.com>
 <20191011083745.GA17297@richard> <87zhi7va4c.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhi7va4c.fsf@trasno.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrang??" <berrange@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Wei Yang <richardw.yang@linux.intel.com>,
 Marc-Andr?? Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 12:40:03PM +0200, Juan Quintela wrote:
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>> On Wed, Sep 04, 2019 at 08:29:15AM +0200, Juan Quintela wrote:
>>>Reviewed-by: Daniel P. Berrang?? <berrange@redhat.com>
>>>Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>---
>>> migration/socket.c | 7 ++++++-
>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/migration/socket.c b/migration/socket.c
>>>index e63f5e1612..97c9efde59 100644
>>>--- a/migration/socket.c
>>>+++ b/migration/socket.c
>>>@@ -178,10 +178,15 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
>>> {
>>>     QIONetListener *listener = qio_net_listener_new();
>>>     size_t i;
>>>+    int num = 1;
>>> 
>>>     qio_net_listener_set_name(listener, "migration-socket-listener");
>>> 
>>>-    if (qio_net_listener_open_sync(listener, saddr, 1, errp) < 0) {
>>>+    if (migrate_use_multifd()) {
>>>+        num = migrate_multifd_channels();
>>>+    }
>>>+
>>>+    if (qio_net_listener_open_sync(listener, saddr, num, errp) < 0) {
>>>         object_unref(OBJECT(listener));
>>>         return;
>>>     }
>>
>> My confusion is this function is called at the beginning of the program, which
>> means we didn't set multifd on or change the multifd channel parameter.
>>
>> They are the default value at this point.
>>
>> Am I right?
>
>Hi
>
>good catch!
>
>You are right.  The fix worked for me because I always use on the
>command line:
>
>--global migration.multifd-channels=10
>
>or whatever number I want to avoid typing.  I can only see two
>solutions:
>- increase the number always

You mean change default value? Then which one should we choose?

>- require "defer" when using multifd to be able to setup parameters.
>
>Any other good ideas?

Would you mind explaining more about "defer"? How this works?

>
>Thanks, Juan.
>
>PD.  I was having problem reproducing this issue because I use the
>command line for the parameter.

-- 
Wei Yang
Help you, Help me

