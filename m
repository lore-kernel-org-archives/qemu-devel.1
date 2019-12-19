Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F6C2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 21:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A9D2467B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 21:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="Fla6YOBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A9D2467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii3BI-0002xr-GZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 16:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1ii3Ad-0002Wz-Qp
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 16:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1ii3Ab-0006NE-Py
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 16:17:19 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:54242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1ii3Ab-0006CZ-Dc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 16:17:17 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
 by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xBJLC02m041330; Thu, 19 Dec 2019 13:17:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=mAWQstY3X0SNrdG4rXcS55VRJyW29cZlqvBvuWxZfO8=;
 b=Fla6YOBxQ1WeHlWdx3/90t0Gh25S6ptNh8JUxzHHRR25eX4/cH41jJQsoWjhcQZMMlQ3
 5jMIwA+rhyvpsKhbK2037A2+JAYRNbmTdtLv0nLqmN6TOs2I/kRr62mi4DK3NmEUpJUg
 BbB7c8rKjtU8IA9yBawqpFgC5+ofd4M1mjbeRrNo499kNk5d6DpcHxf9t4SngD+U+ETQ
 Bz/t0OMbCYQAccwXlAKlUNjxpn0PO6gkM51jZdzDB7GrNOjRP63olnA3AQH6IoZwULFs
 q5v9b62flWHV4IWiKN60fPey+dPC45zCE/rupmhv3Efp4PZuigLTLisWI/o91VJyfHDV zg== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp02.apple.com with ESMTP id 2wyypg9ddb-16
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 19 Dec 2019 13:17:15 -0800
Received: from nwk-mmpp-sz10.apple.com
 (nwk-mmpp-sz10.apple.com [17.128.115.122]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q2S007SY34O9950@ma1-mtap-s03.corp.apple.com>; Thu,
 19 Dec 2019 13:17:13 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q2S0040034C0Z00@nwk-mmpp-sz10.apple.com>; Thu,
 19 Dec 2019 13:17:12 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 
X-Va-E-CD: 
X-Va-R-CD: 
X-Va-CD: 0
X-Va-ID: 1abfd963-75cc-48f6-9601-f04d22fca16e
X-V-A: 
X-V-T-CD: d84713a760465a4a8b2ed3e217d59fe6
X-V-E-CD: 4e11d0ed2d9193018f7a51d432186aae
X-V-R-CD: def13d22600e3853ef2873f9300d3b22
X-V-CD: 0
X-V-ID: d454c616-587f-42b9-8916-579d7136ad30
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-19_06:,, signatures=0
Received: from [17.193.42.234] by nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q2S00BTV34O8C70@nwk-mmpp-sz10.apple.com>; Thu,
 19 Dec 2019 13:17:12 -0800 (PST)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 0/1] Fix bochs memory leak
In-reply-to: <cover.1576139278.git.dirty@apple.com>
Date: Thu, 19 Dec 2019 13:17:10 -0800
Cc: qemu-devel@nongnu.org, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Content-transfer-encoding: quoted-printable
Message-id: <C548409B-8871-4D77-80B8-D487DE0F6E48@apple.com>
References: <cover.1576139278.git.dirty@apple.com>
To: Cameron Esfahani <dirty@apple.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-19_06:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.67
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

Ping.

Cameron Esfahani
dirty@apple.com

"Americans are very skilled at creating a custom meaning from something =
that's mass-produced."

Ann Powers


> On Dec 12, 2019, at 12:30 AM, Cameron Esfahani via =
<qemu-devel@nongnu.org> wrote:
>=20
> Fix a small memory leak in the Bochs display driver.
>=20
> Each frame would leak about 304 bytes.
>=20
> v2: Add missing signed-off-by line.
> v3: Add reviewed-by and fixes lines.
>=20
> Cameron Esfahani (1):
>  display/bochs-display: fix memory leak
>=20
> hw/display/bochs-display.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> --=20
> 2.24.0
>=20
>=20


