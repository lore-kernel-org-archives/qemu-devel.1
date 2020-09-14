Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8911C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D3F20735
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D3F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnYu-0007Un-Pz
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kHnXn-0006dl-9S; Mon, 14 Sep 2020 08:25:15 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:7280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kHnXk-0007Sp-WD; Mon, 14 Sep 2020 08:25:14 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0A6C544BA5;
 Mon, 14 Sep 2020 14:25:07 +0200 (CEST)
To: qemu-block@nongnu.org
From: Stefan Reiter <s.reiter@proxmox.com>
Subject: Potential regression in 'qemu-img convert' to LVM
Message-ID: <1b7b5aa0-2ab0-75a5-68f4-01eb4684dbcb@proxmox.com>
Date: Mon, 14 Sep 2020 14:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 07:46:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi list,

following command fails since 5.1 (tested on kernel 5.4.60):

# qemu-img convert -p -f raw -O raw /dev/zvol/pool/disk-1 /dev/vg/disk-1
qemu-img: error while writing at byte 2157968896: Device or resource busy

(source is ZFS here, but doesn't matter in practice, it always fails the 
same; offset changes slightly but consistently hovers around 2^31)

strace shows the following:
fallocate(13, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2157968896, 
4608) = -1 EBUSY (Device or resource busy)

Other fallocate calls leading up to this work fine.

This happens since commit edafc70c0c "qemu-img convert: Don't pre-zero 
images", before that all fallocates happened at the start. Reverting the 
commit and calling qemu-img exactly the same way on the same data works 
fine. Simply retrying the syscall on EBUSY (like EINTR) does *not* work, 
once it fails it keeps failing with the same error.

I couldn't find anything related to EBUSY on fallocate, and it only 
happens on LVM targets... Any idea or pointers where to look?

~ Stefan


