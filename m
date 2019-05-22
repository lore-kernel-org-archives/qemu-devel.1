Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B1FC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE712173E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE712173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTKVI-0001ht-5A
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 02:13:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hTKU6-00013S-P3
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hTKU5-0000T4-Em
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:12:18 -0400
Received: from charlie.dont.surf ([128.199.63.193]:54654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hTKU2-0000OK-GK; Wed, 22 May 2019 02:12:14 -0400
Received: from apples.localdomain (soho-cph.cust-cnex.dsd101.net
	[194.62.216.132])
	by charlie.dont.surf (Postfix) with ESMTPSA id 46B8ABF513;
	Wed, 22 May 2019 06:12:12 +0000 (UTC)
Date: Wed, 22 May 2019 08:12:08 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Message-ID: <20190522061208.GA2180@apples.localdomain>
Mail-Followup-To: qemu-block@nongnu.org,
	Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20190517084234.26923-1-klaus@birkelund.eu>
	<20190517084234.26923-6-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517084234.26923-6-klaus@birkelund.eu>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/8] nvme: add support for
 metadata
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

On Fri, May 17, 2019 at 10:42:31AM +0200, Klaus Birkelund Jensen wrote:
> The new `ms` parameter may be used to indicate the number of metadata
> bytes provided per LBA.
> 
> Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c | 31 +++++++++++++++++++++++++++++--
>  hw/block/nvme.h | 11 ++++++++++-
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index c514f93f3867..675967a596d1 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -33,6 +33,8 @@
>   *   num_ns=<int>          : Namespaces to make out of the backing storage,
>   *                           Default:1
>   *   num_queues=<int>      : Number of possible IO Queues, Default:64
> + *   ms=<int>              : Number of metadata bytes provided per LBA,
> + *                           Default:0
>   *   cmb_size_mb=<int>     : Size of CMB in MBs, Default:0
>   *
>   * Parameters will be verified against conflicting capabilities and attributes
> @@ -386,6 +388,8 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>  
>      uint32_t unit_len = nvme_ns_lbads_bytes(ns);
>      uint32_t len = req->nlb * unit_len;
> +    uint32_t meta_unit_len = nvme_ns_ms(ns);
> +    uint32_t meta_len = req->nlb * meta_unit_len;
>      uint64_t prp1 = le64_to_cpu(cmd->prp1);
>      uint64_t prp2 = le64_to_cpu(cmd->prp2);
>  
> @@ -399,6 +403,19 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return err;
>      }
>  
> +    qsg.nsg = 0;
> +    qsg.size = 0;
> +
> +    if (cmd->mptr && n->params.ms) {
> +        qemu_sglist_add(&qsg, le64_to_cpu(cmd->mptr), meta_len);
> +
> +        err = nvme_blk_setup(n, ns, &qsg, ns->blk_offset_md, meta_unit_len,
> +            req);
> +        if (err) {
> +            return err;
> +        }
> +    }
> +
>      qemu_sglist_destroy(&qsg);
>  
>      return NVME_SUCCESS;
> @@ -1902,6 +1919,11 @@ static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
>          return 1;
>      }
>  
> +    if (params->ms && !is_power_of_2(params->ms)) {
> +        error_setg(errp, "nvme: invalid metadata configuration");
> +        return 1;
> +    }
> +
>      return 0;
>  }
>  
> @@ -2066,17 +2088,20 @@ static void nvme_init_ctrl(NvmeCtrl *n)
>  
>  static uint64_t nvme_ns_calc_blks(NvmeCtrl *n, NvmeNamespace *ns)
>  {
> -    return n->ns_size / nvme_ns_lbads_bytes(ns);
> +    return n->ns_size / (nvme_ns_lbads_bytes(ns) + nvme_ns_ms(ns));
>  }
>  
>  static void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns)
>  {
> +    NvmeParams *params = &n->params;
> +
>      id_ns->nlbaf = 0;
>      id_ns->flbas = 0;
> -    id_ns->mc = 0;
> +    id_ns->mc = params->ms ? 0x2 : 0;
>      id_ns->dpc = 0;
>      id_ns->dps = 0;
>      id_ns->lbaf[0].lbads = BDRV_SECTOR_BITS;
> +    id_ns->lbaf[0].ms = params->ms;
>  }
>  
>  static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> @@ -2086,6 +2111,8 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>      nvme_ns_init_identify(n, id_ns);
>  
>      ns->ns_blks = nvme_ns_calc_blks(n, ns);
> +    ns->blk_offset_md = ns->blk_offset + nvme_ns_lbads_bytes(ns) * ns->ns_blks;
> +
>      id_ns->nuse = id_ns->ncap = id_ns->nsze = cpu_to_le64(ns->ns_blks);
>  
>      return 0;
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 711ca249eac5..81ee0c5173d5 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -8,13 +8,15 @@
>      DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
>      DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
>      DEFINE_PROP_UINT32("num_ns", _state, _props.num_ns, 1), \
> -    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
> +    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7), \
> +    DEFINE_PROP_UINT8("ms", _state, _props.ms, 0)
>  
>  typedef struct NvmeParams {
>      char     *serial;
>      uint32_t num_queues;
>      uint32_t num_ns;
>      uint8_t  mdts;
> +    uint8_t  ms;
>      uint32_t cmb_size_mb;
>  } NvmeParams;
>  
> @@ -91,6 +93,7 @@ typedef struct NvmeNamespace {
>      uint32_t        id;
>      uint64_t        ns_blks;
>      uint64_t        blk_offset;
> +    uint64_t        blk_offset_md;
>  } NvmeNamespace;
>  
>  #define TYPE_NVME "nvme"
> @@ -154,4 +157,10 @@ static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
>      return 1 << nvme_ns_lbads(ns);
>  }
>  
> +static inline uint16_t nvme_ns_ms(NvmeNamespace *ns)
> +{
> +    NvmeIdNs *id = &ns->id_ns;
> +    return le16_to_cpu(id->lbaf[NVME_ID_NS_FLBAS_INDEX(id->flbas)].ms);
> +}
> +
>  #endif /* HW_NVME_H */
> -- 
> 2.21.0
> 

Hi Kevin,

I feel this patch that has nothing to do with ocssd also touches upon
the core issue we are discussing in the ocssd thread.

As I understand it, QEMU does not support metadata pr LBA in the block
layer. Thus, the approach in this patch is also flawed because it breaks
the assumptions of other devices?

The approach suggested in this patch is to split the image into a large
data part and a trailing part for storing metadata bytes per data
sector.

  [                      data                        ][ meta ]

How about I drop this patch and the ocssd patch from this series and
just move forward with the other changes to the nvme device (i.e. v1.3
and sgls) for now and we can continue the discussion on how to get
metadata and ocssd support merged in another thread?

