Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A7AC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F65521481
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGOtUAuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F65521481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhkm-0006cV-Oq
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 17:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVhiy-0005fn-8u
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 17:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVhiv-0005rt-0M
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 17:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603400531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZmJkxVa6e/6odY3Fw8eK/Uqe9Fg9nciaR9k8MrOYxA=;
 b=eGOtUAuqIYGd1BnhFW50Qco/UyD0rRhKFLx1tKP00YFQlbqok390Rf/DSIwB2N88c8PXhs
 FmKnqGzLNTieYJj+g0w8O/DzS9cqUjT+QEvbEDccBAExTB9nbaahVWhdVnOQ5VzhsxvUnA
 UN9RrJqYxVRkWtoy9gaQdJbaS71j0nk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-J6vff7oeP4iyS7VLO0UKkQ-1; Thu, 22 Oct 2020 17:02:08 -0400
X-MC-Unique: J6vff7oeP4iyS7VLO0UKkQ-1
Received: by mail-wm1-f72.google.com with SMTP id g71so1113686wmg.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 14:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ZmJkxVa6e/6odY3Fw8eK/Uqe9Fg9nciaR9k8MrOYxA=;
 b=r2Y15kd8YE10rbBgRwbOQTnyuL5hlTW/4XgFjbM0gmMjTQ+rBeDARCksYCgydEIBzs
 pizRPhjc6IZN4cjVGHVV1mi3x8suhb7Tv4UwkWdhxF+uit7Myn3YMNLc5kFrJLtskWVs
 1VDtY+LbRI/pOiIpuSJ1OdXa7MwlQshxMoSYwXG1Q0dvGB2S4A0Vj5YCXhTfXNxxXhel
 RFoT4GgFNI8Xzz1/MH/VEV9xBk/3R20d5AWON6gpNvpQ9yF4GfrFxYAe3RhONAhmctB7
 YKWyRZhxG4HaWfu9FN+jc/6mQeg62W8Z21Vb+uIyd8cYgBrtb42ijXNlBCL0+G6bF3Be
 5C5Q==
X-Gm-Message-State: AOAM530fWbpZAj+8yFG7WJHDqi9DppE2IrD9qMpgtYZj+9WQfLlmIhFf
 fsFPh9Fo40SRFkQ+SouJ5KeX7h7w9l7iH6iNHLWhQ4sWEVhxGLHjqmHvasioP/yC0Upzxjaz/ED
 67bns2ETrix7slrs=
X-Received: by 2002:adf:a1cb:: with SMTP id v11mr4431563wrv.86.1603400526286; 
 Thu, 22 Oct 2020 14:02:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGGS3F1WUzmKHRio0zBlkO80XrFMM1nVSMo80d/wbFVlh00VSQi/6LXtrm+ZTZy+IfAgHzZA==
X-Received: by 2002:adf:a1cb:: with SMTP id v11mr4431536wrv.86.1603400525967; 
 Thu, 22 Oct 2020 14:02:05 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q5sm6508284wrs.54.2020.10.22.14.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 14:02:05 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] hw/block/nvme: add the dataset management command
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20201022184959.240505-1-its@irrelevant.dk>
 <20201022184959.240505-3-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05c41ab7-039f-f327-c6a0-5864430f5ba6@redhat.com>
Date: Thu, 22 Oct 2020 23:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022184959.240505-3-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 10/22/20 8:49 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add support for the Dataset Management command and the Deallocate
> attribute. Deallocation results in discards being sent to the underlying
> block device. Whether of not the blocks are actually deallocated is
> affected by the same factors as Write Zeroes (see previous commit).
> 
>       format | discard | dsm (512b)  dsm (4kb)  dsm (64kb)

Please use B/KiB units which are unambiguous (kb is for kbits)
(if you queue this yourself, you can fix when applying, no need
to repost).

>      ------------------------------------------------------
>        qcow2    ignore   n           n          n
>        qcow2    unmap    n           n          y
>        raw      ignore   n           n          n
>        raw      unmap    n           y          y
> 
> Again, a raw format and 4kb LBAs are preferable.
> 
> In order to set the Namespace Preferred Deallocate Granularity and
> Alignment fields (NPDG and NPDA), choose a sane minimum discard
> granularity of 4kb. If we are using a passthru device supporting discard
> at a 512b granularity, user should set the discard_granularity property

