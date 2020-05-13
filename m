Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59D4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D346E204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEVdl2wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D346E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtte-0002by-L5
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYtpN-000474-QF
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:01:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYtpL-000135-SA
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589385706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xivfzXJ99mgYNkBxUJ7+vPdZ06ocwQgeW6OnuOvqOrM=;
 b=UEVdl2wqqgQsGPNs4Hg6SxLx6EA6jm5NU1mA27WXSKTlY8FUYDUKXnjuZ0bYifk1DturvR
 KEsOJO7oGwUzqCnD5HE1MWZbE57l3dc81BlzWd0nusI9T4MbldtgoYHOQi36L2ehv7GFG0
 3QDDrkX5EBraF9Ryc4GR8wWf4fJvHjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-tUWqrK1ZP1KYTwbr0d-w9w-1; Wed, 13 May 2020 12:01:16 -0400
X-MC-Unique: tUWqrK1ZP1KYTwbr0d-w9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDB94835B42;
 Wed, 13 May 2020 16:01:15 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3880B10013BD;
 Wed, 13 May 2020 16:01:15 +0000 (UTC)
Subject: Re: [RFC] migration: Add migrate-set-bitmap-node-mapping
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200513144941.1469447-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <133ba6c2-fdb2-f4aa-af6f-01800644757b@redhat.com>
Date: Wed, 13 May 2020 11:01:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513144941.1469447-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 9:49 AM, Max Reitz wrote:
> This command allows mapping block node names to aliases for the purpose
> of block dirty bitmap migration.
> 
> This way, management tools can use different node names on the source
> and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-rfc
> Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-rfc
> 
> Vladimir has proposed something like this in April:
> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00171.html
> 
> Now I’ve been asked by my manager to look at this, so I decided to just
> write a patch to see how it’d play out.
> 
> This is an RFC, because I’d like to tack on tests to the final version,
> but I’m not sure whether I can come up with something before the end of
> the week (and I’ll be on PTO for the next two weeks).
> 
> Also, I don’t know whether migration/block-dirty-bitmap.c is the best
> place to put qmp_migrate_set_bitmap_mapping(), but it appears we already
> have some QMP handlers in migration/, so I suppose it isn’t too bad.

My 'qemu-img bitmap' series has block/monitor/bitmap-qmp-cmds.c - 
perhaps that's a decent location?  Or maybe another new file in that 
directory, if putting it directly in an existing file would drag in too 
much into qemu-img?

> ---
>   qapi/migration.json            | 36 ++++++++++++++++++++
>   migration/block-dirty-bitmap.c | 60 ++++++++++++++++++++++++++++++++--
>   2 files changed, 94 insertions(+), 2 deletions(-)

But I see you've already posted a v2, so I'll stop reviewing here and 
switch to that thread.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


