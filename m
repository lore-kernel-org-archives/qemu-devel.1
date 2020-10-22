Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30CC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFA5221FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDngAnD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFA5221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVW5g-0006rP-U6
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVW1w-0003Sk-7t
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVW1t-0000OQ-RC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603355576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=keGvF5MvQkqgYRWOcwGJQuoXKBsgxOxFvYkNeHLFLpU=;
 b=fDngAnD0zzN8ZhKRxTkTr7AbuqUClFWL69wRZYjsbX+z1mRr0qkaGq/SYg4Pa3zV/cBQbx
 I0YohB1aEj/WoMTYVFqKTqyKHSZP+HC6l+HDohHvQHddrcDyDoJqeCL95lrA6Z5oKpMFxN
 s0csIsVHIf28q/rdGTpk5/ZRXTzYsto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-ihImfVcNMj-CosSnrqjFoA-1; Thu, 22 Oct 2020 04:32:52 -0400
X-MC-Unique: ihImfVcNMj-CosSnrqjFoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEC991084CA4;
 Thu, 22 Oct 2020 08:32:50 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 194981972A;
 Thu, 22 Oct 2020 08:32:48 +0000 (UTC)
Subject: Re: [PATCH] s390x: pv: Fix diag318 PV fencing
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <74c4631b-735c-e5ad-77a3-0bbd9c63c4db@redhat.com>
 <20201022082312.124708-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3c2d61a4-1312-14a9-ac99-c562dfedcf31@redhat.com>
Date: Thu, 22 Oct 2020 10:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022082312.124708-1-frankja@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, cohuck@redhat.com, walling@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.10.20 10:23, Janosch Frank wrote:
> Diag318 fencing needs to be determined on the current VM PV state and
> not on the state that the VM has when we create the CPU model.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: fabdada935 ("s390: guest support for diagnose 0x318")
> ---
> 
> If you're sure that this is what you want, then I'll send a v2 of the
> patch set.

So that's going to be the first CPU feature that gets suppressed in PC
mode - which seems to be what we want.

diag318_needed() will return false, resulting in vmstate_diag318() not
being included in the migration stream (I know, we don't support
migration yet for PV).

I don't see where diag318 would get reset during a reipl - is it
expected to be persistent when switching in/out of PV, or when reipling
etc..?

> 
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


-- 
Thanks,

David / dhildenb


