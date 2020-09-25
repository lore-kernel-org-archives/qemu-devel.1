Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2255BC47420
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A602D206FC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGtfGreo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A602D206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLuQk-0003Dg-K4
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLuP1-0001YT-6u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLuOz-0004jY-Dy
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:33:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601065988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DiOISlUzz1DBdB0gdF6ULC0W1Qa1Ugpes4SyPgSL19M=;
 b=VGtfGreoqbqDt71TxSmlEnzHRhIXlgtaQZDUiTRupCaP+NRLLIZ2SXa6HXDgY/7m3szBTA
 qagOKB8XoLMMf+C6BrkpVxuF4w9ukrZdfEL3VQKmxDGb3iwICuGwFmhZBNzbfAPCflzmS4
 RBiaOh/hxESXvFA80j9VHfOSxLEV0VM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-QJicQSE0MaOOJ8X-kehXhw-1; Fri, 25 Sep 2020 16:32:51 -0400
X-MC-Unique: QJicQSE0MaOOJ8X-kehXhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73FCE10066FE;
 Fri, 25 Sep 2020 20:32:50 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD83B5C1BB;
 Fri, 25 Sep 2020 20:32:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Exposing backing-chain allocation over NBD
Date: Fri, 25 Sep 2020 15:32:46 -0500
Message-Id: <20200925203249.155705-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: pkrempa@redhat.com, vsementsov@virtuozzo.com, rjones@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm working on preparing my KVM Forum presentation on NBD, and ran
into a situation where I really wanted to do the equivalent of
'qemu-img map' over NBD for determining which portions of an overlay
image are changed from the backing layer.  So after less than 24 hours
hacking, I'm pretty pleased with the results.

Known caveats:

- Probably has lots of conflicts with Kevin's pending work on
  refactoring NBD for nicer use in qemu-storage-daemon

- Not yet tested with Vladimir's patches to fix bdrv_block_status bugs
  when the backing file is short (and therefore, applying this series
  without that is likely to make it possible to expose the same bugs
  of wrong information)

- I _still_ want to get QMP 'block-dirty-bitmap-populate' in qemu 5.2;
  with that in place, you could avoid the need for this series by
  instead populating a temporary bitmap and exposing that bitmap over
  NBD instead.  But that requires more work, both in coding (Peter
  Krempa and I still need to make sure we have the ideal QMP
  interface) and in usage (managing temporary bitmaps is more effort
  than a new bool toggle).

- And if we _did_ use block-dirty-bitmap-populate, I find myself
  wanting to be able to expose more than one bitmap at a time over
  NBD, which in turn means revisiting our current QAPI for
  nbd-server-add of '*bitmap':'str' to instead allow an alternate type
  that permits either "'str'" or "['str']", except that our QAPI
  generator does not yet support arrays in alternates, and is
  undergoing changes from John Snow for python cleanups...

- I am aware of long-standing qemu bugs where when we advertise a
  large minimum block size (say 4k) but the backing file has smaller
  granularity (such as 512), then we can violate NBD protocol by
  sending a reply to NBD_CMD_BLOCK_STATUS with misaligned data.  This
  adds yet another instance of being able to tickle that (rare) bug.
  I really need to revisit my patches to add
  bdrv_block_status_aligned...

Also available at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/nbd-alloc-depth-v1

Eric Blake (3):
  nbd: Simplify meta-context parsing
  nbd: Add new qemu:allocation-depth metacontext
  nbd: Add 'qemu-nbd -A' to expose allocation depth

 docs/interop/nbd.txt       |  22 ++-
 docs/tools/qemu-nbd.rst    |   6 +
 qapi/block-core.json       |  13 +-
 include/block/nbd.h        |  15 +-
 blockdev-nbd.c             |   3 +-
 nbd/server.c               | 294 ++++++++++++++++++++-----------------
 qemu-nbd.c                 |  16 +-
 tests/qemu-iotests/309     |  73 +++++++++
 tests/qemu-iotests/309.out |  22 +++
 tests/qemu-iotests/group   |   1 +
 10 files changed, 310 insertions(+), 155 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

-- 
2.28.0


