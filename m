Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E66207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yyjaec8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E66207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrH7C-0007uV-Ap
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrH6a-0007Sh-G4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:31:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35857
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrH6Y-0005s0-AJ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593765089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hBAnYUM6VDmt2qsVL5ScX/EPUvM081wDrBOXTKALS6c=;
 b=Yyjaec8gDy5Ol56OLLW4n9SyH8scdEgRgSDmEud1198devrbSz7f5FNY0X9opT2ogQn2To
 LXfI9ir/igEW4eg3zmmgmibZdqXgAzacEGwBXpmHEh/03hwyVYL6Yo7mpLvtDxMJhLViFX
 oS0IZb/TGm8ArFpRzcsyCrdN5O7clGY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-w3pcRpKSNV27ATCDYQ4KzA-1; Fri, 03 Jul 2020 04:31:27 -0400
X-MC-Unique: w3pcRpKSNV27ATCDYQ4KzA-1
Received: by mail-wr1-f70.google.com with SMTP id d11so13617951wrw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hBAnYUM6VDmt2qsVL5ScX/EPUvM081wDrBOXTKALS6c=;
 b=BoCjGnGWfR13q45enaO0ELbUFHqrG9trP947u3dJdCKkAIOSE63Tv4mOExhlI8BTAU
 lpx9jiyg7WYTWrT7Bq3MhiDZdOUy765OwHuG9PfEFTD8FgcfDFI7F/2KsngwV0typwy1
 FdooxWzRsGm48q3MYlQ51FsRfUEOZYf0kx3o/bk9ZoHp7zJrQkixliwijCTGakxZquaG
 H+hu2XcZ9xExNtBx4s81faNbLlqKf+rA+7W3A1Tq6c2nGmbdrnuF8h4xWP1uFa7AyWBj
 kBPEKL4tVZl3Q65ToAYFDu4SFxOaoNcAylaymhOxE/kkMkV2Nbi4yu09sUTbgrF5RSDK
 0ERQ==
X-Gm-Message-State: AOAM530GKSy5POBLLzkb1migssaCPpahhkjHvknx68wFr0JTLzJLJTNV
 YS8+ebb5tcYkBzpSX6YTF7zYHbkxxxpP6isIequ07M3CssRxtIptwZjPm6J4FV+H+Fv3qakQHFH
 9rNu3TLwGmDi7XLY=
X-Received: by 2002:adf:f082:: with SMTP id n2mr37639799wro.326.1593765086452; 
 Fri, 03 Jul 2020 01:31:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQVV86JJCFPHlg0H2OCd/Sm0Mceaf7/cI7hYtg7+7+zAyj2dds7ZGJ3KjbcBtpp5cNSEoR8g==
