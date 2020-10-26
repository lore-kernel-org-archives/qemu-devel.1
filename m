Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74268C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F197320874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbHbmpEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F197320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6zL-0007N9-0w
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6pC-00041f-MJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6pA-0005xV-Nx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603735347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw6YY5QCHEiYvr4UiKcC9BtrIULT407mCFEwpfC8CCo=;
 b=XbHbmpExywdYCjekgeFpmrYTgrSFgG55stq4fdzdZiDvysq9KtRI4nB/kt2xlzQ4Y+0DYU
 LH14w4vUZj3YodiDLGgnbzsYFc4n6QeNy0vRd2NyM1UFkxq2lutLJfVgAUnGuzJfXIuM8d
 5G+cKlcqNR+IO/7ik+TDk+T8QCmEHn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-rD7zHEpgPYyNxxeWo2RrSA-1; Mon, 26 Oct 2020 14:02:25 -0400
X-MC-Unique: rD7zHEpgPYyNxxeWo2RrSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6A4B1099F68;
 Mon, 26 Oct 2020 18:02:24 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCEB45C1BB;
 Mon, 26 Oct 2020 18:02:16 +0000 (UTC)
Subject: Re: [PATCH v2 06/19] util/vfio-helpers: Trace PCI I/O config accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-7-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <850b5014-d1b8-ddbf-76e8-360d83fe6f8f@redhat.com>
Date: Mon, 26 Oct 2020 19:02:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-7-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/26/20 11:54 AM, Philippe Mathieu-Daudé wrote:
> We sometime get kernel panic with some devices on Aarch64
> hosts. Alex Williamson suggests it might be broken PCIe
> root complex. Add trace event to record the latest I/O
> access before crashing. In case, assert our accesses are
> aligned.
> 
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 8 ++++++++
>  util/trace-events   | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 14a549510fe..1d4efafcaa4 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -227,6 +227,10 @@ static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
>  {
>      int ret;
>  
> +    trace_qemu_vfio_pci_read_config(buf, ofs, size,
> +                                    s->config_region_info.offset,
> +                                    s->config_region_info.size);
> +    assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
>      do {
>          ret = pread(s->device, buf, size, s->config_region_info.offset + ofs);
>      } while (ret == -1 && errno == EINTR);
> @@ -237,6 +241,10 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int
>  {
>      int ret;
>  
> +    trace_qemu_vfio_pci_write_config(buf, ofs, size,
> +                                     s->config_region_info.offset,
> +                                     s->config_region_info.size);
> +    assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
>      do {
>          ret = pwrite(s->device, buf, size, s->config_region_info.offset + ofs);
>      } while (ret == -1 && errno == EINTR);
> diff --git a/util/trace-events b/util/trace-events
> index 24c31803b01..c048f85f828 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -85,3 +85,5 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova
>  qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size 0x%zx iova 0x%"PRIx64
>  qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
>  qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
> +qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
> +qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
I would personally use 0x%PRIx64 for the size too as generally done in
hw/vfio/trace-events .

Thanks

Eric
> 


