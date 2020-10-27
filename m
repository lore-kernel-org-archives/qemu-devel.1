Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01434C56202
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1FE22264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WutT/Xsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1FE22264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQiP-0006R8-DJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXQPr-00013D-D9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:57:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXQPo-0004xt-NQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:57:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09REqexe005205; Tue, 27 Oct 2020 10:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7q2SPZwVezQ0A4XI226MSwgf+tR4IkC+Y6m9h/BEMM0=;
 b=WutT/XsaDT6kRwx2x8/AaKY7lNkGoJ5nyHgwiMKCdNrRf0qIPGLt/H+IDzbjkuRlGsfC
 boU+QGi3RRJqpdqmrcO7n8n64N07ELV9ujAb21n/JXunG40+b2EG/ZHsUyGDHNqS3L/L
 4lNlzIV12Gfpe5xUfdAb1F7GjtQ2KKgoGIx67Ixn+j2nGVJ3B5F0ENUq7yA93Vmf6rat
 4AS30fOtcOta+ppwqYZ3j1sTBBW3UDwZD7wycTC1wx/b0EZU3t+WW/zC9OOz9Y5k1Bce
 oKHnahyy/I6VCRpn98iF9kAImkWijR/B+7Oty5EQsctPmdLp6S5iQkAHbi61BA5+HU4X +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34e4jwcvqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 10:57:34 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09REqrT0006056;
 Tue, 27 Oct 2020 10:57:19 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34e4jwcvpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 10:57:19 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09REv92W022454;
 Tue, 27 Oct 2020 14:57:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02dal.us.ibm.com with ESMTP id 34e1gnhmvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2020 14:57:18 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09REvHqL53805454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2020 14:57:17 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 356D36A057;
 Tue, 27 Oct 2020 14:57:17 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68F546A047;
 Tue, 27 Oct 2020 14:57:16 +0000 (GMT)
Received: from [9.160.17.83] (unknown [9.160.17.83])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2020 14:57:16 +0000 (GMT)
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
 <20201026155006.GE496050@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2020 10:57:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201026155006.GE496050@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-27_08:2020-10-26,
 2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270092
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:57:35
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In terms of ar and linker, if you don't have the right mix it will just
stop at link time with an error.

In terms of using gcc the errors may be a bit more subtle, similar to
what Daniel mentioned. Succesfully compiling but then showing issues at
runtime or in the test suite.

I'm using ubuntu 18.04 and the stock compiler (based on gcc 7.5) issues
a bunch of warnings but compile succesfully with LTO.
However, the tcg binary for sparc64 is broken. System-wide emulation
stops in OpenFirmware with an exception. User emulation triggers a
segmentation fault in some of the test cases. If I compile QEMU with
--enable-debug the tests magically work.

I briefly tested with gcc-9 and that seemed to work ok, buy your mileage
may vary

On 10/26/2020 11:50 AM, Daniel P. Berrangé wrote:
> On Mon, Oct 26, 2020 at 10:51:43AM +0100, Paolo Bonzini wrote:
>> On 23/10/20 22:06, Daniele Buono wrote:
>>> This patch allows to compile QEMU with link-time optimization (LTO).
>>> Compilation with LTO is handled directly by meson. This patch adds checks
>>> in configure to make sure the toolchain supports LTO.
>>>
>>> Currently, allow LTO only with clang, since I have found a couple of issues
>>> with gcc-based LTO.
>>>
>>> In case fuzzing is enabled, automatically switch to llvm's linker (lld).
>>> The standard bfd linker has a bug where function wrapping (used by the fuzz*
>>> targets) is used in conjunction with LTO.
>>>
>>> Tested with all major versions of clang from 6 to 12
>>>
>>> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
>>
>> What are the problems like if you have GCC or you ar/linker are not up
>> to the job?  I wouldn't mind omitting the tests since this has to be
>> enabled explicitly by the user.
> 
> We temporarily disabled LTO in Fedora rawhide due to GCC bugs causing
> wierd test suite asserts. Those were pre-release versions of GCC/binutils
> though. I've just tested again and LTO works correctly, so I've enabled
> LTO once again.
> 
> Regards,
> Daniel
> 

