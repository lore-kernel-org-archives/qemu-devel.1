Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A81AC55186
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B932071E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0Z+cKDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B932071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSIVh-0002u9-6t
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSIUn-0001ij-B4
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSIUm-0006tl-MY
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:57:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jSIUm-0006ta-8y
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587812235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDRGRr8h59lZ16agr8SC+2jl+L8bVIn7v1sbPGjDyXA=;
 b=C0Z+cKDFW/TnNG0TvubjbLqaftB59EAgWCoVA+5bY15YYPUKQ6QOesBoBg7BpKzBd8uLLL
 TonBUhHZgfjniPrabpDiU1ZU24bE+95S6lBJ6m2Z1CUxpRMUuTRv0r3ZojbEHcYORktDa9
 ogpHiXTtenvWKqXsiPU+Sl/poJkXVfo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-dxVraxnnNz2NUbRmUYNRYA-1; Sat, 25 Apr 2020 06:57:13 -0400
X-MC-Unique: dxVraxnnNz2NUbRmUYNRYA-1
Received: by mail-wm1-f69.google.com with SMTP id h6so5046502wmi.7
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 03:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TDRGRr8h59lZ16agr8SC+2jl+L8bVIn7v1sbPGjDyXA=;
 b=jAq8GPt826gRESr8LUmg8U9xv7Wa/S8dnWRHcZYG3crcJot+l7b/PxRxU8/EQgbEXY
 GfQ7aReK7vyMIBdOy8Z+OGbBAHfQfu3orFo86bmQ/yqvU/fhfVgw/yFpuV6AINKlxmR0
 gdBJ8Ur6guTKeqJBTUWhWCgHxrL8z+4hGSy8RPgURfXZpZvFffA0iQqXo1RpZkqZS7NZ
 oZtXlvF/xg9rTE8ZBQDtvRIZgjdpqovRktvr+ctuhm7X6L2Zc9CMv+7UKF+7B4Q0z+M0
 G6L8YMT1ss8+R9BmFUFuSg2UHwaXjcEY2Asb1ONBKDLo4q1xkJ8l9CSU5JMG0StNIFuM
 lLDw==
X-Gm-Message-State: AGi0PubpHR1CGKTEVP+PWJ6Vnz/o3ODvLB+UOQgTx2SVCQuWW8LjH3Ox
 qoRho57yTxF/C8vcnzLFIp1a9o1zKlhT9Zyz0nXcXlD3jHIf2lEOnD7i3upPlnGpLk767TwDI2d
 A9tjIylOR5r2V5j8=
X-Received: by 2002:adf:e487:: with SMTP id i7mr16288650wrm.393.1587812232169; 
 Sat, 25 Apr 2020 03:57:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypLBNrFKM3EVL8/OnYaANvo5NG7irgs9xXi0el8M2Naneml4tGzfMJQ7J0QBi6Oqgg2HiNcwtw==
X-Received: by 2002:adf:e487:: with SMTP id i7mr16288634wrm.393.1587812231947; 
 Sat, 25 Apr 2020 03:57:11 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id h2sm6852369wmf.34.2020.04.25.03.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 03:57:11 -0700 (PDT)
Subject: Re: [PATCH] hw/i386/amd_iommu: Fix the reserved bits definition of
 IOMMU commands
To: Wei Huang <wei.huang2@amd.com>, qemu-devel@nongnu.org
References: <20200418042845.596457-1-wei.huang2@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa1c1635-88f4-5bb5-6030-8dec941bf99c@redhat.com>
Date: Sat, 25 Apr 2020 12:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418042845.596457-1-wei.huang2@amd.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 05:12:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/04/20 06:28, Wei Huang wrote:
> Many reserved bits of amd_iommu commands are defined incorrectly in QEMU.
> Because of it, QEMU incorrectly injects lots of illegal commands into guest
> VM's IOMMU event log.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> ---
>  hw/i386/amd_iommu.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index fd75cae02437..4346060e6223 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -370,7 +370,7 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
>      hwaddr addr = cpu_to_le64(extract64(cmd[0], 3, 49)) << 3;
>      uint64_t data = cpu_to_le64(cmd[1]);
>  
> -    if (extract64(cmd[0], 51, 8)) {
> +    if (extract64(cmd[0], 52, 8)) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                     s->cmdbuf + s->cmdbuf_head);
>      }
> @@ -395,7 +395,7 @@ static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>      uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
>  
>      /* This command should invalidate internal caches of which there isn't */
> -    if (extract64(cmd[0], 15, 16) || cmd[1]) {
> +    if (extract64(cmd[0], 16, 44) || cmd[1]) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                     s->cmdbuf + s->cmdbuf_head);
>      }
> @@ -405,9 +405,9 @@ static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>  
>  static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
>  {
> -    if (extract64(cmd[0], 15, 16) ||  extract64(cmd[0], 19, 8) ||
> +    if (extract64(cmd[0], 16, 16) ||  extract64(cmd[0], 52, 8) ||
>          extract64(cmd[1], 0, 2) || extract64(cmd[1], 3, 29)
> -        || extract64(cmd[1], 47, 16)) {
> +        || extract64(cmd[1], 48, 16)) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                     s->cmdbuf + s->cmdbuf_head);
>      }
> @@ -438,8 +438,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
>  {
>      uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
>  
> -    if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 16, 12) ||
> -        extract64(cmd[0], 3, 10)) {
> +    if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
> +        extract64(cmd[1], 3, 9)) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                     s->cmdbuf + s->cmdbuf_head);
>      }
> @@ -451,7 +451,7 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
>  
>  static void amdvi_prefetch_pages(AMDVIState *s, uint64_t *cmd)
>  {
> -    if (extract64(cmd[0], 16, 8) || extract64(cmd[0], 20, 8) ||
> +    if (extract64(cmd[0], 16, 8) || extract64(cmd[0], 52, 8) ||
>          extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
>          extract64(cmd[1], 5, 7)) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
> @@ -463,7 +463,7 @@ static void amdvi_prefetch_pages(AMDVIState *s, uint64_t *cmd)
>  
>  static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
>  {
> -    if (extract64(cmd[0], 16, 16) || cmd[1]) {
> +    if (extract64(cmd[0], 16, 44) || cmd[1]) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                     s->cmdbuf + s->cmdbuf_head);
>          return;
> @@ -479,7 +479,8 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
>  {
>  
>      uint16_t devid = extract64(cmd[0], 0, 16);
> -    if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 9)) {
> +    if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
> +        extract64(cmd[1], 6, 6)) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
>                                     s->cmdbuf + s->cmdbuf_head);
>          return;
> 

Queued, thanks.

Paolo


