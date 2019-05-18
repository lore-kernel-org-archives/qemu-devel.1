Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C1C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 17:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43762087B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 17:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43762087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS3bR-000149-0a
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 13:58:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hS3a5-0000UK-2Z
	for qemu-devel@nongnu.org; Sat, 18 May 2019 13:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hS3Zd-0004Wq-Mw
	for qemu-devel@nongnu.org; Sat, 18 May 2019 13:56:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:43061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kenneth.heitke@intel.com>)
	id 1hS3Zd-0004Ui-Dx; Sat, 18 May 2019 13:56:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	18 May 2019 10:56:41 -0700
Received: from rpgilroy-mobl1.amr.corp.intel.com (HELO [10.252.138.203])
	([10.252.138.203])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	18 May 2019 10:56:40 -0700
To: Klaus Birkelund Jensen <klaus@birkelund.eu>, qemu-block@nongnu.org
References: <20190518073905.17178-1-klaus@birkelund.eu>
From: "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <ee4de9a0-2cfb-c2f3-fabb-d91a07daf7bf@intel.com>
Date: Sat, 18 May 2019 11:56:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190518073905.17178-1-klaus@birkelund.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH] nvme: fix copy direction in DMA reads
 going to CMB
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/18/2019 1:39 AM, Klaus Birkelund Jensen wrote:
> `nvme_dma_read_prp` erronously used `qemu_iovec_*to*_buf` instead of
> `qemu_iovec_*from*_buf` when the request involved the controller memory
> buffer.
> 
> Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
> ---
>   hw/block/nvme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7caf92532a09..63a5b58849fb 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -238,7 +238,7 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>           }
>           qemu_sglist_destroy(&qsg);
>       } else {
> -        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) != len)) {
> +        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) != len)) {
>               trace_nvme_err_invalid_dma();
>               status = NVME_INVALID_FIELD | NVME_DNR;
>           }
> 

Reviewed-by: Kenneth Heitke <kenneth.heitke@intel.com>

