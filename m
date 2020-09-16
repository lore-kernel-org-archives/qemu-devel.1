Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C220FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EA62244C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4UhM2MN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EA62244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIa8Z-0006HT-3y
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIa7J-0005KL-H0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kIa7G-0007pF-PM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600273025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9EsnOGzOhPR6QqbkJOoiHVayjiazyxeJO1u9uDG23U=;
 b=G4UhM2MN/4XPfJQ4IpBmnp1sFIQMHZWrNrma6Ew/rNQ1htNIPWW0PqqylBxoi8S6vIA+Qu
 E14Sb2s8DeChOUrk1q/Viu5tw358I9E/mqwN+l2jaIAVeZg+64pQWBy0I1/ETg+0bhsX2E
 Zw7UL/ul9sc82jUgSzK7PjamaWrzHPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-VRELtzg0MUiEtHlptNYnSw-1; Wed, 16 Sep 2020 12:17:02 -0400
X-MC-Unique: VRELtzg0MUiEtHlptNYnSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29B3E425CE
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:17:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-131.ams2.redhat.com
 [10.36.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4B71002D41;
 Wed, 16 Sep 2020 16:16:57 +0000 (UTC)
Subject: Re: [PATCH] hw/nvram/fw_cfg: Assert linked data is not NULL
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200916140535.1451663-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7fe3ec9c-2ffb-7003-d189-5920ac124541@redhat.com>
Date: Wed, 16 Sep 2020 18:16:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200916140535.1451663-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

On 09/16/20 16:05, Philippe Mathieu-Daudé wrote:
> The linked data passed to the fw_cfg device must not be NULL.
> Add an assertion.
>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index f3a4728288e..40dcc08b57b 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -711,6 +711,7 @@ static void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
>
>      key &= FW_CFG_ENTRY_MASK;
>
> +    assert(data);
>      assert(key < fw_cfg_max_entry(s) && len < UINT32_MAX);
>      assert(s->entries[arch][key].data == NULL); /* avoid key conflict */
>
>

(1) this assert() would fire without my

  [PATCH] hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data() consumption

so minimally we should apply your patch only after mine.

(2) I'm unsure if it's *always* a programming error to link a NULL datum
under an fw_cfg key. The reader functions fw_cfg_data_read() and
fw_cfg_dma_transfer() deal with NULL data gracefully.

I think we should add the assert() only if we can prove that
"include/hw/nvram/fw_cfg.h" already forbids callers from passing in NULL
data. Otherwise, we'll have to audit all the fw-cfg-add-xxx call sites,
extend the comments in the header file, and *then* add the assert().

For now I'd only go with the patch I posted.

Thanks!
Laszlo


