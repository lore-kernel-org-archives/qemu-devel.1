Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72694C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B5A22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVAikZ24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B5A22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYEy-00027H-Dj
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 06:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVYE4-0001e8-1Z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVYE1-00005q-O6
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603364019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NwRq0PabdJdCQj6EX2d17OstZFJtMQcRR03zgJBcV8=;
 b=cVAikZ24lpeHZb9knxZTI2fejULXvJEGyZKGNDqfCbLV3nU7rOfxJi2NRics5BlQt0USin
 U6YlBqaXLMntTyxsCx0DvzJnZy4vHGAEslJBSQo5w8B+a5IATniRs86i9Q8cHmQ1Xrd7Hh
 qghgkp9unWBrbzui8ivGmeC8U8ibMrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-cp56jv4YP9uphMsnY0yZLA-1; Thu, 22 Oct 2020 06:53:37 -0400
X-MC-Unique: cp56jv4YP9uphMsnY0yZLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52251804B7C;
 Thu, 22 Oct 2020 10:53:36 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25FC75C1C7;
 Thu, 22 Oct 2020 10:53:33 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] s390x: pv: Fix diag318 PV fencing
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20201022103135.126033-1-frankja@linux.ibm.com>
 <20201022103135.126033-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <649cdd6b-db3b-13ec-af74-7e774e59c01a@redhat.com>
Date: Thu, 22 Oct 2020 12:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022103135.126033-3-frankja@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 06:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, cohuck@redhat.com, walling@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.10.20 12:31, Janosch Frank wrote:
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
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


