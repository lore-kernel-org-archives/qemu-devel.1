Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A3C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C6320724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbpEl2TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C6320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl5j-0006UB-2P
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrl2D-0002pI-8N
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:29:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrl28-0002hJ-2f
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593880134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3zBmqB6JDEohAkPJJvciyzQ+ZFRo2muu4VpiNKOg47w=;
 b=CbpEl2TIkf0i9r4PYpTY+FGf9aIRJvb7x28X7QjC5YTuNAyGOIpz+WvFn92cfCdAU/zV+Z
 tWqjv0lXm27PyMfl5Ymx6pxSIMvT0mRkavuyswKrz1Ec1RguxSfyHlpcfx+FYHYoeLVYBG
 9ZCZjhyAvtllxCSiT06PnYI/IMSH9bU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-GZ6QL5eRNBW-Bdm-lqIrTw-1; Sat, 04 Jul 2020 12:28:50 -0400
X-MC-Unique: GZ6QL5eRNBW-Bdm-lqIrTw-1
Received: by mail-wm1-f71.google.com with SMTP id t18so39850237wmj.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 09:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3zBmqB6JDEohAkPJJvciyzQ+ZFRo2muu4VpiNKOg47w=;
 b=IQN4LBjycToGtZo+E7PTrpRm616/ypE/7d0ljOqDXWPX8K2Wh+a2Vmrd2jbn8jRo83
 brwcegd/Sl8PAGntSZqQJGYAiIkUErHSHBIRzMXIA5nN9X5r5RY/zc+W8YCLKxpS3+r2
 Vn1qia2epgcjvCNJ56MQgdvXKVS+FKGZl0Jz7iD5wdp8HFkATr1pKnJnSzzNfE2PK7uS
 Ro4FCLXIucHFOpwB/OoG1Cnj3IP8Q55SoAV0V3VEGbEZqEF1vcfKqAYp23OxlrAisGRO
 LlSiufdkeoq+P41GIdEmcFuLW4S17M+8FDWLswjO3rpMhvKfQdoSlthCjudcC/2uRxe2
 7V2A==
X-Gm-Message-State: AOAM531In34H2HGUdYsxkk+3GvHf7rKty/73HjaMe+30soWXnPha7O02
 3hCir3cUTaSE/iK1rqotGrqy1oEC2j5RqaUqVetWUH1Z7ZI69qfZmDexLajP9hZACvjxrUZ8iPU
 75cx8CVhapGPKWMs=
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr40737816wmh.134.1593880129177; 
 Sat, 04 Jul 2020 09:28:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5r/BEoDdO+r+x4DSU5aTPxh812DNK8YR0qbf9RNidJPO4yCjOHBXFK12UGCba7L6ZBmaZNQ==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr40737798wmh.134.1593880128874; 
 Sat, 04 Jul 2020 09:28:48 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g145sm8772530wmg.23.2020.07.04.09.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 09:28:48 -0700 (PDT)
Subject: Re: [PATCH v11 3/8] SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
 <20200703090816.3295-4-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <7cd9eb58-06c1-15a6-3c68-a7977ed55d3b@redhat.com>
Date: Sat, 4 Jul 2020 18:28:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703090816.3295-4-vsementsov@virtuozzo.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 11:08 AM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &error_fatal
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
> 
> If we want to check error after errp-function call, we need to
> introduce local_err and then propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatal, this means that we don't break error_abort
>    (we'll abort on error_set, not on error_propagate)
> 
> This commit is generated by command
> 
>     sed -n '/^SD (Secure Card)$/,/^$/{s/^F: //p}' \
>         MAINTAINERS | \
>     xargs git ls-files | grep '\.[hc]$' | \
>     xargs spatch \
>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --in-place --no-show-diff --max-width 80
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If possible 's/SD (Secure Card)/sd/' in subject.
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sd/sdhci-pci.c |  7 +++----
>  hw/sd/sdhci.c     | 21 +++++++++------------
>  hw/sd/ssi-sd.c    | 10 +++++-----
>  3 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
> index 4f5977d487..38ec572fc6 100644
> --- a/hw/sd/sdhci-pci.c
> +++ b/hw/sd/sdhci-pci.c
> @@ -29,13 +29,12 @@ static Property sdhci_pci_properties[] = {
>  
>  static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      SDHCIState *s = PCI_SDHCI(dev);
> -    Error *local_err = NULL;
>  
>      sdhci_initfn(s);
> -    sdhci_common_realize(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_common_realize(s, errp);
> +    if (*errp) {
>          return;
>      }
>  
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index eb2be6529e..be1928784d 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1288,7 +1288,7 @@ static const MemoryRegionOps sdhci_mmio_ops = {
>  
>  static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
>  {
> -    Error *local_err = NULL;
> +    ERRP_AUTO_PROPAGATE();
>  
>      switch (s->sd_spec_version) {
>      case 2 ... 3:
> @@ -1299,9 +1299,8 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
>      }
>      s->version = (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
>  
> -    sdhci_check_capareg(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_check_capareg(s, errp);
> +    if (*errp) {
>          return;
>      }
>  }
> @@ -1332,11 +1331,10 @@ void sdhci_uninitfn(SDHCIState *s)
>  
>  void sdhci_common_realize(SDHCIState *s, Error **errp)
>  {
> -    Error *local_err = NULL;
> +    ERRP_AUTO_PROPAGATE();
>  
> -    sdhci_init_readonly_registers(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_init_readonly_registers(s, errp);
> +    if (*errp) {
>          return;
>      }
>      s->buf_maxsz = sdhci_get_fifolen(s);
> @@ -1456,13 +1454,12 @@ static void sdhci_sysbus_finalize(Object *obj)
>  
>  static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      SDHCIState *s = SYSBUS_SDHCI(dev);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> -    Error *local_err = NULL;
>  
> -    sdhci_common_realize(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_common_realize(s, errp);
> +    if (*errp) {
>          return;
>      }
>  
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index e0fb9f3093..43e5730b00 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -241,10 +241,10 @@ static const VMStateDescription vmstate_ssi_sd = {
>  
>  static void ssi_sd_realize(SSISlave *d, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, d);
>      DeviceState *carddev;
>      DriveInfo *dinfo;
> -    Error *err = NULL;
>  
>      qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
>                          DEVICE(d), "sd-bus");
> @@ -255,23 +255,23 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
>      carddev = qdev_new(TYPE_SD_CARD);
>      if (dinfo) {
>          if (!qdev_prop_set_drive_err(carddev, "drive",
> -                                     blk_by_legacy_dinfo(dinfo), &err)) {
> +                                     blk_by_legacy_dinfo(dinfo), errp)) {
>              goto fail;
>          }
>      }
>  
> -    if (!object_property_set_bool(OBJECT(carddev), "spi", true, &err)) {
> +    if (!object_property_set_bool(OBJECT(carddev), "spi", true, errp)) {
>          goto fail;
>      }
>  
> -    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
> +    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), errp)) {
>          goto fail;
>      }
>  
>      return;
>  
>  fail:
> -    error_propagate_prepend(errp, err, "failed to init SD card: ");
> +    error_prepend(errp, "failed to init SD card: ");
>  }
>  
>  static void ssi_sd_reset(DeviceState *dev)
> 


