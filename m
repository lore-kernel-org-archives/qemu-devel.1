Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A533C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE7D20684
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="enpnbgVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE7D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZh6F-0005Zp-Vz
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 15:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iZh4v-0004yg-A8
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iZh4u-0002G2-B3
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:04:53 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:55850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iZh4t-0002Ej-Va
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:04:52 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xAQK1lRU026600; Tue, 26 Nov 2019 12:04:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=fHFjGvpNn5tGAD/h7UqR9A+7RnRCEIXJzBrikPoDVo0=;
 b=enpnbgVI9oq3rm/NWyZOkAPFhueYqM758zdjYNvIsNhb5HIOXx4WY3SDyB6dendpavFu
 sCJS2XJK3CpVVmQkBw7Sqy6z7phGYfXZyaTa21MoFzHzIgXuHx18VSoNa/c1NY0LBDBO
 zoyJfHDiLrrq2KBtezv9AiXdlW9+vWqqs/Wgv4Etko1yjC4MOg2dxGbw43YNW38yRF34
 eYzWziQ2eFcHYqJSrEvsLXnFejfH7rRSSBDEpCeGdqj/YoXqpADBSh7nJcyIPq7dmJiJ
 QQL2jIlqL9lTqw+otnrRRS/mMMck/8JnCc+U+LrevNfXmbb+qfm/P/RKNiO3KuNUfvDE gw== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com
 [17.40.76.5])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 2wfnvpb3eu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 26 Nov 2019 12:04:49 -0800
Received: from nwk-mmpp-sz12.apple.com
 (nwk-mmpp-sz12.apple.com [17.128.115.204]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1L005OGEG02Y10@ma1-mtap-s01.corp.apple.com>; Tue,
 26 Nov 2019 12:04:49 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz12.apple.com by
 nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1L00J00E82QD00@nwk-mmpp-sz12.apple.com>; Tue,
 26 Nov 2019 12:04:48 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 07468e1da2f6e987d649ff6cb4055ea6
X-Va-E-CD: 41404d9c28fbc215bab670c20d826187
X-Va-R-CD: eb29b0577443ea815658bc1e1be1b1f2
X-Va-CD: 0
X-Va-ID: f0ee5913-400c-44d1-afd3-bd93606da9ec
X-V-A: 
X-V-T-CD: 07468e1da2f6e987d649ff6cb4055ea6
X-V-E-CD: 41404d9c28fbc215bab670c20d826187
X-V-R-CD: eb29b0577443ea815658bc1e1be1b1f2
X-V-CD: 0
X-V-ID: d2e12f96-5b3b-496a-8bec-dd487d67b1e6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-26_06:,, signatures=0
Received: from [17.234.111.141] (unknown [17.234.111.141])
 by nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1L00EH8EG0UI90@nwk-mmpp-sz12.apple.com>; Tue,
 26 Nov 2019 12:04:48 -0800 (PST)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 5/5] hvf: save away type as well as vector so we can
 reinject them
In-reply-to: <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
Date: Tue, 26 Nov 2019 12:04:47 -0800
Cc: qemu-devel@nongnu.org
Content-transfer-encoding: quoted-printable
Message-id: <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
 <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
 <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-26_06:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.68
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Our test case was booting many concurrent macOS VMs under heavy system =
load.  I don't know if I could create one to replicate that.

Cameron Esfahani
dirty@apple.com

"In the elder days of Art, Builders wrought with greatest care each =
minute and unseen part; For the gods see everywhere."

"The Builders", H. W. Longfellow



> On Nov 25, 2019, at 2:26 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 24/11/19 21:05, Cameron Esfahani wrote:
>> Save away type as well as vector in hvf_store_events() so we can
>> correctly reinject both in hvf_inject_interrupts().
>>=20
>> Make sure to clear ins_len and has_error_code when ins_len isn't
>> valid and error_code isn't set.
>=20
> Do you have a testcase for this?  (I could guess it's about the INT1
> instruction).
>=20
> Paolo
>=20


