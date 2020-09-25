Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAABC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C27E2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjfbeZXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C27E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjlw-00053f-DQ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLjl1-0003yd-9L
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLjkz-0007sh-Q7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:11:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601025068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NZurm5z8iuHuysDo1zJVvjkfhTxWEFODXXOjvtp2hwQ=;
 b=XjfbeZXQC+uGB4lIL1MsCsMkzdXQIUw4hR1qsLF87628xKwrbpMLw7EmxClJIVA3JOIxzC
 hX+F5i2PDc6yuBer5JzP8Yt1pJT6rLuH6F7DYiWpaVgpjvU0nDRNQFCevz9MHjhWT0o0PJ
 qxXgXRhKLfkSv93b7Ra0nocBy698IkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-dwCbQUTHOFS3Ooic1oaZXg-1; Fri, 25 Sep 2020 05:11:06 -0400
X-MC-Unique: dwCbQUTHOFS3Ooic1oaZXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA9E41007482
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:11:05 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20BD41001901;
 Fri, 25 Sep 2020 09:10:56 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] vhost-vdpa: add trace functions in vhost-vdpa.c
Date: Fri, 25 Sep 2020 11:10:53 +0200
Message-Id: <20200925091055.186023-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace events functions in vdpa functions.=0D
=0D
Modify qemu_hexdump() to be able to dump the vdpa config=0D
in trace logs in hexadecimal form.=0D
=0D
v3: fix typo in commit message=0D
    trace vhost_vdpa_dma_map() and vhost_vdpa_dma_unmap()=0D
=0D
v2: fix problems reported by checkpatch (TAB, missing 0x and 80+ line)=0D
    added Stefan Acked-by=0D
=0D
Laurent Vivier (2):=0D
  util/hexdump: introduce qemu_hexdump_line()=0D
  vhost-vdpa: add trace-events=0D
=0D
 hw/virtio/trace-events | 31 ++++++++++++++=0D
 hw/virtio/vhost-vdpa.c | 92 +++++++++++++++++++++++++++++++++++++++---=0D
 include/qemu-common.h  |  8 ++++=0D
 util/hexdump.c         | 54 ++++++++++++++++---------=0D
 4 files changed, 160 insertions(+), 25 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


