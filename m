Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A102C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23A5205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23A5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQqD-0006mX-Kr
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnQq2-0006JZ-E2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnQq1-0007M1-EG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnQpz-0007Iz-4P; Tue, 16 Jul 2019 13:01:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7663DC034DF3;
 Tue, 16 Jul 2019 17:01:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-24.ams2.redhat.com [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 947201001B04;
 Tue, 16 Jul 2019 17:01:57 +0000 (UTC)
Date: Tue, 16 Jul 2019 19:01:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190716170156.GJ7297@linux.fritz.box>
References: <20190703172813.6868-1-mreitz@redhat.com>
 <20190703172813.6868-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703172813.6868-7-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 16 Jul 2019 17:01:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/12] block: Deep-clear inherits_from
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.07.2019 um 19:28 hat Max Reitz geschrieben:
> BDS.inherits_from does not always point to an immediate parent node.
> When launching a block job with a filter node, for example, the node
> directly below the filter will not point to the filter, but keep its old
> pointee (above the filter).
> 
> If that pointee goes away while the job is still running, the node's
> inherits_from will not be updated and thus point to garbage.  To fix
> this, bdrv_unref_child() has to check not only the parent node's
> immediate children for nodes whose inherits_from needs to be cleared,
> but its whole subtree.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Isn't the real bug that we keep pointing to a node that isn't a parent
of the node any more? I think this will effectively disable option
inheritance in bdrv_reopen() as long as the filter node is present,
which is certainly not what we intended.

The intuitive thing would be that after inserting a filter, the image
now inherits from the filter node, and when the filter is removed, it
inherits from the filter's bs->inherit_from if that becomes a parent of
the node. (Though I'm not necessarily saying that my intuition is to be
trusted here.)

Kevin

