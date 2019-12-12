Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62466C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F13E206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13E206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTOI-0006XP-St
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifTHN-0005cf-4C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifTHL-00014c-PX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:33:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58484
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ifTHL-00013M-Jg; Thu, 12 Dec 2019 13:33:35 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCIMCoe079339; Thu, 12 Dec 2019 13:33:24 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrjbu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:33:24 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCIMIST081972;
 Thu, 12 Dec 2019 13:33:24 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrjbtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:33:23 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCIUrJk015812;
 Thu, 12 Dec 2019 18:33:23 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 2wr3q709au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 18:33:23 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCIXMkn57934226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 18:33:22 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41611136053;
 Thu, 12 Dec 2019 18:33:22 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5BF913604F;
 Thu, 12 Dec 2019 18:33:21 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 18:33:21 +0000 (GMT)
Subject: Re: [PATCH v4 3/8] tpm_emulator: Implement callback for whether we
 are suspended
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
References: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
 <20191212180744.1070446-4-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <76e147e3-c5d1-e7e0-1297-f1f2f0e07aa5@linux.ibm.com>
Date: Thu, 12 Dec 2019 13:33:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212180744.1070446-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 1:07 PM, Stefan Berger wrote:
> Implement the check whether the emulator backend is suspended.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 22f9113432..7be7d3a91b 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -80,6 +80,8 @@ typedef struct TPMEmulator {
>       unsigned int established_flag_cached:1;
>   
>       TPMBlobBuffers state_blobs;
> +
> +    bool is_suspended;
>   } TPMEmulator;
>   
>   struct tpm_error {
> @@ -486,6 +488,13 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
>       return actual_size;
>   }
>   
> +static bool tpm_emulator_is_suspended(TPMBackend *tb)
> +{
> +    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
> +
> +    return tpm_emu->is_suspended;
> +}
> +
>   static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
>   {
>       Error *err = NULL;
> @@ -846,6 +855,8 @@ static int tpm_emulator_pre_save(void *opaque)
>       TPMBackend *tb = opaque;
>       TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>   
> +    tpm_emu->is_suspended = true;

This is the most critical part here. It must be true when we receive a 
response in the tpm_spapr_request_completed(). The problem is that what 
tpm_backend_finish_sync() does is not specific to this backend but more 
a global operation that another device could run as well -- none seem to 
do this today. So the point is that there could be a race here. This 
flag should really be set in '.pre_pre_save,' so before any other device 
could poll. Better would be calling a global function that indicates 
whether device suspension has started. In this case we could do away 
with this and just call that function from the spapr device.



