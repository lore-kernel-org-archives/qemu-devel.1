Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A87206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tVOgaNJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A87206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRG6-0008T2-LC
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4Q-0001oW-L9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4P-0008SB-BH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4P-0008Qp-1x
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGnBVb178095;
 Thu, 12 Mar 2020 16:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=qKmhxTfgYi9KAWiRjgeZeHB33lq+tlyTupRMiYDKyZc=;
 b=tVOgaNJFAK0iEUw7wDNw/IAth8DaxzeIUhG/ETc9I/NrLwl10L9/oMl6QsJR4hROe0vh
 xn1hfp9HmrF5NlwbYQW1wri2hk1mv+rYtJxjTUMAMxiJ7h4UDlFfH4h2V9Zsv0oLB2wQ
 dQ4z0/2QeAyrbaMo7nNMtJ5xGNAUnXxYjQqbCD0XqvpUG2LmebGH5hstulpEKx7426r6
 D3n6Z7YFIeujBh53OGBfi3CCB/vS94eh8wzAltrHjuaWeYJ93xzDSh/MC66okln0VQF7
 UhVJ5c6t/7KnoTtFlaA45UCCR0as8+df0L7chzIOzPQ30ZGIg3VLOT2jUZsOMvkuvOu0 VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yp9v6dw32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoUwL123422;
 Thu, 12 Mar 2020 16:52:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yp8r0sn8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:24 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGqMjk000649;
 Thu, 12 Mar 2020 16:52:22 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:22 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/16]:  hw/i386/vmport: Bug fixes and improvements
Date: Thu, 12 Mar 2020 18:54:15 +0200
Message-Id: <20200312165431.82118-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
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

v2->v3:
- Repalce VMPort compatability version property with multiple boolean
  compatability properties. [MST]
- Prefix "vmx-*" properties with "vmware-vmx-*" to avoid confusion with
  Intel VT-x short name. Prefix suggested by MST. [MST]
- Remove VMX_Type enum and instead hard-code default vmware-vmx-type
  value and only reference open-vm-tools for rest of values. [MST]
- Add reference (link) to VMware open-vm-tools code. [MST]


