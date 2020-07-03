Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A677FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C2D206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGKToi5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C2D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGlW-0002an-Ob
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGks-0001bU-Th
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:09:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGkq-00006g-OM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593763743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iEa5ZtEDkDYGW+/+k1TSFjcId/lGhTCxhOtyeJs5zao=;
 b=iGKToi5K8FRwspzg4264a5H3J5yJOchq/mpYZxKbaiV+BtTmuxMXoRJ0VshKNV3zf0yzbk
 Vqa5XAFFrlxHgh5SaV1YQd+xf2zYk5ShO7BV/8YBkl1+bSNT8VMW+P7toiC38Wi/qkMBoo
 ZLx3S3S8dIwpEDYDFD08xciLy9et84U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-t0_5xBDJOPiX1QAi5BPsOQ-1; Fri, 03 Jul 2020 04:09:00 -0400
X-MC-Unique: t0_5xBDJOPiX1QAi5BPsOQ-1
Received: by mail-wr1-f72.google.com with SMTP id w4so29068936wrm.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=iEa5ZtEDkDYGW+/+k1TSFjcId/lGhTCxhOtyeJs5zao=;
 b=Rprcig3CD6jL8ii2g6HgVFGpm03mmkmDL7NEb3YHX9aR4JdieN9zycpVnV1BVHJWTG
 WtIJzog76FcQ1pUvvz+T5QlzEkBRZn2PkjPYgSKEdnUgmeJPu9uBou/iswOMvoE+m7i3
 aTkUPuWG1oQEAqFutX2PLmeh7dnCJuH9U34ucvRgGIWkDQxJLGSdKm54YOjyCG2FHv3Q
 BaomeOTHTjYuvJBvAUlwmvMy/bXnwE/zva7lrjRM2FDrlmOmQByThpfGHVQkSRdzlvZz
 yboud/sdkE3OS9kVHFOG96znckpSzu6sTg5V1+ypxFj+DiFAYNlEeIZ7qcSF38P4gVXW
 SnDA==
X-Gm-Message-State: AOAM532j7A2kvRDxnogspNqqppznnTmcU2+TsUMO9FGEH7nKIobkXdrE
 5r7S4TXfFgZ26XbxxZgJtagLVJeU4my6XqsfMaRR8HzXynhgYvC6iQFwpNYCsbFRq6CYWKvT9xD
 zsDgXthO7Y04BwUM=
X-Received: by 2002:a5d:6803:: with SMTP id w3mr35038190wru.200.1593763739371; 
 Fri, 03 Jul 2020 01:08:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1QCxxZAgyXgl1OTP518f3p6LlZACOqmjgNy8DvfUdOtiRjikdN4NNBbFlO9ZeKNQx9xrKdQ==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr35038158wru.200.1593763739063; 
 Fri, 03 Jul 2020 01:08:59 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm12558516wmg.5.2020.07.03.01.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 01:08:58 -0700 (PDT)
Subject: Re: [PATCH v2 04/18] hw/block/nvme: add temperature threshold feature
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-5-its@irrelevant.dk>
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
Message-ID: <91dbea26-9503-fd4c-f0f6-45c8bf9c17e5@redhat.com>
Date: Fri, 3 Jul 2020 10:08:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703063420.2241014-5-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:34 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> It might seem weird to implement this feature for an emulated device,
> but it is mandatory to support and the feature is useful for testing
> asynchronous event request support, which will be added in a later
> patch.

It might be interesting to plug that to the "temperature sensor
interface" I suggested here (I'll rework on it during 5.2):
https://www.mail-archive.com/qemu-block@nongnu.org/msg65192.html

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/block/nvme.h      |  1 +
>  include/block/nvme.h |  5 ++++-
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index b7037a7d3504..5ca50646369e 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -59,6 +59,9 @@
>  #define NVME_DB_SIZE  4
>  #define NVME_CMB_BIR 2
>  #define NVME_PMR_BIR 2
> +#define NVME_TEMPERATURE 0x143
> +#define NVME_TEMPERATURE_WARNING 0x157
> +#define NVME_TEMPERATURE_CRITICAL 0x175
>  
>  #define NVME_GUEST_ERR(trace, fmt, ...) \
>      do { \
> @@ -827,9 +830,31 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
>  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>      uint32_t result;
>  
>      switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        result = 0;
> +
> +        /*
> +         * The controller only implements the Composite Temperature sensor, so
> +         * return 0 for all other sensors.
> +         */
> +        if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
> +            break;
> +        }
> +
> +        switch (NVME_TEMP_THSEL(dw11)) {
> +        case NVME_TEMP_THSEL_OVER:
> +            result = cpu_to_le16(n->features.temp_thresh_hi);
> +            break;
> +        case NVME_TEMP_THSEL_UNDER:
> +            result = cpu_to_le16(n->features.temp_thresh_low);
> +            break;
> +        }
> +
> +        break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          result = blk_enable_write_cache(n->conf.blk);
>          trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
> @@ -874,6 +899,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>  
>      switch (dw10) {
> +    case NVME_TEMPERATURE_THRESHOLD:
> +        if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
> +            break;
> +        }
> +
> +        switch (NVME_TEMP_THSEL(dw11)) {
> +        case NVME_TEMP_THSEL_OVER:
> +            n->features.temp_thresh_hi = NVME_TEMP_TMPTH(dw11);
> +            break;
> +        case NVME_TEMP_THSEL_UNDER:
> +            n->features.temp_thresh_low = NVME_TEMP_TMPTH(dw11);
> +            break;
> +        default:
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
> +        break;
>      case NVME_VOLATILE_WRITE_CACHE:
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>          break;
> @@ -1454,6 +1496,7 @@ static void nvme_init_state(NvmeCtrl *n)
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>      n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
>      n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> +    n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
>  }
>  
>  static void nvme_init_blk(NvmeCtrl *n, Error **errp)
> @@ -1611,6 +1654,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->acl = 3;
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 0;
> +
> +    /* recommended default value (~70 C) */
> +    id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
> +    id->cctemp = cpu_to_le16(NVME_TEMPERATURE_CRITICAL);
> +
>      id->sqes = (0x6 << 4) | 0x6;
>      id->cqes = (0x4 << 4) | 0x4;
>      id->nn = cpu_to_le32(n->num_namespaces);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 1bf5c80ed843..3acde10e1d2a 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -107,6 +107,7 @@ typedef struct NvmeCtrl {
>      NvmeSQueue      admin_sq;
>      NvmeCQueue      admin_cq;
>      NvmeIdCtrl      id_ctrl;
> +    NvmeFeatureVal  features;
>  } NvmeCtrl;
>  
>  /* calculate the number of LBAs that the namespace can accomodate */
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 2a80d2a7ed89..d2c457695b38 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -860,7 +860,10 @@ enum NvmeIdCtrlOncs {
>  typedef struct NvmeFeatureVal {
>      uint32_t    arbitration;
>      uint32_t    power_mgmt;
> -    uint32_t    temp_thresh;
> +    struct {
> +        uint16_t temp_thresh_hi;
> +        uint16_t temp_thresh_low;
> +    };
>      uint32_t    err_rec;
>      uint32_t    volatile_wc;
>      uint32_t    num_queues;
> 


