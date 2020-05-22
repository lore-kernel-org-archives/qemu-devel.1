Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93585C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A101205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A101205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc9Rv-0000SZ-JO
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 11:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jc9RM-00084V-Of
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:18:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jc9RL-0002e1-DU
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:18:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04MEY1v0000739
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 11:18:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mgu52f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 11:18:24 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04MEZn93010777
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 11:18:24 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mgu520-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 11:18:24 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04MFEJhV002632;
 Fri, 22 May 2020 15:18:23 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04wdc.us.ibm.com with ESMTP id 313wh45p7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 15:18:22 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04MFIK4J12452582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 15:18:20 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5D466A047;
 Fri, 22 May 2020 15:18:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23AC16A054;
 Fri, 22 May 2020 15:18:21 +0000 (GMT)
Received: from [9.160.66.72] (unknown [9.160.66.72])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2020 15:18:20 +0000 (GMT)
Subject: Re: [PATCH 1/4] coroutine: support SafeStack in ucontext backend
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-2-dbuono@linux.vnet.ibm.com>
 <20200521094402.GA251811@stefanha-x1.localdomain>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <c4411a43-ea2b-7d8a-60db-6f98239089d7@linux.vnet.ibm.com>
Date: Fri, 22 May 2020 11:18:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521094402.GA251811@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-22_05:2020-05-22,
 2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220110
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:18:25
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,
thank you so much for reviewing this.
See my answers below:

On 5/21/2020 5:44 AM, Stefan Hajnoczi wrote:
> On Wed, Apr 29, 2020 at 03:44:17PM -0400, Daniele Buono wrote:
>> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
>> index bd6b0468e1..2ffd75ddbe 100644
>> --- a/include/qemu/coroutine_int.h
>> +++ b/include/qemu/coroutine_int.h
>> @@ -28,6 +28,12 @@
>>   #include "qemu/queue.h"
>>   #include "qemu/coroutine.h"
>>   
>> +#if defined(__has_feature) && __has_feature(safe_stack)
>> +#define CONFIG_SAFESTACK 1
> 
> Please perform this feature check in ./configure. That way
> CONFIG_SAFESTACK will be defined alongside all the other CONFIG_* values
> and be available to C and Makefiles via config-host.h and
> config-host.mak.
> 

Sure, will do this in v2.

>> @@ -160,6 +169,19 @@ Coroutine *qemu_coroutine_new(void)
>>       /* swapcontext() in, siglongjmp() back out */
>>       if (!sigsetjmp(old_env, 0)) {
>>           start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
>> +#ifdef CONFIG_SAFESTACK
>> +        /*
>> +         * Before we swap the context, set the new unsafe stack
>> +         * The unsafe stack grows just like the normal stack, so start from
>> +         * the last usable location of the memory area.
>> +         * NOTE: we don't have to re-set it afterwards because sigsetjmp was
>> +         * called with the original usp. Since we are not coming back with a
>> +         * swapcontext, but with a siglongjmp, when we are back here we
>> +         * already have usp restored to the valid one for this function
> 
> I don't understand this comment. __safestack_unsafe_stack_ptr is a
> thread-local variable, not a CPU register. How will siglongjmp()
> automatically restore it?
> 
Correct, setjmp/longjmp have no visibility of the unsafe stack. What I
meant is that it is not automatically restored by the longjmp itself,
but by code the compiler adds around the sigsetjmp.

Specifically, every sigsetjmp/sigjmp is intercepted by the compiler, the
current value of __safestack_unsafe_stack_ptr is saved on the normal
(safe) stack.
Right after the sigsetjmp call it is then restored.

I will change the comment to make it clearer.

In practice, this is what happens:

Original clang implementation in qemu_coroutine_new:
----
40130c:  callq  4008d0 <__sigsetjmp@plt>
401311:  cmp    $0x0,%eax
401314:  jne    40132d <qemu_coroutine_new+0x12d>
----
Clang Implementation with safestack:
----
4027a7:  mov    %rdx,-0x38(%rbp) <- Save unsafe ptr onto the safe stack
[...]
40289c:  callq  401410 <__sigsetjmp@plt>
4028a1:  mov    0x201738(%rip),%rdi        # 603fe0 
<__safestack_unsafe_stack_ptr@@Base+0x603fe0>
4028a8:  mov    -0x38(%rbp),%rbx
4028ac:  mov    %rbx,%fs:(%rdi) <- Restore the unsafe ptr
4028b0:  cmp    $0x0,%eax
4028b3:  jne    4028d9 <qemu_coroutine_new+0x179>


>> +         */
>> +        void *usp = co->unsafe_stack + co->unsafe_stack_size;
>> +        __safestack_unsafe_stack_ptr = usp;
>> +#endif
>>           swapcontext(&old_uc, &uc);
>>       }
>>   

