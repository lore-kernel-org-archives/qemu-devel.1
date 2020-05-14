Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6712EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219BC20675
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRWQB9S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219BC20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZKNO-0000Wr-C5
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 16:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZKMW-0008DG-Vw
 for qemu-devel@nongnu.org; Thu, 14 May 2020 16:21:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZKMU-0004Ub-Sp
 for qemu-devel@nongnu.org; Thu, 14 May 2020 16:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589487705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iul9M0m1s7Qhd7lW9ZF7OaIW3H4XdJCv0njcS9Nn/7c=;
 b=MRWQB9S3nWocnBGl/HNq0QrD1zdJh5S4R4btMWYlZ7rTYtZT//wk/jho+ZJRyPeuThuTu8
 JH07JBVyrmZkJHlyE8ZD1vl7a83xq6KTrRrwtOWwNyCORuFg55auHPgxCvvKsOds0bio8/
 49JJD0VgdYbUVQnR6X71pKcwMHPbrTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-oNtkZsVlPeaMgA0iCHeAxQ-1; Thu, 14 May 2020 16:21:43 -0400
X-MC-Unique: oNtkZsVlPeaMgA0iCHeAxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1B56835B57;
 Thu, 14 May 2020 20:21:42 +0000 (UTC)
Received: from [10.10.119.184] (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E68361463;
 Thu, 14 May 2020 20:21:41 +0000 (UTC)
Subject: Re: [PATCH] hw/ide: Make IDEDMAOps handlers take a const IDEDMA
 pointer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200512194917.15807-1-philmd@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <01f5f413-d1d0-43cb-65cc-9f7bd1e59893@redhat.com>
Date: Thu, 14 May 2020 16:21:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512194917.15807-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 12:05:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/12/20 3:49 PM, Philippe Mathieu-Daudé wrote:
> Handlers don't need to modify the IDEDMA structure.
> Make it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I'll trust your judgment. As long as it still compiles and passes
qtests, I'm happy if you're happy.

Acked-by: John Snow <jsnow@redhat.com>

> ---
>  include/hw/ide/internal.h | 12 ++++++------
>  hw/ide/ahci.c             | 18 +++++++++---------
>  hw/ide/core.c             |  6 +++---
>  hw/ide/macio.c            |  6 +++---
>  hw/ide/pci.c              | 12 ++++++------
>  5 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
> index 55da35d768..1a7869e85d 100644
> --- a/include/hw/ide/internal.h
> +++ b/include/hw/ide/internal.h
> @@ -322,12 +322,12 @@ typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
>  
>  typedef void EndTransferFunc(IDEState *);
>  
> -typedef void DMAStartFunc(IDEDMA *, IDEState *, BlockCompletionFunc *);
> -typedef void DMAVoidFunc(IDEDMA *);
> -typedef int DMAIntFunc(IDEDMA *, bool);
> -typedef int32_t DMAInt32Func(IDEDMA *, int32_t len);
> -typedef void DMAu32Func(IDEDMA *, uint32_t);
> -typedef void DMAStopFunc(IDEDMA *, bool);
> +typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
> +typedef void DMAVoidFunc(const IDEDMA *);
> +typedef int DMAIntFunc(const IDEDMA *, bool);
> +typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
> +typedef void DMAu32Func(const IDEDMA *, uint32_t);
> +typedef void DMAStopFunc(const IDEDMA *, bool);
>  
>  struct unreported_events {
>      bool eject_request;
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 13d91e109a..168d34e9f2 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -44,7 +44,7 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot);
>  static void ahci_reset_port(AHCIState *s, int port);
>  static bool ahci_write_fis_d2h(AHCIDevice *ad);
>  static void ahci_init_d2h(AHCIDevice *ad);
> -static int ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit);
> +static int ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit);
>  static bool ahci_map_clb_address(AHCIDevice *ad);
>  static bool ahci_map_fis_address(AHCIDevice *ad);
>  static void ahci_unmap_clb_address(AHCIDevice *ad);
> @@ -1338,7 +1338,7 @@ out:
>  }
>  
>  /* Transfer PIO data between RAM and device */
> -static void ahci_pio_transfer(IDEDMA *dma)
> +static void ahci_pio_transfer(const IDEDMA *dma)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>      IDEState *s = &ad->port.ifs[0];
> @@ -1397,7 +1397,7 @@ out:
>      }
>  }
>  
> -static void ahci_start_dma(IDEDMA *dma, IDEState *s,
> +static void ahci_start_dma(const IDEDMA *dma, IDEState *s,
>                             BlockCompletionFunc *dma_cb)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
> @@ -1406,7 +1406,7 @@ static void ahci_start_dma(IDEDMA *dma, IDEState *s,
>      dma_cb(s, 0);
>  }
>  
> -static void ahci_restart_dma(IDEDMA *dma)
> +static void ahci_restart_dma(const IDEDMA *dma)
>  {
>      /* Nothing to do, ahci_start_dma already resets s->io_buffer_offset.  */
>  }
> @@ -1415,7 +1415,7 @@ static void ahci_restart_dma(IDEDMA *dma)
>   * IDE/PIO restarts are handled by the core layer, but NCQ commands
>   * need an extra kick from the AHCI HBA.
>   */
> -static void ahci_restart(IDEDMA *dma)
> +static void ahci_restart(const IDEDMA *dma)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>      int i;
> @@ -1432,7 +1432,7 @@ static void ahci_restart(IDEDMA *dma)
>   * Called in DMA and PIO R/W chains to read the PRDT.
>   * Not shared with NCQ pathways.
>   */
> -static int32_t ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit)
> +static int32_t ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>      IDEState *s = &ad->port.ifs[0];
> @@ -1453,7 +1453,7 @@ static int32_t ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit)
>   * Called via dma_buf_commit, for both DMA and PIO paths.
>   * sglist destruction is handled within dma_buf_commit.
>   */
> -static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
> +static void ahci_commit_buf(const IDEDMA *dma, uint32_t tx_bytes)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>  
> @@ -1461,7 +1461,7 @@ static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
>      ad->cur_cmd->status = cpu_to_le32(tx_bytes);
>  }
>  
> -static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
> +static int ahci_dma_rw_buf(const IDEDMA *dma, bool is_write)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>      IDEState *s = &ad->port.ifs[0];
> @@ -1486,7 +1486,7 @@ static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
>      return 1;
>  }
>  
> -static void ahci_cmd_done(IDEDMA *dma)
> +static void ahci_cmd_done(const IDEDMA *dma)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>  
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 689bb36409..d997a78e47 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2570,16 +2570,16 @@ static void ide_init1(IDEBus *bus, int unit)
>                                             ide_sector_write_timer_cb, s);
>  }
>  
> -static int ide_nop_int(IDEDMA *dma, bool is_write)
> +static int ide_nop_int(const IDEDMA *dma, bool is_write)
>  {
>      return 0;
>  }
>  
> -static void ide_nop(IDEDMA *dma)
> +static void ide_nop(const IDEDMA *dma)
>  {
>  }
>  
> -static int32_t ide_nop_int32(IDEDMA *dma, int32_t l)
> +static int32_t ide_nop_int32(const IDEDMA *dma, int32_t l)
>  {
>      return 0;
>  }
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index a9f25e5d02..5b8098268d 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -376,17 +376,17 @@ static void macio_ide_reset(DeviceState *dev)
>      ide_bus_reset(&d->bus);
>  }
>  
> -static int ide_nop_int(IDEDMA *dma, bool is_write)
> +static int ide_nop_int(const IDEDMA *dma, bool is_write)
>  {
>      return 0;
>  }
>  
> -static int32_t ide_nop_int32(IDEDMA *dma, int32_t l)
> +static int32_t ide_nop_int32(const IDEDMA *dma, int32_t l)
>  {
>      return 0;
>  }
>  
> -static void ide_dbdma_start(IDEDMA *dma, IDEState *s,
> +static void ide_dbdma_start(const IDEDMA *dma, IDEState *s,
>                              BlockCompletionFunc *cb)
>  {
>      MACIOIDEState *m = container_of(dma, MACIOIDEState, dma);
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 97347f07f1..5e85c4ad17 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -103,7 +103,7 @@ const MemoryRegionOps pci_ide_data_le_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> -static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
> +static void bmdma_start_dma(const IDEDMA *dma, IDEState *s,
>                              BlockCompletionFunc *dma_cb)
>  {
>      BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
> @@ -126,7 +126,7 @@ static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
>   * IDEState.io_buffer_size will contain the number of bytes described
>   * by the PRDs, whether or not we added them to the sglist.
>   */
> -static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t limit)
> +static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
>  {
>      BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>      IDEState *s = bmdma_active_if(bm);
> @@ -181,7 +181,7 @@ static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t limit)
>  }
>  
>  /* return 0 if buffer completed */
> -static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
> +static int bmdma_rw_buf(const IDEDMA *dma, bool is_write)
>  {
>      BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>      IDEState *s = bmdma_active_if(bm);
> @@ -230,7 +230,7 @@ static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
>      return 1;
>  }
>  
> -static void bmdma_set_inactive(IDEDMA *dma, bool more)
> +static void bmdma_set_inactive(const IDEDMA *dma, bool more)
>  {
>      BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>  
> @@ -242,7 +242,7 @@ static void bmdma_set_inactive(IDEDMA *dma, bool more)
>      }
>  }
>  
> -static void bmdma_restart_dma(IDEDMA *dma)
> +static void bmdma_restart_dma(const IDEDMA *dma)
>  {
>      BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>  
> @@ -257,7 +257,7 @@ static void bmdma_cancel(BMDMAState *bm)
>      }
>  }
>  
> -static void bmdma_reset(IDEDMA *dma)
> +static void bmdma_reset(const IDEDMA *dma)
>  {
>      BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>  
> 


