Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07806C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8ED6215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="pMed0yVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ED6215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDfa-0003ti-1o
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJDex-0003Ot-7K
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJDev-0003kj-QH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:58:15 -0400
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:44022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJDev-0003kI-Ko
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:58:13 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02V9pmsf021029; Tue, 31 Mar 2020 02:57:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=VSONpEnQKDJCzB625OeXw62RRRVOj+Rgpr6BZNRZWt8=;
 b=pMed0yVUEkUoEA+1ZsrU9GZvcZO0tQTd8S2MXfaHoLWxP+5T6efitqrbuqeiWfH9arDD
 GDgpBYTuisZyisk5Y+uBrVV8u3ARSXxqUrzntdQEINsjWVbEyfeqZVG+uJDBSJotXD+M
 lKx46uBhBdV4xgWlJ6ikp60zEZc6DZTLe2Y9huLNbyLO5wNnyTTbPAzgE0dGhRcifF8l
 HjJBUDXiYUnEpNd1kF/VYvgFunTHdpsysIptYzhlOzWn378yEz7QQ6ITM4eSlrxvas5W
 pi7bPVfxIsq0y1ku4Acdnh1LcmuhkPhDyRS0g7IRdbOWtvhyVEQYvioaP0paBRB+akoF AA== 
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 30238sqyf6-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 31 Mar 2020 02:57:58 -0700
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8100JCSYCLXHB0@rn-mailsvcp-mta-lapp03.rno.apple.com>; 
 Tue, 31 Mar 2020 02:57:57 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100500Y2K8200@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 31 Mar 2020 02:57:57 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: b1aa2595368ad139bab7164dff388cf3
X-Va-E-CD: d1b04e1bd6d154f87ae03aa5ecb8d694
X-Va-R-CD: 4ce53bcb44072d4b699c104a90ef4dba
X-Va-CD: 0
X-Va-ID: bfa25967-f8ec-4eb1-b6a2-e7ac90e1e7c9
X-V-A: 
X-V-T-CD: b1aa2595368ad139bab7164dff388cf3
X-V-E-CD: d1b04e1bd6d154f87ae03aa5ecb8d694
X-V-R-CD: 4ce53bcb44072d4b699c104a90ef4dba
X-V-CD: 0
X-V-ID: bd5a0a96-5c04-4585-9ada-3198e4c9dd82
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_03:2020-03-30,
 2020-03-31 signatures=0
Received: from [17.234.84.168] (unknown [17.234.84.168])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8100EIGYCLLA50@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Tue,
 31 Mar 2020 02:57:57 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
In-reply-to: <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
Date: Tue, 31 Mar 2020 02:57:56 -0700
Cc: Cameron Esfahani via <qemu-devel@nongnu.org>, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Robert Mustacchi <rm@fingolfin.org>
Content-transfer-encoding: quoted-printable
Message-id: <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
References: <20200330214444.43494-1-dirty@apple.com>
 <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_03:2020-03-30,
 2020-03-31 signatures=0
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

Philippe -
=46rom what I've seen, access size has nothing to do with alignment.

What the code in access_with_adjusted_size() will do is make sure that =
"size" is >=3D min_access_size and <=3D max_access_size.

So reading 2-bytes from address 2 turns into reading 4-bytes from =
address 2: xhci_cap_read() is called with reg 2, size 4.

But, due to the fact our change to support reg 2 only returns back =
2-bytes, and how the loops work in access_with_adjusted_size(), we only =
call xhci_cap_read() once.

It seems like we should also change impl.min_access_size for =
xhci_cap_ops to be 2.

But, after that, to support people doing strange things like reading =
traditionally 4-byte values as 2 2-byte values, we probably need to =
change xhci_cap_read() to handle every memory range in steps of 2-bytes.

But I'll defer to Gerd on this...

Cameron Esfahani
dirty@apple.com

"Americans are very skilled at creating a custom meaning from something =
that's mass-produced."

Ann Powers


> On Mar 31, 2020, at 12:52 AM, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> On 3/30/20 11:44 PM, Cameron Esfahani via wrote:
>> macOS will read HCIVERSION separate from CAPLENGTH.  Add a distinct
>> handler for that register.
>=20
> Apparently a fix for https://bugs.launchpad.net/qemu/+bug/1693050.
>=20
>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>> ---
>>  hw/usb/hcd-xhci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index b330e36fe6..061f8438de 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -2739,6 +2739,9 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr =
reg, unsigned size)
>>      case 0x00: /* HCIVERSION, CAPLENGTH */
>>          ret =3D 0x01000000 | LEN_CAP;
>>          break;
>> +    case 0x02: /* HCIVERSION */
>> +        ret =3D 0x0100;
>> +        break;
>=20
> But we have:
>=20
> static const MemoryRegionOps xhci_cap_ops =3D {
>    .read =3D xhci_cap_read,
>    .write =3D xhci_cap_write,
>    .valid.min_access_size =3D 1,
>    .valid.max_access_size =3D 4,
>    .impl.min_access_size =3D 4,
>    .impl.max_access_size =3D 4,
>    .endianness =3D DEVICE_LITTLE_ENDIAN,
> };
>=20
> IIUC ".impl.min_access_size =3D 4" means the case 'reg =3D=3D 2' can =
not happen. It seems we have a bug in memory.c elsewhere.
>=20
> How can we reproduce?
>=20
> If not easy, can you share the backtrace of:
>=20
> -- >8 --
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index b330e36fe6..d021129f3f 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -2735,6 +2735,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr =
reg, unsigned size)
>     XHCIState *xhci =3D ptr;
>     uint32_t ret;
>=20
> +    assert(reg !=3D 2);
>     switch (reg) {
>     case 0x00: /* HCIVERSION, CAPLENGTH */
>         ret =3D 0x01000000 | LEN_CAP;
> ---
>=20
>>      case 0x04: /* HCSPARAMS 1 */
>>          ret =3D ((xhci->numports_2+xhci->numports_3)<<24)
>>              | (xhci->numintrs<<8) | xhci->numslots;


