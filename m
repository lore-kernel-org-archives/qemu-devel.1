Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7581EC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6AD2080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9fmpUZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6AD2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiLB-0008GQ-Oz
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaiC8-0000CX-8p
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaiC5-0006CT-SB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604593981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zIPaJ+TzRB5R378/Kg5Nk3DMZCatxdKPD0c3SCkNPQ=;
 b=H9fmpUZ56yZierTc3p3VyN2aWiu1CxUV915rcij7hMYArYvXJsP55aSw6YI3c8On0iIDe/
 gAKXxSP0Bs9+XGpMoUSqMrvw/xdhu7sZkpB3C3tZVRS2ZoLQHPWzLpvhLIPt72YofLdzPm
 rvewfLdGmOkHNU+ehkHMdOnN3Ls/mNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-lyvv_eLhOLCMfFvTYB33MA-1; Thu, 05 Nov 2020 11:32:57 -0500
X-MC-Unique: lyvv_eLhOLCMfFvTYB33MA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3B42884E7F;
 Thu,  5 Nov 2020 16:32:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-31.ams2.redhat.com
 [10.36.114.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13A646CE4E;
 Thu,  5 Nov 2020 16:32:36 +0000 (UTC)
Subject: Re: [PATCH v4] block: Fix integer promotion error in bdrv_getlength()
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20201105155122.60943-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3aaa7cba-58db-315c-cc75-7fc160ff7c58@redhat.com>
Date: Thu, 5 Nov 2020 17:32:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105155122.60943-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, chengchiwen@h3c.com, berto@igalia.com, tu.guoyi@h3c.com,
 "open list:Block layer core" <qemu-block@nongnu.org>, armbru@redhat.com,
 wang.yongD@h3c.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.11.20 16:51, Eric Blake wrote:
> Back in 2015, we attempted to fix error reporting for images that
> claimed to have more than INT64_MAX/512 sectors, but due to the type
> promotions caused by BDRV_SECTOR_SIZE being unsigned, this
> inadvertently forces all negative ret values to be slammed into -EFBIG
> rather than the original error.  While we're at it, we can avoid the
> confusing ?: by spelling the logic more directly.
> 
> Fixes: 4a9c9ea0d3
> Reported-by: Guoyi Tu <tu.guoyi@h3c.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Thanks, applied to my block branch (replacing the original patch):

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


