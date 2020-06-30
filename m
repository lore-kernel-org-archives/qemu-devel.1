Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D506C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D8E20771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="erUKJ2OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D8E20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDVq-0002Zf-G6
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jqDUo-00016L-2l; Tue, 30 Jun 2020 06:28:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:33901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jqDUl-0000G8-E6; Tue, 30 Jun 2020 06:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Z9ZCpOWDoszv5mWsLL6UIbF37AfS7UYQNEql9Mr+Z+8=; 
 b=erUKJ2OVmfeCZsNsBcQn3pn4xUNTNtNqrR6ci7qJOyqg6nvk4Sexn4yL9aMoWgX8wXuZ9MoBJfqYf4jFySZTXEg08uXKOWZZhKGyQB6i+2ah4m+lqzIkOULZefdKhR1CQ0IMpYW+BtAahJyog3Q47qQVSM6hdAi6zpb2aTOykp7nEr4E6dy8+TzU581KekAiSltHkwTxYyDI7AYm0kttXICu/hFxU9YwYU1OUHYn1CCoFuyziNxIvWmlz3tLCzeaA3oWe7Zsk7+1sl6tTaTRAuty3Fe97NKVJxTEnzM44rX65XTyDU30W9cV51l2r2ws3/Y2MgLexkX8fX/G+uLd8g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jqDUM-0004Ry-FO; Tue, 30 Jun 2020 12:27:42 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jqDUM-0002he-5s; Tue, 30 Jun 2020 12:27:42 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 02/34] qcow2: Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
In-Reply-To: <32a231b3-abc2-8d84-6a7d-eb8ccd388e33@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <4d3e11a48c18c3b4d34f567046334d4a1afde352.1593342067.git.berto@igalia.com>
 <32a231b3-abc2-8d84-6a7d-eb8ccd388e33@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 30 Jun 2020 12:27:42 +0200
Message-ID: <w51eepwn90h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:27:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 30 Jun 2020 12:19:42 PM CEST, Max Reitz wrote:
>> @@ -537,8 +542,6 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
>>          bytes_needed = bytes_available;
>>      }
>>  
>> -    *cluster_offset = 0;
>> -
>
> You drop this line without replacement now.  That means that
> *host_offset is no longer set to 0 if the L1 entry is out of bounds or
> empty (which causes this function to return QCOW2_CLUSTER_UNALLOCATED
> and no error).  Was that intentional?

Hmm, no, it wasn't intentional.

It does not have any side effect but I should be explicitly set
it to 0. I'll fix it in the next version.

Berto

