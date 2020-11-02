Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD049C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBB4222B9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL+g1S38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBB4222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWPY-00041v-6i
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOC-0002Ob-Pz
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOA-000569-Sb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604310273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8NLEifIg/xmTSr7dA5d9yd3Q1q/qXWeb6A4gQ2SueG8=;
 b=CL+g1S38y4bVInvUKDwpxSxCzRno3Vx+F479kLk3K3KyDKXdprwJU1g2tQvNdJUthmaZLS
 ZoD+wM9mdmGj+pUH8EBcfRdCqfbPaBgUU4IbzBh9okzDtxVzZ6txI7GFyleO156SNVtUdR
 FUa30VqeyBdyNCFETWRD+RdZIW64XJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-p-FQr_ZlPQyjTxLXYc46gw-1; Mon, 02 Nov 2020 04:44:31 -0500
X-MC-Unique: p-FQr_ZlPQyjTxLXYc46gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 519D657205;
 Mon,  2 Nov 2020 09:44:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6251555761;
 Mon,  2 Nov 2020 09:44:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCCF41132BD6; Mon,  2 Nov 2020 10:44:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/11] sockets: Attempt to drain the abstract socket swamp
Date: Mon,  2 Nov 2020 10:44:11 +0100
Message-Id: <20201102094422.173975-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my opinion, the Linux-specific abstract UNIX domain socket feature
introduced in 5.1 should have been rejected.  The feature is niche,
the interface clumsy, the implementation buggy and incomplete, and the
test coverage insufficient.  Review fail.

Fixing the parts we can still fix now is regrettably expensive.  If I
had the power to decide, I'd unceremoniously revert the feature,
compatibility to 5.1 be damned.  But I don't, so here we go.

I'm not sure this set of fixes is complete.  However, I already spent
too much time on this, so out it goes.  Lightly tested.

For additional information, see

    Subject: Our abstract UNIX domain socket support is a mess
    Date: Wed, 28 Oct 2020 13:41:06 +0100
    Message-ID: <87o8kmwmjh.fsf@dusky.pond.sub.org>

v2:
* PATCH 03: Have unix_server_thread_func(), unix_client_thread_func()
  store their parameter in a variable in the hope of communicating its
  type more clearly [Daniel].  No lasting effect, as the former goes
  away in PATCH 5, and the latter is rewritten in PATCH 6.
* PATCH 05: Fix commit message typo [Eric]
* PATCH 07: Improve commit message [Paolo]
* PATCH 08: Fix computation of @tight [Paolo, Eric], and copying of
  @sun_path [Eric]
* PATCH 11: Tweak QAPI schema [Eric], less ugly ifdeffery [Eric],
  fix logic error in use of new saddr_is_tight().

Markus Armbruster (11):
  test-util-sockets: Plug file descriptor leak
  test-util-sockets: Correct to set has_abstract, has_tight
  test-util-sockets: Clean up SocketAddress construction
  test-util-sockets: Factor out test_socket_unix_abstract_one()
  test-util-sockets: Synchronize properly, don't sleep(1)
  test-util-sockets: Test the complete abstract socket matrix
  sockets: Fix default of UnixSocketAddress member @tight
  sockets: Fix socket_sockaddr_to_address_unix() for abstract sockets
  char-socket: Fix qemu_chr_socket_address() for abstract sockets
  sockets: Bypass "replace empty @path" for abstract unix sockets
  sockets: Make abstract UnixSocketAddress depend on CONFIG_LINUX

 qapi/sockets.json         |  14 ++--
 chardev/char-socket.c     |  24 +++++-
 chardev/char.c            |   2 +
 tests/test-util-sockets.c | 155 ++++++++++++++++++++------------------
 util/qemu-sockets.c       |  54 ++++++++++---
 5 files changed, 157 insertions(+), 92 deletions(-)

-- 
2.26.2


