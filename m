Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503EC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 21:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8149F2085A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 21:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kzi3AKHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8149F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdi0t-0002tv-KF
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 17:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hdhxU-0001TQ-L4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 17:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hdhxS-0002c9-N7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 17:17:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hdhxP-0002SR-Eb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 17:17:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JLAQvK157752;
 Wed, 19 Jun 2019 21:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=dLcHinxAhc17xmJ4PH3I4zzI05fcUKqgiXIuoVoY4U4=;
 b=Kzi3AKHFHu/BOtu3/NgD5B+BlsWQLYC12Aj9iYe06lYUIIcMhpiv/8FdV8TH9Z57bCZn
 IBaFO7ose0FGUtIqL+v5tAB3fw+AcH6Qz2xHmFowyKeKuQ4tm1EIH2bwUe7OfI+H/DRc
 UwkJUPTHEhlQvTyCSH1f4nGx8iybk8Qy1Vrr5T3gMl2wlp4MkhbKZLqIGMhCXk4TVG54
 9X67yZG+M3ET2/wi0Igf2Kom7w6AxVlxf0XC5wMWA+ARZbj067JA/8CBkjb4eEWT54GL
 09gL986av6vrMI7yE512twqPKDV4G4Ow5uyoXgxhvF7cUb2cDkYz2K6NmqQ7dDKD/Mjf 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2t7809dqyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 21:17:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JLGUDB022311;
 Wed, 19 Jun 2019 21:17:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t77yp2nsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 21:17:13 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JLH9EI014194;
 Wed, 19 Jun 2019 21:17:09 GMT
Received: from [10.141.197.71] (/10.141.197.71)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 14:17:09 -0700
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190619162140.133674-1-liran.alon@oracle.com>
 <20190619162140.133674-7-liran.alon@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <cc839d68-70f7-14f1-2313-fd8a8907b6d7@oracle.com>
Date: Wed, 19 Jun 2019 14:17:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619162140.133674-7-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190174
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [QEMU PATCH v4 06/10] linux-headers: i386: Modify
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

On 6/19/2019 9:21 AM, Liran Alon wrote:
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
>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   linux-headers/asm-x86/kvm.h | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 7a0e64ccd6ff..6e7dd792e448 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -383,16 +383,26 @@ struct kvm_sync_regs {
>   #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
>   #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
>   
> +#define KVM_STATE_NESTED_FORMAT_VMX	0
> +#define KVM_STATE_NESTED_FORMAT_SVM	1
> +
>   #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
>   #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
>   #define KVM_STATE_NESTED_EVMCS		0x00000004
>   
> +#define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
> +
>   #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
>   #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
>   
> -struct kvm_vmx_nested_state {
> +struct kvm_vmx_nested_state_data {
> +	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
> +	__u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
> +};
> +
> +struct kvm_vmx_nested_state_hdr {
>   	__u64 vmxon_pa;
> -	__u64 vmcs_pa;
> +	__u64 vmcs12_pa;
>   
>   	struct {
>   		__u16 flags;
> @@ -401,24 +411,25 @@ struct kvm_vmx_nested_state {
>   
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
> +	} data;
>   };
>   
>   #endif /* _ASM_X86_KVM_H */

Reviewed-by: Maran Wilson <maran.wilson@oracle.com>

Thanks,
-Maran

