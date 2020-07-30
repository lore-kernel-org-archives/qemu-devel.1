Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EC4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F5320838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZWBl2Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F5320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1EXq-0002x8-T0
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k1EX4-0001jo-3A
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:48:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1k1EX1-0006kg-Fe
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596138478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aFWJpzGhsDniDBHu+uzRvAR9IX+8RUIXlBDYugJOvvs=;
 b=HZWBl2UtAzFr1EZHmwzJZ2M/zURe6SwWakZkKhXaBhsYSAcZ/yIIeFW+52oY40Y6Cn35gF
 qANJCJUhBpkNb4sHHnPTepOwUl5+RbwttK3KLUgBqJiQrYe9c6s1YEw+u09q3PCsb2+bOl
 Bi/jESw+RpzNaJ7zgcjjMrD0GwSe8D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-voBe6tKWMH2n_yWASKRUdA-1; Thu, 30 Jul 2020 15:47:56 -0400
X-MC-Unique: voBe6tKWMH2n_yWASKRUdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84953801A03
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 19:47:55 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-166.rdu2.redhat.com [10.10.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E969287B03;
 Thu, 30 Jul 2020 19:47:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 515C32237A7; Thu, 30 Jul 2020 15:47:48 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] virtiofsd: Add a unprivileged passthrough mode
Date: Thu, 30 Jul 2020 15:47:31 -0400
Message-Id: <20200730194736.173994-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
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
Cc: berrange@redhat.com, vromanso@redhat.com, dwalsh@redhat.com,
 dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is V2 of patches. Only change since last version is handling of
lock/pid file creation as per the comments from Daniel Berrange.

I can't think of any more changes needed. As a unpriviliged user
inside VM I can do simple operations like create/remove/read/write
files.

For more testing, I probably need a testsuite which runs as unpriviliged
user. pjdfstests needs to run as root and this does not work in this
setup as creation of files as root fails. (On host, daemon tries to
switch to root uid and that fails).

So as of now, I think these are the minimum changes needed to support
unprivileged passthrough mode of virtiofsd.

Thanks
Vivek

Vivek Goyal (5):
  virtiofsd: Add notion of unprivileged mode
  virtiofsd: create lock/pid file in per user cache dir
  virtiofsd: open /proc/self/fd/ in sandbox=NONE mode
  virtiofsd: Open lo->source while setting up root in sandbox=NONE mode
  virtiofsd: Skip setup_capabilities() in sandbox=NONE mode

 tools/virtiofsd/fuse_virtio.c    | 15 ++++++++++++++-
 tools/virtiofsd/passthrough_ll.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.25.4


