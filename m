Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A35C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8151F20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ichC22Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8151F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3p6-0006UP-Mz
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3kU-0000br-70
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3kT-0006rW-5z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:59:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3kT-0006rF-1V
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfcwV8/ZdtSbstmz4jQAMd6npA1t+jqSmx/ySRyYh5o=;
 b=ichC22Xo04BzB1Gt1pirEk0f7++kkOGRzJCqjTb1fm/8BvgBd3bQrE13iXIQhSAEjf8b72
 7O5r3fynBeK6r05ysBpeeIEmMsdwCnPp6klQkyL3MbDAPLPnawfuVYqdxttZjxe/5fBDvx
 z+q/7ronNprTRKR2uMjunKZXl7/xWuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-u2XrJaYzNDqyxptGOguhow-1; Wed, 25 Mar 2020 06:58:57 -0400
X-MC-Unique: u2XrJaYzNDqyxptGOguhow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBED18018A3;
 Wed, 25 Mar 2020 10:58:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C42E41001938;
 Wed, 25 Mar 2020 10:58:53 +0000 (UTC)
Message-ID: <6128d1fa5cecea19772a2ea34cfa882dec3a9739.camel@redhat.com>
Subject: Re: [PATCH v6 37/42] nvme: refactor identify active namespace id list
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:58:52 +0200
In-Reply-To: <20200316142928.153431-38-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-38-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Prepare to support inactive namespaces.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index b89b96990f52..bf9fb500842a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1505,16 +1505,16 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
>      uint32_t min_nsid = le32_to_cpu(c->nsid);
>      uint32_t *list;
>      uint16_t ret;
> -    int i, j = 0;
> +    int j = 0;
>  
>      trace_nvme_dev_identify_nslist(min_nsid);
>  
>      list = g_malloc0(data_len);
> -    for (i = 0; i < n->num_namespaces; i++) {
> -        if (i < min_nsid) {
> +    for (int i = 1; i <= n->num_namespaces; i++) {
> +        if (i <= min_nsid) {
>              continue;
>          }
> -        list[j++] = cpu_to_le32(i + 1);
> +        list[j++] = cpu_to_le32(i);
>          if (j == data_len / sizeof(uint32_t)) {
>              break;
>          }


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky





