Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA27C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B2C20835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="egFU7XZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B2C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je0JZ-0002oW-37
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1je0If-0001YX-59
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:57:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1je0Ic-0007zN-4d
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:57:08 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04RHXceU169035
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 13:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Mbd8zL0FODy17qRWow2rXYsURwe4sHGxAzka9JOjOeA=;
 b=egFU7XZrclJheCIOC4Sl1GjYrWMLgi4kb+/PeSo1bluaoKxyu04MywUj/FEJun1BIw1e
 wImCZcmgbYSptwIK0+MPIEaekay/ixyebEoFQif8a26H7lqnrVkPq7PluRK2F7mf/+Av
 fnR4HGlC2emDFLB1lxLGbDhXO8huolaNZH7nFo6Ve2pYIsYDTGjBOcjcSykuZxjIXogn
 c9YUx+KrvBabF/47q/sM6Wlt3jzDSbS4/9iti0EKpCqp9/h1Vs6S6jlSbGmUbfYSop6g
 EywugHam/H05YBFotBDYCJ/1iocsnZA/IIDVs5GybOtz0cUu4p9HhClBgdN0GmvCiHRO MA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 317hek2dws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 13:57:03 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04RHYXTC171854
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 13:57:03 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 317hek2dwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 13:57:03 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04RHsrmO007797;
 Wed, 27 May 2020 17:57:02 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02dal.us.ibm.com with ESMTP id 316ufaq3p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 17:57:02 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04RHv0k711272742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2020 17:57:00 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81E8A6A058;
 Wed, 27 May 2020 17:57:01 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C19F46A054;
 Wed, 27 May 2020 17:57:00 +0000 (GMT)
Received: from [9.160.21.42] (unknown [9.160.21.42])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 27 May 2020 17:57:00 +0000 (GMT)
Subject: Re: [PATCH 2/4] coroutine: Add check for SafeStack in sigalstack
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-3-dbuono@linux.vnet.ibm.com>
 <20200521094930.GB251811@stefanha-x1.localdomain>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <8b253efe-ecba-a172-050e-f05ef3885624@linux.vnet.ibm.com>
Date: Wed, 27 May 2020 13:56:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521094930.GB251811@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-27_03:2020-05-27,
 2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270137
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 13:57:04
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Sorry, missed the question at the end of the email.
Will change the commit and error message to explain better in v2.

Similar to the ucontext, case, sigaltstack does not work out of the box
because it requires a stack to be allocated by the user.

I'll be honest, I didn't check the details of how sigaltstack is used in
coroutine-sigaltstack. It is very possible that this coroutine version
can also be adapted to run properly with SafeStack.
coroutine_trampoline is probably the place where we can set the usp so
that, when coroutine_bootstrap is called, it is done with the new unsafe
stack.

My initial focus was on the ucontext implementation since that is the
default one and mostly used. For now, I am just blocking the user from
using coroutine-sigaltstack with SafeStack.

However, if you are interested, Ican try to add support to sigaltstack
in the future.

On 5/21/2020 5:49 AM, Stefan Hajnoczi wrote:
> On Wed, Apr 29, 2020 at 03:44:18PM -0400, Daniele Buono wrote:
> 
> s/sigalstack/sigaltstack/ in the commit message.
> 
>> LLVM's SafeStack instrumentation cannot be used inside signal handlers
>> that make use of sigaltstack().
>> Since coroutine-sigaltstack relies on sigaltstack(), it is not
>> compatible with SafeStack. The resulting binary is incorrect, with
>> different coroutines sharing the same unsafe stack and producing
>> undefined behavior at runtime.
>> To avoid this, we add a check in coroutine-sigaltstack that throws a
>> preprocessor #error and interrupt the compilation if SafeStack is
>> enabled.
>>
>> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
>> ---
>>   util/coroutine-sigaltstack.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
>> index f6fc49a0e5..b7cdc959f8 100644
>> --- a/util/coroutine-sigaltstack.c
>> +++ b/util/coroutine-sigaltstack.c
>> @@ -30,6 +30,10 @@
>>   #include "qemu-common.h"
>>   #include "qemu/coroutine_int.h"
>>   
>> +#ifdef CONFIG_SAFESTACK
>> +#error "SafeStack does not work with sigaltstack's implementation"
>> +#endif
> 
> Neither the commit description nor the #error message explain why it
> doesn't work. Could it work in the future or is there a fundamental
> reason why it will never work?
> 
> Stefan
> 

