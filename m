Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1987CC47247
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD00420659
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Xg19i3y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD00420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWint-0000Al-22
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWinF-00088d-S1; Thu, 07 May 2020 11:50:37 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWinC-0002yl-L7; Thu, 07 May 2020 11:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Zj2F1XoVheMGa4Sm50Jol9OJtUOeEulaakXnSbsUT4E=; 
 b=Xg19i3y4rwfhuMYHJTjS7gSSLTNgckZf9mZmACPe+XtOTBJwD+NaFt5wEMNmEIG/MPjL32jyGLkduhOzCQ4QljnOjIsZBd0/rlzVh0CR9FkMzCIchYUVt+mY/avyM975sasWGBexnBdyZLmFsk97iafBoZbQjYK5p1ybDEjckr8wyLDSxivgq3Tyc5EH+spa1sD4ml+vYNANrvIaV9kO9rq3Qi0szEY0EHn48sVpJyyrqe0wBu2QW/uHPIdPTTAvQuLU5l8WkoWdLITxB2Gf6T29dhK4wssbQzd33q7TX8OzJpYKB6P2XYklcn7PEUxnQUaV5PFdGdpAXC+r7zEuwg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jWin9-0001iA-8Y; Thu, 07 May 2020 17:50:31 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jWin8-0000gg-VK; Thu, 07 May 2020 17:50:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 19/31] qcow2: Add subcluster support to
 calculate_l2_meta()
In-Reply-To: <w51a72jn4hx.fsf@maestria.local.igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
 <907ab6846b93b441a27eb6853ff3058f1c821bf9.1588699789.git.berto@igalia.com>
 <12569151-2f16-f136-6928-2a915b25120b@redhat.com>
 <w517dxp9ea6.fsf@maestria.local.igalia.com>
 <9478ac11-8cae-4576-345e-3acf9e287119@redhat.com>
 <w51a72jn4hx.fsf@maestria.local.igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 07 May 2020 17:50:30 +0200
Message-ID: <w517dxnn3qx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 10:37:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 07 May 2020 05:34:18 PM CEST, Alberto Garcia wrote:
> On Wed 06 May 2020 07:39:48 PM CEST, Eric Blake wrote:
>>   In fact, if we rely on 20/31 checking for invalid subclusters when
>> computing nb_clusters, we could probably assert that the start and end
>> cluster in this function are not invalid, instead of adding the fail:
>> label.
>
> I think you're right with that, good catch! There's no need to return an
> error code in this function.

No, wait, I got confused. 

Patch 20/31 updates qcow2_get_host_offset(), and that's used for
reading.

The caller of calculate_l2_meta() is qcow2_alloc_cluster_offset()
(indirectly), which is used for writing.

nb_clusters here is calculated with cluster_needs_new_alloc(), but that
doesn't check whether a cluster is valid or not, and certainly doesn't
check if every single subcluster is valid.

Thinking about it, there are probably faster ways to check for the
validity of extended L2 entries, for example:

- For QCOW2_CLUSTER_NORMAL, (l2_bitmap >> 32) & l2_bitmap should be 0.

- For QCOW2_CLUSTER_UNALLOCATED, l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC
  should be 0.

That's enough to cover all cases of QCOW2_SUBCLUSTER_INVALID that we
have at the moment.

Berto

