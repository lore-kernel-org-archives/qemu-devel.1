Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5116EC31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 08:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118CB2133D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 08:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zfyUjLEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118CB2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcQZM-00083z-2B
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 04:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59250)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hcQYF-0007Uc-Vm
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 04:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hcQYE-0003sB-Q2
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 04:30:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hcQYE-0003nA-Gy
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 04:30:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5G8Su0P129039;
 Sun, 16 Jun 2019 08:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=EZ1jVMgWoTokiucZPLuepHj5ZTyvCPcOidXsx/UDy6Y=;
 b=zfyUjLExUy9GTc8FaVCJkIoGlfUEcJjWc+9GzyfoR7Y2TQrQhON7VzFp83fu9lMR9UOR
 eV/6U3Kh5iMsbcUmEQxD6asXuDUkipEuGVs/6C7NJBu9PikJA3Zsc2EsVWQpxcTrwKZo
 Hrp0UwDro8OEjNntNZ1uJXoQQMPVu2cvvABToOAAYx7frvjK01iXgSMHNZSqR9Vdwrg5
 42R/Ye/J44UtZB+KUYvhSmDrCF4YNcHlSyg11qrnnirIUOZhI7kH1knj/p6AyDqClxZC
 AXH4cXeApiH+mA+lUX3v1eqTkRixOz5jA2ReBbiTxYmm7j4vD42cFaehNrZW3K+Xyqgm Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t4r3tag9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Jun 2019 08:30:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5G8Toce082308;
 Sun, 16 Jun 2019 08:30:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2t59gcub6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Jun 2019 08:30:02 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5G8Twir008818;
 Sun, 16 Jun 2019 08:29:58 GMT
Received: from [10.0.5.57] (/213.57.127.10)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 16 Jun 2019 01:29:58 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190615004256.16367-5-pbonzini@redhat.com>
Date: Sun, 16 Jun 2019 11:29:55 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <829F36FB-3551-4682-9E69-50CC479DAC09@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-5-pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9289
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906160083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9289
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=986 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906160083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH 4/7] linux-headers: import improved
 definition of KVM_GET/SET_NESTED_STATE structs
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
Cc: qemu-devel@nongnu.org, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On 15 Jun 2019, at 3:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> This patch improves the KVM_GET/SET_NESTED_STATE structs by detailing
> the format of VMX nested state in a struct.  The VMX nested state is
> accessible through struct kvm_vmx_nested_state though, to avoid
> changing the size of the structs, it has to be accessed as =
"vmx.data[0]"
> rather than just "vmx.data".
>=20
> Also, the values of the "format" field are defined as macros.  This
> patch should be sent to Linus very shortly.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> linux-headers/asm-x86/kvm.h | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index 7a0e64ccd6..06b8727a3b 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -383,6 +383,9 @@ struct kvm_sync_regs {
> #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
> #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
>=20
> +#define KVM_STATE_NESTED_FORMAT_VMX	0
> +#define KVM_STATE_NESTED_FORMAT_SVM	1
> +
> #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
> #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
> #define KVM_STATE_NESTED_EVMCS		0x00000004
> @@ -390,6 +393,11 @@ struct kvm_sync_regs {
> #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
> #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
>=20
> +struct kvm_vmx_nested_state_data {
> +	__u8 vmcs12[0x1000];
> +	__u8 shadow_vmcs12[0x1000];
> +};

Do you think we should replace this 0x1000 with VMCS12_SIZE?

> +
> struct kvm_vmx_nested_state {
> 	__u64 vmxon_pa;
> 	__u64 vmcs_pa;
> @@ -397,6 +405,9 @@ struct kvm_vmx_nested_state {
> 	struct {
> 		__u16 flags;
> 	} smm;
> +
> +	__u8 pad[120 - 18];
> +	struct kvm_vmx_nested_state_data data[0];
> };

I don=E2=80=99t like this pad[] thing.
It creates weird dependency between the padding in kvm_nested_state and =
this one.
Also, it doesn=E2=80=99t separate nicely between header & data regions.
What do you think on the following alternative patch?
(Note that it should still preserve kvm_nested_state struct size)

-struct kvm_vmx_nested_state {
+struct kvm_vmx_nested_state_data {
+       __u8 vmcs12[0x1000];
+       __u8 shadow_vmcs12[0x1000];
+};
+
+struct kvm_vmx_nested_state_hdr {
        __u64 vmxon_pa;
-       __u64 vmcs_pa;
+       __u64 vmcs12_pa;

        struct {
                __u16 flags;
        } smm;
 };

+struct kvm_svm_nested_state_data {
+       /* TODO: Implement */
+};
+
+struct kvm_svm_nested_state_hdr {
+       /* TODO: Implement */
+};
+
 /* for KVM_CAP_NESTED_STATE */
 struct kvm_nested_state {
-       /* KVM_STATE_* flags */
        __u16 flags;
-
-       /* 0 for VMX, 1 for SVM.  */
        __u16 format;
-
-       /* 128 for SVM, 128 + VMCS size for VMX.  */
        __u32 size;

        union {
-               /* VMXON, VMCS */
-               struct kvm_vmx_nested_state vmx;
+               struct kvm_vmx_nested_state_hdr vmx;
+               struct kvm_svm_nested_state_hdr svm;

                /* Pad the header to 128 bytes.  */
                __u8 pad[120];
-       };
+       } hdr;

-       __u8 data[0];
+       /*
+        * Define data region as 0 bytes to preserve =
backwards-compatability
+        * to old definition of kvm_nested_state in order to avoid =
changing
+        * KVM_{GET,PUT}_NESTED_STATE ioctl values.
+        */
+       union {
+               struct kvm_vmx_nested_state_data vmx[0];
+               struct kvm_svm_nested_state_data svm[0];
+       } data;
 };

I think this is cleaner.

-Liran


