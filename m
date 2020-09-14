Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B33C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B66621741
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B66621741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmxH-0005n6-Hg
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kHmwV-0005B7-4d; Mon, 14 Sep 2020 07:46:43 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:37739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kHmwS-0002tk-Ng; Mon, 14 Sep 2020 07:46:42 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7106744BBD;
 Mon, 14 Sep 2020 13:46:28 +0200 (CEST)
Subject: Re: [PATCH 0/3] Add support for sequential backups
From: Stefan Reiter <s.reiter@proxmox.com>
To: qemu-block@nongnu.org
References: <20200826121359.15450-1-s.reiter@proxmox.com>
Message-ID: <3b016643-dc96-bb0a-2b7a-592cb439fc94@proxmox.com>
Date: Mon, 14 Sep 2020 13:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200826121359.15450-1-s.reiter@proxmox.com>
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
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, w.bumiller@proxmox.com, t.lamprecht@proxmox.com,
 qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Friendly ping :)

On 8/26/20 2:13 PM, Stefan Reiter wrote:
> Backups can already be done for multiple drives in a transaction. However, these
> jobs will start all at once, potentially hogging a lot of disk IO all at once.
> This problem is made worse, since IO throttling is only available on a per-job
> basis.
> 
> Add a flag to QMP to support sequential transactions for backups. This way,
> every job will be executed one after the other, while still providing the
> benefit of transactions (i.e. once one fails, all remaining ones will be
> cancelled).
> 
> We've internally (in Proxmox VE) been doing sequential backups for a long time
> with great success, albeit in a different fashion. This series is the result of
> aligning our internal changes closer to upstream, and might be useful for other
> people as well.
> 
> 
> Stefan Reiter (3):
>    job: add sequential transaction support
>    blockdev: add sequential mode to *-backup transactions
>    backup: initialize bcs bitmap on job create, not start
> 
>   block/backup.c        |  4 ++--
>   blockdev.c            | 25 ++++++++++++++++++++++---
>   include/qemu/job.h    | 12 ++++++++++++
>   job.c                 | 24 ++++++++++++++++++++++++
>   qapi/transaction.json |  6 +++++-
>   5 files changed, 65 insertions(+), 6 deletions(-)
> 


