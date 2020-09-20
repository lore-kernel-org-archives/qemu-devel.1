Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00DC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 20:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5CC2085B
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 20:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5CC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK5uz-0004q9-Tt
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 16:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>) id 1kK5tA-00047Y-CX
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 16:24:48 -0400
Received: from kerio.kamp.de ([195.62.97.192]:37788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>) id 1kK5t8-0003hb-HP
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 16:24:48 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:24:38 +0200
Received: (qmail 61296 invoked from network); 20 Sep 2020 20:24:42 -0000
Received: from ac34.vpn.kamp-intra.net (HELO ?172.20.250.34?)
 (pl@kamp.de@::ffff:172.20.250.34)
 by submission.kamp.de with ESMTPS (AES128-SHA encrypted) ESMTPA;
 20 Sep 2020 20:24:42 -0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Peter Lieven <pl@kamp.de>
Subject: Limiting per vCPU Usage
Message-ID: <68336702-cedc-dc38-3d18-d153cd7652dd@kamp.de>
Date: Sun, 20 Sep 2020 22:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=195.62.97.192; envelope-from=pl@kamp.de;
 helo=kerio.kamp.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 15:03:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Qemu folks,


is there a BCP to limit just the maximum usage of a virtual (KVM) cpu?

I know that there are many approaches, but as far as I know they all limit the complete qemu process which is far more

than just the virtual CPUs.

Is it possible to limit just the vCPU threads and leave threads that handle the monitor, vnc, qmp, iothreads, storage backend etc.

unthrottled?


Thanks,

Peter



