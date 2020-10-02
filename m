Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2A9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFB5206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n3x1BSYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFB5206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kODv6-0004VQ-Cl
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 01:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1kOB18-0008OT-5e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 22:41:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1kOB14-0002xy-Ui
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 22:41:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0922Ttep020891;
 Fri, 2 Oct 2020 02:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=vEyMavtXhFuUH/zlU5eGIIPXPHCntSJ4H7wR33Q5U9A=;
 b=n3x1BSYzw90lU9qNIDNbxKNnDhfq2Bg4nmyc+asYBRK+8/t/u89ZfccxikJENM9x+Mrr
 0pL1qBZ0l/XC+LA0OvCtiwqVxi7l1N8qTWsTwnrlS+XiSazGDzLA3T2299ef/OF5+bi3
 acAk2bFX8fSp25TZPvp+8n5tqtsTs3IID+R1n7Kt6C+r9eAK44dShLdJXXZRxKSOgFr0
 ETM1CA3/9mGsQvfYtApMWU9xVYbTp7uBsKSLc0XD8A6qZ2vD76mobyK0znkfPKfzn7Yd
 6IrLJLhjPQwLYLvio8xmOZ6SOuDpg8ymD1rHqBWgDdpLFONmX3ZwtE52naeeVVufWHRi oQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 33su5b982t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 02 Oct 2020 02:41:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0922TqRC056445;
 Fri, 2 Oct 2020 02:41:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 33tfk2r689-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Oct 2020 02:41:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0922feEJ027385;
 Fri, 2 Oct 2020 02:41:40 GMT
Received: from ban25x6uut148.us.oracle.com (/10.153.73.148)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 19:41:39 -0700
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] Do not stop guest when panic event is received
Date: Thu,  1 Oct 2020 22:41:33 -0400
Message-Id: <1601606494-1154-1-git-send-email-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020016
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 22:41:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 02 Oct 2020 01:46:45 -0400
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following patch adds an option to request that QEMU does not stop the VM when a panic event is received.
This allows guests in cloud environments to report the panic condition to the control plane, but be able to
proceed to collect a crash dump and automatically reboot, without waiting to receive one or several 'cont'
monitor commands.

I am aware of a previous discussion regarding the decision to stop the guest on panic event:
https://lore.kernel.org/qemu-devel/52148F88.5000509@redhat.com/
that is why I propose explicitly using a parameter to change the default behavior when necessary.

The PVPANIC_CRASHLOADED event was introduced in the v5.6 kernel, and it is intended to tell QEMU that the guest
will handle the panic condition by itself, but unfortunately older kernels will only support sending the
PVPANIC_PANICKED event, for which the default behavior is to pause the VM.

Having a '-no-panicstop' option allows for older guest kernels that do not support the PVPANIC_CRASHLOADED event
to behave in the same way as newer kernels, simplifying control plane code. It also provides the same advantage
when launching Windows guests with the hv-crash enlightenment, since the hv-crash MSR writes are ultimately
handled by QEMU as if the guest had sent a PVPANIC_PANICKED event.

The fact that the behavior of hv-crash is also affected is why I chose to implement this change as an independent
option, as opposed to making it a property of the pvpanic device (e.g. -device pvpanic,no-panicstop).

Please let me know if you have any comments or suggestions.

Regards,
Alejandro

Alejandro Jimenez (1):
  vl: Add -no-panicstop option

 qemu-options.hx | 11 +++++++++++
 softmmu/vl.c    | 17 ++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

-- 
1.8.3.1


