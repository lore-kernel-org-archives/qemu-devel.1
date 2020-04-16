Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889F2C352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 08:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607AF20784
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 08:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607AF20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOzYV-0002BK-HQ
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jOzXv-0001lN-Ft
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 04:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jOzXu-0004Uh-G8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 04:06:51 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:57274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jOzXu-0004R3-8l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 04:06:50 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E9BC84205B;
 Thu, 16 Apr 2020 10:06:37 +0200 (CEST)
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Stefan Reiter <s.reiter@proxmox.com>
Subject: qemu_coroutine_yield switches thread?
Message-ID: <5dde1955-49db-2626-1fa5-332e4d7a0928@proxmox.com>
Date: Thu, 16 Apr 2020 10:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, slp@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi list,

quick question: Can a resume from a qemu_coroutine_yield happen in a 
different thread?

Well, it can, since I'm seeing it happen, but is that okay or a bug?

I.e. in a backup-job the following can sporadically trip:

   unsigned long tid = pthread_self();
   qemu_get_current_aio_context(); // returns main context
   qemu_coroutine_yield();
   qemu_get_current_aio_context(); // still returns main context, but:
   assert(tid == pthread_self()); // this fails

It seems to be called from a vCPU thread when it happens. VM uses no 
iothreads.

~


