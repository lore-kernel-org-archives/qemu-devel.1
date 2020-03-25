Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78ABC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BF62076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxDSdnTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BF62076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5Yb-0000XX-Gw
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jH5Xr-00006M-QO
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jH5Xq-00079m-Ew
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:54:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jH5Xq-00078i-BV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585140846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37YXI+Vi5QARz6EMzvgTYd6v+ZayoidINuJR8JmIsFQ=;
 b=CxDSdnTBpIJedDuB5+WaWamIRNP3caXiAsFytMqeO2hazit2Bsla+P4dKVjRIchfSgdx/w
 HQVzmRFy+D3Y7/ULXkII7rM/oulvo5K1ZkugVmTaPMTFOVnhTri2a7jtVp2PI6NCg9GqAz
 HqX03KK7+7vlG+wfaQ69iGfLqVbNzrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-FGkgyACjNJqAxv4Ru0q8VQ-1; Wed, 25 Mar 2020 08:54:04 -0400
X-MC-Unique: FGkgyACjNJqAxv4Ru0q8VQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43B1D1005510;
 Wed, 25 Mar 2020 12:54:03 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B953E10027A9;
 Wed, 25 Mar 2020 12:54:02 +0000 (UTC)
Subject: Re: [PATCH 2/2] util/bufferiszero: improve avx2 accelerator
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org
References: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
 <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9eea6e9c-e35c-72e7-4574-7b9a6b72f9a7@redhat.com>
Date: Wed, 25 Mar 2020 07:54:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: robert.hu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 1:50 AM, Robert Hoo wrote:
> By increasing avx2 length_to_accel to 128, we can simplify its logic and reduce a
> branch.
> 
> The authorship of this patch actually belongs to Richard Henderson <richard.henderson@linaro.org>,

Long line; it's nice to wrap commit messages around column 70 or so 
(because reading 'git log' in an 80-column window adds indentation).

> I just fix a boudary case on his original patch.

boundary

> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>   util/bufferiszero.c | 26 +++++++++-----------------
>   1 file changed, 9 insertions(+), 17 deletions(-)
> 


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


