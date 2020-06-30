Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E62C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2570206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzC7Slfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2570206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqClX-00054T-3m
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqCju-00037Y-Kc
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:39:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqCjs-0000UD-AS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sd50wt1Ki5WYZKEFKx0I38rjdYDl/JFwsBJgfxM/Bo4=;
 b=TzC7Slfer3sh3xJzPEsAeuUwkZP69b1yh7qJcOaXGriTThyP70C92aFZuI93WSpLokN0NI
 R4M4mCHUetV2lInxNHwCR6t2P8vLTHN7/cC7E0/l3JpOtd8TX1lnFLRKHPsn55AVbP/YHV
 Q3o9isl6QEhooWh3Fwb2ZovXRO7WZEA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-5Ht8-2q8NveQfLSLXduWrQ-1; Tue, 30 Jun 2020 05:38:57 -0400
X-MC-Unique: 5Ht8-2q8NveQfLSLXduWrQ-1
Received: by mail-ej1-f70.google.com with SMTP id d17so12050436ejy.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 02:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Sd50wt1Ki5WYZKEFKx0I38rjdYDl/JFwsBJgfxM/Bo4=;
 b=pFZwZpm8zJxgOYrVwoSMG2gZcy1oFPNqEGNRF6cviNHE6l0bchUJlTkqnA7vB4RQdQ
 3HJQo3dBzeGycLQKjZUTOsOmKlm1q1BWNM/1Dui/W6mx+U4XfaPEXQ5NutJOfBQRbwTu
 ilDhFitie1hMCD1ZWxEijRuoHM3/FEczEw2OOe5hCZitWr21i4X33/dg0DpQnA6Sk+tx
 BI7g6qdti35oobR2TWUWy0v34k2Y5vvo+yCl5r00fsOPECX/zsIqMLx3IfDXeypPasZS
 c0OJVrC9fB7tATn2BB6/espp0JLJFRiSKJ97m1NZAjV1nbutqwxGNCZuoe2BTMj6OqEI
 llNA==
X-Gm-Message-State: AOAM533TAYdZy5mCmssCIhmHW7EnfHUh1E3YRYOvOVVANyFUL1oR4wSW
 fpReMnCIgz4v3vY8jOG9XfXdX8fM1jgP3g0Nt2Q707Qn/5yotNUe7t+RqJ4Gmw+B0SG6Bwj65Bt
 gwuuQsSjSAYGQCbM=
X-Received: by 2002:aa7:c15a:: with SMTP id r26mr21143303edp.21.1593509936390; 
 Tue, 30 Jun 2020 02:38:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYqjuiTc0hZNBYamwhi6OWyQ61h3TJ+zIOqkxnmHD+ZvPvFkZmB+BCXqCI9ZaBovtvh1hmYw==
X-Received: by 2002:aa7:c15a:: with SMTP id r26mr21143287edp.21.1593509936152; 
 Tue, 30 Jun 2020 02:38:56 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c7sm2206144edt.35.2020.06.30.02.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 02:38:55 -0700 (PDT)
