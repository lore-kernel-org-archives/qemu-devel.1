Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513CDC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F25C20748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F25C20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isYwf-00060j-8G
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 16:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dave.anglin@bell.net>) id 1isVUn-0002iY-LA
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dave.anglin@bell.net>) id 1isVUj-0004Go-GU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:33:21 -0500
Received: from simcoe208srvr.owm.bell.net ([184.150.200.208]:38558
 helo=torfep02.bell.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dave.anglin@bell.net>)
 id 1isVUj-0004Eh-B3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:33:17 -0500
Received: from bell.net torfep02 184.150.200.158 by torfep02.bell.net
 with ESMTP
 id <20200117173313.RTBZ16761.torfep02.bell.net@torspm02.bell.net>
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 12:33:13 -0500
Received: from [192.168.0.101] (really [65.95.37.184]) by torspm02.bell.net
 with ESMTP
 id <20200117173313.RWU16325.torspm02.bell.net@[192.168.0.101]>;
 Fri, 17 Jan 2020 12:33:13 -0500
To: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <7b14c840-0d3f-0c67-06be-81b058c727fb@gmx.de>
 <08c4bdcb-b07d-eb30-a38d-f27ed6400952@redhat.com>
 <2c0285e8-5919-e768-c191-f22b9c296208@gmx.de>
From: John David Anglin <dave.anglin@bell.net>
Openpgp: preference=signencrypt
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
Message-ID: <ca1f9390-aa77-6346-943d-1984899b43d7@bell.net>
Date: Fri, 17 Jan 2020 12:33:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2c0285e8-5919-e768-c191-f22b9c296208@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-CM-Analysis: v=2.3 cv=KfusTjQD c=1 sm=1 tr=0 a=DwDZ6JUTUl7ZyOFm/YZ6ZA==:117
 a=DwDZ6JUTUl7ZyOFm/YZ6ZA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10 a=FBHGMhGWAAAA:8 a=pLNHzyMZLHhJew_mZeAA:9
 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4wfOKK83ZiH686Y8whch9Xd+4p8xbpLqhezHBBepjx573VaiS1oj9YF316Ra9ylUPpbjfGtpgTKGi40bTzCjs9h0sO8lRyn6ZFpl7L30dJJ7wnZgVnQMkn
 DFpLl3LjmnStpcf5yRzN5LXoZ3M2MR54cC4e4AxQHrFgODn+rD/s7nppOD8W8uk8BkD+glhXOacnXg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 184.150.200.208
X-Mailman-Approved-At: Fri, 17 Jan 2020 16:13:05 -0500
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

This is not related to the patch but there is one other corner issue with=
 the load and clear instructions.

When the target register is GR0, the instruction may be implemented as a =
normal load and clear
which clears memory, or it may be aliased to the equivalent-sized load in=
struction, in which case
it behaves exactly like that prefetch instruction and does not clear the =
data in memory.

See page 6-12 on PA 2.0 architecture.

Don't know what was actually done.

Regards,
Dave

--=20
John David Anglin  dave.anglin@bell.net



