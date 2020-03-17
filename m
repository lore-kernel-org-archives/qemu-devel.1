Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05152C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01C820738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="JCHL6GdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01C820738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELli-00043K-TN
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jELa4-0001Zt-7x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jELa2-0007kr-Pb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:04 -0400
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:56114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jELa2-0007Xw-GE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:25:02 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02HNCt0g051955; Tue, 17 Mar 2020 16:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=LKLvLyuwmiwybblk68vbP6oi4CNkb27jOgjDz+Qb0u8=;
 b=JCHL6GdVreg95HJgu2JFEvaN7ULQny7dCsD3oR83VuHmQUVkgD6aA/8nKQoZLKOrmIEP
 SNVZrFIvv6Olq1U4Y3gYHC7+/jh1qGAxI7skiBaMPyMB3nUIb2k1PLbf5FBIGpjXHdeP
 TSg4+6h9gdzb2quQQOl3WWMTji1yfBhu61EGduYYJxbwA0V7UeKkEiv6KhK3eyA9UFkm
 b7BpLKUD3yycwi/x37DjwwQLa9op69PuSFoO8+8iE54U/yvGhR/ShsSJ3bzL59cXEqmj
 oBy/y6jZ/VE3j09cy5LSA/60LpvcDvQlV8FWon/d+bw6EBIZ0eyR+Hp5LJBIwTssi328 SQ== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 2yrwx2gq5f-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 17 Mar 2020 16:24:47 -0700
Received: from nwk-mmpp-sz09.apple.com
 (nwk-mmpp-sz09.apple.com [17.128.115.80]) by
 rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q7D00LYX2D9FPG0@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Tue, 17 Mar 2020 16:24:46 -0700 (PDT)
Received: from process_milters-daemon.nwk-mmpp-sz09.apple.com by
 nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q7D00J0022UZX00@nwk-mmpp-sz09.apple.com>; Tue,
 17 Mar 2020 16:24:45 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 20c0c410705af0c5efefeb0380f25862
X-Va-E-CD: d39bee373f7d7155fd3c1813e6410fde
X-Va-R-CD: 90ebc19ed3c4b4977ee71a149d52c323
X-Va-CD: 0
X-Va-ID: a6577fba-d881-4249-906d-f9494cb7ed0b
X-V-A: 
X-V-T-CD: 20c0c410705af0c5efefeb0380f25862
X-V-E-CD: d39bee373f7d7155fd3c1813e6410fde
X-V-R-CD: 90ebc19ed3c4b4977ee71a149d52c323
X-V-CD: 0
X-V-ID: e77a7321-2146-4144-bee0-2be891cf2966
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-17_09:2020-03-17,
 2020-03-17 signatures=0
Received: from [17.234.62.43] (unknown [17.234.62.43])
 by nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q7D00GAU2D9AK40@nwk-mmpp-sz09.apple.com>; Tue,
 17 Mar 2020 16:24:45 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 04/11] MAINTAINERS: Add an entry for the HVF accelerator
In-reply-to: <20200316121241.GA4312@SPB-NB-133.local>
Date: Tue, 17 Mar 2020 16:24:44 -0700
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 "Reviewed-by : Nikita Leshenko" <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Content-transfer-encoding: quoted-printable
Message-id: <D599D20D-5F23-48CB-B24C-2D1604AFE94E@apple.com>
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-5-philmd@redhat.com>
 <20200316121241.GA4312@SPB-NB-133.local>
To: Roman Bolshakov <r.bolshakov@yadro.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-17_09:2020-03-17,
 2020-03-17 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.60
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

Sorry I didn't see this yesterday.

We've (Apple) signed up for taking over HVF ownership.  I didn't realize =
I needed to add to the MAINTAINERS list.

Roman, we also have a bunch of pending fixes for some of the issues =
you've listed.  We're in the process of upstreaming them.

Cameron Esfahani
dirty@apple.com

"All that is necessary for the triumph of evil is that good men do =
nothing."

Edmund Burke



> On Mar 16, 2020, at 5:12 AM, Roman Bolshakov <r.bolshakov@yadro.com> =
wrote:
>=20
> Hi Philippe,
>=20
> I can take the ownership if nobody wants it. At the moment I'm working
> on APIC for HVF to get kvm-unit-tests fixed.
>=20
> Next items on the list (in no particular order):
> * MMX emulation
> * SSE emulation
> * qxl display
> * gdb stub
> * virtio-gpu/virgil running on metal
> * VFIO-PCI based on macOS user-space DriverKit framework
>=20
> Best regards,
> Roman
>=20
> On Mon, Mar 16, 2020 at 01:00:42PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
>> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
>> Cc: Patrick Colp <patrick.colp@oracle.com>
>> Cc: Cameron Esfahani <dirty@apple.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Cc: Heiher <r@hev.cc>
>> ---
>> MAINTAINERS | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7ec42a18f7..bcf40afb85 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -420,6 +420,12 @@ F: accel/stubs/hax-stub.c
>> F: target/i386/hax-all.c
>> F: include/sysemu/hax.h
>>=20
>> +HVF Accelerator
>> +S: Orphan
>> +F: accel/stubs/hvf-stub.c
>> +F: target/i386/hvf/hvf.c
>> +F: include/sysemu/hvf.h
>> +
>> WHPX CPUs
>> M: Sunil Muthuswamy <sunilmut@microsoft.com>
>> S: Supported
>> --=20
>> 2.21.1
>>=20
>=20


