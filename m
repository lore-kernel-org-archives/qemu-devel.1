Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1618DC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89092082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tZVXbsht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89092082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMRm-0005qV-6A
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48034)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMP6-0004Pg-UR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hdMP5-0007OW-11
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:16:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hdMP4-0007BA-NN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:16:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMGJIW194710;
 Tue, 18 Jun 2019 22:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lYY4RyxYhBasL45yqr6qcF0o7IiIm/ZUtdDad0aawUQ=;
 b=tZVXbshththemMMNodKWrH0KDUfEY/crlIHANFuhqYNAHQTqTcSReBpsNQJ8/OafN6au
 uhSMHT1Yxa0bcS368iMs7cgSO03y02O6QdsiEaWjQXDA2UZDwcSjd4rOIWCwvR6l0c0d
 BGFeNeZJMkxCY7FYz/z4ojFGdHGL0f6hDPSJE0kQgKot1DbGGUFkuIaJ5zk6HlhJMFGP
 l6JSE3XBjHq73ZNCUR1ewuLuF3q9AEoDzgXlpm8NtLLiqphbFP0FoJqBaoEuc52neSHO
 aPOew1fP9xFU89qxqc4yti1YmA8aGJQyeztcL5BbLr0lTolHaZ9OGU+VbK1c4CVfYsTq +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t780983tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:16:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IMF7vn069365;
 Tue, 18 Jun 2019 22:16:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2t77ymred3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 22:16:17 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5IMGGJW031854;
 Tue, 18 Jun 2019 22:16:16 GMT
Received: from [10.141.197.71] (/10.141.197.71)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Jun 2019 15:16:16 -0700
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-6-liran.alon@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <fad1387b-54fd-cbfc-89c8-433d9e8da141@oracle.com>
Date: Tue, 18 Jun 2019 15:16:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175658.135869-6-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180178
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [QEMU PATCH v3 5/9] linux-headers: i386: Modify
 struct kvm_nested_state to have explicit fields for data
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/2019 10:56 AM, Liran Alon wrote:
> Improve the KVM_{GET,SET}_NESTED_STATE structs by detailing the format
> of VMX nested state data in a struct.
>
> In order to avoid changing the ioctl values of
> KVM_{GET,SET}_NESTED_STATE, there is a need to preserve
> sizeof(struct kvm_nested_state). This is done by defining the data
> struct as "data.vmx[0]". It was the most elegant way I found to
> preserve struct size while still keeping struct readable and easy to
> maintain. It does have a misfortunate side-effect that now it has to be
> accessed as "data.vmx[0]" rather than just "data.vmx".
>
> Because we are already modifying these structs, I also modified the
> following:
> * Define the "format" field values as macros.
> * Rename vmcs_pa to vmcs12_pa for better readability.
> * Add stub structs for AMD SVM.
>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   linux-headers/asm-x86/kvm.h | 41 +++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 7a0e64ccd6ff..e655d108af19 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -383,6 +383,9 @@ struct kvm_sync_regs {
>   #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
>   #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
>   
> +#define KVM_STATE_NESTED_FORMAT_VMX	0
> +#define KVM_STATE_NESTED_FORMAT_SVM	1
> +
>   #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
>   #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
>   #define KVM_STATE_NESTED_EVMCS		0x00000004
> @@ -390,35 +393,51 @@ struct kvm_sync_regs {
>   #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
>   #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
>   
> -struct kvm_vmx_nested_state {
> +struct kvm_vmx_nested_state_data {
> +	__u8 vmcs12[0x1000];
> +	__u8 shadow_vmcs12[0x1000];

I assume you will replace this magic 0x1000 value too, as discussed with 
respect to patch 7?

Thanks,
-Maran

> +};
> +
> +struct kvm_vmx_nested_state_hdr {
>   	__u64 vmxon_pa;
> -	__u64 vmcs_pa;
> +	__u64 vmcs12_pa;
>   
>   	struct {
>   		__u16 flags;
>   	} smm;
>   };
>   
> +struct kvm_svm_nested_state_data {
> +	/* TODO: Implement */
> +};
> +
> +struct kvm_svm_nested_state_hdr {
> +	/* TODO: Implement */
> +};
> +
>   /* for KVM_CAP_NESTED_STATE */
>   struct kvm_nested_state {
> -	/* KVM_STATE_* flags */
>   	__u16 flags;
> -
> -	/* 0 for VMX, 1 for SVM.  */
>   	__u16 format;
> -
> -	/* 128 for SVM, 128 + VMCS size for VMX.  */
>   	__u32 size;
>   
>   	union {
> -		/* VMXON, VMCS */
> -		struct kvm_vmx_nested_state vmx;
> +		struct kvm_vmx_nested_state_hdr vmx;
> +		struct kvm_svm_nested_state_hdr svm;
>   
>   		/* Pad the header to 128 bytes.  */
>   		__u8 pad[120];
> -	};
> +	} hdr;
>   
> -	__u8 data[0];
> +	/*
> +	 * Define data region as 0 bytes to preserve backwards-compatability
> +	 * to old definition of kvm_nested_state in order to avoid changing
> +	 * KVM_{GET,PUT}_NESTED_STATE ioctl values.
> +	 */
> +	union {
> +		struct kvm_vmx_nested_state_data vmx[0];
> +		struct kvm_svm_nested_state_data svm[0];
> +	} data;
>   };
>   
>   #endif /* _ASM_X86_KVM_H */


