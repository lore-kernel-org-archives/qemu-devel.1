Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0902C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D43F24670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fku1qLtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D43F24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHAV-0003Jq-5c
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idG0b-0000Oj-Qj
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idG0W-0005H5-2y
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:59:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idG0S-00057h-7z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575647936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOpI2RlIFhR2XUOa01CmZcH5f4Zty2y2A1iWYE+DNZc=;
 b=fku1qLtKmBgih6L25SpJcrLlXpqyfex9ujub0iPfZ/TF0O304SdhcWnQXqPTglg5lqDCOX
 CHElYkZM076bw4T/3HjJGnbOJS+s8EQtpyjSVXgfPUZHpcNajeX8tx61+VHPfSq/PtlWFQ
 qW8B4T/5v3CAYWbN8QDUMAJ6SjumsKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-sssd528sMdOpuq_N8QFH0g-1; Fri, 06 Dec 2019 10:58:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22BD18C8ACD;
 Fri,  6 Dec 2019 15:58:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2EDD785C1;
 Fri,  6 Dec 2019 15:58:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1B2E1138606; Fri,  6 Dec 2019 16:58:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v8 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-22-vsementsov@virtuozzo.com>
 <54278946-ad45-1a0d-e2b2-f96b86285c05@redhat.com>
Date: Fri, 06 Dec 2019 16:58:50 +0100
In-Reply-To: <54278946-ad45-1a0d-e2b2-f96b86285c05@redhat.com> (Eric Blake's
 message of "Thu, 5 Dec 2019 11:51:41 -0600")
Message-ID: <8736dxcuo5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sssd528sMdOpuq_N8QFH0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 12/5/19 11:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The local_err parameter is not here to return information about
>> nbd_iter_channel_error failure. Instead it's assumed to be filled when
>> passed to the function. This is already stressed by its name
>> (local_err, instead of classic errp). Stress it additionally by
>> assertion.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd.c | 1 +
>>   1 file changed, 1 insertion(+)
>
> Our timing resulted in crossed mails - I was replying to v7 when this
> landed, and my reply there is still relevant (namely, a better commit
> message is needed, but the code gets my R-b with that change).

If v8 turns out to be fine except for commit message tweaks, I'll gladly
to these in my tree.  Just tell me what to do in a reply to this
message.


