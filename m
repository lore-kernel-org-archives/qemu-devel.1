Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E64C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54992080A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zPsUkXHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54992080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9PU-0002uX-7s
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1kX8yZ-0008JM-7X
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:20:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1kX8yW-0007xT-VX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:20:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QKFdIZ032616;
 Mon, 26 Oct 2020 20:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=OPTgZ2fte0r8mrKDkxkehkpLfcPHZk5shGQk4Mafx+0=;
 b=zPsUkXHHzpqWNeNRH1zQF/sPHCc4N66S6gCEqyKGhx3fgRp/lj5P4+95ffue+uqxCZ3Z
 SXAwSmhpMgpMxDUBmD4P9q/f/yLIXX9Eupr+C3lNHKvxEZAN7jmhfxmCYb7gVDKlOMOD
 eLRNEvmF0CqlpF/73+dgIYtpFBFR9Zdf2KTbfO8PNKd8ygcjYsAqRk9Qa1mTcMtam6NV
 EEAXt47kZkOaVqiLJcf1W7Jm6L51JQjknV5YXngvH1cfkGjv0werLzzue7HhtBEBppE3
 /1rswFUp6mZaXsMq4hSaQbZ6OOjUFh4C+27E1JCZuezVK9UWOKbHth+C30cI1JGkY7QI DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 34c9saps3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Oct 2020 20:20:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QKGDOJ141318;
 Mon, 26 Oct 2020 20:20:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34cx1pwrfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2020 20:20:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09QKKAvl009717;
 Mon, 26 Oct 2020 20:20:10 GMT
Received: from vm345.localdomain (/10.149.224.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 26 Oct 2020 13:20:09 -0700
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] acpi: Implement ACPI ERST support for guests
Date: Mon, 26 Oct 2020 16:19:32 -0400
Message-Id: <1603743573-9870-1-git-send-email-eric.devolder@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=601 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 impostorscore=0
 mlxlogscore=613 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260133
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=eric.devolder@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 16:20:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2020 16:46:19 -0400
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
Cc: ehabkost@redhat.com, mst@redhat.com, konrad.wilk@oracle.com,
 pbonzini@redhat.com, imammedo@redhat.com, boris.ostrovsky@oracle.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changeset introduces support for the ACPI Error Record
Serialization Table, ERST.

The change to hw/acpi/meson.build simply adds in the new .c file
for compilation.

The change to hw/i386/acpi-build.c calls out the building of the
ERST table (and also creates the associated device).

The new file hw/acpi/erst.c contains the building of the ERST
table, as well as the simple device for exchanging error records.

The new file include/hw/acpi/erst.h contains associated definitions
and declarations for ERST.

The primary description of this changeset is in the patch commit
message.

NOTES: When reviewing, I would especially appreciate feedback
on the following topics:

- The hope is to have ERST always present if ACPI is enabled, however,
  I have found it difficult to devise a method for passing the base
  address that does not require the workaround at the bottom of
  build_erst(). The issues I encountered are:
  - desire to keep this is common ACPI code
  - the device requires a qdev_new(), this needs to happen early,
    thus the workaround in build_erst()
  - the base address is machine/arch specific (eg ARM vs x86)
  I've not found a nice way to thread this needle, so what I've settled
  on is to simply lump ERST on to the CONFIG_ACPI (rather than a
  separate CONFIG_ACPI_ERST), and the workaround at the bottom of
  build_erst(). I suspect there is a better way for a built-in/
  always present device. This does not support "-device acpi-erst,...".

- I found a base address that "worked", but would like an address
  that would be known to be availabe, and then to document/reserve
  it for ERST. This takes into account that the base address can be
  different for x86 vs ARM.

- I've run this through checkpatch, and all issues addressed except
  for the long lines in build_erst(). For readable I left the long
  lines, but will change if asked.

- What else do I need to provide?

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

---
 hw/acpi/erst.c         | 909 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/meson.build    |   1 +
 hw/i386/acpi-build.c   |   4 +
 include/hw/acpi/erst.h |  97 ++++++
 4 files changed, 1011 insertions(+)
 create mode 100644 hw/acpi/erst.c
 create mode 100644 include/hw/acpi/erst.h


