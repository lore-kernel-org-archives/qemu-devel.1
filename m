Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43749C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4812073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4812073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfaZ-000669-91
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jCfZw-0005hW-R6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jCfZv-0006My-9t
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:22:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jCfZv-0006LA-4p
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:21:59 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02D8Ljfa110238
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 04:21:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yquet11bx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 04:21:57 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Fri, 13 Mar 2020 08:21:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 08:21:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02D8LJGc45678648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 08:21:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20B704C040;
 Fri, 13 Mar 2020 08:21:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7BBB4C046;
 Fri, 13 Mar 2020 08:21:18 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.119])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 08:21:18 +0000 (GMT)
Subject: Re: [PATCH v9] s390x: protvirt: Fence huge pages
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200312162510.5472-1-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 xsFNBE6cPPgBEAC2VpALY0UJjGmgAmavkL/iAdqul2/F9ONz42K6NrwmT+SI9CylKHIX+fdf
 J34pLNJDmDVEdeb+brtpwC9JEZOLVE0nb+SR83CsAINJYKG3V1b3Kfs0hydseYKsBYqJTN2j
 CmUXDYq9J7uOyQQ7TNVoQejmpp5ifR4EzwIFfmYDekxRVZDJygD0wL/EzUr8Je3/j548NLyL
 4Uhv6CIPf3TY3/aLVKXdxz/ntbLgMcfZsDoHgDk3lY3r1iwbWwEM2+eYRdSZaR4VD+JRD7p8
 0FBadNwWnBce1fmQp3EklodGi5y7TNZ/CKdJ+jRPAAnw7SINhSd7PhJMruDAJaUlbYaIm23A
 +82g+IGe4z9tRGQ9TAflezVMhT5J3ccu6cpIjjvwDlbxucSmtVi5VtPAMTLmfjYp7VY2Tgr+
 T92v7+V96jAfE3Zy2nq52e8RDdUo/F6faxcumdl+aLhhKLXgrozpoe2nL0Nyc2uqFjkjwXXI
 OBQiaqGeWtxeKJP+O8MIpjyGuHUGzvjNx5S/592TQO3phpT5IFWfMgbu4OreZ9yekDhf7Cvn
 /fkYsiLDz9W6Clihd/xlpm79+jlhm4E3xBPiQOPCZowmHjx57mXVAypOP2Eu+i2nyQrkapaY
 IdisDQfWPdNeHNOiPnPS3+GhVlPcqSJAIWnuO7Ofw1ZVOyg/jwARAQABzUNDaHJpc3RpYW4g
 Qm9ybnRyYWVnZXIgKDJuZCBJQk0gYWRkcmVzcykgPGJvcm50cmFlZ2VyQGxpbnV4LmlibS5j
 b20+wsF5BBMBAgAjBQJdP/hMAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQEXu8
 gLWmHHy/pA/+JHjpEnd01A0CCyfVnb5fmcOlQ0LdmoKWLWPvU840q65HycCBFTt6V62cDljB
 kXFFxMNA4y/2wqU0H5/CiL963y3gWIiJsZa4ent+KrHl5GK1nIgbbesfJyA7JqlB0w/E/SuY
 NRQwIWOo/uEvOgXnk/7+rtvBzNaPGoGiiV1LZzeaxBVWrqLtmdi1iulW/0X/AlQPuF9dD1Px
 hx+0mPjZ8ClLpdSp5d0yfpwgHtM1B7KMuQPQZGFKMXXTUd3ceBUGGczsgIMipZWJukqMJiJj
 QIMH0IN7XYErEnhf0GCxJ3xAn/J7iFpPFv8sFZTvukntJXSUssONnwiKuld6ttUaFhSuSoQg
 OFYR5v7pOfinM0FcScPKTkrRsB5iUvpdthLq5qgwdQjmyINt3cb+5aSvBX2nNN135oGOtlb5
 tf4dh00kUR8XFHRrFxXx4Dbaw4PKgV3QLIHKEENlqnthH5t0tahDygQPnSucuXbVQEcDZaL9
 WgJqlRAAj0pG8M6JNU5+2ftTFXoTcoIUbb0KTOibaO9zHVeGegwAvPLLNlKHiHXcgLX1tkjC
 DrvE2Z0e2/4q7wgZgn1kbvz7ZHQZB76OM2mjkFu7QNHlRJ2VXJA8tMXyTgBX6kq1cYMmd/Hl
 OhFrAU3QO1SjCsXA2CDk9MM1471mYB3CTXQuKzXckJnxHkHOwU0ETpw8+AEQAJjyNXvMQdJN
 t07BIPDtbAQk15FfB0hKuyZVs+0lsjPKBZCamAAexNRk11eVGXK/YrqwjChkk60rt3q5i42u
 PpNMO9aS8cLPOfVft89Y654Qd3Rs1WRFIQq9xLjdLfHh0i0jMq5Ty+aiddSXpZ7oU6E+ud+X
 Czs3k5RAnOdW6eV3+v10sUjEGiFNZwzN9Udd6PfKET0J70qjnpY3NuWn5Sp1ZEn6lkq2Zm+G
 9G3FlBRVClT30OWeiRHCYB6e6j1x1u/rSU4JiNYjPwSJA8EPKnt1s/Eeq37qXXvk+9DYiHdT
 PcOa3aNCSbIygD3jyjkg6EV9ZLHibE2R/PMMid9FrqhKh/cwcYn9FrT0FE48/2IBW5mfDpAd
 YvpawQlRz3XJr2rYZJwMUm1y+49+1ZmDclaF3s9dcz2JvuywNq78z/VsUfGz4Sbxy4ShpNpG
 REojRcz/xOK+FqNuBk+HoWKw6OxgRzfNleDvScVmbY6cQQZfGx/T7xlgZjl5Mu/2z+ofeoxb
 vWWM1YCJAT91GFvj29Wvm8OAPN/+SJj8LQazd9uGzVMTz6lFjVtH7YkeW/NZrP6znAwv5P1a
 DdQfiB5F63AX++NlTiyA+GD/ggfRl68LheSskOcxDwgI5TqmaKtX1/8RkrLpnzO3evzkfJb1
 D5qh3wM1t7PZ+JWTluSX8W25ABEBAAHCwV8EGAECAAkFAk6cPPgCGwwACgkQEXu8gLWmHHz8
 2w//VjRlX+tKF3szc0lQi4X0t+pf88uIsvR/a1GRZpppQbn1jgE44hgF559K6/yYemcvTR7r
 6Xt7cjWGS4wfaR0+pkWV+2dbw8Xi4DI07/fN00NoVEpYUUnOnupBgychtVpxkGqsplJZQpng
 v6fauZtyEcUK3dLJH3TdVQDLbUcL4qZpzHbsuUnTWsmNmG4Vi0NsEt1xyd/Wuw+0kM/oFEH1
 4BN6X9xZcG8GYUbVUd8+bmio8ao8m0tzo4pseDZFo4ncDmlFWU6hHnAVfkAs4tqA6/fl7RLN
 JuWBiOL/mP5B6HDQT9JsnaRdzqF73FnU2+WrZPjinHPLeE74istVgjbowvsgUqtzjPIG5pOj
 cAsKoR0M1womzJVRfYauWhYiW/KeECklci4TPBDNx7YhahSUlexfoftltJA8swRshNA/M90/
 i9zDo9ySSZHwsGxG06ZOH5/MzG6HpLja7g8NTgA0TD5YaFm/oOnsQVsf2DeAGPS2xNirmknD
 jaqYefx7yQ7FJXXETd2uVURiDeNEFhVZWb5CiBJM5c6qQMhmkS4VyT7/+raaEGgkEKEgHOWf
 ZDP8BHfXtszHqI3Fo1F4IKFo/AP8GOFFxMRgbvlAs8z/+rEEaQYjxYJqj08raw6P4LFBqozr
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Fri, 13 Mar 2020 09:21:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312162510.5472-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031308-4275-0000-0000-000003AB935F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031308-4276-0000-0000-000038C0B436
Message-Id: <09c0b73f-9587-ded0-35c3-f7ce231af69d@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_03:2020-03-11,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130041
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12.03.20 17:25, Janosch Frank wrote:
> Let's bail out of the protected transition if we detect that huge
> pages might be in use.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> I'd like to squash this into the unpack patch to give a proper error
> message if we try to transition into the protected mode while being
> backed by huge pages. 

