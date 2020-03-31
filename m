Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20A3C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE45320781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="atOjOAsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE45320781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJE5f-0006Cx-T9
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJE4c-00057y-9C
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJE4b-00042v-54
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:24:46 -0400
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:52288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJE4a-00040K-Tf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:24:45 -0400
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02VAGvS2040068; Tue, 31 Mar 2020 03:24:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=yNVfKmnWYXnXUHJvdWhzj8VTxaVYVaiVI5UHAbdiez8=;
 b=atOjOAsSkDsSUzihCJAE+5QxStH2lpn7O7J+gIH9vYORD9Id6d6TTzqkrv8H/Dq4/I6W
 wTnFTIkgN5/umW1e2Dwm0aVVuqw/GDlXcFRn8Af2l2w6Jc8kyAvUS38qquFYr+Jt1pIy
 h+5VcpRP4UprSEnMc9H34zSt00r4eYCXwNGSLz+RFd3ychapA0ndbii2bHPVrmQ/TIkU
 vn5GUvjKxVw5wqKbefwVOeYmnRYDouCKS4Nb79wUry2k7fpk5TuhtaEY95AIZ/5+IwT+
 Ex69IjxwHs/GV1gnV4225bhJ1S7PZA2O0fq+5l/l7DVhb/x/lBIjsVF/HsZBh1IjnepC AA== 
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 3025h0re27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 31 Mar 2020 03:24:29 -0700
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8100AEGZKT7190@rn-mailsvcp-mta-lapp01.rno.apple.com>; 
 Tue, 31 Mar 2020 03:24:29 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100200ZCB2400@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 31 Mar 2020 03:24:29 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: d84713a760465a4a8b2ed3e217d59fe6
X-Va-E-CD: d1b04e1bd6d154f87ae03aa5ecb8d694
X-Va-R-CD: 4ce53bcb44072d4b699c104a90ef4dba
X-Va-CD: 0
X-Va-ID: 3070610b-ddac-4722-bc5f-501713d3a6bf
X-V-A: 
X-V-T-CD: d84713a760465a4a8b2ed3e217d59fe6
X-V-E-CD: d1b04e1bd6d154f87ae03aa5ecb8d694
X-V-R-CD: 4ce53bcb44072d4b699c104a90ef4dba
X-V-CD: 0
X-V-ID: 978f2d5a-693c-4678-a60a-54c781e6a860
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_03:2020-03-30,
 2020-03-31 signatures=0
Received: from [17.234.84.168] (unknown [17.234.84.168])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q81009FRZKS3W60@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 31 Mar 2020 03:24:29 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
In-reply-to: <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
Date: Tue, 31 Mar 2020 03:24:28 -0700
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Robert Mustacchi <rm@fingolfin.org>
Content-transfer-encoding: quoted-printable
Message-id: <58CE5200-AB75-4014-AA2B-EE6E2F265A43@apple.com>
References: <20200330214444.43494-1-dirty@apple.com>
 <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
 <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
To: Cameron Esfahani <dirty@apple.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_03:2020-03-30,
 2020-03-31 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.151.62.66
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

Actually, reading the specification a little more, the only fields which =
are documented as being smaller than 4-bytes are CAPLENGTH (1-byte) and =
HCIVERSION (2-bytes).

So maybe change impl.min_access_size to 1 and rely on the fact that =
traditionally callers haven't read less than 4-bytes for any of the =
4-byte fields...

Cameron Esfahani
dirty@apple.com

"In the elder days of Art, Builders wrought with greatest care each =
minute and unseen part; For the gods see everywhere."

"The Builders", H. W. Longfellow



> On Mar 31, 2020, at 2:57 AM, Cameron Esfahani via =
<qemu-devel@nongnu.org> wrote:
>=20
> Philippe -
> =46rom what I've seen, access size has nothing to do with alignment.
>=20
> What the code in access_with_adjusted_size() will do is make sure that =
"size" is >=3D min_access_size and <=3D max_access_size.
>=20
> So reading 2-bytes from address 2 turns into reading 4-bytes from =
address 2: xhci_cap_read() is called with reg 2, size 4.
>=20
> But, due to the fact our change to support reg 2 only returns back =
2-bytes, and how the loops work in access_with_adjusted_size(), we only =
call xhci_cap_read() once.
>=20
> It seems like we should also change impl.min_access_size for =
xhci_cap_ops to be 2.
>=20
> But, after that, to support people doing strange things like reading =
traditionally 4-byte values as 2 2-byte values, we probably need to =
change xhci_cap_read() to handle every memory range in steps of 2-bytes.
>=20
> But I'll defer to Gerd on this...
>=20


