Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3882078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CdAVRxFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3882078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdwRA-0004UA-Q8
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 09:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jdwQc-00045V-67
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:49:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jdwQa-0004iG-SA
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:49:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04RDVwge001028
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GCGMC8cT8cyS677D0yPXU66ACETOunle7oCgrTq0DY4=;
 b=CdAVRxFIl4lAtHqCa2tt2U1fCSrjdtsyk21VZWp0X3idmOfr2wS48xJGvth/1m47eog9
 Eo5ni1cAhX/8WpZVTAnuRm9T8wgnJjjzqjWBvHpaouSF0pv8vg0YM1ib5Rz34byYDfs7
 GYxBj0W7VujxyLoTzKVZuC0P34rV0tdgtjTB/bvX/A11K/esQwBUsDvGioHo5WGqOODV
 qm1C2kF6Y/VZpilkhXzNLgTAXT5i3h/8YMEqDyVRDUdrTCGe34QiC97acVcQiC35Cmr4
 Yy/aWBvPM8HJvEhAmZUySRFYTIfDDvH0AOxea7XmCGl62thsotvOr1rpguTYsT2NtlOj lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3170c7538q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:49:01 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04RDWRrB003177
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:49:01 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3170c75385-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 09:49:01 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04RDjD02016184;
 Wed, 27 May 2020 13:49:00 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01wdc.us.ibm.com with ESMTP id 316uf8q7f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 13:49:00 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04RDmxkt29295014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2020 13:48:59 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75E556A057;
 Wed, 27 May 2020 13:48:59 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A17EE6A051;
 Wed, 27 May 2020 13:48:58 +0000 (GMT)
Received: from [9.160.21.42] (unknown [9.160.21.42])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 27 May 2020 13:48:58 +0000 (GMT)
Subject: Re: [PATCH 3/4] configure: add flag to enable SafeStack
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-4-dbuono@linux.vnet.ibm.com>
 <20200521095237.GC251811@stefanha-x1.localdomain>
 <02f318af-609a-ee9d-4857-abe297773dda@linux.vnet.ibm.com>
 <20200527111212.GC29137@stefanha-x1.localdomain>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <428c9546-ce0c-1213-63d3-d53d9ac9dddc@linux.vnet.ibm.com>
Date: Wed, 27 May 2020 09:48:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527111212.GC29137@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-27_03:2020-05-27,
 2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 cotscore=-2147483648 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270098
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 09:49:02
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

Hi Stefan, a quick clarification on configure:

right now, in configure, there's
* "Advanced Options (experts only)"
which usually don't have both enable and disable for each option, and
* "Optional features, enabled with --enable-FEATURE and
disabled with --disable-FEATURE, default is enabled if available:"

How do you think SafeStack should be classified?
* If we do it as Advanced option, we should probably force it disabled
unless --enable-safe-stack is provided. In this case
--disable-safe-stack is not really necessary.
* If we do it as optional feature, I have two ways to handle the default:
1. enable/disable based on the compilation flags given to configure
2. enable every time the provided compiler supports it

On 5/27/2020 7:12 AM, Stefan Hajnoczi wrote:
> On Fri, May 22, 2020 at 11:24:46AM -0400, Daniele Buono wrote:
>> I would feel more confident by adding another check in configure to make
>> sure that the user didn't enable SafeStack manually through other means,
>> like manually setting the option through extra_cflags.
>> What do you think?
> 
> Sure, a compile_prog call could check if SafeStack is enable when it
> shouldn't be.
> 
> This can be done together with a --disable option.
> 
> Stefan
> 

