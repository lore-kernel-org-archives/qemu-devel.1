Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BCC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FDD20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="WvQoQIlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FDD20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlBd-0001B8-2q
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jLlAt-0000ij-Vo
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jLlAs-00039x-V2
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:09:43 -0400
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:58390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jLlAs-00039c-PG
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:09:42 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 037A6obf049702; Tue, 7 Apr 2020 03:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=C/Tx4rpY5TqnGN0KGIcGwW3BP1HdAZKJC9VWdA/5iUM=;
 b=WvQoQIlxh09kn4WdYL2M9aa1xKVdaTnho2Pc8jFPlG/90NBcFYIcrmWCOadtUEdYlVu3
 g97DLS5FgyU+W3HzRn2sbhuhHgIqIKtxJx9i/+o46qMkQsUZcJMSMFqw7BydKmeo8aNQ
 FD9px7MzDZp6RBR0HNmTG4FqRhAXGduCBIi4kAco0x8gDDDSzPhH60TfzwxuKAinhxwy
 IC6RDSpUICPY550MWstq5BIasqVvEGnlIZ8hfE10slxVOgdrHNc1JnfxKmo8MyzPRnZB
 4iFWKsnDCkD27DqFTSOINAT28FsQ69LRZiRvsnjSziM+sm2SgHOTX6ffqDBFyRjZnL6M Mg== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 306pwtqqeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 07 Apr 2020 03:09:33 -0700
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8E00NBCXJWO590@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Tue, 07 Apr 2020 03:09:32 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8E00M00X4KSE00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 07 Apr 2020 03:09:32 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 19bf591f1631dacef6cd419e595ed10e
X-Va-E-CD: 525671786f253ed03682d9bd52b2ca38
X-Va-R-CD: 232d18ad9ecc4440b29bb0e6a41132a7
X-Va-CD: 0
X-Va-ID: f90db92c-8ac8-41ce-ba2f-7bbeef330aef
X-V-A: 
X-V-T-CD: 19bf591f1631dacef6cd419e595ed10e
X-V-E-CD: 525671786f253ed03682d9bd52b2ca38
X-V-R-CD: 232d18ad9ecc4440b29bb0e6a41132a7
X-V-CD: 0
X-V-ID: c2619292-488c-48f7-9f72-129d0b835bdb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_02:2020-04-07,
 2020-04-07 signatures=0
Received: from [17.234.106.165] (unknown [17.234.106.165])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8E00EMTXJWCA90@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 07 Apr 2020 03:09:32 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
In-reply-to: <6aac0d31-d0a4-d103-e3b5-89feef27c018@redhat.com>
Date: Tue, 07 Apr 2020 03:09:31 -0700
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com,
 joel@jms.id.au, clg@kaod.org
Content-transfer-encoding: quoted-printable
Message-id: <BFA58F3C-CA4F-4ADF-854F-2658134D3888@apple.com>
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
 <6aac0d31-d0a4-d103-e3b5-89feef27c018@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_02:2020-04-07,
 2020-04-07 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.68
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

I'm not burying anything.  This patch is stand alone and all the tests =
do work.  They work with or without Cedric's nee Andrew's patch.  But, =
if some derivative of that patch is eventually implemented, something =
needs to be done for this NRF51 gpio qtest to work.

There are two possibilities for the following qtest in microbit-test.c:

>     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + =
NRF51_GPIO_REG_CNF_END) & 0x01;
>     g_assert_cmpuint(actual, =3D=3D, 0x01);


1 - The code is purposefully reading 32-bits from an unaligned address =
which only partially refers to a documented register.  And the only =
reason this code works is because that 32-bit value is turned into a =
8-bit read.  And if that's the case, then someone should update a =
comment in the test to indicate that this is being done purposefully.
2 - NRF51_GPIO_REG_CNF_END is incorrectly set to be 0x77F.  Looking at =
the documentation for this chip, the last defined CNF register starts at =
0x77C.

The NRF51 doesn't support unaligned accesses, so I assume that =
possibility 1 isn't true.

So, is NRF51_GPIO_REG_CNF_END supposed to refer to a valid register, or =
the end of the implementation space?

If it's the former, then it should be adjusted to 0x77c and possibly =
update the below code in nrf51_gpio.c (line 156):

>     case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:


to become

>     case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END + 3:

if unaligned access are expected to work.  But, considering the NRF51 =
doesn't support unaligned accesses, I don't think this appropriate.

If it's the latter, then the test cases in microbit-test.c should be =
updated to something like the following:

>     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + =
NRF51_GPIO_REG_CNF_END - 3) & 0x01;
>     g_assert_cmpuint(actual, =3D=3D, 0x01);


Cameron Esfahani
dirty@apple.com

"Americans are very skilled at creating a custom meaning from something =
that's mass-produced."

Ann Powers


> On Apr 7, 2020, at 1:44 AM, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
>> Considering NRF51 doesn't support unaligned accesses, the simplest =
fix
>> is to actually set NRF51_GPIO_REG_CNF_END to the start of the last =
valid
>> CNF register: 0x77c.
>=20
> NAck. You are burying bugs deeper. This test has to work.
>=20
> What would be helpful is qtests with unaligned accesses (expected to =
work) such your USB XHCI VERSION example.


