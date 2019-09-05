Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C7C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98DD21848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nX2sTBU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98DD21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5qc4-0003pS-3C
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 08:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <66eeead73a86802bc9e8e09654f19f8ee53dfa7b@lizzy.crudebyte.com>)
 id 1i5qZS-0001vw-5v
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <66eeead73a86802bc9e8e09654f19f8ee53dfa7b@lizzy.crudebyte.com>)
 id 1i5qZQ-00067f-OU
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:09:01 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:52275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <66eeead73a86802bc9e8e09654f19f8ee53dfa7b@lizzy.crudebyte.com>)
 id 1i5qZL-0003XU-So
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=oyfydXHE0+mFGltuWzWVJiRsCNGqKKvhhn6mjetGZjI=; b=nX2sT
 BU5uzb7Ba/yuIv43KmsQODO9COpG8tytuLDaDoou8jxiyyoz/diTLWLrOOpNsfX+C7gmXCuzphYD1
 PhZ4ciVsL5Wroyh/oqjg+/AFoOQ6LwxYy+GR1SVYtbloeWnuhyuHzNY24s8nWNHUXpnocrLtwMpf9
 xv22hyJcuAX8wLde1ZYnz8J1AQ6q7vHgseJVh6U8y2FDMW6aNuP82IvmpSe+DUMUyEIBXDuy+Epmq
 kJ7xU7Jk9pHylikQkPy0qr+j6rIqZRT3TYc4RQMzXwI+kGfdoNuX5nZ7ibj5u2/1XckikeyZcQVuZ
 2nCGvT8AzAcZ0Gaj6g8ovQ6JsRg9A==;
Message-Id: <cover.1567680121.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Thu, 5 Sep 2019 12:42:01 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v7 of a proposed patch set for fixing file ID collisions with 9pfs.

v6->v7:

  * Rebased to https://github.com/gkurz/qemu/commits/9p-next
    (SHA1 7fc4c49e91).

  * Be pedantic and abort with error on wrong value for new command line
    argument 'multidevs'.

  * Adjusted patches to qemu code style guidelines.

  * Fixed potential crash in qp_table_destroy() on error path.

  * Use dedicated hash table init functions (qpd_table_init(),
    qpf_table_init(), qpp_table_init()):
    https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00144.html

  * Use warn_report_once() instead of error_report_once() for issues
    interpreted merely as being warnings, not errors.

  * Simplified hash table destruction (due to simplified error path
    introduced by SHA1 7fc4c49e91).

  * Dropped capturing root_ino for now:
    https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00146.html

  * Don't update proxy docs, since new command line argument 'multidevs' is
    limited to the local backend for now.

  * Mention in docs that readdir() is currently not blocked by
    'multidevs=forbid'.

  * Rename qid_path_prefixmap() -> qid_path_suffixmap() in patch 3
    (due to the semantic change of that function by that patch).

Christian Schoenebeck (3):
  9p: Added virtfs option 'multidevs=remap|forbid|warn'
  9p: stat_to_qid: implement slow path
  9p: Use variable length suffixes for inode remapping

 fsdev/file-op-9p.h      |   5 +
 fsdev/qemu-fsdev-opts.c |   7 +-
 fsdev/qemu-fsdev.c      |  17 ++
 hw/9pfs/9p.c            | 456 ++++++++++++++++++++++++++++++++++++++--
 hw/9pfs/9p.h            |  59 ++++++
 qemu-options.hx         |  26 ++-
 vl.c                    |   7 +-
 7 files changed, 552 insertions(+), 25 deletions(-)

-- 
2.20.1