Subject: Re: [PATCH 1/3] hw/block/nvme: add NVMe 1.4 specific fields
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200630043122.1307043-1-its@irrelevant.dk>
 <20200630043122.1307043-2-its@irrelevant.dk>
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
Message-ID: <8d851505-9b7b-0a7c-260c-ab8ba8130d0a@redhat.com>
Date: Tue, 30 Jun 2020 11:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630043122.1307043-2-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 6:31 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add new fields from NVM Express v1.4.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c      |   3 +-
>  include/block/nvme.h | 195 +++++++++++++++++++++++++++++++++++++------
>  2 files changed, 172 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 8e147b667c81..07ac409f37c9 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -60,7 +60,7 @@
>  #define NVME_MAX_IOQPAIRS 0xffff
>  #define NVME_REG_SIZE 0x1000
>  #define NVME_DB_SIZE  4
> -#define NVME_SPEC_VER 0x00010300
> +#define NVME_SPEC_VER 0x00010400
>  #define NVME_CMB_BIR 2
>  #define NVME_PMR_BIR 2
>  #define NVME_TEMPERATURE 0x143
> @@ -2910,6 +2910,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->ieee[2] = 0xb3;
>      id->mdts = n->params.mdts;
>      id->ver = cpu_to_le32(NVME_SPEC_VER);
> +    id->cntrltype = 0x1;
>      id->oacs = cpu_to_le16(0);
>  
>      /*
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 2a9c5e95bfd2..b27be237cd33 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -7,7 +7,7 @@ typedef struct NvmeBar {
>      uint32_t    intms;
>      uint32_t    intmc;
>      uint32_t    cc;
> -    uint32_t    rsvd1;
> +    uint8_t     rsvd24[4];
>      uint32_t    csts;
>      uint32_t    nssrc;
>      uint32_t    aqa;
> @@ -15,14 +15,20 @@ typedef struct NvmeBar {
>      uint64_t    acq;
>      uint32_t    cmbloc;
>      uint32_t    cmbsz;
> -    uint8_t     padding[3520]; /* not used by QEMU */
> +    uint32_t    bpinfo;
> +    uint32_t    bprsel;
> +    uint64_t    bpmbl;
> +    uint64_t    cmbmsc;
> +    uint32_t    cmbsts;
> +    uint8_t     rsvd92[3492];
>      uint32_t    pmrcap;
>      uint32_t    pmrctl;
>      uint32_t    pmrsts;
>      uint32_t    pmrebs;
>      uint32_t    pmrswtp;
> -    uint32_t    pmrmsc;
> -} NvmeBar;
> +    uint64_t    pmrmsc;
> +    uint8_t     rsvd3612[484];
> +} QEMU_PACKED NvmeBar;
>  
>  enum NvmeCapShift {
>      CAP_MQES_SHIFT     = 0,
> @@ -34,7 +40,8 @@ enum NvmeCapShift {
>      CAP_CSS_SHIFT      = 37,
>      CAP_MPSMIN_SHIFT   = 48,
>      CAP_MPSMAX_SHIFT   = 52,
> -    CAP_PMR_SHIFT      = 56,
> +    CAP_PMRS_SHIFT     = 56,
> +    CAP_CMBS_SHIFT     = 57,
>  };
>  
>  enum NvmeCapMask {
> @@ -47,7 +54,8 @@ enum NvmeCapMask {
>      CAP_CSS_MASK       = 0xff,
>      CAP_MPSMIN_MASK    = 0xf,
>      CAP_MPSMAX_MASK    = 0xf,
> -    CAP_PMR_MASK       = 0x1,
> +    CAP_PMRS_MASK      = 0x1,
> +    CAP_CMBS_MASK      = 0x1,
>  };
>  
>  #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
> @@ -59,6 +67,8 @@ enum NvmeCapMask {
>  #define NVME_CAP_CSS(cap)   (((cap) >> CAP_CSS_SHIFT)    & CAP_CSS_MASK)
>  #define NVME_CAP_MPSMIN(cap)(((cap) >> CAP_MPSMIN_SHIFT) & CAP_MPSMIN_MASK)
>  #define NVME_CAP_MPSMAX(cap)(((cap) >> CAP_MPSMAX_SHIFT) & CAP_MPSMAX_MASK)
> +#define NVME_CAP_PMRS(cap)  (((cap) >> CAP_PMRS_SHIFT)   & CAP_PMRS_MASK)
> +#define NVME_CAP_CMBS(cap)  (((cap) >> CAP_CMBS_SHIFT)   & CAP_CMBS_MASK)
>  
>  #define NVME_CAP_SET_MQES(cap, val)   (cap |= (uint64_t)(val & CAP_MQES_MASK)  \
>                                                             << CAP_MQES_SHIFT)
> @@ -78,8 +88,10 @@ enum NvmeCapMask {
>                                                             << CAP_MPSMIN_SHIFT)
>  #define NVME_CAP_SET_MPSMAX(cap, val) (cap |= (uint64_t)(val & CAP_MPSMAX_MASK)\
>                                                              << CAP_MPSMAX_SHIFT)
> -#define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
> -                                                            << CAP_PMR_SHIFT)
> +#define NVME_CAP_SET_PMRS(cap, val)   (cap |= (uint64_t)(val & CAP_PMRS_MASK)\
> +                                                            << CAP_PMRS_SHIFT)
> +#define NVME_CAP_SET_CMBS(cap, val)   (cap |= (uint64_t)(val & CAP_CMBS_MASK)\
> +                                                            << CAP_CMBS_SHIFT)
>  
>  enum NvmeCcShift {
>      CC_EN_SHIFT     = 0,
> @@ -151,22 +163,58 @@ enum NvmeAqaMask {
>  #define NVME_AQA_ACQS(aqa) ((aqa >> AQA_ACQS_SHIFT) & AQA_ACQS_MASK)
>  
>  enum NvmeCmblocShift {
> -    CMBLOC_BIR_SHIFT  = 0,
> -    CMBLOC_OFST_SHIFT = 12,
> +    CMBLOC_BIR_SHIFT     = 0,
> +    CMBLOC_CQMMS_SHIFT   = 3,
> +    CMBLOC_CQPDS_SHIFT   = 4,
> +    CMBLOC_CDPMLS_SHIFT  = 5,
> +    CMBLOC_CDPCILS_SHIFT = 6,
> +    CMBLOC_CDMMMS_SHIFT  = 7,
> +    CMBLOC_CQDA_SHIFT    = 8,
> +    CMBLOC_OFST_SHIFT    = 12,
>  };
>  
>  enum NvmeCmblocMask {
> -    CMBLOC_BIR_MASK  = 0x7,
> -    CMBLOC_OFST_MASK = 0xfffff,
> +    CMBLOC_BIR_MASK     = 0x7,
> +    CMBLOC_CQMMS_MASK   = 0x1,
> +    CMBLOC_CQPDS_MASK   = 0x1,
> +    CMBLOC_CDPMLS_MASK  = 0x1,
> +    CMBLOC_CDPCILS_MASK = 0x1,
> +    CMBLOC_CDMMMS_MASK  = 0x1,
> +    CMBLOC_CQDA_MASK    = 0x1,
> +    CMBLOC_OFST_MASK    = 0xfffff,
>  };
>  
> -#define NVME_CMBLOC_BIR(cmbloc) ((cmbloc >> CMBLOC_BIR_SHIFT)  & \
> -                                 CMBLOC_BIR_MASK)
> -#define NVME_CMBLOC_OFST(cmbloc)((cmbloc >> CMBLOC_OFST_SHIFT) & \
> -                                 CMBLOC_OFST_MASK)
> +#define NVME_CMBLOC_BIR(cmbloc) \
> +    ((cmbloc >> CMBLOC_BIR_SHIFT) & CMBLOC_BIR_MASK)
> +#define NVME_CMBLOC_CQMMS(cmbloc) \
> +    ((cmbloc >> CMBLOC_CQMMS_SHIFT) & CMBLOC_CQMMS_MASK)
> +#define NVME_CMBLOC_CQPDS(cmbloc) \
> +    ((cmbloc >> CMBLOC_CQPDS_SHIFT) & CMBLOC_CQPDS_MASK)
> +#define NVME_CMBLOC_CDPMLS(cmbloc) \
> +    ((cmbloc >> CMBLOC_CDPMLS_SHIFT) & CMBLOC_CDPMLS_MASK)
> +#define NVME_CMBLOC_CDPCILS(cmbloc) \
> +    ((cmbloc >> CMBLOC_CDPCILS_SHIFT) & CMBLOC_CDPCILS_MASK)
> +#define NVME_CMBLOC_CDMMS(cmbloc) \
> +    ((cmbloc >> CMBLOC_CDMMS_SHIFT) & CMBLOC_CDMMS_MASK)
> +#define NVME_CMBLOC_CQDA(cmbloc) \
> +    ((cmbloc >> CMBLOC_CQDA_SHIFT) & CMBLOC_CQDA_MASK)
> +#define NVME_CMBLOC_OFST(cmbloc) \
> +    ((cmbloc >> CMBLOC_OFST_SHIFT) & CMBLOC_OFST_MASK)
>  
> -#define NVME_CMBLOC_SET_BIR(cmbloc, val)  \
> +#define NVME_CMBLOC_SET_BIR(cmbloc, val) \
>      (cmbloc |= (uint64_t)(val & CMBLOC_BIR_MASK) << CMBLOC_BIR_SHIFT)
> +#define NVME_CMBLOC_SET_CQMMS(cmbloc, val) \
> +    (cmbloc |= (uint64_t)(val & CMBLOC_CQMMS_MASK) << CMBLOC_CQMMS_SHIFT)
> +#define NVME_CMBLOC_SET_CQPDS(cmbloc, val) \
> +    (cmbloc |= (uint64_t)(val & CMBLOC_CQPDS_MASK) << CMBLOC_CQPDS_SHIFT)
> +#define NVME_CMBLOC_SET_CDPMLS(cmbloc, val) \
> +    (cmbloc |= (uint64_t)(val & CMBLOC_CDPMLS_MASK) << CMBLOC_CDPMLS_SHIFT)
> +#define NVME_CMBLOC_SET_CDPCILS(cmbloc, val) \
> +    (cmbloc |= (uint64_t)(val & CMBLOC_CDPCILS_MASK) << CMBLOC_CDPCILS_SHIFT)
> +#define NVME_CMBLOC_SET_CDMMS(cmbloc, val) \
> +    (cmbloc |= (uint64_t)(val & CMBLOC_CDMMS_MASK) << CMBLOC_CDMMS_SHIFT)
> +#define NVME_CMBLOC_SET_CQDA(cmbloc, val) \
> +    (cmbloc |= (uint64_t)(val & CMBLOC_CQDA_MASK) << CMBLOC_CQDA_SHIFT)
>  #define NVME_CMBLOC_SET_OFST(cmbloc, val) \
>      (cmbloc |= (uint64_t)(val & CMBLOC_OFST_MASK) << CMBLOC_OFST_SHIFT)
>  
> @@ -377,6 +425,35 @@ enum NvmePmrmscMask {
>  #define NVME_PMRMSC_SET_CBA(pmrmsc, val)   \
>      (pmrmsc |= (uint64_t)(val & PMRMSC_CBA_MASK) << PMRMSC_CBA_SHIFT)
>  
> +enum NvmeCmbmscShift {
> +    CMBMSC_CRE_SHIFT  = 0,
> +    CMBMSC_CMSE_SHIFT = 1,
> +    CMBMSC_CBA_SHIFT  = 12,
> +};
> +
> +enum NvmeCmbmscMask {
> +    CMBMSC_CRE_MASK  = 0x1,
> +    CMBMSC_CMSE_MASK = 0x1,
> +};
> +
> +#define CMBMSC_CBA_MASK ((1 << 52) - 1)
> +
> +#define NVME_CMBMSC_CRE(cmbmsc) \
> +    ((cmbmsc >> CMBMSC_CRE_SHIFT)  & CMBMSC_CRE_MASK)
> +#define NVME_CMBMSC_CMSE(cmbmsc) \
> +    ((cmbmsc >> CMBMSC_CMSE_SHIFT) & CMBMSC_CMSE_MASK)
> +#define NVME_CMBMSC_CBA(cmbmsc) \
> +    ((cmbmsc >> CMBMSC_CBA_SHIFT)  & CMBMSC_CBA_MASK)
> +
> +#define NVME_CMBMSC_SET_CRE(cmbmsc, val)  \
> +    (cmbmsc |= (uint64_t)(val & CMBMSC_CRE_MASK) << CMBMSC_CRE_SHIFT)
> +#define NVME_CMBMSC_SET_CMSE(cmbmsc, val) \
> +    (cmbmsc |= (uint64_t)(val & CMBMSC_CMSE_MASK) << CMBMSC_CMSE_SHIFT)
> +#define NVME_CMBMSC_SET_CBA(cmbmsc, val)  \
> +    (cmbmsc |= (uint64_t)(val & CMBMSC_CBA_MASK) << CMBMSC_CBA_SHIFT)
> +
> +#define NVME_CMBSTS_CBAI(cmbsts) (cmsts & 0x1)
> +
>  enum NvmeSglDescriptorType {
>      NVME_SGL_DESCR_TYPE_DATA_BLOCK          = 0x0,
>      NVME_SGL_DESCR_TYPE_BIT_BUCKET          = 0x1,
> @@ -523,8 +600,12 @@ typedef struct NvmeIdentify {
>      uint64_t    rsvd2[2];
>      uint64_t    prp1;
>      uint64_t    prp2;
> -    uint32_t    cns;
> -    uint32_t    rsvd11[5];
> +    uint8_t     cns;
> +    uint8_t     rsvd3;
> +    uint16_t    cntid;
> +    uint16_t    nvmsetid;
> +    uint16_t    rsvd4;
> +    uint32_t    rsvd11[4];
>  } NvmeIdentify;
>  
>  typedef struct NvmeRwCmd {
> @@ -681,6 +762,23 @@ enum NvmeStatusCodes {
>      NVME_NO_COMPLETE            = 0xffff,
>  };
>  
> +typedef struct NvmeNvmSetAttributes {
> +    uint16_t nvmsetid;
> +    uint16_t endgid;
> +    uint8_t  rsvd7[4];
> +    uint32_t rrt;
> +    uint32_t ows;
> +    uint8_t  tnvmsetcap[16];
> +    uint8_t  unvmsetcap[16];
> +    uint8_t  rsvd127[80];
> +} NvmeNvmSetAttributes;
> +
> +typedef struct NvmeIdNvmSetList {
> +    uint8_t nid;
> +    uint8_t rsvd127[127];
> +    NvmeNvmSetAttributes sets[31];
> +} NvmeIdNvmSetList;
> +
>  typedef struct NvmeFwSlotInfoLog {
>      uint8_t     afi;
>      uint8_t     reserved1[7];
> @@ -734,6 +832,24 @@ enum NvmeSmartWarn {
>      NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
>  };
>  
> +typedef struct NvmeEnduranceGroupLog {
> +    uint8_t critical_warning;
> +    uint8_t rsvd2[2];
> +    uint8_t available_spare;
> +    uint8_t available_spare_threshold;
> +    uint8_t percentage_used;
> +    uint8_t rsvd31[26];
> +    uint8_t endurance_estimate[16];
> +    uint8_t data_units_read[16];
> +    uint8_t data_units_written[16];
> +    uint8_t media_units_written[16];
> +    uint8_t host_read_commands[16];
> +    uint8_t host_write_commands[16];
> +    uint8_t media_and_data_integrity_errors[16];
> +    uint8_t number_of_error_information_log_entries[16];
> +    uint8_t rsvd511[352];
> +} NvmeEnduranceGroupLog;
> +
>  enum NvmeLogIdentifier {
>      NVME_LOG_ERROR_INFO     = 0x01,
>      NVME_LOG_SMART_INFO     = 0x02,
> @@ -777,9 +893,14 @@ typedef struct NvmeIdCtrl {
>      uint32_t    rtd3e;
>      uint32_t    oaes;
>      uint32_t    ctratt;
> -    uint8_t     rsvd100[12];
> +    uint16_t    rrls;
> +    uint8_t     rsvd102[9];
> +    uint8_t     cntrltype;
>      uint8_t     fguid[16];
> -    uint8_t     rsvd128[128];
> +    uint16_t    crdt1;
> +    uint16_t    crdt2;
> +    uint16_t    crdt3;
> +    uint8_t     rsvd134[122];
>      uint16_t    oacs;
>      uint8_t     acl;
>      uint8_t     aerl;
> @@ -805,7 +926,16 @@ typedef struct NvmeIdCtrl {
>      uint16_t    mntmt;
>      uint16_t    mxtmt;
>      uint32_t    sanicap;
> -    uint8_t     rsvd332[180];
> +    uint32_t    hmminds;
> +    uint16_t    hmmaxd;
> +    uint16_t    nsetidmax;
> +    uint16_t    endgidmax;
> +    uint8_t     anatt;
> +    uint8_t     anacap;
> +    uint32_t    anagrpmax;
> +    uint32_t    nanagrpid;
> +    uint32_t    pels;
> +    uint8_t     rsvd356[156];
>      uint8_t     sqes;
>      uint8_t     cqes;
>      uint16_t    maxcmd;
> @@ -817,11 +947,12 @@ typedef struct NvmeIdCtrl {
>      uint16_t    awun;
>      uint16_t    awupf;
>      uint8_t     nvscc;
> -    uint8_t     rsvd531;
> +    uint8_t     nwpc;
>      uint16_t    acwu;
>      uint8_t     rsvd534[2];
>      uint32_t    sgls;
> -    uint8_t     rsvd540[228];
> +    uint32_t    mnan;
> +    uint8_t     rsvd544[224];
>      uint8_t     subnqn[256];
>      uint8_t     rsvd1024[1024];
>      NvmePSD     psd[32];
> @@ -976,7 +1107,17 @@ typedef struct NvmeIdNs {
>      uint16_t    nabspf;
>      uint16_t    noiob;
>      uint8_t     nvmcap[16];
> -    uint8_t     rsvd64[40];
> +    uint16_t    npwg;
> +    uint16_t    npwa;
> +    uint16_t    npdg;
> +    uint16_t    npda;
> +    uint16_t    nows;
> +    uint8_t     rsvd74[18];
> +    uint32_t    anagrpid;
> +    uint8_t     rsvd96[3];
> +    uint8_t     nsattr;
> +    uint16_t    nvmsetid;
> +    uint16_t    endgid;
>      uint8_t     nguid[16];
>      uint64_t    eui64;
>      NvmeLBAF    lbaf[16];
> @@ -1048,7 +1189,11 @@ static inline void _nvme_check_size(void)
>      QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeEnduranceGroupLog) != 512);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
>      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeNvmSetAttributes) != 128);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNvmSetList) != 4096);
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
>  }
>  #endif
> 


