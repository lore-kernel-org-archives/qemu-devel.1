Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C092072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKS16bc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C092072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOI7-0000gz-75
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjOH1-0008Gi-0u
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:33:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjOGz-0001DL-Pf
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591886020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=8xA2vGH3Kk+eRqnyfryhhJEA+Wb72GFM2Fc98dA08EQ=;
 b=JKS16bc0cvdQlrqGViakYgpESP1W9dfbb8Ec81wsjl11vYfde3whzFnfOKBa+bbYBee72c
 CqIRb4fDQJYwLgY+0pO3t4Q8WuDbu5kQox3W7QvLxUQ+XByWgCXbY192Akg7TTaaUhAejv
 ebVnR3VwhMTLV7smzGtJy5MA4h8mAzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-Cbv1hJ26PQCkz9FGFNh-uw-1; Thu, 11 Jun 2020 10:33:37 -0400
X-MC-Unique: Cbv1hJ26PQCkz9FGFNh-uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A96611009624;
 Thu, 11 Jun 2020 14:33:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D7535C578;
 Thu, 11 Jun 2020 14:33:23 +0000 (UTC)
Subject: Re: [PATCH v2 5/8] s390/sclp: use cpu offset to locate cpu entries
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-6-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <09384867-d2d7-e37d-bb6a-40e75ecb02ad@redhat.com>
Date: Thu, 11 Jun 2020 16:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515222032.18838-6-walling@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> The start of the CPU entry region in the Read SCP Info response data is
> denoted by the offset_cpu field. As such, QEMU needs to begin creating
> entries at this address. Note that the length of the Read SCP Info data
> (data_len) denotes the same value as the cpu offset.
> 
> This is in preparation of when Read SCP Info inevitably introduces new
> bytes that push the start of the CPUEntry field further away.
> 
> Read CPU Info is unlikely to ever change, so let's not bother
> accounting for the offset there.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/sclp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 5d6e98ae64..755f5f3fab 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -113,13 +113,14 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>      int rnsize, rnmax;
>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>      int data_len = get_read_scp_info_data_len();
> +    CPUEntry *entries_start = (void *)sccb + data_len;
>  
>      if (!sccb_has_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
>          return;
>      }
>  
>      /* CPU information */
> -    prepare_cpu_entries(machine, read_info->entries, &cpu_count);
> +    prepare_cpu_entries(machine, entries_start, &cpu_count);
>      read_info->entries_cpu = cpu_to_be16(cpu_count);
>      read_info->offset_cpu = cpu_to_be16(data_len);
>      read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


