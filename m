Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08495C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC8620874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsJ4TGol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC8620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6zi-0008IT-5W
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6tA-0007qA-Dr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX6t8-0006Wv-Q1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603735594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3zKK/C6nlb7gL9WjdPhn1g8qmcnQgsKca0KRpbIeSY=;
 b=HsJ4TGolMWoFY1qyVhnQFDEQIH7ZptHT+ddLWNynD+fKexllFuhu/cRlXqVLoTXF6J+WPp
 SzDTzG7Bw480nJJ7iAxU4fPdkQufqqqgxwzy8R8E3P4B5X5+uPsHjGY33PJTeCpgRN2sm9
 IDqfQ+k/0t11FcXTsJVgubJKSFBheos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-GGZaxlAwOLGef-Hu0etT1Q-1; Mon, 26 Oct 2020 14:06:30 -0400
X-MC-Unique: GGZaxlAwOLGef-Hu0etT1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEA1F56BE3;
 Mon, 26 Oct 2020 18:06:28 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37E0B5B4A4;
 Mon, 26 Oct 2020 18:06:21 +0000 (UTC)
Subject: Re: [PATCH v2 07/19] util/vfio-helpers: Trace PCI BAR region info
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-8-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c95c0cc2-7e32-6fee-a51a-948051604161@redhat.com>
Date: Mon, 26 Oct 2020 19:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-8-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> For debug purpose, trace BAR regions info.
> 
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 8 ++++++++
>  util/trace-events   | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 1d4efafcaa4..cd6287c3a98 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -136,6 +136,7 @@ static inline void assert_bar_index_valid(QEMUVFIOState *s, int index)
>  
>  static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error **errp)
>  {
> +    g_autofree char *barname = NULL;
>      assert_bar_index_valid(s, index);
>      s->bar_region_info[index] = (struct vfio_region_info) {
>          .index = VFIO_PCI_BAR0_REGION_INDEX + index,
> @@ -145,6 +146,10 @@ static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error **errp)
>          error_setg_errno(errp, errno, "Failed to get BAR region info");
>          return -errno;
>      }
> +    barname = g_strdup_printf("bar[%d]", index);
> +    trace_qemu_vfio_region_info(barname, s->bar_region_info[index].offset,
> +                                s->bar_region_info[index].size,
> +                                s->bar_region_info[index].cap_offset);
>  
>      return 0;
>  }
> @@ -416,6 +421,9 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>          ret = -errno;
>          goto fail;
>      }
> +    trace_qemu_vfio_region_info("config", s->config_region_info.offset,
> +                                s->config_region_info.size,
> +                                s->config_region_info.cap_offset);
>  
>      for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
>          ret = qemu_vfio_pci_init_bar(s, i, errp);
> diff --git a/util/trace-events b/util/trace-events
> index c048f85f828..4d40c74a21f 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -87,3 +87,4 @@ qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *io
>  qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
>  qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
>  qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
> +qemu_vfio_region_info(const char *desc, uint64_t offset, uint64_t size, uint32_t cap_offset) "region '%s' ofs 0x%"PRIx64" size %"PRId64" cap_ofs %"PRId32
Use hexa too for the offsets and size. This is generally more readable.

Thanks

Eric
> 


