Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A05C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86374207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CYrW6eAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86374207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKFbf-0000oN-Bv
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 02:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kKFZq-00085P-Ot
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 02:45:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32284
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovmurik@linux.vnet.ibm.com>)
 id 1kKFZk-0004pc-TF
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 02:45:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08L6XCpx121323; Mon, 21 Sep 2020 02:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qc+TFvGdxkbzSsv1yg1yWx1oPyx1PkEfeCodzvuGZo4=;
 b=CYrW6eAShvqWn23QIKnpprhrsJnjI0bqxovMQBHV06uTByjxOv257BQTQsMun2TbWIwY
 0YrZWF2YelX4wF+T6AIc4qGTkGjJNd4YcqqRLLwSaN7Jj6YilZ6cEKuAnpg/r0xJSGN7
 +0b7Q3kCVvLLZJtSjW/u+vw30HWuVdalZr21AY/JV8/jeyF7t1HE0N4m8QuZqCqN7Mq1
 hsQf8fn7YupstrkxZe5v6rVya9NiEMrBvLcsLrJ4is5BjI4QgElj0Dwb6QcrB0U+4lQB
 lVkzyvw1VmHUzcXxqCnB9Gth7PCEEoazjevygTqYnKwLV7NoZ+3u2G2ZOApEq1EfqObG aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33pprhgjye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2020 02:45:16 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08L6YMq8124106;
 Mon, 21 Sep 2020 02:45:15 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33pprhgjwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2020 02:45:13 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08L6bEro007577;
 Mon, 21 Sep 2020 06:45:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma05fra.de.ibm.com with ESMTP id 33n9m7rvfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2020 06:45:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08L6j7lw26738998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2020 06:45:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73A6A5206D;
 Mon, 21 Sep 2020 06:45:07 +0000 (GMT)
Received: from [9.65.232.226] (unknown [9.65.232.226])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 13F3852054;
 Mon, 21 Sep 2020 06:45:03 +0000 (GMT)
From: Dov Murik <dovmurik@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/5] sev/i386: Add initial support for SEV-ES
To: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <e2456cc461f329f52aa6eb3fcd0d0ce9451b8fa7.1600205384.git.thomas.lendacky@amd.com>
Message-ID: <e8cf44ef-3180-8922-5f0a-2ce532005e51@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2020 09:45:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <e2456cc461f329f52aa6eb3fcd0d0ce9451b8fa7.1600205384.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-21_01:2020-09-21,
 2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 clxscore=1011 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210049
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dovmurik@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 02:45:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Connor Kuehl <ckuehl@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/2020 0:29, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Provide initial support for SEV-ES. This includes creating a function to
> indicate the guest is an SEV-ES guest (which will return false until all
> support is in place), performing the proper SEV initialization and
> ensuring that the guest CPU state is measured as part of the launch.
> 
> Co-developed-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   target/i386/cpu.c      |  1 +
>   target/i386/sev-stub.c |  5 +++++
>   target/i386/sev.c      | 46 ++++++++++++++++++++++++++++++++++++++++--
>   target/i386/sev_i386.h |  1 +
>   4 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..bbbe581d35 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5969,6 +5969,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       case 0x8000001F:
>           *eax = sev_enabled() ? 0x2 : 0;
> +        *eax |= sev_es_enabled() ? 0x8 : 0;
>           *ebx = sev_get_cbit_position();
>           *ebx |= sev_get_reduced_phys_bits() << 6;
>           *ecx = 0;
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index 88e3f39a1e..040ac90563 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -49,3 +49,8 @@ SevCapability *sev_get_capabilities(Error **errp)
>       error_setg(errp, "SEV is not available in this QEMU");
>       return NULL;
>   }
> +
> +bool sev_es_enabled(void)
> +{
> +    return false;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c3ecf86704..6c9cd0854b 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -359,6 +359,12 @@ sev_enabled(void)
>       return !!sev_guest;
>   }
> 
> +bool
> +sev_es_enabled(void)
> +{
> +    return false;
> +}
> +
>   uint64_t
>   sev_get_me_mask(void)
>   {
> @@ -578,6 +584,22 @@ sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
>       return ret;
>   }
> 
> +static int
> +sev_launch_update_vmsa(SevGuestState *sev)
> +{
> +    int ret, fw_error;
> +
> +    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL, &fw_error);
> +    if (ret) {
> +        error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;

goto (and the err: label) is not needed.

> +    }
> +
> +err:
> +    return ret;
> +}
> +
>   static void
>   sev_launch_get_measure(Notifier *notifier, void *unused)
>   {
> @@ -590,6 +612,14 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
>           return;
>       }
> 
> +    if (sev_es_enabled()) {
> +        /* measure all the VM save areas before getting launch_measure */
> +        ret = sev_launch_update_vmsa(sev);
> +        if (ret) {
> +            exit(1);

Other error cases in this function just return on error. Why quit QEMU here?

> +        }
> +    }
> +
>       measurement = g_new0(struct kvm_sev_launch_measure, 1);
> 
>       /* query the measurement blob length */
> @@ -684,7 +714,7 @@ sev_guest_init(const char *id)
>   {
>       SevGuestState *sev;
>       char *devname;
> -    int ret, fw_error;
> +    int ret, fw_error, cmd;
>       uint32_t ebx;
>       uint32_t host_cbitpos;
>       struct sev_user_data_status status = {};
> @@ -745,8 +775,20 @@ sev_guest_init(const char *id)
>       sev->api_major = status.api_major;
>       sev->api_minor = status.api_minor;
> 
> +    if (sev_es_enabled()) {
> +        if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
> +            error_report("%s: guest policy requires SEV-ES, but "
> +                         "host SEV-ES support unavailable",
> +                         __func__);
> +            goto err;
> +        }
> +        cmd = KVM_SEV_ES_INIT;
> +    } else {
> +        cmd = KVM_SEV_INIT;
> +    }
> +
>       trace_kvm_sev_init();
> -    ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
> +    ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
>       if (ret) {
>           error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
>                        __func__, ret, fw_error, fw_error_to_str(fw_error));
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 4db6960f60..4f9a5e9b21 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -29,6 +29,7 @@
>   #define SEV_POLICY_SEV          0x20
> 
>   extern bool sev_enabled(void);
> +extern bool sev_es_enabled(void);
>   extern uint64_t sev_get_me_mask(void);
>   extern SevInfo *sev_get_info(void);
>   extern uint32_t sev_get_cbit_position(void);
> 

