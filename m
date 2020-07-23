Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C102F2080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTAUMbkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C102F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYwf-0003ZT-1q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyYvv-00034J-R9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:58:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jyYvu-0002n7-4D
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595501917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfG3ve6iRrlNztYi1/RA/UBDyRPWHXgvKQCPFhLt5hk=;
 b=CTAUMbkvf2GBwXgq8eW+2uWok5jdEaOaztE1ExRaPXFZXm/ognsrrnPZcTdZXGQu5lKheF
 K0btpu9pyYLX0U+EZMeeD+4ZSZ/uGCc7MTuDBIxVVqg8b93D4B1/hHjLWtxF/GbCJ2C7mP
 LjJlwcfzY43FKZS5VlBai4RMSO91V5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-dL7rJIpKOHiZGAeuUBAbpg-1; Thu, 23 Jul 2020 06:58:35 -0400
X-MC-Unique: dL7rJIpKOHiZGAeuUBAbpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F481005510;
 Thu, 23 Jul 2020 10:58:33 +0000 (UTC)
Received: from gondolin (ovpn-112-228.ams2.redhat.com [10.36.112.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9268A69320;
 Thu, 23 Jul 2020 10:58:26 +0000 (UTC)
Date: Thu, 23 Jul 2020 12:58:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 2/2] ppc: Enable 2nd DAWR support on p10
Message-ID: <20200723125824.52383e32.cohuck@redhat.com>
In-Reply-To: <20200723104220.314671-3-ravi.bangoria@linux.ibm.com>
References: <20200723104220.314671-1-ravi.bangoria@linux.ibm.com>
 <20200723104220.314671-3-ravi.bangoria@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: christophe.leroy@c-s.fr, qemu-ppc@nongnu.org, mikey@neuling.org,
 rogealve@br.ibm.com, kvm@vger.kernel.org, mst@redhat.com, mpe@ellerman.id.au,
 qemu-devel@nongnu.org, npiggin@gmail.com, paulus@samba.org, clg@kaod.org,
 jniethe5@gmail.com, pedromfc@br.ibm.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 16:12:20 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> As per the PAPR, bit 0 of byte 64 in pa-features property indicates
> availability of 2nd DAWR registers. i.e. If this bit is set, 2nd
> DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to
> find whether kvm supports 2nd DAWR or nor. If it's supported, set
> the pa-feature bit in guest DT so the guest kernel can support 2nd
> DAWR.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  hw/ppc/spapr.c                  | 33 +++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h          |  1 +
>  linux-headers/asm-powerpc/kvm.h |  4 ++++
>  linux-headers/linux/kvm.h       |  1 +
>  target/ppc/cpu.h                |  2 ++
>  target/ppc/kvm.c                |  7 +++++++
>  target/ppc/kvm_ppc.h            |  6 ++++++
>  target/ppc/translate_init.inc.c | 17 ++++++++++++++++-
>  8 files changed, 70 insertions(+), 1 deletion(-)
> 

(...)

> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
> index 38d61b73f5..c5c0f128b4 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -640,6 +640,10 @@ struct kvm_ppc_cpu_char {
>  #define KVM_REG_PPC_ONLINE	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
>  #define KVM_REG_PPC_PTCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc0)
>  
> +/* POWER10 registers. */
> +#define KVM_REG_PPC_DAWR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc1)
> +#define KVM_REG_PPC_DAWRX1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc2)
> +
>  /* Transactional Memory checkpointed state:
>   * This is all GPRs, all VSX regs and a subset of SPRs
>   */
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index a28c366737..015fa4b44b 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1031,6 +1031,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PPC_SECURE_GUEST 181
>  #define KVM_CAP_HALT_POLL 182
>  #define KVM_CAP_ASYNC_PF_INT 183
> +#define KVM_CAP_PPC_DAWR1 184
>  
>  #ifdef KVM_CAP_IRQ_ROUTING

Same here, this should go together with the headers changes from the
first patch.


