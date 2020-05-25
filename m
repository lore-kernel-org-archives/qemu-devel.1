Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2366C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 19:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B5A2068D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 19:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibKbIoRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B5A2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdINh-0005Tf-Rb
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 15:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jdIMf-0004UO-6T
 for qemu-devel@nongnu.org; Mon, 25 May 2020 15:02:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49480
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jdIMe-0000U9-DD
 for qemu-devel@nongnu.org; Mon, 25 May 2020 15:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590433338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYJDKDudENUxgOK0FpxJlslfW0rT52flUqylQ8V8foI=;
 b=ibKbIoRLqnZhTro/vKpBpV7Fv20ibv1g3ynODtT2Jyb9KadbnIDqiNCwLOUkxSSqTsqp1H
 HYqrDmNrkW432LoJFL/6MsbZZZenZn6LeIX/ogUsnAGBo6ol7NnjwocjrFCoQFziyPahBp
 9eC9OeXbTMUx2lWHDFBlNmMraLK8sx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-PNoS1Pe3Me6RY8LefVsmMA-1; Mon, 25 May 2020 15:02:14 -0400
X-MC-Unique: PNoS1Pe3Me6RY8LefVsmMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60601107ACCD;
 Mon, 25 May 2020 19:02:13 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-168.ams2.redhat.com
 [10.36.114.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9CBD60BE1;
 Mon, 25 May 2020 19:02:10 +0000 (UTC)
Subject: Re: [PATCH] hw/block/pflash_cfi01: Limit maximum flash size to 256 MiB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200525155826.11333-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0520c681-a6f9-5bcd-ca7d-4ad92e4d4764@redhat.com>
Date: Mon, 25 May 2020 21:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200525155826.11333-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>, qemu-block@nongnu.org,
 Hongbo Zhang <hongbo.zhang@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/25/20 17:58, Philippe Mathieu-Daudé wrote:
> As of this commit, the biggest CFI01 NOR flash documented is
> the Micron PC28F00BP33EF. Its size is 2 GiB (256 MiB).

I don't understand what "2 GiB (256 MiB)" means; please clarify.

> 
> Actually this "2Gb device employs a virtual chip enable feature,
> which combines two 1Gb die with a common chip enable".
> 
> Since we do not want to model unrealistic hardware, cap the
> current model to this maximum. At least we have a datasheet
> to refer.
> 
> If a bigger flash is provided, the user get this warning:
> 
>   qemu-system-aarch64: Initialization of device cfi.pflash01 failed: Maximum supported CFI flash size is 16 MiB.
> 
> Note, the sbsa-ref ARM machine introduced in commit 64580903c2b
> already uses a pair of 256 MiB flash devices.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 11922c0f96..40f145dde7 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -37,6 +37,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/cutils.h"
>  #include "hw/block/block.h"
>  #include "hw/block/flash.h"
>  #include "hw/qdev-properties.h"
> @@ -68,6 +70,8 @@ do {                                                        \
>  #define PFLASH_BE          0
>  #define PFLASH_SECURE      1
>  
> +#define PFLASH_SIZE_MAX     (256 * MiB) /* Micron PC28F00BP33EF */
> +
>  struct PFlashCFI01 {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -717,6 +721,12 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>      }
>  
>      total_len = pfl->sector_len * pfl->nb_blocs;
> +    if (total_len > PFLASH_SIZE_MAX) {
> +        char *maxsz = size_to_str(PFLASH_SIZE_MAX);
> +        error_setg(errp, "Maximum supported CFI flash size is %s.", maxsz);
> +        g_free(maxsz);
> +        return;
> +    }
>  
>      /* These are only used to expose the parameters of each device
>       * in the cfi_table[].
> 

I'm unsure how strong the argument is, "we do not want to model
unrealistic hardware", but I do think the patch does what it says on the
tin (modulo the one part in the commit message that I don't understand).

With the commit message clarified

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(I expect & hope people will provide better reviews than mine.)

Thanks
Laszlo


