Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE99C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D18E20777
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPWmUNus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D18E20777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHA0H-0002VG-JT
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jH9zg-0001z8-5A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jH9ze-00087k-Mr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:39:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58915)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jH9zd-00086T-BH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585157944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxQ6MLYgpbx4fAf7XY21rdhODaUus0m/c6cuLlhbbsw=;
 b=WPWmUNus0/XL4c6xa7ZIZM+LwEQlPoR8XDPT6ULSYFrsu4vLjotoS+PKmzIBHg5OBTKy3z
 pzXuXMSiShickzwIQrUKiTDRNqctUZjYibPgeTsREdLpfpu0zG/9yVSJZpm8cQKCzA5Btk
 GqpMeL8EP1oAkygmg2xixipqJ22w3yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-Yo3aBpIQPRGX7UDr3BOBww-1; Wed, 25 Mar 2020 13:39:03 -0400
X-MC-Unique: Yo3aBpIQPRGX7UDr3BOBww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B90E8017CE;
 Wed, 25 Mar 2020 17:39:02 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7E3210002A9;
 Wed, 25 Mar 2020 17:39:01 +0000 (UTC)
Subject: Re: [PATCH 2/2] mirror: Wait only for in-flight operations
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200325172326.22347-1-kwolf@redhat.com>
 <20200325172326.22347-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <927a1047-493e-6ca0-1dac-aab57d6ebd41@redhat.com>
Date: Wed, 25 Mar 2020 12:39:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325172326.22347-3-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 12:23 PM, Kevin Wolf wrote:
> mirror_wait_for_free_in_flight_slot() just picks a random operation to
> wait for. However, a MirrorOp is already in s->ops_in_flight when
> mirror_co_read() waits for free slots, so if not enough slots are
> immediately available, an operation can end up waiting for itself, or
> two or more operations can wait for each other to complete, which
> results in a hang.
> 
> Fix this by adding a flag to MirrorOp that tells us if the request is
> already in flight (and therefore occupies slots that it will later
> free), and picking only such operations for waiting.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1794692
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/mirror.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 393131b135..7fef52ded2 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -102,6 +102,7 @@ struct MirrorOp {
>   
>       bool is_pseudo_op;
>       bool is_active_write;
> +    bool is_in_flight;
>       CoQueue waiting_requests;
>       Coroutine *co;
>   
> @@ -293,7 +294,9 @@ mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
>            * caller of this function.  Since there is only one pseudo op
>            * at any given time, we will always find some real operation
>            * to wait on. */
> -        if (!op->is_pseudo_op && op->is_active_write == active) {
> +        if (!op->is_pseudo_op && op->is_in_flight &&
> +            op->is_active_write == active)
> +        {
>               qemu_co_queue_wait(&op->waiting_requests, NULL);

Looks like a one-way transition - op->is_in_flight always starts as 
false, and only ever gets set to true (once the op is finished, op is no 
longer needed).  And being more selective on what you wait for here does 
look like it should work in more cases than what patch 1 reverted.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


