Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E44DC73C6D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F0020693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F0020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl6jk-0001aj-MV
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 03:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wentong.wu@intel.com>) id 1hl6iF-00014U-F0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wentong.wu@intel.com>) id 1hl6iD-0003IV-R4
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:08:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:57902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wentong.wu@intel.com>)
 id 1hl6iB-0003Ak-K6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:08:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 00:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
 d="scan'208,217";a="192950188"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2019 00:08:15 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 00:08:15 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 00:08:15 -0700
Received: from shsmsx106.ccr.corp.intel.com ([169.254.10.240]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.240]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 15:08:13 +0800
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: in icount mode guest OS can't boot on qemu_x86 when shift
 value range in [0, 3] 
Thread-Index: AdU27Jpm512BV98IRK+ajWB/8kN2SwAAWfpA
Date: Wed, 10 Jul 2019 07:08:12 +0000
Message-ID: <228A20DABA3D9846AF1B64E31C217296010BF183@SHSMSX106.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzljZTRiZGEtY2Q0Ny00ZWE5LWFkNWItNzBlYWIwNzBiODg1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidkhrWHl3S3pGb2hSK05oZWdtOTBYWGtsb0JuWjhleWdEbTlKWjNQbEwzb3ZwbnlSc2pqejBjanhyd3BpM1MzdCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] in icount mode guest OS can't boot on qemu_x86
 when shift value range in [0, 3]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add more info:

the qemu binary is qemu-system-i386 and it's TCG mode, not kvm.

From: Wu, Wentong
Sent: Wednesday, July 10, 2019 3:01 PM
To: 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>
Subject: in icount mode guest OS can't boot on qemu_x86 when shift value ra=
nge in [0, 3]


Hi all,

I'm running a rtos on qemu_x86 with icount mode enabled, shift value locate=
d in [0, 3], there is very high possibility that the guest os(the rtos) can=
't boot up. Does anyone have any idea for this issue? And this issue blocke=
d me long time, appreciate any input?


Thanks
