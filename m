Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1FAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56A820772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56A820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyg4-0003jq-8S
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jqyfP-0003BU-Je
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:50:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50942
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jqyfM-0008GF-QE
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:50:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 062CWYXY038237
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2020 08:50:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 320t3gdp6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 08:50:11 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 062CfAl2093046
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2020 08:50:10 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 320t3gdp61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2020 08:50:10 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 062CeaLu016296;
 Thu, 2 Jul 2020 12:50:10 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma05wdc.us.ibm.com with ESMTP id 31wwr98bc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2020 12:50:10 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 062Co9HC61735254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2020 12:50:09 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6514E6A047;
 Thu,  2 Jul 2020 12:50:09 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC56B6A04F;
 Thu,  2 Jul 2020 12:50:08 +0000 (GMT)
Received: from [9.160.82.151] (unknown [9.160.82.151])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2020 12:50:08 +0000 (GMT)
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
 <20200702095252.GF1888119@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <0ed44c55-1f5d-6866-9555-82134ef628fb@linux.vnet.ibm.com>
Date: Thu, 2 Jul 2020 08:50:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702095252.GF1888119@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-02_05:2020-07-02,
 2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 cotscore=-2147483648 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020089
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 08:50:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/2/2020 5:52 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 02, 2020 at 01:49:48AM -0400, Daniele Buono wrote:
>> This patch adds a flag to enable/disable control flow integrity checks
>> on indirect function calls. This feature is only provided by LLVM/Clang
>> v3.9 or higher, and only allows indirect function calls to functions
>> with compatible signatures.
>>
>> We also add an option to enable a debugging version of cfi, with verbose
>> output in case of a CFI violation.
>>
>> CFI on indirect function calls does not support calls to functions in
>> shared libraries (since they were not known at compile time), and such
>> calls are forbidden. QEMU relies on dlopen/dlsym when using modules,
>> so we make modules incompatible with CFI.
>>
>> We introduce a blacklist file, to disable CFI checks in a limited number
>> of TCG functions.
>>
>> The feature relies on link-time optimization (lto), which requires the
>> use of the gold linker, and the LLVM versions of ar, ranlib and nm.
>> This patch take care of checking that all the compiler toolchain
>> dependencies are met.
>>
>> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
>> ---
>>   cfi-blacklist.txt |  27 +++++++
>>   configure         | 177 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 204 insertions(+)
>>   create mode 100644 cfi-blacklist.txt
>>
>> diff --git a/cfi-blacklist.txt b/cfi-blacklist.txt
>> new file mode 100644
>> index 0000000000..bf804431a5
>> --- /dev/null
>> +++ b/cfi-blacklist.txt
>> @@ -0,0 +1,27 @@
>> +# List of functions that should not be compiled with Control-Flow Integrity
>> +
>> +[cfi-icall]
>> +# TCG creates binary blobs at runtime, with the transformed code.
>> +# When it's time to execute it, the code is called with an indirect function
>> +# call. Since such function did not exist at compile time, the runtime has no
>> +# way to verify its signature. Disable CFI checks in the function that calls
>> +# the binary blob
>> +fun:cpu_tb_exec
>> +
>> +# TCI (Tiny Compiler Interpreter) is an interpreter for TCG pseudo code.
>> +# One possible operation in the pseudo code is a call to binary code.
>> +# Therefore, disable CFI checks in the interpreter function
>> +fun:tcg_qemu_tb_exec
>> +
>> +# TCG Plugins Callback Functions. The mechanism rely on opening external
>> +# shared libraries at runtime and get pointers to functions in such libraries
>> +# Since these pointers are external to the QEMU binary, the runtime cannot
>> +# verify their signature. Disable CFI Checks in all the functions that use
>> +# such pointers.
>> +fun:plugin_vcpu_cb__simple
>> +fun:plugin_cb__simple
>> +fun:plugin_cb__udata
>> +fun:qemu_plugin_tb_trans_cb
>> +fun:qemu_plugin_vcpu_syscall
>> +fun:qemu_plugin_vcpu_syscall_ret
>> +fun:plugin_load
> 
> The need to maintain this list of functions makes me feel very
> uneasy.
> 
> How can we have any confidence that this list of functions is
> accurate ? How will maintainers ensure that they correctly update
> it as they are writing/changing code, and how will they test the
> result ?
> 
> It feels like it has the same general maint problem as the original
> seccomp code we used, where we were never confident we had added
> the right exceptions to let QEMU run without crashing when users
> tickled some feature we forgot about.
> 
> 
> Regards,
> Daniel
> 

I agree with you that keeping that list updated is a daunting task. In 
my opinion, however, it is not as difficult as a seccomp filter, for the 
following reasons:

1) Seccomp covers everything that runs in your process, including shared 
libraries that you have no control over. CFI covers only the code in the 
QEMU binary. So at least we don't have to guess what other libraries 
used by QEMU will or won't do during execution.

2) With seccomp you have to filter behavior that, while admissible, 
should not happen in your code. CFI can be seen as a run-time type 
checking system; if the signature of the function is wrong, that is a 
coding error... in theory. In practice, there is a corner-case because 
the type checking doesn't know the signature of code loaded or written 
at run-time, and that is why you have to use a CFI filter.

So yes, there is risk, but IMHO it's not as high as in seccomp.

I think with a bit of education, it would be easy to spot red flags in 
new code.
As for education/testing... I can definitely work on a doc to be put in 
docs/devel.
Testing for CFI violations may be more difficult, however if a test code 
that exercises it is written in tests/, compiling QEMU with CFI and 
running the test should be sufficient to hit the violation.
I also wonder if this is something that could be put in the fuzzing 
environment. It would probably also help in finding coding error in 
corner cases quicker.

Regards,
Daniele

