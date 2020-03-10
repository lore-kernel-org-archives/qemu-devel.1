Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B3C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55ABD20873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tRJFpqXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55ABD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBi7R-0007h1-I7
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6O-0006Ih-Kl
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6M-00050B-KQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6M-0004uI-3s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcLie010599;
 Tue, 10 Mar 2020 16:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=YbVeSlgughlbReU7FCK0S5UiDbyQ+kkAKjbxgBMSydc=;
 b=tRJFpqXrki0j/yUSYP/UMe5NyBNNc0oJV8GPTRDtufSZtE7g2yjhGWcwpWgrEo2KFRiX
 1cgHQ42QWLx10hn64YVCT1r5l6IAnjakShnNLss1v4qac62cCk4yWMkMzEaSiAwZSg8a
 JsTxbEJp0V5e0UKMPDg+FxDzeBICDYWwtozc86jwAS8fch1pZn0Bx16Tzc6VDdVb75VS
 m1fgYMORq5nq8n94Ty23PK6lO/gRPIX0WVstAq4sRIiIfkjGNe8heRDYxrLvhgWbtK+A
 ECmjZIHGltj0yYFfTHo0kVkI1TVW7vYncyxddNkeLwC5RKHxpsHajOHASlbtOzCrEzwH aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcA2s053871;
 Tue, 10 Mar 2020 16:51:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yp8psg3r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGpPvl031514;
 Tue, 10 Mar 2020 16:51:26 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:25 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/16]:  hw/i386/vmport: Bug fixes and improvements
Date: Tue, 10 Mar 2020 18:53:16 +0200
Message-Id: <20200310165332.140774-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=951 bulkscore=0 suspectscore=1 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: nikita.leshchenko@oracle.com, mst@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series aims to fix several bugs in VMPort and improve it by supporting
more VMPort commands and make command results more configurable to
user via QEMU command-line.

This functionality was proven to be useful to run various VMware VMs
when attempting to run them as-is on top of QEMU/KVM.

For more details, see commit messages.

Regards,
-Liran

v1->v2:
* Fix coding convention [Patchew Bot & MST].
* Create new header file for vmport.h [MST].
* Move KVM_APIC_BUS_FREQUENCY from linux-headers/asm-x86/kvm.h
  auto-generated header [MST]
* Elaborate more that vmx-version refers to the VMware userspace
  VMM in commit message. [MST]
* Use le32_to_cpu() on BIOS_UUID vmport command. [MST]
* Introduce VMPort compatability version property to maintain migration
  compatibility. [MST]


