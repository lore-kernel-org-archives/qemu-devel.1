Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F2FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA30206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA30206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUxs-0004gs-E8
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgUm0-0000gf-9k
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:53:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:48398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgUlz-0000bQ-Gd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:53:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 59672ACA3;
 Wed,  3 Jun 2020 14:53:45 +0000 (UTC)
Subject: Re: [PATCH 3/4] block: Add block accounting code for GET LBA STATUS
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
References: <20200602074201.10879-1-lma@suse.com>
 <20200602074201.10879-4-lma@suse.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <ad734b49-f0d2-0483-fa73-b7394971654e@suse.de>
Date: Wed, 3 Jun 2020 16:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200602074201.10879-4-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 22:45:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 9:42 AM, Lin Ma wrote:
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  include/block/accounting.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/block/accounting.h b/include/block/accounting.h
> index 878b4c3581..645014fb0b 100644
> --- a/include/block/accounting.h
> +++ b/include/block/accounting.h
> @@ -38,6 +38,7 @@ enum BlockAcctType {
>      BLOCK_ACCT_WRITE,
>      BLOCK_ACCT_FLUSH,
>      BLOCK_ACCT_UNMAP,
> +    BLOCK_ACCT_GET_LBA_STATUS,
>      BLOCK_MAX_IOTYPE,
>  };
>  
> 

This should probably be combined with the change that makes use of BLOCK_ACCT_GET_LBA_STATUS to constitute a single, meaningful change.

Ciao,

Claudio

