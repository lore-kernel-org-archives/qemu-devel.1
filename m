Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 12:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD655207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 12:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD655207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjiNf-00025q-0W
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 08:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjiMe-0001et-V9
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 08:00:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjiMc-0004Zw-DP
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 08:00:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05CB2auu167793; Fri, 12 Jun 2020 08:00:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31m0jcym6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2020 08:00:42 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05CB2uPT169965;
 Fri, 12 Jun 2020 08:00:42 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31m0jcym5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2020 08:00:42 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CBswHP018853;
 Fri, 12 Jun 2020 12:00:40 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 31kr29v6xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2020 12:00:40 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05CC0eCq34931184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2020 12:00:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3704112069;
 Fri, 12 Jun 2020 12:00:39 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA101112066;
 Fri, 12 Jun 2020 12:00:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2020 12:00:39 +0000 (GMT)
Subject: Re: [PATCH v3 08/12] hw/tpm: Make TRACE_TPM_UTIL_SHOW_BUFFER check
 local to tpm_util.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200612085444.8362-1-philmd@redhat.com>
 <20200612085444.8362-9-philmd@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <870bb195-4368-3583-85b8-ec5d8083fcb4@linux.ibm.com>
Date: Fri, 12 Jun 2020 08:00:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200612085444.8362-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-11_23:2020-06-11,
 2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 cotscore=-2147483648 spamscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:47
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 4:54 AM, Philippe Mathieu-Daudé wrote:
> The trace_event_get_state_backends() call is useful to avoid
> making extensive calls (usually preparing arguments passed to
> the tracing framework. In this case, the extensive work is
> done in tpm_util_show_buffer(), and the arguments used to
> call it don't involve extra processing. Simplify by moving
> the TRACE_TPM_UTIL_SHOW_BUFFER check to tpm_util_show_buffer.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   hw/tpm/tpm_tis_common.c | 8 ++------
>   hw/tpm/tpm_util.c       | 3 +++
>   2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 94704870f6..1779b4fc1e 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -78,9 +78,7 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t flags)
>    */
>   static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
>   {
> -    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> -        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
> -    }
> +    tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
>   
>       /*
>        * rw_offset serves as length indicator for length of data;
> @@ -246,9 +244,7 @@ void tpm_tis_request_completed(TPMState *s, int ret)
>       s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
>       s->rw_offset = 0;
>   
> -    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> -        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
> -    }
> +    tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
>   
>       if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
>           tpm_tis_abort(s);
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index c0a0f3d71f..12f19465c5 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -357,6 +357,9 @@ void tpm_util_show_buffer(const unsigned char *buffer,
>       size_t len, i;
>       char *line_buffer, *p;
>   
> +    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> +        return;
> +    }
>       len = MIN(tpm_cmd_get_size(buffer), buffer_size);
>   
>       /*



