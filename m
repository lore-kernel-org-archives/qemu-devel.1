Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF5C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3223821775
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si/0uwex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3223821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9XU0-0007dP-Eb
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 12:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9XTK-0006ki-55
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9XTI-0004JG-Gt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:06:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9XTI-0004J1-Ae
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 12:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583341572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V1q0vT910JdSPP87E0WxKCYvtyVYeFD7ArQ/jFnXqWQ=;
 b=Si/0uwexUvQYd/DXzAA0JC4v3w+PYcWD2HCz6RvUScbdBsw6a4oqvlTIs5Nw1ulzQjyeLd
 4V2ml+ZGlP/6dr+Si/Ss705lybe6WLZgRqPRYlRCIfKEyOrnG2U19upZSGKFOnQipCk8rF
 qc1mVM6vzGKVsn85UYHplVWZoabCmm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-B0qf3C4pPOaZ5UBkN_HGmg-1; Wed, 04 Mar 2020 12:06:08 -0500
X-MC-Unique: B0qf3C4pPOaZ5UBkN_HGmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F835800D4E;
 Wed,  4 Mar 2020 17:06:07 +0000 (UTC)
Received: from [10.36.117.195] (ovpn-117-195.ams2.redhat.com [10.36.117.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B691219C4F;
 Wed,  4 Mar 2020 17:06:05 +0000 (UTC)
Subject: Re: [PATCH v6 02/18] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <e6247adf-32c6-09a8-7243-b1a4b8274094@redhat.com>
Date: Wed, 4 Mar 2020 18:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304114231.23493-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04.03.20 12:42, Janosch Frank wrote:
> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
> holds the address and length of the secure execution header, as well
> as a list of guest components.
> 
> Each component is a block of memory, for example kernel or initrd,
> which needs to be decrypted by the Ultravisor in order to run a
> protected VM. The secure execution header instructs the Ultravisor on
> how to handle the protected VM and its components.
> 
> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
> start the protected guest.
> 
> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> 3 and then the 8 and 10 combination for a protected reboot.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/ipl.c      | 47 ++++++++++++++++++++++++++++++++++++++++++---
>  hw/s390x/ipl.h      | 32 ++++++++++++++++++++++++++++++
>  target/s390x/diag.c | 26 ++++++++++++++++++++++---
>  3 files changed, 99 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 9c1ecd423c..80c6ab233a 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -538,15 +538,55 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
>      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
>  }
>  
> +int s390_ipl_pv_check_components(IplParameterBlock *iplb)
> +{
> +    int i;
> +    IPLBlockPV *ipib_pv = &iplb->pv;
> +
> +    if (ipib_pv->num_comp == 0) {
> +        return -EINVAL;
> +    }
> +
> +    for (i = 0; i < ipib_pv->num_comp; i++) {
> +        /* Addr must be 4k aligned */
> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
> +            return -EINVAL;
> +        }
> +
> +        /* Tweak prefix is monotonously increasing with each component */
> +        if (i < ipib_pv->num_comp - 1 &&
> +            ipib_pv->components[i].tweak_pref >
> +            ipib_pv->components[i + 1].tweak_pref) {
> +            return -EINVAL;
> +        }
> +    }
> +    return 0;
> +}
> +
>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>  {
>      S390IPLState *ipl = get_ipl_device();
>  
> -    ipl->iplb = *iplb;
> -    ipl->iplb_valid = true;
> +    if (iplb->pbt == S390_IPL_TYPE_PV) {
> +        ipl->iplb_pv = *iplb;
> +        ipl->iplb_valid_pv = true;
> +    } else {
> +        ipl->iplb = *iplb;
> +        ipl->iplb_valid = true;
> +    }
>      ipl->netboot = is_virtio_net_device(iplb);
>  }
>  
> +IplParameterBlock *s390_ipl_get_iplb_secure(void)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +
> +    if (!ipl->iplb_valid_pv) {
> +        return NULL;
> +    }
> +    return &ipl->iplb_pv;
> +}
> +
>  IplParameterBlock *s390_ipl_get_iplb(void)
>  {
>      S390IPLState *ipl = get_ipl_device();
> @@ -561,7 +601,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>  {
>      S390IPLState *ipl = get_ipl_device();
>  
> -    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
> +    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL ||
> +        reset_type == S390_RESET_PV) {
>          /* use CPU 0 for full resets */
>          ipl->reset_cpu_index = 0;
>      } else {
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index d4813105db..04be63cee1 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -15,6 +15,24 @@
>  #include "cpu.h"
>  #include "hw/qdev-core.h"
>  
> +struct IPLBlockPVComp {
> +    uint64_t tweak_pref;
> +    uint64_t addr;
> +    uint64_t size;
> +} QEMU_PACKED;
> +typedef struct IPLBlockPVComp IPLBlockPVComp;
> +
> +struct IPLBlockPV {
> +    uint8_t  reserved[87];
> +    uint8_t  version;
> +    uint32_t reserved70;
> +    uint32_t num_comp;
> +    uint64_t pv_header_addr;
> +    uint64_t pv_header_len;
> +    struct IPLBlockPVComp components[];
> +} QEMU_PACKED;
> +typedef struct IPLBlockPV IPLBlockPV;
> +
>  struct IplBlockCcw {
>      uint8_t  reserved0[85];
>      uint8_t  ssid;
> @@ -71,6 +89,7 @@ union IplParameterBlock {
>          union {
>              IplBlockCcw ccw;
>              IplBlockFcp fcp;
> +            IPLBlockPV pv;
>              IplBlockQemuScsi scsi;
>          };
>      } QEMU_PACKED;
> @@ -84,9 +103,11 @@ union IplParameterBlock {
>  typedef union IplParameterBlock IplParameterBlock;
>  
>  int s390_ipl_set_loadparm(uint8_t *loadparm);
> +int s390_ipl_pv_check_components(IplParameterBlock *iplb);
>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>  IplParameterBlock *s390_ipl_get_iplb(void);
> +IplParameterBlock *s390_ipl_get_iplb_secure(void);
>  
>  enum s390_reset {
>      /* default is a reset not triggered by a CPU e.g. issued by QMP */
> @@ -94,6 +115,7 @@ enum s390_reset {
>      S390_RESET_REIPL,
>      S390_RESET_MODIFIED_CLEAR,
>      S390_RESET_LOAD_NORMAL,
> +    S390_RESET_PV,
>  };
>  void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
>  void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type);
> @@ -133,6 +155,7 @@ struct S390IPLState {
>      /*< private >*/
>      DeviceState parent_obj;
>      IplParameterBlock iplb;
> +    IplParameterBlock iplb_pv;
>      QemuIplParameters qipl;
>      uint64_t start_addr;
>      uint64_t compat_start_addr;
> @@ -140,6 +163,7 @@ struct S390IPLState {
>      uint64_t compat_bios_start_addr;
>      bool enforce_bios;
>      bool iplb_valid;
> +    bool iplb_valid_pv;
>      bool netboot;
>      /* reset related properties don't have to be migrated or reset */
>      enum s390_reset reset_type;
> @@ -161,9 +185,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>  
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PV 0x05
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
>  
>  #define S390_IPLB_HEADER_LEN 8
> +#define S390_IPLB_MIN_PV_LEN 148
>  #define S390_IPLB_MIN_CCW_LEN 200
>  #define S390_IPLB_MIN_FCP_LEN 384
>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
> @@ -185,4 +211,10 @@ static inline bool iplb_valid_fcp(IplParameterBlock *iplb)
>             iplb->pbt == S390_IPL_TYPE_FCP;
>  }
>  
> +static inline bool iplb_valid_pv(IplParameterBlock *iplb)
> +{
> +    return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_PV_LEN &&
> +           iplb->pbt == S390_IPL_TYPE_PV;
> +}
> +
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index b5aec06d6b..945b263f0a 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -52,6 +52,7 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  #define DIAG_308_RC_OK              0x0001
>  #define DIAG_308_RC_NO_CONF         0x0102
>  #define DIAG_308_RC_INVALID         0x0402
> +#define DIAG_308_RC_NO_PV_CONF      0x0902
>  
>  #define DIAG308_RESET_MOD_CLR       0
>  #define DIAG308_RESET_LOAD_NORM     1
> @@ -59,6 +60,9 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  #define DIAG308_LOAD_NORMAL_DUMP    4
>  #define DIAG308_SET                 5
>  #define DIAG308_STORE               6
> +#define DIAG308_PV_SET              8
> +#define DIAG308_PV_STORE            9
> +#define DIAG308_PV_START            10
>  
>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>                                uintptr_t ra, bool write)
> @@ -105,6 +109,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>          break;
>      case DIAG308_SET:
> +    case DIAG308_PV_SET:
>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>              return;
>          }
> @@ -117,7 +122,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
>  
> -        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
> +        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
> +            !(iplb_valid_pv(iplb) && !s390_ipl_pv_check_components(iplb))) {
>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
>              goto out;
>          }
> @@ -128,17 +134,31 @@ out:
>          g_free(iplb);
>          return;
>      case DIAG308_STORE:
> +    case DIAG308_PV_STORE:
>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>              return;
>          }
> -        iplb = s390_ipl_get_iplb();
> +        if (subcode == DIAG308_PV_STORE) {
> +            iplb = s390_ipl_get_iplb_secure();
> +        } else {
> +            iplb = s390_ipl_get_iplb();
> +        }
>          if (iplb) {
>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
>              env->regs[r1 + 1] = DIAG_308_RC_OK;
>          } else {
>              env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
>          }
> -        return;
> +        break;
> +    case DIAG308_PV_START:
> +        iplb = s390_ipl_get_iplb_secure();
> +        if (!iplb || !iplb_valid_pv(iplb)) {
> +            env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
> +            return;
> +        }
> +
> +        s390_ipl_reset_request(cs, S390_RESET_PV);
> +        break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          break;
> 

Sorry, another comment. The new subcodes should be fenced via the cpu
model or similar. Applying this patch and triggering one of these
subcodes will end in a questionable state.

-- 
Thanks,

David / dhildenb


