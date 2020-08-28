Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DFFC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845EA2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqxSU2Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845EA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdmF-0000HF-JY
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl1-00077J-EB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdkx-0006CU-4q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598618721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SXMny/nbzQEhRusdSUh8O3Xzq4IAIsq7tveKYwcJ5Hk=;
 b=bqxSU2LhaaUm6f+WoF2SEw5cDkbwL7g6Stu/ZViv1wDgGcHQoty3Xn1mS1zr+LMA0Sarh2
 EF9+Zg5/oODS9C4PMB/Vt0HsU6rkgVYFXlVzjcxEJ9ZUN8aPRqpdvcPXRr5Myk6u1Zanny
 FNBRPFfEnyzeoz8/fJhs/CVkD9WUb9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-KkBuFUqkNBiBBLTzwlDYyQ-1; Fri, 28 Aug 2020 08:45:19 -0400
X-MC-Unique: KkBuFUqkNBiBBLTzwlDYyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6559480EF9E;
 Fri, 28 Aug 2020 12:45:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-100.ams2.redhat.com
 [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E796074E12;
 Fri, 28 Aug 2020 12:45:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 slp@redhat.com, yezhenyu2@huawei.com, longpeng2@huawei.com,
 berrange@redhat.com
Subject: [PULL 0/8] migration and virtiofsd queue
Date: Fri, 28 Aug 2020 13:45:01 +0100
Message-Id: <20200828124509.311210-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 3e39dac0354c39b4b647940e42360c6b1f3edc02:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-08-28 11:05:08 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200828a

for you to fetch changes up to fd9279ec9985d9c8a0b533eff24839f93695b0f4:

  virtiofsd: probe unshare(CLONE_FS) and print an error (2020-08-28 13:34:52 +0100)

----------------------------------------------------------------
Migration and virtiofsd pull 2020-08-28

Migration:
   vsock support for migration
   minor fixes

virtiofsd:
   Disable remote posix locks by default - because we
     never supported blocking variants and this breaks things
   Some prep work for un/less priviliged modes

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Daniel P. Berrangé (1):
      migration: improve error reporting of block driver state name

Longpeng (Mike) (2):
      migration: unify the framework of socket-type channel
      migration: add vsock as data channel support

Sergio Lopez (1):
      virtiofsd: Remove "norace" from cmdline help and docs

Stefan Hajnoczi (2):
      virtiofsd: drop CAP_DAC_READ_SEARCH
      virtiofsd: probe unshare(CLONE_FS) and print an error

Vivek Goyal (1):
      virtiofsd: Disable remote posix locks by default

Zhenyu Ye (1):
      migration: tls: fix memory leak in migration_tls_get_creds

 docs/tools/virtiofsd.rst         |  5 +--
 migration/migration.c            | 20 +++++------
 migration/savevm.c               | 12 +++----
 migration/socket.c               | 72 +++++++++-------------------------------
 migration/socket.h               | 11 ++----
 migration/tls.c                  |  1 -
 tests/qemu-iotests/267.out       |  4 +--
 tools/virtiofsd/fuse_virtio.c    | 16 +++++++++
 tools/virtiofsd/helper.c         |  2 --
 tools/virtiofsd/passthrough_ll.c |  3 +-
 10 files changed, 54 insertions(+), 92 deletions(-)


