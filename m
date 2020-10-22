Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E1DC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E76222267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 12:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7G8cmwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E76222267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVZus-0004Kp-I9
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 08:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kVZtm-0003I2-O9; Thu, 22 Oct 2020 08:40:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1kVZtk-0005q2-20; Thu, 22 Oct 2020 08:40:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09MCXQvb030875; Thu, 22 Oct 2020 08:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=JoiN4GiiRYHjOJFtr1pk1INNI9sKKbWiWwsRMgOl89k=;
 b=l7G8cmwc9MQJqQK1LAzsrVqAvmcBEArRFoUIut+roWnwv6JU/w4TTt0WqsMV/RloPROM
 j5U5foJk5nJkOpR6cl4b2dmiWQOFT+nMbs3mJ7nFP6Fa3Cm/AirYXMJ223UG8ctK1y3C
 FRSvgpoqC/ONMxwaiMaJce+CoRobIEG62mtQuavh4BrXavaaRJTQuJxfREsJdCwl5adl
 nBKVLS6Jh6DYgpyCfbNYR4BpqST427ycFKMjQGEkr4Tc9XqR6wdDRKKXyGlQDM1mqoNM
 XuiNIsMwwldheXcdsXcfJylYv0eVd95+dsRVOqGVE6vqyhmEKvMEr2aiJVpfhAAyUFV1 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b5pd0s8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 08:40:48 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09MCXeGh032368;
 Thu, 22 Oct 2020 08:40:48 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b5pd0s7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 08:40:47 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MCX56H015288;
 Thu, 22 Oct 2020 12:40:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03ams.nl.ibm.com with ESMTP id 348d5qvkvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 12:40:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09MCegRF14090716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 12:40:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6FDF4C046;
 Thu, 22 Oct 2020 12:40:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C35554C052;
 Thu, 22 Oct 2020 12:40:41 +0000 (GMT)
Received: from marcibm (unknown [9.145.43.161])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 22 Oct 2020 12:40:41 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] s390x: pv: Fix diag318 PV fencing
In-Reply-To: <20201022103135.126033-3-frankja@linux.ibm.com>
References: <20201022103135.126033-1-frankja@linux.ibm.com>
 <20201022103135.126033-3-frankja@linux.ibm.com>
Date: Thu, 22 Oct 2020 14:40:40 +0200
Message-ID: <871rhqo2lz.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-22_06:2020-10-20,
 2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 suspectscore=1 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220087
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:40:49
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 walling@linux.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 06:31 AM -0400, Janosch Frank <frankja@linux.ibm.com> wrote:
> Diag318 fencing needs to be determined on the current VM PV state and
> not on the state that the VM has when we create the CPU model.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: fabdada935 ("s390: guest support for diagnose 0x318")
> ---
>  target/s390x/cpu_features.c | 5 +++++
>  target/s390x/cpu_features.h | 4 ++++
>  target/s390x/cpu_models.c   | 4 ++++
>  target/s390x/kvm.c          | 3 +--
>  4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 31ea8df246..42fe0bf4ca 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -14,6 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "cpu_features.h"
> +#include "hw/s390x/pv.h"
>  
>  #define DEF_FEAT(_FEAT, _NAME, _TYPE, _BIT, _DESC) \
>      [S390_FEAT_##_FEAT] = {                        \
> @@ -105,6 +106,10 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>          }
>          feat = find_next_bit(features, S390_FEAT_MAX, feat + 1);
>      }
> +
> +    if (type == S390_FEAT_TYPE_SCLP_FAC134 && s390_is_pv()) {
> +        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
> +    }
>  }
>  
>  void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index ef52ffce83..87463f064d 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -81,6 +81,10 @@ const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
>  
>  #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
>  
> +static inline void clear_be_bit(unsigned int bit_nr, uint8_t *array)
> +{
> +    array[bit_nr / 8] &= ~(0x80 >> (bit_nr % 8));
> +}
>  static inline void set_be_bit(unsigned int bit_nr, uint8_t *array)
>  {
>      array[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index ca484bfda7..461e0b8f4a 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pci.h"
>  #endif
>  #include "qapi/qapi-commands-machine-target.h"
> +#include "hw/s390x/pv.h"
>  
>  #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
>      {                                                                    \
> @@ -238,6 +239,9 @@ bool s390_has_feat(S390Feat feat)
>          }
>          return 0;
>      }
> +    if (feat == S390_FEAT_DIAG_318 && s390_is_pv()) {
> +        return false;
> +    }
>      return test_bit(feat, cpu->model->features);
>  }
>  
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index f13eff688c..baa070fdf7 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2498,8 +2498,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>       */
>      set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
>  
> -    /* DIAGNOSE 0x318 is not supported under protected virtualization */
> -    if (!s390_is_pv() && kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
> +    if (kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
>          set_bit(S390_FEAT_DIAG_318, model->features);
>      }
>  
> -- 
> 2.25.1

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

