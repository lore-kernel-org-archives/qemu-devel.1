Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BDBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687AE206A4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZLh5+Jde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687AE206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3QX-0004l2-75
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb3Pa-00045H-O8; Fri, 06 Nov 2020 10:12:22 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:49764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb3PX-0003fe-VH; Fri, 06 Nov 2020 10:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Xxe/W/hJGjgOHoseywTrVEeToYd68vQbUL8G5FWHZJo=; 
 b=ZLh5+JdeadTrKB8UnC4LpUUL3XFBVxa6G6CyXnyIhXpj0EHhy9ixuvEgxt5kYEmoEcc7+s1rZHLK0lH3V1bsSG2hM3e7982rawXbuonfOaN9o4buS1PC8Btqp8SfW9FJ95UyHTJ49AyqFJR7n3Ox3nEBmSIznIYwGCFs/3zTtDcuvds0U9sxdg1lfubUEpayQj9kTW4LlCQWpUtCXmCB5c92ZK5/lgK/8gWnsnaBLhnBNS7NznzUPMswLgSHKBbTk+G5A9hcK+5zFy0eqtElxH0d0NpKk6V9FlpMk198JO74cU23bombKFBcWetqgq3tx66+ATj/0aunLUgER/RRFQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kb3PS-0002NO-MC; Fri, 06 Nov 2020 16:12:14 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1kb3PS-0000CM-Cu; Fri, 06 Nov 2020 16:12:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 3/7] block: make bdrv_drop_intermediate() less wrong
In-Reply-To: <20201106124241.16950-4-vsementsov@virtuozzo.com>
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
 <20201106124241.16950-4-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 06 Nov 2020 16:12:14 +0100
Message-ID: <w51361ma59t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 10:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 06 Nov 2020 01:42:37 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> First, permission update loop tries to do iterations transactionally,
> but the whole update is not transactional: nobody roll-back successful
> loop iterations when some iteration fails.
>
> Second, in the iteration we have nested permission update:
> c->klass->update_filename may point to bdrv_child_cb_update_filename()
> which calls bdrv_backing_update_filename(), which may do node reopen to
> RW.
>
> Permission update system is not prepared to nested updates, at least it
> has intermediate permission-update state stored in BdrvChild
> structures: has_backup_perm, backup_perm and backup_shared_perm.
>
> So, let's first do bdrv_replace_node_common() (which is more
> transactional than open-coded update in bdrv_drop_intermediate()) and
> then call update_filename() in separate. We still do not rollback
> changes in case of update_filename() failure but it's not much worse
> than pre-patch behavior.
>
> Note that bdrv_replace_node_common() does check for frozen children,
> so corresponding check is dropped in bdrv_drop_intermediate().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

