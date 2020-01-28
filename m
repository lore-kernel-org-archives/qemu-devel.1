Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F994C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E3A24681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+tZehiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E3A24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTjb-0007jK-7t
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iwTif-0006vf-4H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iwTid-0002lU-Qk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:28:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iwTid-0002kz-Mn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580228882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odW+lJDZ2Lmz7BsIl51gbc4/c2wH2TyvgUXdFuUpFw4=;
 b=F+tZehiF0sOF0Dn5LRSfNSO7sE0QEW8yHdET0s5a2tn4zcx4lZKF7FrM6PxiLjCdTJB3gp
 A3pqTClfO15p5Tg7rp0x9dyiNAn1Wv+lAuyVmVc+g+A2JIdVDOuaekCq+EX/ZVb9uVBQfK
 lATxdheDt45akbdYwphaGkvuqH2OhKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-QxAxctJxPbaSRYz0R4NUVw-1; Tue, 28 Jan 2020 11:28:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EF68C30E8;
 Tue, 28 Jan 2020 16:27:59 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8795C7C35A;
 Tue, 28 Jan 2020 16:27:56 +0000 (UTC)
Subject: Re: [PATCH 2/2] mirror: Don't let an operation wait for itself
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200128151755.25162-1-kwolf@redhat.com>
 <20200128151755.25162-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <72ac830e-b8de-8c9e-4e80-b9af2bbfb9a0@redhat.com>
Date: Tue, 28 Jan 2020 10:27:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128151755.25162-3-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QxAxctJxPbaSRYz0R4NUVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

On 1/28/20 9:17 AM, Kevin Wolf wrote:
> mirror_wait_for_free_in_flight_slot() just picks a random operation to
> wait for. However, when mirror_co_read() waits for free slots, its
> MirrorOp is already in s->ops_in_flight, so if not enough slots are
> immediately available, an operation can end up waiting for itself to
> complete, which results in a hang.

Eww. That can't have been fun to debug.

> 
> Fix this by passing the current MirrorOp and skipping this operation
> when picking an operation to wait for.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1794692
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/mirror.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 8959e4255f..cacbc70014 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -283,11 +283,14 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
>   }
>   
>   static inline void coroutine_fn
> -mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
> +mirror_wait_for_any_operation(MirrorBlockJob *s, MirrorOp *self, bool active)
>   {
>       MirrorOp *op;
>   
>       QTAILQ_FOREACH(op, &s->ops_in_flight, next) {
> +        if (self == op) {
> +            continue;
> +        }

But this is the obvious fix.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


