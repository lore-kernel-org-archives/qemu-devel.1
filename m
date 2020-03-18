Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392ECC5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 18:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E76C20780
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 18:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="MPAsEqle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E76C20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEdYl-0000pW-6n
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 14:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jEdXv-0000CT-S4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 14:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jEdXu-00036i-OX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 14:36:03 -0400
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:35046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jEdXu-000340-I7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 14:36:02 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02IIRZbI028937; Wed, 18 Mar 2020 11:35:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=cRbXlKOYI5FWEHsemKaFBQy+r4jwXggqjh+IFYmrtOE=;
 b=MPAsEqlekhC5bIl4T1k4dBwuNGBgPYO0Gwi/n+11u3FU1P0SGAg1oIIkbM0Rj0tPuccX
 lb882jxEG5eU5IdX0SciOztz8JuP6atwEvK6K7KiUeWVMNxTxpd6OOiIKwsnAA7iyT2H
 UjMBRTOGze05laDCvYT+acshKb4FRDuY58RvR9mR6OI50nXrI1mdHLl8cl5g+pfstfiu
 RLJGltwcx+WNFMG7l7qxQelImpRzqrznWgfab7NzbxLdxd+sJhRU9rChFUfasasE8ZBE
 U5s/wWcOtXDo1T0nyDuKUQDrilHX/tzg50VcRlpOUQ/jbgRUCwjLa8bZBUNdB4bqJDjT Ag== 
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 2yruxu23ng-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 18 Mar 2020 11:35:57 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q7E00VNMJNV7M00@rn-mailsvcp-mta-lapp03.rno.apple.com>; 
 Wed, 18 Mar 2020 11:35:55 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q7E00800JFO0D00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 18 Mar 2020 11:35:55 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: b1aa2595368ad139bab7164dff388cf3
X-Va-E-CD: d39bee373f7d7155fd3c1813e6410fde
X-Va-R-CD: 90ebc19ed3c4b4977ee71a149d52c323
X-Va-CD: 0
X-Va-ID: cb874141-95a6-4b97-a629-b4ec42731e35
X-V-A: 
X-V-T-CD: b1aa2595368ad139bab7164dff388cf3
X-V-E-CD: d39bee373f7d7155fd3c1813e6410fde
X-V-R-CD: 90ebc19ed3c4b4977ee71a149d52c323
X-V-CD: 0
X-V-ID: a925d99d-8c29-4c12-811d-abc2ef9892b7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_07:2020-03-18,
 2020-03-18 signatures=0
Received: from [17.234.80.9] (unknown [17.234.80.9])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q7E00OZMJNVBFA0@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 18 Mar 2020 11:35:55 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 04/11] MAINTAINERS: Add an entry for the HVF accelerator
In-reply-to: <20200316120049.11225-5-philmd@redhat.com>
Date: Wed, 18 Mar 2020 11:35:54 -0700
Cc: Cameron Esfahani via <qemu-devel@nongnu.org>,
 Patrick Colp <patrick.colp@oracle.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Liran Alon <liran.alon@oracle.com>,
 "Reviewed-by : Nikita Leshenko" <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Content-transfer-encoding: quoted-printable
Message-id: <C16A00EA-8D8B-4761-87DE-F636513DBFB7@apple.com>
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-5-philmd@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_07:2020-03-18,
 2020-03-18 signatures=0
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

Please add me to the HVF maintainers as well.

Cameron Esfahani
dirty@apple.com

"In the elder days of Art, Builders wrought with greatest care each =
minute and unseen part; For the gods see everywhere."

"The Builders", H. W. Longfellow



> On Mar 16, 2020, at 5:00 AM, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Cc: Patrick Colp <patrick.colp@oracle.com>
> Cc: Cameron Esfahani <dirty@apple.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Heiher <r@hev.cc>
> ---
> MAINTAINERS | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ec42a18f7..bcf40afb85 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -420,6 +420,12 @@ F: accel/stubs/hax-stub.c
> F: target/i386/hax-all.c
> F: include/sysemu/hax.h
>=20
> +HVF Accelerator
> +S: Orphan
> +F: accel/stubs/hvf-stub.c
> +F: target/i386/hvf/hvf.c
> +F: include/sysemu/hvf.h
> +
> WHPX CPUs
> M: Sunil Muthuswamy <sunilmut@microsoft.com>
> S: Supported
> --=20
> 2.21.1
>=20
>=20


