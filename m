Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4505C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A94247FF
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sRN/ZeN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A94247FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXq8y-0000f1-Pj
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXq6F-0008Gu-US
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:23:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kXq6C-0007H8-Ap
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:23:07 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09SI2c16164646; Wed, 28 Oct 2020 14:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Orx9g/5EY/+vdos+afjxIinwjgjwUw2dTckotCpZljA=;
 b=sRN/ZeN6gnhoywFdcWWj+uLjgH+Wr0ykpS0DgpCUNdknB73M7J/KW+UifOHwYqTEfM3H
 XI5LgMRUHJvPHsLJsiBsbEiqsm0sTLGGGzYjaTPMgRGbkz0pnirxRfRUBw/QDG9vU8om
 dVLKf8b7E6ACqziJAqyDBR6hIh7lfcV7ejkkzrdFNCIPJgJVICNOCFVpdI52ZogHmxAP
 1N4/EL4u0AlpU0FoGGQa/9TnOyxzr3clV4dOpC1TNL0TuW7eIzL2VOpvkGoeRQDlXRv6
 RujGTlgoI29CBd9Wucb3O0ZMqvyHTPDL8RTaGtluHT0v52gLkiWbaSJc0sC9uBsh/hR5 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dcqfstud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 14:22:47 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09SI3Ip2166103;
 Wed, 28 Oct 2020 14:22:47 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34dcqfsttq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 14:22:46 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09SILdpe029428;
 Wed, 28 Oct 2020 18:22:45 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04wdc.us.ibm.com with ESMTP id 34cbw9hxbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2020 18:22:45 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09SIMioD22872338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2020 18:22:44 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FB3B6A051;
 Wed, 28 Oct 2020 18:22:44 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 999636A04D;
 Wed, 28 Oct 2020 18:22:43 +0000 (GMT)
Received: from [9.160.17.83] (unknown [9.160.17.83])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2020 18:22:43 +0000 (GMT)
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
 <20201026155006.GE496050@redhat.com>
 <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
 <20201027151744.GF529052@redhat.com>
 <606b3283-25e5-329a-7d02-4d3d39383c73@linux.vnet.ibm.com>
 <0b7e524f-59f5-a7b3-7e4f-608042f0bd4f@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <718a0446-09f5-9e45-5f64-e22a72708e67@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2020 14:22:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0b7e524f-59f5-a7b3-7e4f-608042f0bd4f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-28_08:2020-10-28,
 2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010280118
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 14:22:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Cc: Fam Zheng <fam@euphon.net>, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If LTO is enabled with the wrong linker/ar:
- with the checks, it will exit at configure with an error. I can change 
this in a warning and disabling LTO if preferred.
- without the checks compilation will fail

If LTO is enabled with the wrong compiler (e.g. old gcc), you may get a 
bunch of warnings at compile time, and a binary that won't pass some of 
the tests in make check.

On 10/28/2020 2:44 AM, Paolo Bonzini wrote:
> On 27/10/20 21:42, Daniele Buono wrote:
>> Ok, no problem. I can definitely disable the check on GCC.
>>
>> Paolo, would you like me to disable checks on AR/linker for lto too?
>> If so, should I add some of this information on a document, perhaps
>> docs/devel/lto.rst, so it is written somewhere for future uses?
> 
> I am not sure of the effects.  Does it simply effectively disable LTO or
> is it something worse?
> 
> I'll look into the SCSI issue.
> 
> Paolo
> 

