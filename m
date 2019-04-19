Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2DC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD0020859
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD0020859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fennosys.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHdJi-0006lo-EY
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:53:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <reader@fennosys.fi>) id 1hHdIW-000642-Cp
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <reader@fennosys.fi>) id 1hHd8Q-0005Qm-EJ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:41:35 -0400
Received: from smtp.fennosys.fi ([62.241.241.27]:45058 helo=mail.fennosys.fi)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <reader@fennosys.fi>) id 1hHd8O-0005P3-K5
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:41:34 -0400
Received: (qmail 16256 invoked by uid 210); 19 Apr 2019 23:41:27 -0000
Received: from 49.158.119.22 (antti@fennosys.fi@49.158.119.22) by
	mail01-fennosys (envelope-from <reader@fennosys.fi>,
	uid 201) with qmail-scanner-2.08st 
	(clamdscan: 0.98.7/25423. spamassassin: 3.4.0. perlscan: 2.08st.  
	Clear:RC:1(49.158.119.22):. 
	Processed in 0.142091 secs); 19 Apr 2019 23:41:27 -0000
Received: from unknown (HELO gail) (antti@fennosys.fi@49.158.119.22)
	by 10.200.232.5 with ESMTPA; 19 Apr 2019 23:41:26 -0000
Date: Sat, 20 Apr 2019 07:41:17 +0800
From: Antti Antinoja <reader@fennosys.fi>
To: qemu-devel@nongnu.org
Message-Id: <20190420074117.e4f4e200b576b0e9b034b0f4@fennosys.fi>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 62.241.241.27
Subject: [Qemu-devel] Using --enable-kvm fails with WindowsXP guest on an
 AMD host (works on Intel host)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419234117.cCxBUlA5eWiCEY1t_FBiyBLLFcR0hjtK91EIV8qTw1g@z>

Hi,

After upgrading host (Gentoo Linux) a Windows XP guest can't boot anymore.

Some findings while testing:

* XP image boots & works OK on an Intel machine (Gentoo Linux)
** qemu: 3.1.0-r4
** kernel: 5.0.7
** CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz

* XP image FAILS to boot on an AMD machine (Gentoo Linux)
** qemu: 3.1.0-r4
** kernel: 4.19.34
** CPU: AMD FX-6300 Six-Core Processor
** image boots OK if NOT using --enable-kvm

* XP image FAILS to boot on an AMD machine (Gentoo Linux)
** qemu: 3.1.0-r4 & 3.1.0-r1
** kernel: 4.19.34 & 5.0.7
** CPU: AMD Opteron(tm) Processor 4170 HE
** image boots OK if NOT using --enable-kvm
** The image worked OK on this machine with Qemu 2.12.1 & Kernel 4.18.20

Booting to Safe Mode fails too (on mentioned AMD machines with --enbale-kvm). 

Trying various -cpu options on the AMD machines didn't seem to help either (qemu64, pentium3, etc).

There are no errors visible on the host (kernel logs etc clean). The guest boot just interrupts on very early state and Windows safe mode menu will loop forever.

All Linux VM's are working without issues.

Cheers,
Antti

-- 
Antti Antinoja <reader@fennosys.fi>

