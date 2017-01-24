Received: from eggs.gnu.org ([2001:4830:134:3::10]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cVsuY-0000Pz-S2
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cVsuV-0001Ke-Nw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:40:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cVsuV-0001KL-ER
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:40:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0O4dTNo038014
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 23:40:45 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 285ee51v80-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 23:40:45 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 24 Jan 2017 14:40:42 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 540F43578053
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:40:39 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0O4eVfw15401094
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:40:39 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0O4e6WS011316
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:40:06 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	v0O4e6Dm010579
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:40:06 +1100
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4FEB2A0193
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:39:42 +1100 (AEDT)
Date: Tue, 24 Jan 2017 15:39:41 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20170124043941.GA12671@tungsten.ozlabs.ibm.com>
Subject: [Qemu-devel] update-linux-headers.sh fails on clean kernel dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi QEMU developers,

If I run scripts/update-linux-headers.sh from a clean checkout of QEMU
and point it at a clean checkout of a recent linux kernel (4.10-rc1 or
later), it fails:

$ scripts/update-linux-headers.sh ~/tmp/linux/

...

scripts/Makefile.headersinst:62: *** Missing generated UAPI file ./arch/arm/include/generated/uapi/asm/unistd-common.h.  Stop.

This seems to be because the script passes the arch to the kernel
makefile using "SRCARCH" rather than "ARCH".

(SRCARCH seems to be intended as an internal value, and setting it does
not propagate the setting to ARCH. Because ARCH is left empty, the
prerequisites that should generate unistd-common.h fail. If ARCH is set,
SRCARCH is set automatically and everything works.)

Changing the script to use "ARCH" seems to fixe the problem.

(Note: when testing this be careful: unistd-common.h is not removed by
"make clean" in the kernel directory.)

Does this seem correct?

Should I send a patch even though it's a very small change?

Cheers,
Sam.