Ditto.

> explicitly. NPDG and NPDA will also account for the cluster_size of the
> block driver if required (i.e. for QCOW2).
> 
> See NVM Express 1.3d, Section 6.7 ("Dataset Management command").
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.h      |   2 +
>   include/block/nvme.h |   7 ++-
>   hw/block/nvme-ns.c   |  36 +++++++++++++--
>   hw/block/nvme.c      | 101 ++++++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 140 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index e080a2318a50..574333caa3f9 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -28,6 +28,7 @@ typedef struct NvmeRequest {
>       struct NvmeNamespace    *ns;
>       BlockAIOCB              *aiocb;
>       uint16_t                status;
> +    void                    *opaque;
>       NvmeCqe                 cqe;
>       NvmeCmd                 cmd;
>       BlockAcctCookie         acct;
> @@ -60,6 +61,7 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
>       case NVME_CMD_WRITE:            return "NVME_NVM_CMD_WRITE";
>       case NVME_CMD_READ:             return "NVME_NVM_CMD_READ";
>       case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
> +    case NVME_CMD_DSM:              return "NVME_NVM_CMD_DSM";
>       default:                        return "NVME_NVM_CMD_UNKNOWN";
>       }
>   }
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 966c3bb304bd..e95ff6ca9b37 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -990,7 +990,12 @@ typedef struct QEMU_PACKED NvmeIdNs {
>       uint16_t    nabspf;
>       uint16_t    noiob;
>       uint8_t     nvmcap[16];
> -    uint8_t     rsvd64[40];
> +    uint16_t    npwg;
> +    uint16_t    npwa;
> +    uint16_t    npdg;
> +    uint16_t    npda;
> +    uint16_t    nows;
> +    uint8_t     rsvd74[30];
>       uint8_t     nguid[16];
>       uint64_t    eui64;
>       NvmeLBAF    lbaf[16];

If you consider "block/nvme.h" shared by 2 different subsystems,
it is better to add the changes in a separate patch. That way
the changes can be acked individually.

> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index f1cc734c60f5..840651db7256 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -28,10 +28,14 @@
>   #include "nvme.h"
>   #include "nvme-ns.h"
>   
> -static void nvme_ns_init(NvmeNamespace *ns)
> +#define MIN_DISCARD_GRANULARITY (4 * KiB)
> +
> +static int nvme_ns_init(NvmeNamespace *ns, Error **errp)

Hmm the Error* argument could be squashed in "hw/block/nvme:
support multiple namespaces". Else better split patch in dumb
units IMHO (maybe a reviewer's taste).

>   {
> +    BlockDriverInfo bdi;
>       NvmeIdNs *id_ns = &ns->id_ns;
>       int lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
> +    int npdg, ret;
>   
>       ns->id_ns.dlfeat = 0x9;
>   
> @@ -43,8 +47,25 @@ static void nvme_ns_init(NvmeNamespace *ns)
>       id_ns->ncap = id_ns->nsze;
>       id_ns->nuse = id_ns->ncap;
>   
> -    /* support DULBE */
> -    id_ns->nsfeat |= 0x4;
> +    /* support DULBE and I/O optimization fields */
> +    id_ns->nsfeat |= (0x4 | 0x10);

The comment helps, but isn't needed if you use explicit definitions
for these flags. You already introduced the NVME_ID_NS_NSFEAT_DULBE
and NVME_ID_NS_FLBAS_EXTENDED but they are restricted to extract bits.
This is why I personally prefer the registerfields API (see
"hw/registerfields.h").

> +
> +    npdg = ns->blkconf.discard_granularity / ns->blkconf.logical_block_size;
> +
> +    ret = bdrv_get_info(blk_bs(ns->blkconf.blk), &bdi);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "could not get block driver info");
> +        return ret;
> +    }
> +
> +    if (bdi.cluster_size &&
> +        bdi.cluster_size > ns->blkconf.discard_granularity) {
> +        npdg = bdi.cluster_size / ns->blkconf.logical_block_size;
> +    }
> +
> +    id_ns->npda = id_ns->npdg = npdg - 1;
> +
> +    return 0;
>   }
>   
>   static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> @@ -59,6 +80,11 @@ static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>           return -1;
>       }
>   
> +    if (ns->blkconf.discard_granularity == -1) {
> +        ns->blkconf.discard_granularity =
> +            MAX(ns->blkconf.logical_block_size, MIN_DISCARD_GRANULARITY);
> +    }
> +
>       ns->size = blk_getlength(ns->blkconf.blk);
>       if (ns->size < 0) {
>           error_setg_errno(errp, -ns->size, "could not get blockdev size");
> @@ -92,7 +118,9 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>           return -1;
>       }
>   
> -    nvme_ns_init(ns);
> +    if (nvme_ns_init(ns, errp)) {
> +        return -1;
> +    }
>   
>       if (nvme_register_namespace(n, ns, errp)) {
>           return -1;
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 4ab0705f5a92..7acb9e9dc38a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -959,6 +959,103 @@ static void nvme_rw_cb(void *opaque, int ret)
>       nvme_enqueue_req_completion(nvme_cq(req), req);
>   }
>   
> +static void nvme_aio_discard_cb(void *opaque, int ret)
> +{
> +    NvmeRequest *req = opaque;
> +    int *discards = req->opaque;
> +
> +    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
> +
> +    if (ret) {
> +        req->status = NVME_INTERNAL_DEV_ERROR;
> +        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
> +                               req->status);
> +    }
> +
> +    if (discards && --(*discards) > 0) {

This line is hard to read.

> +        return;
> +    }
> +
> +    g_free(req->opaque);
> +    req->opaque = NULL;
> +
> +    nvme_enqueue_req_completion(nvme_cq(req), req);
> +}
> +
> +static uint16_t nvme_dsm(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeNamespace *ns = req->ns;
> +    NvmeDsmCmd *dsm = (NvmeDsmCmd *) &req->cmd;
> +    NvmeDsmRange *range = NULL;

g_autofree?

> +    int *discards = NULL;
> +
> +    uint32_t attr = le32_to_cpu(dsm->attributes);
> +    uint32_t nr = (le32_to_cpu(dsm->nr) & 0xff) + 1;
> +
> +    uint16_t status = NVME_SUCCESS;
> +
> +    trace_pci_nvme_dsm(nvme_cid(req), nvme_nsid(ns), nr, attr);
> +
> +    if (attr & NVME_DSMGMT_AD) {
> +        int64_t offset;
> +        size_t len;
> +
> +        range = g_new(NvmeDsmRange, nr);
> +
> +        status = nvme_dma(n, (uint8_t *)range, nr * sizeof(NvmeDsmRange),
> +                          DMA_DIRECTION_TO_DEVICE, req);
> +        if (status) {
> +            goto out;
> +        }
> +
> +        discards = g_new(int, 1);
> +        *discards = 1;
> +        req->opaque = discards;

If opaque is a pointer, why not instead using it as an uintptr_t
discards directly without using the heap?

> +
> +        for (int i = 0; i < nr; i++) {
> +            uint64_t slba = le64_to_cpu(range[i].slba);
> +            uint32_t nlb = le32_to_cpu(range[i].nlb);
> +
> +            if (nvme_check_bounds(n, ns, slba, nlb)) {
> +                trace_pci_nvme_err_invalid_lba_range(slba, nlb,
> +                                                     ns->id_ns.nsze);
> +                continue;
> +            }
> +
> +            trace_pci_nvme_dsm_deallocate(nvme_cid(req), nvme_nsid(ns), slba,
> +                                          nlb);
> +
> +            offset = nvme_l2b(ns, slba);
> +            len = nvme_l2b(ns, nlb);
> +
> +            while (len) {
> +                size_t bytes = MIN(BDRV_REQUEST_MAX_BYTES, len);
> +
> +                (*discards)++;
> +
> +                blk_aio_pdiscard(ns->blkconf.blk, offset, bytes,
> +                                 nvme_aio_discard_cb, req);
> +
> +                offset += bytes;
> +                len -= bytes;
> +            }
> +        }
> +
> +        if (--(*discards)) {
> +            status = NVME_NO_COMPLETE;
> +        } else {
> +            g_free(discards);
> +            req->opaque = NULL;
> +            status = req->status;
> +        }
> +    }
> +
> +out:
> +    g_free(range);
> +
> +    return status;
> +}
[...]


