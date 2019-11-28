Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12391C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2BB21771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6yOl1Xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2BB21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLbI-0002OZ-0t
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iaKa2-0003WM-Rn
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iaKZx-00087R-RB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:15:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iaKZx-00080X-Fr
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574950532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=puC+z5moYUYh7PWMjjaV25+AlBlMja4kgHyGd2FvV3o=;
 b=c6yOl1Xvm3G6sQn8f6H0mYxyUmWHjK0LxZ7LvHRS9AbRjaOvIUDyvScCaEdZApn0Zxk48P
 MSaUGMHCn7+1aZoxbCMwsOhuZRMUrAvvOF5HGmwFMaMH8RhA1cgQ2K6OVZbzXqj4dHmg8e
 Tw/If4G0B+rZnt5K5TYKYkb98myT8FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-X-F4WMyIO56wB_o_9tE24w-1; Thu, 28 Nov 2019 09:15:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E548DB3D;
 Thu, 28 Nov 2019 14:15:29 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 558A3608B9;
 Thu, 28 Nov 2019 14:15:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] RFC: add -mem-shared option
Date: Thu, 28 Nov 2019 18:15:16 +0400
Message-Id: <20191128141518.628245-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: X-F4WMyIO56wB_o_9tE24w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Setting up shared memory for vhost-user is a bit complicated from
command line, as it requires NUMA setup such as: m 4G -object
memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -numa
node,memdev=3Dmem.

Instead, I suggest to add a -mem-shared option for non-numa setups,
that will make the -mem-path or anonymouse memory shareable.

Comments welcome,

Marc-Andr=C3=A9 Lureau (2):
  memfd: add qemu_memfd_open()
  Add -mem-shared option

 exec.c                  | 11 ++++++++++-
 hw/core/numa.c          | 16 +++++++++++++++-
 include/qemu/memfd.h    |  3 +++
 include/sysemu/sysemu.h |  1 +
 qemu-options.hx         | 10 ++++++++++
 util/memfd.c            | 39 +++++++++++++++++++++++++--------------
 vl.c                    |  4 ++++
 7 files changed, 68 insertions(+), 16 deletions(-)

--=20
2.24.0


