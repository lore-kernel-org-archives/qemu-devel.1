Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2985CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F3020673
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUB33-0006zf-2s
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:19:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hUAoY-0003SB-4R
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hUAje-0007HB-AP
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hUAjd-0006re-6t; Fri, 24 May 2019 09:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF90430820E6;
	Fri, 24 May 2019 13:59:21 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CE9910027C6;
	Fri, 24 May 2019 13:59:19 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190524124829.2589-1-peter.maydell@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <79be2f7d-d9b6-4742-e116-078ce937a051@redhat.com>
Date: Fri, 24 May 2019 15:59:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190524124829.2589-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 24 May 2019 13:59:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/arm/smmuv3: Fix decoding of ID register
 range
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 5/24/19 2:48 PM, Peter Maydell wrote:
> The SMMUv3 ID registers cover an area 0x30 bytes in size
> (12 registers, 4 bytes each). We were incorrectly decoding
> only the first 0x20 bytes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thank you for the fix.

Eric

> ---
>  hw/arm/smmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index fd8ec7860ee..e96d5beb9a8 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1232,7 +1232,7 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>                                uint64_t *data, MemTxAttrs attrs)
>  {
>      switch (offset) {
> -    case A_IDREGS ... A_IDREGS + 0x1f:
> +    case A_IDREGS ... A_IDREGS + 0x2f:
>          *data = smmuv3_idreg(offset - A_IDREGS);
>          return MEMTX_OK;
>      case A_IDR0 ... A_IDR5:
> 

