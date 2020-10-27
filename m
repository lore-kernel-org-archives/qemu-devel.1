Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC526C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A7920791
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hOtrSGlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A7920791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXVoj-00012D-Ih
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 16:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXVnV-0000Mt-Iv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 16:42:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38856
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXVnT-0006uQ-BQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 16:42:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09RKWpGw150247; Tue, 27 Oct 2020 16:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wUiq+CwxFocULo4fPzlHjywyStHl3KhHA9UbbVmaM98=;
 b=hOtrSGlKnUnE6/nbdqymB50SVuC/bkqFwWDAlQXGlZgS7Y4+yYptNRsiY2vER0qzGjcg
 HfFU9oSfaQsYOVDHsavtGdYKfaf2ceaKU1VGLZfGeMcfOOa/IInETsjahL04vkByq9hP
 8klZeEvU51xHncPWeMas6EOzL7Nq7PKYVCgpZnaM7Dv1OFhcyTEbBpyE5qJrmPvMucCd
 Km0JpMJ7JhjY0NcuRw7/nj5OelxUZQrJobkNZ7JIv1cW0aAQBjCSQ9BwY2ZXvo25Hn17
 C1n7Hgv1cvzA9zVUlkR6mOgc7tGsqE0P5PcNLVal05xsWiD8/5Cf9fT9LSnRnkQnIASJ XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34eqnne7b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 16:42:16 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09RKYioa155121;
 Tue, 27 Oct 2020 16:42:15 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34eqnne7b4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 16:42:15 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09RKbYa6032419;
 Tue, 27 Oct 2020 20:42:15 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma05wdc.us.ibm.com with ESMTP id 34cbw92twe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 20:42:15 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09RKg9dV56492346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2020 20:42:09 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 538456A051;
 Tue, 27 Oct 2020 20:42:14 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2D456A04D;
 Tue, 27 Oct 2020 20:42:13 +0000 (GMT)
Received: from [9.160.17.83] (unknown [9.160.17.83])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2020 20:42:13 +0000 (GMT)
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
 <20201026155006.GE496050@redhat.com>
 <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
 <20201027151744.GF529052@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <606b3283-25e5-329a-7d02-4d3d39383c73@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2020 16:42:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201027151744.GF529052@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-27_15:2020-10-26,
 2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270115
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 16:42:22
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ok, no problem. I can definitely disable the check on GCC.

Paolo, would you like me to disable checks on AR/linker for lto too?
If so, should I add some of this information on a document, perhaps
docs/devel/lto.rst, so it is written somewhere for future uses?

--

Btw, using lto with gcc I found another interesting warning here
(adding scsi maintainer so they can chip in on the solution):

In function 'scsi_disk_new_request_dump',
     inlined from 'scsi_new_request' at 
../qemu-cfi-v3/hw/scsi/scsi-disk.c:2588:9:
../qemu-cfi-v3/hw/scsi/scsi-disk.c:2562:17: warning: argument 1 value 
'18446744073709551612' exceeds maximum object size 9223372036854775807 
[-Walloc-size-larger-than=]
      line_buffer = g_malloc(len * 5 + 1);
                  ^
../qemu-cfi-v3/hw/scsi/scsi-disk.c: In function 'scsi_new_request':
/usr/include/glib-2.0/glib/gmem.h:78:10: note: in a call to allocation 
function 'g_malloc' declared here
  gpointer g_malloc         (gsize  n_bytes) G_GNUC_MALLOC 
G_GNUC_ALLOC_SIZE(1);

This seems like a bug to me. len is a signed integer filled up by
scsi_cdb_length which can return -1 if it can't decode the command.
What would probably happen is that we try a g_malloc with something too
big and that would fail. However, scsi_disk_new_request_dump is used for
tracing and:

a) I believe an unknown command here is a possibility, and is
handled by the caller - scsi_new_request - that has the following:

     command = buf[0];
     ops = scsi_disk_reqops_dispatch[command];
     if (!ops) {
         ops = &scsi_disk_emulate_reqops;
     }

so a termination here on the malloc is probably not desired.

b) In the tracing, we should probably print the content of the buffer
anyway, so that the unknown command can be debugged. However, I don't
know what size I should use here.
I'm thinking either 1, to print just the command header in the buffer,
or the max size of the buffer, which I am not sure how to get.

Ideas or you prefer having an initial patch and then discuss it there?

On 10/27/2020 11:17 AM, Daniel P. Berrangé wrote:
> On Tue, Oct 27, 2020 at 10:57:14AM -0400, Daniele Buono wrote:
>> In terms of ar and linker, if you don't have the right mix it will just
>> stop at link time with an error.
>>
>> In terms of using gcc the errors may be a bit more subtle, similar to
>> what Daniel mentioned. Succesfully compiling but then showing issues at
>> runtime or in the test suite.
>>
>> I'm using ubuntu 18.04 and the stock compiler (based on gcc 7.5) issues
>> a bunch of warnings but compile succesfully with LTO.
>> However, the tcg binary for sparc64 is broken. System-wide emulation
>> stops in OpenFirmware with an exception. User emulation triggers a
>> segmentation fault in some of the test cases. If I compile QEMU with
>> --enable-debug the tests magically work.
>>
>> I briefly tested with gcc-9 and that seemed to work ok, buy your mileage
>> may vary
> 
> This why we shouldn't artificially block use of LTO with GCC in
> the configure script. It blocks completely legitimate usage of
> LTO with GCC versions where it works.
> 
> The user can detect if their version of GCC is broken by running the
> test suite during their build process, which is best practice already,
> and actually testing the result.
> 
>>
>> On 10/26/2020 11:50 AM, Daniel P. Berrangé wrote:
>>> On Mon, Oct 26, 2020 at 10:51:43AM +0100, Paolo Bonzini wrote:
>>>> On 23/10/20 22:06, Daniele Buono wrote:
>>>>> This patch allows to compile QEMU with link-time optimization (LTO).
>>>>> Compilation with LTO is handled directly by meson. This patch adds checks
>>>>> in configure to make sure the toolchain supports LTO.
>>>>>
>>>>> Currently, allow LTO only with clang, since I have found a couple of issues
>>>>> with gcc-based LTO.
>>>>>
>>>>> In case fuzzing is enabled, automatically switch to llvm's linker (lld).
>>>>> The standard bfd linker has a bug where function wrapping (used by the fuzz*
>>>>> targets) is used in conjunction with LTO.
>>>>>
>>>>> Tested with all major versions of clang from 6 to 12
>>>>>
>>>>> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
>>>>
>>>> What are the problems like if you have GCC or you ar/linker are not up
>>>> to the job?  I wouldn't mind omitting the tests since this has to be
>>>> enabled explicitly by the user.
>>>
>>> We temporarily disabled LTO in Fedora rawhide due to GCC bugs causing
>>> wierd test suite asserts. Those were pre-release versions of GCC/binutils
>>> though. I've just tested again and LTO works correctly, so I've enabled
>>> LTO once again.
>>>
>>> Regards,
>>> Daniel
>>>
>>
> 
> Regards,
> Daniel
> 

