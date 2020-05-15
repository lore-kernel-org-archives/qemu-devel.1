Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC32C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B85205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SZyrP5/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B85205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWLM-0004Zm-G5
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZWIh-00084t-Gx
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:39 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:56402)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZWId-0002LB-7N
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rLxF3
 181KA43VpDsqwpjEml0S0zkCEdTt1OyW0Kt6bY=; b=SZyrP5/vj9s7fW6os32G1
 A5fJkmxckRsCpo1GsGyke5ZhDirRRLYQVyuwqgFNm2CsTVrpPwduJBb8f0Y79liC
 0FgtdqayWZZupDCUq0n/7psjeAq5KgZw/BbMZsQ9/7kXFDfy6Er2CdTL20ZG1vVM
 zFbrZvQCysp5wBV4ZREoqI=
Received: from localhost.localdomain (unknown [114.240.93.195])
 by smtp3 (Coremail) with SMTP id G9xpCgBnt5uKW75eMHSGBQ--.172S2;
 Fri, 15 May 2020 17:06:24 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] qemu-sockets: add abstract UNIX domain socket support
Date: Fri, 15 May 2020 17:06:05 +0800
Message-Id: <20200515090608.5373-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBnt5uKW75eMHSGBQ--.172S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyxJFW8Kw43tr1kCF1Dtrb_yoW3Arc_Xr
 y0k3s5KrW2ya1rCas5CrnxJFW7Cr40gF1vqF1UtrWkGw1rZr98trs8Ar17Kw1UJFyfWF17
 X3s7Gr93A342gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1H7KDUUUUU==
X-Originating-IP: [114.240.93.195]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEBAlxlUMRFTpTAAAsP
Received-SPF: pass client-ip=123.126.97.3; envelope-from=zxq_yx_007@163.com;
 helo=mail-m973.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 05:06:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 armbru@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu does not support abstract UNIX domain
socket address. Add this ability to make qemu handy
when abstract address is needed.

Changes since v4:
* fix typo and coding style problems

v3 -> v4: 
* rebase on master
* refine qapi document statement
* use random names to avoid name clash in unit test

Xiaoqiang Zhao (3):
  qemu-sockets: add abstract UNIX domain socket support
  tests/util-sockets: add abstract unix socket cases
  qemu-options: updates for abstract unix sockets

 chardev/char-socket.c     |  4 ++
 chardev/char.c            |  7 +++
 qapi/sockets.json         |  8 +++-
 qemu-options.hx           |  9 +++-
 tests/test-util-sockets.c | 92 +++++++++++++++++++++++++++++++++++++++
 util/qemu-sockets.c       | 39 ++++++++++++++---
 6 files changed, 149 insertions(+), 10 deletions(-)

-- 
2.17.1


