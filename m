Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BFF2077D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="KTYafo5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BFF2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=apple.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgd4C-0007gF-3L
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 19:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dirty@apple.com>) id 1jgd3c-00079V-8S
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:44:28 -0400
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:56260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dirty@apple.com>) id 1jgd3b-0006Ev-E4
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 19:44:27 -0400
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
 by nwk-aaemail-lapp02.apple.com (8.16.0.42/8.16.0.42) with SMTP id
 053NcTGO064949; Wed, 3 Jun 2020 16:44:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=8a9MOsw0W3skkvp5IbmUbGQ0EOAmesE+IZiebvqeFRw=;
 b=KTYafo5KDhywbEXYkQlC4dY47YmxN+1Ghu3OFtll+Wxgk/uS7hciLU9lwh7rC2IHqv1b
 6k/RXa0ZchzlPEXtirbryCDcV/xFi5Ep3nWE4l9BBtsuvjCDw0nPtsl/TO/XycSqW7xE
 1nfhFksdrVkCogz/MPrDUwTWGltTC/stqA3ofoZkpyM4EprVOSEtCwy+Ib24RY0G1Zx9
 rxENQDu0CDKLa8k9NE2FdQR63oBxcFkvTTZWndrvqHpdsmA+w7VvdjrbjTzUtersRZlt
 HR223zQJJ60V7oPyEcReKImhF6SvK1p4uVNvCi/FIy9PElgSC7AhMHJ7vKW/yMuRR+VK 2A== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by nwk-aaemail-lapp02.apple.com with ESMTP id 31bm2ha53s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 03 Jun 2020 16:44:26 -0700
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0QBD007WQJA14M90@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Wed, 03 Jun 2020 16:44:25 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0QBD00S00IYJEV00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Wed,
 03 Jun 2020 16:44:25 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 46931e9116192002279dfee8d345dfa3
X-Va-E-CD: 60a558adcae14311613a1773d174b849
X-Va-R-CD: 3f9e7a567f249bdb29d0e39dccc2f261
X-Va-CD: 0
X-Va-ID: fa3c19e5-9835-459a-8f3c-66624e3b75ea
X-V-A: 
X-V-T-CD: 46931e9116192002279dfee8d345dfa3
X-V-E-CD: 60a558adcae14311613a1773d174b849
X-V-R-CD: 3f9e7a567f249bdb29d0e39dccc2f261
X-V-CD: 0
X-V-ID: 77d14f5c-cf2f-4ec3-8ae8-23e2999f2380
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-03_13:2020-06-02,
 2020-06-03 signatures=0
Received: from [17.234.60.254] (unknown [17.234.60.254])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0QBD0063ZJA08G00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Wed,
 03 Jun 2020 16:44:25 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5 03/15] acpi: rtc: use a single crs range
From: Cameron Esfahani <dirty@apple.com>
In-reply-to: <20200507131640.14041-4-kraxel@redhat.com>
Date: Wed, 03 Jun 2020 16:44:23 -0700
Cc: Cameron Esfahani via <qemu-devel@nongnu.org>
Content-transfer-encoding: quoted-printable
Message-id: <42136139-DA96-4774-A042-1D490054B0DF@apple.com>
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-4-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-03_13:2020-06-02,
 2020-06-03 signatures=0
Received-SPF: pass client-ip=17.151.62.67; envelope-from=dirty@apple.com;
 helo=nwk-aaemail-lapp02.apple.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 19:35:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Reviewed-by: Cameron Esfahani <dirty@apple.com>

Cameron Esfahani
dirty@apple.com

"Americans are very skilled at creating a custom meaning from something =
that's mass-produced."

Ann Powers


> On May 7, 2020, at 6:16 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> Use a single io range for _CRS instead of two,
> following what real hardware does.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> hw/rtc/mc146818rtc.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 2104e0aa3b14..ab0cc59973b3 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -1013,12 +1013,14 @@ static void rtc_build_aml(ISADevice *isadev, =
Aml *scope)
>     Aml *dev;
>     Aml *crs;
>=20
> +    /*
> +     * Reserving 8 io ports here, following what physical hardware
> +     * does, even though qemu only responds to the first two ports.
> +     */
>     crs =3D aml_resource_template();
>     aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
> -                           0x10, 0x02));
> +                           0x01, 0x08));
>     aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
> -    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE + 2, =
RTC_ISA_BASE + 2,
> -                           0x02, 0x06));
>=20
>     dev =3D aml_device("RTC");
>     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
> --=20
> 2.18.4
>=20
>=20


