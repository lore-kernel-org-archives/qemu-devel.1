Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD9C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56CF2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix9j369C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56CF2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF1uF-0007eI-2H
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 16:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jF1tU-00079B-4M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jF1tS-0007Gt-3h
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:35:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38463)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jF1tR-00077P-98
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584650152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uPhlXn+ve+3FM5jp2ChiVgqmYZE4AlzB5UVncc/Kco=;
 b=ix9j369C8xxeZaWCCmbcvX3tPVfMgEkdQQJsh3yZmgRrsf0nBf8VrOLDbUUAWSAwwzE7i6
 KGAIg5EQI2hbcqj9jXxC0VJATO1w7Hu8QlOTOzG1wU2y2xxHIWGEQs+6RFi2xbL61LKXC2
 WH5Px9IERYOnEeOgxxqq/a2g15U0Vvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-XX6rTzV9MvWNXjyX1taL5Q-1; Thu, 19 Mar 2020 16:35:44 -0400
X-MC-Unique: XX6rTzV9MvWNXjyX1taL5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75039800D53;
 Thu, 19 Mar 2020 20:35:43 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19BBA1001B07;
 Thu, 19 Mar 2020 20:35:43 +0000 (UTC)
Subject: Re: [PATCH] misc: fix __COUNTER__ macro to be referenced properly
To: dnbrdsky@gmail.com, stefanha@gmail.com
References: <20200319161925.1818377-1-dnbrdsky@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <43c25451-f7f9-41ee-749f-1e73d5b46f9c@redhat.com>
Date: Thu, 19 Mar 2020 15:35:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319161925.1818377-1-dnbrdsky@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 11:19 AM, dnbrdsky@gmail.com wrote:
> From: danbrodsky <dnbrdsky@gmail.com>
> 
> - __COUNTER__ doesn't work with ## concat
> - replaced ## with glue() macro so __COUNTER__ is evaluated
> 
> Signed-off-by: danbrodsky <dnbrdsky@gmail.com>

Thanks - this appears to be your first contribution to qemu.

Typically, the S-o-b should match how you would spell your legal name, 
rather than being a single-word computer user name.

It looks like you threaded another message to this one:
Message-Id: <20200319161925.1818377-2-dnbrdsky@gmail.com>
Subject: [PATCH] lockable: replaced locks with lock guard macros where
  appropriate
but without a 0/2 cover letter, or even a 1/2 or 2/2 indicator on the 
individual patches.  This makes it more likely that the second patch may 
be overlooked by our CI tools.

Since this patch is fixing an issue that just went into the tree 
recently, it would be useful to add mention of that in the commit message:
Fixes: 3284c3ddc4

In fact, using 'lockable:' rather than 'misc:' as your subject prefix 
makes it more obvious that you are fixing an issue in the same area as 
where it was introduced.

More patch submission hints at https://wiki.qemu.org/Contribute/SubmitAPatch

> ---
>   include/qemu/lockable.h | 2 +-
>   include/qemu/rcu.h      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
> index 1aeb2cb1a6..a9258f2c2c 100644
> --- a/include/qemu/lockable.h
> +++ b/include/qemu/lockable.h
> @@ -170,7 +170,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockable_auto_unlock)
>    *   }
>    */
>   #define QEMU_LOCK_GUARD(x) \
> -    g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ = \
> +    g_autoptr(QemuLockable) glue(qemu_lockable_auto, __COUNTER__) = \

That said, the patch itself is correct.
Reviewed-by: Eric Blake <eblake@redhat.com>

I'll leave it up to the maintainer for this file whether they can 
improve your commit message (although the hardest part of that would be 
knowing a full proper name to use in place of your username), or if you 
will need to send a v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


