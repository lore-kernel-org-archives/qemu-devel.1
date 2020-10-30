Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D46C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA73620A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NPbWNX/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA73620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYbV-0002tj-Tf
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kYYav-0002UV-PF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40326
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kYYat-0003GE-SK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:53:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09UHVbxp115952; Fri, 30 Oct 2020 13:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=to : cc : from : subject
 : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=sr8HJhuTAqw0EklBnfuB/fEmN3rJ6luDee/lrvTzT4g=;
 b=NPbWNX/JS1DpNuiggzthl9OYrp/MV6EWJlDbMmFCGRHsUDIoTZs/4FMoznpOoq/490uy
 iqo0Sk0kY5B+TBjZ26KpLlvuWKeY7aIf48ORTHOYa6Ur1CB5+2N3fsyfV1HTim9d3JzX
 p6ghQ6x2JRRK6GOB1wrI/zGfFEq0Kkm4bhuH0erz8h4Jz3kQqv6YZmiPvtk3yveR1Nvz
 CVbiy6OejpqOumMHGRKt6FPMqTavSrUT2un3hCil1NXgso1TMp3/0qZoSAQ4tWApp0CG
 776yPs0xWIxu0/iuGuyscIbu6CYs6byOqcYgQXnrGIZO2IOwPtER5qpQ6Bv/sno7yofQ MQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34gq9arngk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 13:53:39 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09UHpLWg021657;
 Fri, 30 Oct 2020 17:53:38 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 34dy04uud4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2020 17:53:38 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09UHrauB37224774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 17:53:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22AE678976;
 Fri, 30 Oct 2020 17:53:36 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9615378973;
 Fri, 30 Oct 2020 17:53:35 +0000 (GMT)
Received: from Tobins-MacBook-Pro-2.local (unknown [9.80.231.229])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2020 17:53:35 +0000 (GMT)
To: qemu-devel@nongnu.org
From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
Subject: RFC: Fast Migration for SEV and SEV-ES - blueprint and proof of
 concept
Message-ID: <8b824c44-6a51-c3a7-6596-921dc47fea39@linux.ibm.com>
Date: Fri, 30 Oct 2020 13:53:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-30_07:2020-10-30,
 2020-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=864 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=tobin@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 13:38:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: ashish.kalra@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 jon.grimm@amd.com, tobin@ibm.com, dovmurik@linux.vnet.ibm.com,
 Dov.Murik1@il.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Dov Murik, James Bottomley, Hubertus Franke, and I have been working on 
a plan for fast live migration with SEV and SEV-ES. We just posted an 
RFC about it to the edk2 list. It includes a proof-of-concept for what 
we feel to be the most difficult part of fast live migration with SEV-ES.

https://edk2.groups.io/g/devel/topic/77875297

This was posted to the edk2 list because OVMF is one of the main 
components of our approach to live migration. With SEV/SEV-ES the 
hypervisor generally does not have access to guest memory/CPU state. We 
propose a Migration Handler in OVMF that runs inside the guest and 
assists the hypervisor with migration. One major challenge to this 
approach is that for SEV-ES this Migration Handler must be able to set 
the CPU state of the target to the CPU state of the source while the 
target is running. Our demo shows that this is feasible.

While OVMF is a major component of our approach, QEMU obviously has a 
huge part to play as well. We want to start thinking about the best way 
to support fast live migration for SEV and for encrypted VMs in general. 
A handful of issues are starting to come into focus. For instance, the 
target VM needs to be started before we begin receiving pages from the 
source VM. We will also need to start an extra vCPU for the Migration 
Handler to run on. We are currently working on a demo of end-to-end live 
migration for SEV (non-ES) VMs that should help crystallize these 
issues. It should be on the list around the end of the year. For now, 
check out our other post, which has a lot more information and let me 
know if you have any thoughts.

-Tobin

