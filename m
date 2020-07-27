Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CAFC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D77206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+jsnNgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D77206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k06gb-0006ko-PY
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k06eY-00042a-6H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:11:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k06eU-0001hh-V8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595869862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=azTKMj9g87S9w6eNzBuD5F2d1c5/MIJCs1scp+4TOZM=;
 b=O+jsnNgV4cwg5Ra6lv2oDNnjJqChSiX3Rx2DGSAJwq5ed0bNRcXyWC80OohMVgqCDVMGa3
 KgiaI2UnVC0jrR8oRHBBYyaNHBHOk1y7g0gVv/yi24e30TqTy7M65eKmVFopD3wmgmcoqz
 P7/iva2bjVsZSRVTAV7c0NwOFQdHJxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-yLUAn_yGMYe4aqE-buWmXA-1; Mon, 27 Jul 2020 13:09:32 -0400
X-MC-Unique: yLUAn_yGMYe4aqE-buWmXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCF521009444;
 Mon, 27 Jul 2020 17:09:31 +0000 (UTC)
Received: from f32-work.redhat.com (unknown [10.40.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F2478FA5D;
 Mon, 27 Jul 2020 17:09:30 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] assertion failure in net_tx_pkt_add_raw_fragment() in
 hw/net/net_tx_pkt.c
Date: Mon, 27 Jul 2020 19:08:36 +0200
Message-Id: <20200727170838.1101775-1-mcascell@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mcascell@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com, mcascell@redhat.com,
 ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An assertion failure issue was reported by Mr. Ziming Zhang (CC'd).
It occurs in the code that processes network packets while adding data
fragments into packet context. This flaw could potentially be abused by
a malicious guest to abort the QEMU process on the host. This two patch
series does a couple of things:

- introduces a new function in net_tx_pkt.{c,h} to check the maximum number
  of data fragments
- adds a check in both e1000e and vmxnet3 devices to skip the packet if the
  current data fragment exceeds max_raw_frags, preventing
  net_tx_pkt_add_raw_fragment() to be called with an invalid raw_frags

Mauro Matteo Cascella (2):
  hw/net/net_tx_pkt: add function to check pkt->max_raw_frags
  hw/net: check max_raw_frags in e1000e and vmxnet3 devices

 hw/net/e1000e_core.c | 3 ++-
 hw/net/net_tx_pkt.c  | 5 +++++
 hw/net/net_tx_pkt.h  | 8 ++++++++
 hw/net/vmxnet3.c     | 3 ++-
 4 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.26.2


