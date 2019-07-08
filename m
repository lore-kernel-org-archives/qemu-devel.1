Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F8FC606A1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F56720651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ywHttSfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F56720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQ4b-0004K7-7c
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47860)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pizhenwei@bytedance.com>) id 1hkQ0w-0000s7-N5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1hkQ0u-00054i-Kz
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:38714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1hkQ0s-0004tS-Lb
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:32:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id y15so7307206pfn.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=9b9kg0vnquUdQTshbTUU30MRkKJ6BAHt/Fak/mTer0k=;
 b=ywHttSfm4q2kcyJ1Kp0isTz/VR5XxsbfxuvWwxEWXDfLwmYSr5UA2px7FW+N7gCuEA
 NmV6CSNgr03it17fgNJZC9FlmL8ax5cz27/GPjXwNAU6l1Sl+zfDetlMLoDhP4qhY/RJ
 Fcq6dijBfhA2jKykAEu6S1ybld5SKXZwEItlDfr42WV9Js9vhPn+tkSboSbgLluNLIxB
 zO8iUcZbjUAHLLfXD6wlanJ4DzrEGMTOKdQrWUxjzarY18qM+JFnm9DPWzySB89+Iwe7
 rh9Tr/Y3FrLTnLEhxVYuaoERhh5YbM6aZd+1oqmI8jUN0qibPnqFFSeMOB9Ozf7w19HJ
 apvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9b9kg0vnquUdQTshbTUU30MRkKJ6BAHt/Fak/mTer0k=;
 b=WeNnubHExXOXwtGEMFOYDLXwGbje3vsWjAZXhwfbGmnJzt+tzubjh1aGZY3S+I+XmZ
 aqChHqcJ644Hr7Q2XcS71wyLsnkY8pwZepgzI/znrMLHlY+xsm/ssn5psIT/UBqXx/K0
 IB1N2Kvbapk2WAS698I2r/b1uAWM+Hku1nMgULAKjcUwKpROFiNkdqHRk1/ULYBCor+h
 rqm6GCZtPgcw0rfnKbTh7x0rmnUMOtPswBSXO1B6qe1IndPm/8i24S0cH9q9Ccj/db9y
 NWf/WUNipY+14OvuVDj8BZ3qe1Jq3diCIs+5MV4e4548m+oVZvBXq8KXJoCTgmzi9Teo
 1psg==
X-Gm-Message-State: APjAAAU6fP26EkhNBnGV/LLANgKGDG3SZvMJGuIpBRRVRBmwjJ4/8Cub
 WkK87S5azJpH0Q7alKlaT12gNA==
X-Google-Smtp-Source: APXvYqw9hQrwJtdxyHHOQnhIX14j0HWIK1bX0gnOTHeM5niy8AnsNRXGacynxsoaFJaeaZAXxxThBA==
X-Received: by 2002:a63:e953:: with SMTP id q19mr22422824pgj.313.1562578355151; 
 Mon, 08 Jul 2019 02:32:35 -0700 (PDT)
Received: from always-ThinkPad-T480.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id q7sm236504pff.2.2019.07.08.02.32.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 08 Jul 2019 02:32:34 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kwolf@redhat.com,
	vsementsov@virtuozzo.com,
	eblake@redhat.com
Date: Mon,  8 Jul 2019 17:32:26 +0800
Message-Id: <1562578349-12333-1-git-send-email-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PATCH v2 0/3] Add block size histogram qapi interface
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pizhenwei@bytedance.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify command 'block-latency-histogram-set' to make block histogram
interface common to use. And support block size histogram.
Thanks to Eric Blake&Vladimir Sementsov-Ogievskiy for the suggestions.

This command has been tested for half year on QEMU-2.12, and we found
that 3K+ virtual machines write 25GB/s totally, the block size
histogram like following:
        0 ~ 8k: 58% ~ 62%
        8k ~ 32k: 10% ~ 12%
        32k ~ 128k: 2% ~ 3%
        128K ~ 512K: 24% ~ 26%
        512K ~ : ...

And the histogram data help us to optimise backend distributed
storage.

Changelog:
v2:
  - make 'block-latency-histogram-set' common.
  - remove duplicated functions.
  - fix uncommon indentation(reviewed by Vladimir Sementsov-Ogievskiy).

zhenwei pi (3):
  block/accounting: rename struct BlockLatencyHistogram
  block/accounting: introduce block size histogram
  qapi: make block histogram interface common

 block/accounting.c         |  62 ++++++++++++++++++++--------
 block/qapi.c               |  32 ++++++++------
 blockdev.c                 |  33 +++++++++++----
 include/block/accounting.h |  13 +++---
 qapi/block-core.json       | 101 +++++++++++++++++++++++++++------------------
 5 files changed, 158 insertions(+), 83 deletions(-)

-- 
2.11.0


