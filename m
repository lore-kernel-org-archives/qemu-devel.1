Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0E0C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3149D2074F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STf5msoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3149D2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfW1-0003xn-Cs
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOfPj-00040a-UZ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOfPi-0001Xq-MB
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:37:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53374
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOfPi-0001XY-HO
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586947022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDfuqoOho3wrn6/nWucDhG5VcyPRj9pbXgSdAphjrZU=;
 b=STf5msoqqEGMx+nhkevJo73/QwF8R1EHcuXl4BZmZcsSV0qhtNrWUX+mMrMgh0UbQ30tEA
 wkYVZY5QAxHP80KPD02tFRMPapAUXI4g4dWg92Z9csaDPTvE1WtgwDrdHE88XNI/0dZjl4
 KtFBiL39+0/FZAsiDCrzQJXMGs6n8rQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-kn1TQl1JP-ypDLrS8fh_qA-1; Wed, 15 Apr 2020 06:36:58 -0400
X-MC-Unique: kn1TQl1JP-ypDLrS8fh_qA-1
Received: by mail-ed1-f71.google.com with SMTP id q27so2552634edc.15
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QDfuqoOho3wrn6/nWucDhG5VcyPRj9pbXgSdAphjrZU=;
 b=KZCPfTBu77PwW5KJ+Z+0+hjTmPGPXUU5Fitw51zVKU4/De5f6ETxR72e9G9pr33kol
 OhGxlJKuhA10ADSN8Ms5K03DPdtaB6lI76G1+ymni7krXbc2RyqYNJqKMJlHvVlNwnHG
 K5NCNda0ee+q7ps2i6DyxZjioOGRdgztlYs9h03HIrRXUt3p+7oLa5MRcTFYFPOmy+1Y
 QJypvrilDWaY9w6Kyy9u3zeIjDkvJbGd1PEJ+axn0sEsUHa4HPb1uoUDPzrRTOPXFma/
 TQ3tI3WFn1h4Ln9zPr5JpcxUJRzuogD1+ccVW1brZH4n4LaraE8LA//Dea8qIefjTeCf
 jmkA==
X-Gm-Message-State: AGi0PubKFZxjcjtTdyAjPYtbN9gG0XUJXH/bf90ZLDeLe5cUUqjFe1es
 Pp8kQgouIOuOEls6rjw+Hae2+QFHUpi2w/j5a2tkAwMM8CjbARwskwDNSlGHa4S/JkfHgASG82M
 g1Tw6/TxU2v+uSNk=
X-Received: by 2002:aa7:d857:: with SMTP id f23mr23993926eds.235.1586947017317; 
 Wed, 15 Apr 2020 03:36:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZutSx5VxPg6GZtKFwdiGI58HY6j+AP1EorroXWZiJH8q0fj0pS0XuNOmtEqPRbC88mC6Ntg==
X-Received: by 2002:aa7:d857:: with SMTP id f23mr23993908eds.235.1586947016982; 
 Wed, 15 Apr 2020 03:36:56 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id m5sm2584919ejq.51.2020.04.15.03.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 03:36:56 -0700 (PDT)
Subject: Re: [PATCH 12/16] nvme: add namespace helpers
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-13-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8315d218-c677-56e3-b589-d3aa3144f745@redhat.com>
Date: Wed, 15 Apr 2020 12:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415102445.564803-13-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 12:24 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Introduce some small helpers to make the next patches easier on the eye.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index ad1786953be9..d9900bed957c 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -67,6 +67,17 @@ typedef struct NvmeNamespace {
>       NvmeIdNs        id_ns;
>   } NvmeNamespace;
>   
> +static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> +{
> +    NvmeIdNs *id_ns = &ns->id_ns;
> +    return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> +}
> +
> +static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> +{
> +    return nvme_ns_lbaf(ns)->ds;
> +}
> +
>   #define TYPE_NVME "nvme"
>   #define NVME(obj) \
>           OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> @@ -101,4 +112,9 @@ typedef struct NvmeCtrl {
>       NvmeIdCtrl      id_ctrl;
>   } NvmeCtrl;
>   
> +static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> +{
> +    return n->ns_size >> nvme_ns_lbads(ns);
> +}
> +
>   #endif /* HW_NVME_H */
> 

Personally I'd use it directly in the same patch, this is one more hunk:

@@ -1455,18 +1469,9 @@ static void nvme_realize(PCIDevice *pci_dev, 
Error **errp)
[...]
-        id_ns->ncap  = id_ns->nuse = id_ns->nsze =
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
+            cpu_to_le64(nvme_ns_nlbas(n, ns));


