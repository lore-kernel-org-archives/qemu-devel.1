Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66118C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317D52084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MG4OSjNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317D52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3cf-0004ON-FE
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr3bx-0003wZ-Vz
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:07:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr3bv-0005wN-VB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593713218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfYHqJAZOT6eVg4OasYslhkmhaOwcE6CkZsCGWHsqIo=;
 b=MG4OSjNw8iRqBvpLTbUKDt00IOWzG86mMoi9HBo5QGW5sSf9gm0sa9bGxTExGa/ZO7NpXk
 rWnynAygPncrxjYYP55Hb5LcXicTpy+Z24ZZFFtoqc+0A6jKKD6zGBHTzY4T0ZoCcXFKOf
 MNnhaGWN/Z4R40nWjjXr+fgeRiVmuzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-mH66x2NLObm74jppuyiSzQ-1; Thu, 02 Jul 2020 14:06:57 -0400
X-MC-Unique: mH66x2NLObm74jppuyiSzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB8064AD6;
 Thu,  2 Jul 2020 18:06:55 +0000 (UTC)
Received: from [10.3.112.202] (ovpn-112-202.phx2.redhat.com [10.3.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E2BC77899;
 Thu,  2 Jul 2020 18:06:55 +0000 (UTC)
Subject: Re: [PATCH v2 35/44] error: Eliminate error_propagate() with
 Coccinelle, part 2
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-36-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cb3ec58e-8eb3-510b-92a3-71f6e19151bf@redhat.com>
Date: Thu, 2 Jul 2020 13:06:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702155000.3455325-36-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 10:49 AM, Markus Armbruster wrote:
> When all we do with an Error we receive into a local variable is
> propagating to somewhere else, we can just as well receive it there
> right away.  The previous commit did that with a Coccinelle script I
> consider fairly trustworthy.  This commit uses the same script with
> the matching of return taken out, i.e. we convert
> 
>      if (!foo(..., &err)) {
> 	...
> 	error_propagate(errp, err);
> 	...
>      }
> 
> to
> 
>      if (!foo(..., errp)) {
> 	...
> 	...
>      }
> 
> This is unsound: @err could still be read between afterwards.  I don't
> know how to express "no read of @err without an intervening write" in
> Coccinelle.  Instead, I manually double-checked for uses of @err.
> 
> Suboptimal line breaks tweaked manually.  qdev_realize() simplified
> further to placate scripts/checkpatch.pl.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block.c              |  6 ++----
>   block/blkdebug.c     |  7 ++-----
>   block/blklogwrites.c |  3 +--
>   block/blkverify.c    |  3 +--
>   block/crypto.c       |  4 +---
>   block/file-posix.c   |  6 ++----
>   block/file-win32.c   |  6 ++----
>   block/gluster.c      |  4 +---
>   block/iscsi.c        |  3 +--
>   block/nbd.c          |  8 ++------
>   block/qcow2.c        | 13 ++++---------
>   block/raw-format.c   |  4 +---
>   block/sheepdog.c     |  8 ++------
>   block/ssh.c          |  4 +---
>   block/throttle.c     |  4 +---
>   block/vmdk.c         |  4 +---
>   block/vpc.c          |  3 +--
>   block/vvfat.c        |  3 +--
>   blockdev.c           |  3 +--
>   hw/intc/xics.c       |  4 +---
>   hw/vfio/pci.c        |  3 +--
>   net/tap.c            |  3 +--
>   qom/object.c         |  4 +---
>   23 files changed, 32 insertions(+), 78 deletions(-)

Small enough to review each instance.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


