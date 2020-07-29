Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A737720656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmiGRpPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A737720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uMa-0005Kx-VZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLV-0003f4-SK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k0uLS-0001BA-IP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596060881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Le4eBw++mBce6PdqacORWJjfRL2BAd88wGHNh6vw6Fw=;
 b=FmiGRpPBWtPkppaPbX/qhXcQ0kAz95Y4azHI20a40WE74yny18HIIkVJ5ottBVklLxMA+N
 LgpXxCMrOs7zDQFIVHo3b+f5PifT0K271uaNdzbS7k3c1WEL31mHJjG9E2egHp7F9KQ527
 MVBu+S7TJUrDHPUjfGKl8ttNIGoxQDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-8HK6I55SMFS27ukpBz4eiA-1; Wed, 29 Jul 2020 18:14:39 -0400
X-MC-Unique: 8HK6I55SMFS27ukpBz4eiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C63BB1083E80
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 22:14:38 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-149.rdu2.redhat.com [10.10.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3326019C71;
 Wed, 29 Jul 2020 22:14:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id B89B22237A7; Wed, 29 Jul 2020 18:14:31 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/5] virtiofsd: Add notion of unprivileged mode
Date: Wed, 29 Jul 2020 18:14:05 -0400
Message-Id: <20200729221410.147556-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:17:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, vromanso@redhat.com, dgilbert@redhat.com,
 virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Daniel Berrange mentioned that having a unpriviliged mode in virtiofsd 
might be useful for certain use cases. Hence I decided to give it
a try.

This is RFC patch series to allow running virtiofsd as unpriviliged
user. This is still work in progress. I am posting it to get
some early feedback.

These patches are dependent on Stefan's patch series for sandbox=chroot.

https://www.redhat.com/archives/virtio-fs/2020-July/msg00078.html

I can now run virtiofsd as user "test" and also export a directory
into a VM running as user test.

This is ideally for the cases where user "test" inside VM will operate
on this virtiofs mount point. Any filesystem operations which can't
be done with the creds of "test" user on host, will fail.

Thanks
Vivek

Vivek Goyal (5):
  virtiofsd: Add notion of unprivileged mode
  virtiofsd: create lock/pid file in per user cache dir
  virtiofsd: open /proc/self/fd/ in sandbox=NONE mode
  virtiofsd: Open lo->source while setting up root in sandbox=NONE mode
  virtiofsd: Skip setup_capabilities() in sandbox=NONE mode

 tools/virtiofsd/fuse_virtio.c    | 40 ++++++++++++++++++++++++++++----
 tools/virtiofsd/passthrough_ll.c | 29 ++++++++++++++++++++---
 2 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.25.4


