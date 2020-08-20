Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB3BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 02:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2ED82078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 02:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UjK32U5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2ED82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Zy6-0006R5-T9
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 22:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8ZxV-0005ke-V1; Wed, 19 Aug 2020 22:05:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29278
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k8ZxT-0006Df-NU; Wed, 19 Aug 2020 22:05:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07K21ndt179919; Wed, 19 Aug 2020 22:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=bHtkBZF/0DvT0qnqLDcGx2xX8saex/9U394LNAvcdZw=;
 b=UjK32U5jQ8+PbcllzKSSlFPeV+WjCTEAsL5ClelNFmAhZ8Xi1NpEcBzqQhdsEdbeyvoP
 jPWpg+QOmO/rRkSRmseLg8lZbhdd9x9Qp4L/I94HTDqCk8sUl3CX2ztScNizS5caXMhE
 V8c+WF348LXLNGqmcso3SnEPxDSetM6JmlcVVHBIK034NGAo5bseix1jEcuIgZ9yFfln
 mhNtQBB4mIDR/F+Nf8qx0ltSgsUWSdD2pOST7fvq0vhzS/orBR0hm2TwQcV3fmA1MOwS
 IxMYpHuzF51CKIeRmbkA+a7plTJVOLPw9seskK9gjbCNxxxIvRw+CTM4CELYjIlpeKXw oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 330ww9rqfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 22:04:56 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07K226BR181652;
 Wed, 19 Aug 2020 22:04:56 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 330ww9rqes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 22:04:56 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07K1xZDA006323;
 Thu, 20 Aug 2020 02:04:55 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02dal.us.ibm.com with ESMTP id 3304ccvuq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2020 02:04:55 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07K24sr744237092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2020 02:04:54 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 478A4AC05E;
 Thu, 20 Aug 2020 02:04:54 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56523AC05F;
 Thu, 20 Aug 2020 02:04:47 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.41.171])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 20 Aug 2020 02:04:46 +0000 (GMT)
References: <20200819164306.625357-1-bauerman@linux.ibm.com>
 <20200820014238.GI271315@yekko.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 0/8] Generalize start-powered-off property from ARM
In-reply-to: <20200820014238.GI271315@yekko.fritz.box>
Date: Wed, 19 Aug 2020 23:04:43 -0300
Message-ID: <87h7sydqdg.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_13:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008200010
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 22:05:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> On Wed, Aug 19, 2020 at 01:42:58PM -0300, Thiago Jung Bauermann wrote:
>> This version has one small fix in patch 7, and adds Philippe's Reviewed-bys.
>> 
>> Applies cleanly on dgibson/ppc-for-5.2.
>> 
>> Original cover letter below, followed by changelog:
>> 
>> 
>> The ARM code has a start-powered-off property in ARMCPU, which is a
>> subclass of CPUState. This property causes arm_cpu_reset() to set
>> CPUState::halted to 1, signalling that the CPU should start in a halted
>> state. Other architectures also have code which aim to achieve the same
>> effect, but without using a property.
>> 
>> The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
>> before cs->halted is set to 1, causing the vcpu to run while it's still in
>> an unitialized state (more details in patch 3).
>> 
>> Peter Maydell mentioned the ARM start-powered-off property and
>> Eduardo Habkost suggested making it generic, so this patch series does
>> that, for all cases which I was able to find via grep in the code.
>> 
>> The only problem is that I was only able to test these changes on a ppc64le
>> pseries KVM guest, so except for patches 2 and 3, all others are only
>> build-tested. Also, my grasp of QOM lifecycle is basically non-existant so
>> please be aware of that when reviewing this series.
>> 
>> The last patch may be wrong, as pointed out by Eduardo, so I marked it as
>> RFC. It may make sense to drop it.
>
> Applied to ppc-for-5.2.

Great news. Thanks!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

