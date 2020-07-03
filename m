Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D7EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406382070C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ2JRnzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406382070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrH3D-000694-J8
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrH2d-0005c1-Jb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:27:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrH2b-0004hQ-N3
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593764843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W0prhWFc2e7xgYzvFoUyi70/5kMuXwvxeUQwhgNCB54=;
 b=OZ2JRnzu12uKDZPREnJdlRAfMPitzKV+wm2rJTOiJyJl0YSjjeVGvE31Zg7aYTtvEbLf2q
 BBpTQ+SzZBzcgR9m2HAiZy+65TCp9npUPWbPOKj/hF441zyC/h5nNntDPAXrADyMah20NJ
 p/BzXgP/88aZ6baYm/ggBGHew2Om4GA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-i0DtraRlP8ec38raKnqgxw-1; Fri, 03 Jul 2020 04:27:22 -0400
X-MC-Unique: i0DtraRlP8ec38raKnqgxw-1
Received: by mail-wm1-f72.google.com with SMTP id t18so34475566wmj.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=W0prhWFc2e7xgYzvFoUyi70/5kMuXwvxeUQwhgNCB54=;
 b=QzdHP2KxlKtwg5kiDvcCf7CfiLUJqqPqcOaIiszMMtA0whoiMWJxfrvNQJGoF+4FMR
 n67DwX1GWUjyUWmd/3/fAA1wNeVmOuzeC6kYcaxZEwarmer/QROdPDP+7qby5sCNPYr+
 vlInvx599CRBp3Y7ZdEf1EtfbnashCZPAzvx1H2kNDvDW2GYaphbq4yqhOJDiaFMs6oE
 O8qmWHlEPgzrfFy61SRRXuh6cZ/oabmWGZZ8NEll/aBBIhckSuXhgLWaR3WddNYt1U17
 D/PVuhO1HPU1PNoxOmd2z/Z9VZBivyygZ95rMJSohnVqU+FGrp6MizxMi8KNwRDlnRhY
 i/Eg==
X-Gm-Message-State: AOAM531pY1IU6Obo3EN8CtDOOOxaSfE2/NkPCiSUiuNqC5ju4eyL2IaE
 AhnRL8j3uRY7oVsOlXCQYZpR8nFxuPfO8cnIwRpXQhU+fgOgJIWMIPrC/ReBAHuR4Td6P/FP1RK
 oe/BWPj1tv92SlMY=
X-Received: by 2002:adf:f452:: with SMTP id f18mr35316046wrp.78.1593764840998; 
 Fri, 03 Jul 2020 01:27:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV6mWgSS/PK+bC/mAExrDztUOflNqshsQMZ84qVXXKa28fB67GMW+cdK1jwuFYYbTWw8EqhA==
X-Received: by 2002:adf:f452:: with SMTP id f18mr35316028wrp.78.1593764840787; 
 Fri, 03 Jul 2020 01:27:20 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j6sm859140wro.25.2020.07.03.01.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 01:27:20 -0700 (PDT)
Subject: Re: [PATCH v2 14/18] hw/block/nvme: support identify namespace
 descriptor list
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-15-its@irrelevant.dk>
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
Message-ID: <1a1e7fdf-6e87-aa6b-f687-cc6d98297efe@redhat.com>
Date: Fri, 3 Jul 2020 10:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703063420.2241014-15-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:34 AM, Klaus Jensen wrote:
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
> index 8230e0e3826b..65c2fa3ac1f4 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -971,6 +971,45 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
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

You might consider to use QemuUUID from "qemu/uuid.h". The benefits
are you can use qemu_uuid_parse() qemu_uuid_unparse*() for tracing,
and DEFINE_PROP_UUID() in case you want to set a particular UUID
from command line, it case it is important to the guest.

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
> @@ -982,6 +1021,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
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
> 


