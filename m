Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91251C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D32B21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rTa35x6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D32B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izM8s-0001jl-Im
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6Y-0005h8-Uq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1izM6X-00054C-Dd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1izM6X-0004k9-38
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:56:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015ErN1u173031;
 Wed, 5 Feb 2020 14:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=wpmtAsdXvfQA0pZUh+Ov4fJAyWnhGEqLYZK9M81Y83U=;
 b=rTa35x6C5GJ4JL6d7ajnEsSZalO7Xh31+wZsfNE3EexyeWY1N0DIm4q/6J9rZzm/bAdZ
 pkoNZav4oaDy/G+61IwB6tUIUM1C0CBpmPejsmTea7UYFjyMAFaNqTNyWCCu72d0iO/p
 LB3EhI9pOxfNgCCdaLJ0x6vElm3qkX7wQTpYngvo88NzZKrWoe6aW6k8QcVv8K5YvHDo
 ok9XLpjBQytxfSJJ8liUIfMInSXCdEGu4nkNRZsahpGPH8dBNpGxQQvAXEOxSh3gXatP
 7LNe9Jy0E5qw/AP5v29CbuBTEAVTjR1lFmnwj9P74Mn8lnL24iVZ64Jl6oYY5T0WaEDg Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2xykbpbgtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015ErLU0094221;
 Wed, 5 Feb 2020 14:56:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2xykc6sfrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 14:56:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015EuE6v028911;
 Wed, 5 Feb 2020 14:56:14 GMT
Received: from ol7.uk.oracle.com (/10.175.206.136)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 06:56:13 -0800
From: Liam Merwick <liam.merwick@oracle.com>
To: alex.bennee@linaro.org, fam@euphon.net, philmd@redhat.com
Subject: [PATCH v2 0/6] tests/boot_linux_console: add extra boot acceptance
 tests
Date: Wed,  5 Feb 2020 14:55:59 +0000
Message-Id: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: slp@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 pbonzini@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add acceptance tests for the microvm machine class, PVH, and the
new qboot BIOS.

In the case of the test to boot an uncompressed kernel there didn't
seem to be any suitable uncompressed kernel on https://archives.fedoraproject.org/
(there is a vmlinux in kernel-debuginfo but that RPM is 575M and
caused timeouts when populating the Avocado cache when first run)
so I chose an RPM with kernels for Kata that is 14M.
(there was a discussion in [1] regarding testing PVH boot but it focussed
more around building a vmlinux binary during testing).

[ What prompted these patches was the discovery that a 'pc' guest booting an
uncompressed kernel (PVH) with a PCI netdev hangs (before we even get guest
console output) when bios-microvm.bin (qboot) is supplied via -bios
(no issue when using 'q35' or 'microvm' machine classes).

E.g. adding the following line to test_x86_64_pc_qboot_pvh() is enough to
trigger a guest hang during startup:
self.vm.add_args('-netdev', 'user,id=n1', '-device', 'virtio-net-pci,netdev=n1')

I bisected that issue to 176d2cda0dee [2] in 4.1 but haven't worked out yet
how/why the "die-id" changes impact the qboot/PVH combination
(the boot succeeds with any subset of those boot variables).

Is booting the 'pc' machine class with bios-microvm.bin something that QEMU
officially supports or is qboot intended for microvm only? ]

Each test added here adds about 1.5s to the overall runtime.
I have run them through the Travis QEMU CI [3] and those acceptance tests pass.

v1 -> v2
Removed unnecessary qboot test for microvm in Patches 2 and 5 [Stefano]
Added SeaBIOS test for microvm to Patch2
Fix path concatenation in Patch4 to use os.path for filesystem paths [Wanier]
Added Patch6 to fix extract_from_deb() to use os.path for filesystem paths
Used dictionary to store kernel info in Patch5 [Philippe]
Dropped patch with typo fix that has been queued separately
Added Stefano's R-b to the patches which have not significantly changed.

[1] https://patchew.org/QEMU/20191206140012.15517-1-wainersm@redhat.com/
[2] 176d2cda0dee ("i386/cpu: Consolidate die-id validity in smp context")
[3] https://travis-ci.org/merwick/qemu/builds/645487393
[4] https://github.com/wainersm/qemu/commit/8f705e98df90b436b0f4946331d441309c437f7b


Liam Merwick (6):
  tests/boot_linux_console: add microvm acceptance test
  tests/boot_linux_console: add BIOS acceptance test
  travis.yml: install rpm2cpio for acceptance tests
  tests/boot_linux_console: add extract_from_rpm method
  tests/boot_linux_console: add PVH acceptance tests
  tests/boot_linux_console: use os.path for filesystem paths

 .travis.yml                            |   1 +
 tests/acceptance/boot_linux_console.py | 114 ++++++++++++++++++++++++++++++---
 2 files changed, 106 insertions(+), 9 deletions(-)

-- 
1.8.3.1