X-Received: by 2002:adf:f082:: with SMTP id n2mr37639784wro.326.1593765086234; 
 Fri, 03 Jul 2020 01:31:26 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w14sm13302785wrt.55.2020.07.03.01.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 01:31:25 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] hw/block/nvme: add remaining mandatory
 controller parameters
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-12-its@irrelevant.dk>
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
Message-ID: <e2cbec3f-896e-fa17-2aac-2c82e0d6df60@redhat.com>
Date: Fri, 3 Jul 2020 10:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703063420.2241014-12-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
> Add support for any remaining mandatory controller operating parameters
> (features).
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c       | 39 +++++++++++++++++++++++++++++++++------
>  hw/block/nvme.h       | 18 ++++++++++++++++++
>  hw/block/trace-events |  2 ++
>  include/block/nvme.h  |  7 +++++++
>  4 files changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ba523f6768bf..affb9a967534 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1056,8 +1056,16 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>      uint32_t result;
> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
> +    uint16_t iv;
>  
> -    switch (dw10) {
> +    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
> +
> +    if (!nvme_feature_support[fid]) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    switch (fid) {
>      case NVME_TEMPERATURE_THRESHOLD:
>          result = 0;
>  
> @@ -1088,14 +1096,27 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>                               ((n->params.max_ioqpairs - 1) << 16));
>          trace_pci_nvme_getfeat_numq(result);
>          break;
> +    case NVME_INTERRUPT_VECTOR_CONF:
> +        iv = dw11 & 0xffff;
> +        if (iv >= n->params.max_ioqpairs + 1) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
> +        result = iv;
> +        if (iv == n->admin_cq.vector) {
> +            result |= NVME_INTVC_NOCOALESCING;
> +        }
> +
> +        result = cpu_to_le32(result);
> +        break;
>      case NVME_ASYNCHRONOUS_EVENT_CONF:
>          result = cpu_to_le32(n->features.async_config);
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_get_feature_timestamp(n, cmd);
>      default:
> -        trace_pci_nvme_err_invalid_getfeat(dw10);
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +        result = cpu_to_le32(nvme_feature_default[fid]);

So here we expect uninitialized fid entries to return 0, right?

> +        break;
>      }
>  
>      req->cqe.result = result;
> @@ -1124,8 +1145,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  {
>      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> +    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
>  
> -    switch (dw10) {
> +    trace_pci_nvme_setfeat(nvme_cid(req), fid, dw11);
> +
> +    if (!nvme_feature_support[fid]) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    switch (fid) {
>      case NVME_TEMPERATURE_THRESHOLD:
>          if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
>              break;
> @@ -1172,8 +1200,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
>      default:
> -        trace_pci_nvme_err_invalid_setfeat(dw10);
> -        return NVME_INVALID_FIELD | NVME_DNR;
> +        return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
>      }
>      return NVME_SUCCESS;
>  }
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index f8940435f9ef..8ad1e3c89cee 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -87,6 +87,24 @@ typedef struct NvmeFeatureVal {
>      uint32_t    async_config;
>  } NvmeFeatureVal;
>  
> +static const uint32_t nvme_feature_default[0x100] = {
> +    [NVME_ARBITRATION]           = NVME_ARB_AB_NOLIMIT,
> +};
> +
> +static const bool nvme_feature_support[0x100] = {
> +    [NVME_ARBITRATION]              = true,
> +    [NVME_POWER_MANAGEMENT]         = true,
> +    [NVME_TEMPERATURE_THRESHOLD]    = true,
> +    [NVME_ERROR_RECOVERY]           = true,
> +    [NVME_VOLATILE_WRITE_CACHE]     = true,
> +    [NVME_NUMBER_OF_QUEUES]         = true,
> +    [NVME_INTERRUPT_COALESCING]     = true,
> +    [NVME_INTERRUPT_VECTOR_CONF]    = true,
> +    [NVME_WRITE_ATOMICITY]          = true,
> +    [NVME_ASYNCHRONOUS_EVENT_CONF]  = true,
> +    [NVME_TIMESTAMP]                = true,
> +};

Nack. No variable assignation in header please.
Move that to the source file.

> +
>  typedef struct NvmeCtrl {
>      PCIDevice    parent_obj;
>      MemoryRegion iomem;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 091af16ca7d7..42e62f4649f8 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -46,6 +46,8 @@ pci_nvme_identify_ctrl(void) "identify controller"
>  pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> +pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" cdw11 0x%"PRIx32""
> +pci_nvme_setfeat(uint16_t cid, uint8_t fid, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" cdw11 0x%"PRIx32""
>  pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 0dce15af6bcf..406648d4cf94 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -662,6 +662,7 @@ enum NvmeStatusCodes {
>      NVME_FW_REQ_RESET           = 0x010b,
>      NVME_INVALID_QUEUE_DEL      = 0x010c,
>      NVME_FID_NOT_SAVEABLE       = 0x010d,
> +    NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
>      NVME_FID_NOT_NSID_SPEC      = 0x010f,
>      NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
>      NVME_CONFLICTING_ATTRS      = 0x0180,
> @@ -866,6 +867,7 @@ enum NvmeIdCtrlLpa {
>  #define NVME_CTRL_SGLS_ADDR_OFFSET         (0x1 << 20)
>  
>  #define NVME_ARB_AB(arb)    (arb & 0x7)
> +#define NVME_ARB_AB_NOLIMIT 0x7
>  #define NVME_ARB_LPW(arb)   ((arb >> 8) & 0xff)
>  #define NVME_ARB_MPW(arb)   ((arb >> 16) & 0xff)
>  #define NVME_ARB_HPW(arb)   ((arb >> 24) & 0xff)
> @@ -873,6 +875,8 @@ enum NvmeIdCtrlLpa {
>  #define NVME_INTC_THR(intc)     (intc & 0xff)
>  #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
>  
> +#define NVME_INTVC_NOCOALESCING (0x1 << 16)
> +
>  #define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
>  #define NVME_TEMP_THSEL_OVER   0x0
>  #define NVME_TEMP_THSEL_UNDER  0x1
> @@ -902,6 +906,9 @@ enum NvmeFeatureIds {
>      NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
>  };
>  
> +#define NVME_GETSETFEAT_FID_MASK 0xff
> +#define NVME_GETSETFEAT_FID(dw10) (dw10 & NVME_GETSETFEAT_FID_MASK)
> +
>  typedef struct NvmeRangeType {
>      uint8_t     type;
>      uint8_t     attributes;
> 


