Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE2DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8692C20691
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONkoCpcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8692C20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjMvw-0000Cg-Q9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjMku-0000lZ-S0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:56:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjMkt-0001M0-4g
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591880185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/+AyV8a2Dh8dmhZd2KCiKZKUxQpoIxtaXppFTE6HSig=;
 b=ONkoCpcLc5DXdtGq1sflIeBi+l8I5BAPWYhP1ddexpYLfCQYFcC18/3mVLpk7LD5KArSjF
 O89rnMQgA1ZsCw6ukK4vTnee/Nt1P8nvReHhbIFASTfGdufE2MkFyBEMJisDLgJ2RgllJY
 imnec7qDhApnFRtkQOawHtxLqKs1cuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-M8bfenRhMDmdm2JN8gOQUg-1; Thu, 11 Jun 2020 08:56:22 -0400
X-MC-Unique: M8bfenRhMDmdm2JN8gOQUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757BC8018A2;
 Thu, 11 Jun 2020 12:56:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E90CD5D9DC;
 Thu, 11 Jun 2020 12:56:11 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] s390/sclp: rework sclp boundary and length checks
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-4-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2db81475-f4cd-448f-561a-fa545db1ae9d@redhat.com>
Date: Thu, 11 Jun 2020 14:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515222032.18838-4-walling@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/05/2020 00.20, Collin Walling wrote:
> Rework the SCLP boundary check to account for different SCLP commands
> (eventually) allowing different boundary sizes.
> 
> Move the length check code into a separate function, and introduce a
> new function to determine the length of the read SCP data (i.e. the size
> from the start of the struct to where the CPU entries should begin).
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/sclp.c | 57 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 2bd618515e..987699e3c4 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
>      return false;
>  }
>  
> +static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
> +                                    SCCBHeader *header)
> +{
> +    uint64_t current_len = sccb_addr + be16_to_cpu(header->length);
> +    uint64_t allowed_len = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> +
> +    switch (code & SCLP_CMD_CODE_MASK) {
> +    default:
> +        if (current_len <= allowed_len) {
> +            return true;
> +        }
> +    }
> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
> +    return false;
> +}
> +
> +/* Calculates sufficient SCCB length to store a full Read SCP/CPU response */
> +static bool sccb_has_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
> +{
> +    int required_len = data_len + num_cpus * sizeof(CPUEntry);
> +
> +    if (be16_to_cpu(sccb->h.length) < required_len) {
> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>  {
>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
> @@ -66,6 +94,16 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>      }
>  }
>  
> +/*
> + * The data length denotes the start of the struct to where the first
> + * CPU entry is to be allocated. This value also denotes the offset_cpu
> + * field.
> + */
> +static int get_read_scp_info_data_len(void)
> +{
> +    return offsetof(ReadInfo, entries);
> +}
> +
>  /* Provide information about the configuration, CPUs and storage */
>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>  {
> @@ -74,16 +112,16 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      int cpu_count;
>      int rnsize, rnmax;
>      IplParameterBlock *ipib = s390_ipl_get_iplb();
> +    int data_len = get_read_scp_info_data_len();
>  
> -    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> +    if (!sccb_has_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
>          return;
>      }
>  
>      /* CPU information */
>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>      read_info->entries_cpu = cpu_to_be16(cpu_count);
> -    read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
> +    read_info->offset_cpu = cpu_to_be16(data_len);
>      read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
>  
>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
> @@ -132,16 +170,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
> +    int data_len = offsetof(ReadCpuInfo, entries);

Is there a reason for not using get_read_scp_info_data_len() here?

 Thomas


