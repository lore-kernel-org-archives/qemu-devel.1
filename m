Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C121122CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoWsycSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C121122CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3JYa-0002sn-R2
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k3JXu-00023n-NW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:33:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k3JXs-0002yn-5o
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596634407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/aSii8EhmexWaJw+KDVIybB6cAGxab6QbndBJqqxD5A=;
 b=FoWsycSmqOQnx7StgkfuSJyJNNQeGFbkKT6n3gtm43kRgLnsbxpO0IbfJUwn97AlW63cHd
 Lj5AulpVFvsF3o3omWUSmweycXlMaw8Oy2GRiojuzWFnhT77LwrCLinnCVs89v7er6Kikj
 +K66Esc4aJyf8g1V9ed0sNhStLPDwQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-cdNsPEoRNFCCcuN2y8aoSQ-1; Wed, 05 Aug 2020 09:33:23 -0400
X-MC-Unique: cdNsPEoRNFCCcuN2y8aoSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1859E8015F4;
 Wed,  5 Aug 2020 13:33:22 +0000 (UTC)
Received: from [10.3.115.21] (ovpn-115-21.phx2.redhat.com [10.3.115.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D8B7619C4;
 Wed,  5 Aug 2020 13:33:21 +0000 (UTC)
Subject: Re: [PATCH for-5.1?] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
To: Tuguoyi <tu.guoyi@h3c.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <81ba90fe0c014f269621c283269b42ad@h3c.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4b23cae2-d35a-dcc3-f534-8fd9ebf67629@redhat.com>
Date: Wed, 5 Aug 2020 08:33:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <81ba90fe0c014f269621c283269b42ad@h3c.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Wangyong <wang.yongD@h3c.com>, Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gaoliang <liang_gao@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 4:22 AM, Tuguoyi wrote:
> When calculating the offset, the result of left shift operation will be promoted
> to type int64 automatically because the left operand of + operator is uint64_t.
> but the result after integer promotion may be produce an error value for us and
> trigger the following asserting error.
> 
> For example, consider i=0x2000, cluster_bits=18, the result of left shift
> operation will be 0x80000000. Cause argument i is of signed integer type,
> the result is automatically promoted to 0xffffffff80000000 which is not
> we expected
> 
> The way to trigger the assertion error:
>    qemu-img create -f qcow2 -o preallocation=full,cluster_size=256k tmpdisk 10G

I wonder if it is worth an iotest addition to cover this.

> 
> This patch fix it by casting @i to uint64_t before doing left shift operation
> 
> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
> ---
>   block/qcow2-cluster.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

While this appears to be long-standing, rather than a regression in 5.1, 
this would be worth getting into -rc3 today if we still have time (if 
not, slipping to 5.2 is okay).

> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index a677ba9..550850b 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -980,7 +980,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>   
>       assert(l2_index + m->nb_clusters <= s->l2_slice_size);
>       for (i = 0; i < m->nb_clusters; i++) {
> -        uint64_t offset = cluster_offset + (i << s->cluster_bits);
> +        uint64_t offset = cluster_offset + ((uint64_t)i << s->cluster_bits);

We have:
offset = uint64_t + (int << int)

which is indeed a cause of unwanted sign extension.

If I'm not mistaken, it would also be feasible to fix this by changing 
qcow2.h to fix typedef struct BDRVQcow2State to use an unsigned type for 
cluster_bits (the way we already do for struct QCowHeader), avoiding the 
need for a cast here.

But if we're trying to get this in today, rather than auditing all other 
uses of BDRVQcow2State for incorrect typing,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