Looks good.
But maybe we can do it better. Why not reverse the logic and
instead of having kvm_s390_get_hpage_1m, let us define an protvirt_allowed
that as of today only returns hugepages != 1:
Then we could (for kvm-stub.c) also say protvirt_allowed=false;
And if other reasons come along we can extend.

We could also keep this patch separate, does not really matter.

> 
> ---
>  hw/s390x/ipl.h             | 16 ++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c |  1 -
>  target/s390x/diag.c        | 23 ++++++++---------------
>  target/s390x/kvm-stub.c    |  5 +++++
>  target/s390x/kvm.c         |  5 +++++
>  target/s390x/kvm_s390x.h   |  1 +
>  6 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index af5bb130a6334821..95e3183c9cccf8b6 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -185,6 +185,22 @@ struct S390IPLState {
>  typedef struct S390IPLState S390IPLState;
>  QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>  
> +#define DIAG_308_RC_OK              0x0001
> +#define DIAG_308_RC_NO_CONF         0x0102
> +#define DIAG_308_RC_INVALID         0x0402
> +#define DIAG_308_RC_NO_PV_CONF      0x0902
> +#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
> +
> +#define DIAG308_RESET_MOD_CLR       0
> +#define DIAG308_RESET_LOAD_NORM     1
> +#define DIAG308_LOAD_CLEAR          3
> +#define DIAG308_LOAD_NORMAL_DUMP    4
> +#define DIAG308_SET                 5
> +#define DIAG308_STORE               6
> +#define DIAG308_PV_SET              8
> +#define DIAG308_PV_STORE            9
> +#define DIAG308_PV_START            10
> +
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
>  #define S390_IPL_TYPE_PV 0x05
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index ebdaaa3a001f6e8c..d32f35c7f47b9c1d 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -361,7 +361,6 @@ out_err:
>      return rc;
>  }
>  
> -#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
>  static void s390_machine_inject_pv_error(CPUState *cs)
>  {
>      int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index b245e557037ded06..b1ca81633b83bbdc 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -21,6 +21,7 @@
>  #include "hw/s390x/ipl.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/pv.h"
> +#include "kvm_s390x.h"
>  
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  {
> @@ -50,21 +51,6 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>      return diag288_class->handle_timer(diag288, func, timeout);
>  }
>  
> -#define DIAG_308_RC_OK              0x0001
> -#define DIAG_308_RC_NO_CONF         0x0102
> -#define DIAG_308_RC_INVALID         0x0402
> -#define DIAG_308_RC_NO_PV_CONF      0x0902
> -
> -#define DIAG308_RESET_MOD_CLR       0
> -#define DIAG308_RESET_LOAD_NORM     1
> -#define DIAG308_LOAD_CLEAR          3
> -#define DIAG308_LOAD_NORMAL_DUMP    4
> -#define DIAG308_SET                 5
> -#define DIAG308_STORE               6
> -#define DIAG308_PV_SET              8
> -#define DIAG308_PV_STORE            9
> -#define DIAG308_PV_START            10
> -
>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>                                uintptr_t ra, bool write)
>  {
> @@ -166,6 +152,13 @@ out:
>              return;
>          }
>  
> +        if (kvm_s390_get_hpage_1m()) {
> +            error_report("Protected VMs can currently not be backed with "
> +                         "huge pages");
> +            env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
> +            return;
> +        }
> +
>          s390_ipl_reset_request(cs, S390_RESET_PV);
>          break;
>      default:
> diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
> index c4cd497f850eb9c7..aa185017a2a886ca 100644
> --- a/target/s390x/kvm-stub.c
> +++ b/target/s390x/kvm-stub.c
> @@ -39,6 +39,11 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
>      return 0;
>  }
>  
> +int kvm_s390_get_hpage_1m(void)
> +{
> +    return 0;
> +}
> +
>  int kvm_s390_get_ri(void)
>  {
>      return 0;
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 1d6fd6a27b48e35f..c695941076b7aead 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -321,6 +321,11 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
>      cap_hpage_1m = 1;
>  }
>  
> +int kvm_s390_get_hpage_1m(void)
> +{
> +    return cap_hpage_1m;
> +}
> +
>  static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 0b21789796d7c462..dea813f450153c34 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -23,6 +23,7 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
>  int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
>  int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
> +int kvm_s390_get_hpage_1m(void);
>  int kvm_s390_get_ri(void);
>  int kvm_s390_get_gs(void);
>  int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
> 


