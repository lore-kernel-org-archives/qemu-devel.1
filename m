Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB55C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA9B2065C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RR49yJwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA9B2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0m6N-0004p2-SF
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0m5l-0004Jt-HJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:25:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0m5k-0001Al-1y
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596029155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTWA4PFK0XTqf3HMRbQ/zfu+zzf+Fbl7FQbRaT7Cfb0=;
 b=RR49yJwvwTuJZmmGvVR1jAL9/uVxYANb/SRmU/HaT0bCp1POw+kuzfrq+XmQWfMGHxxdiF
 /b1kLn5Zyk5epf6tS32PMCu0KTyS9ZosMwcCpfB3txf+uW87SK5ek9KfH4nkJ1EDw3u9Xk
 +20RomSHvIwaUrjTPm4H/y00qBzTyHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-2-lHyDV6PYu6Wb1FsY1H0g-1; Wed, 29 Jul 2020 09:25:52 -0400
X-MC-Unique: 2-lHyDV6PYu6Wb1FsY1H0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B72A1902EA0;
 Wed, 29 Jul 2020 13:25:50 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43B4510098AA;
 Wed, 29 Jul 2020 13:25:46 +0000 (UTC)
Message-ID: <f3674175bdc10aad5607aa6e7b5c7d517558a58e.camel@redhat.com>
Subject: Re: [PATCH v3 14/18] hw/block/nvme: support identify namespace
 descriptor list
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 29 Jul 2020 16:25:45 +0300
In-Reply-To: <20200706061303.246057-15-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-15-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since we are not providing the NGUID or EUI64 fields, we must support
> the Namespace UUID. We do not have any way of storing a persistent
> unique identifier, so conjure up a UUID that is just the namespace id.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>  hw/block/trace-events |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 37e4fd8dfce1..fc58f3d76530 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1007,6 +1007,45 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>      return ret;
>  }
>  
> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
> +{
> +    uint32_t nsid = le32_to_cpu(c->nsid);
> +    uint64_t prp1 = le64_to_cpu(c->prp1);
> +    uint64_t prp2 = le64_to_cpu(c->prp2);
> +
> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
> +
> +    struct data {
> +        struct {
> +            NvmeIdNsDescr hdr;
> +            uint8_t v[16];
> +        } uuid;
> +    };
> +
> +    struct data *ns_descrs = (struct data *)list;
> +
> +    trace_pci_nvme_identify_ns_descr_list(nsid);
> +
> +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> +        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
> +    memset(list, 0x0, sizeof(list));
> +
> +    /*
> +     * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
> +     * structure, a Namespace UUID (nidt = 0x3) must be reported in the
> +     * Namespace Identification Descriptor. Add a very basic Namespace UUID
> +     * here.
> +     */
> +    ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
> +    ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
> +    stl_be_p(&ns_descrs->uuid.v, nsid);
> +
> +    return nvme_dma_read_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2);
> +}
> +
>  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>  {
>      NvmeIdentify *c = (NvmeIdentify *)cmd;
> @@ -1018,6 +1057,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>          return nvme_identify_ctrl(n, c);
>      case NVME_ID_CNS_NS_ACTIVE_LIST:
>          return nvme_identify_nslist(n, c);
> +    case NVME_ID_CNS_NS_DESCR_LIST:
> +        return nvme_identify_ns_descr_list(n, c);
>      default:
>          trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
>          return NVME_INVALID_FIELD | NVME_DNR;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 4a4ef34071df..7b7303cab1dd 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -45,6 +45,7 @@ pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
>  pci_nvme_identify_ctrl(void) "identify controller"
>  pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
> +pci_nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
>  pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
>  pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
>  pci_nvme_setfeat(uint16_t cid, uint8_t fid, uint8_t save, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" save 0x%"PRIx8" cdw11 0x%"PRIx32""

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



