Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C716AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 22:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0A52072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 22:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="pqpoo73r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0A52072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLaen-0005L2-OT
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 18:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jLadx-0004th-3j
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 18:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jLadv-0008Nw-HG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 18:55:00 -0400
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:58090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jLadv-0008Nf-CN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 18:54:59 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 036Mq8s2033682; Mon, 6 Apr 2020 15:54:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=Cv8GlAXx1Fc4DiLF4rIIxiumqdLx/1ctdV9kH3HG3wc=;
 b=pqpoo73r/74UgkPcZlw8IzGrfJam/qtWQUuGmL5QYOWtyawrItomFnva99S+qQzkL8P6
 0+QohBwX4wPtdk4n5wPprY6cri55gGjvinE9czDIHhosXfDisSSfh4CLXOlDrHI4M8ef
 8t2MziNcKk+xxShFX77VOiQVdIhHC40MPnvgZYVD9s6FBC1K6UgjfirYLzXbmS7lqbUO
 5I1gJVMrb/omTaZjnKJJGRC6DJtgmJqyVWp9YrIcdUxCCxO6nLbHeQjNPcUsHNLHLrDJ
 FXVyQuAKezixk4+z0pjqdY06lz625hVMIpRRiYKkCwyvTa7w2Y9o0MXzglxa9dGi515R lw== 
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 306pwtf7j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 06 Apr 2020 15:54:33 -0700
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8E003WF2AXL220@rn-mailsvcp-mta-lapp01.rno.apple.com>; 
 Mon, 06 Apr 2020 15:54:33 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8E00O002AG4Z00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 06 Apr 2020 15:54:33 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: e11d9d8f578c993e81a9aaf5a4282841
X-Va-E-CD: d1b04e1bd6d154f87ae03aa5ecb8d694
X-Va-R-CD: 4ce53bcb44072d4b699c104a90ef4dba
X-Va-CD: 0
X-Va-ID: 0bdc7811-b09c-4834-91f6-a1beb7f78b7a
X-V-A: 
X-V-T-CD: e11d9d8f578c993e81a9aaf5a4282841
X-V-E-CD: d1b04e1bd6d154f87ae03aa5ecb8d694
X-V-R-CD: 4ce53bcb44072d4b699c104a90ef4dba
X-V-CD: 0
X-V-ID: 07d3accf-5fea-408d-9701-03351f363033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_10:2020-04-06,
 2020-04-06 signatures=0
Received: from [17.234.27.122] (unknown [17.234.27.122])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8E004492AWOLD0@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 06 Apr 2020 15:54:33 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
In-reply-to: <2c04ba56-436d-354b-512e-50c9d995b702@kaod.org>
Date: Mon, 06 Apr 2020 15:54:32 -0700
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Robert Mustacchi <rm@fingolfin.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 Andrew Jeffery <andrew@aj.id.au>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-transfer-encoding: quoted-printable
Message-id: <2A2A3321-5171-44B3-AF30-4173C976BE72@apple.com>
References: <20200330214444.43494-1-dirty@apple.com>
 <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
 <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
 <ad609899-d544-f660-6784-5fe5cdc2bf21@redhat.com>
 <2c04ba56-436d-354b-512e-50c9d995b702@kaod.org>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_10:2020-04-06,
 2020-04-06 signatures=0
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

I had a look at this failing test case after running applying Cedric's =
patch =
(https://github.com/legoater/qemu/commit/d57ac950c4be47a2bafd6c6a96dec2922=
c2ecd65).

It looks like this is just a bug in the test case.  The test case is =
attempting to verify that the CNF registers are programmed correctly by =
sampling the first and last CNF register.  The bug is that =
NRF51_GPIO_REG_CNF_END doesn't actually refer to the start of the last =
valid CNF register.  It refers to the last byte of the last valid CNF =
register.  So either NRF51_GPIO_REG_CNF_END needs to be adjusted to =
0x77C or we need to subtract 3 to get to the start of the register.  =
Considering the NRF51 doesn't appear to support unaligned access, it =
seems like changing NRF51_GPIO_REG_CNF_END to 0x77C is reasonable.

Here's a patch which seems to fix it for me:

diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
index 337ee53..1d62bbc 100644
--- a/include/hw/gpio/nrf51_gpio.h
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -42,7 +42,7 @@
 #define NRF51_GPIO_REG_DIRSET       0x518
 #define NRF51_GPIO_REG_DIRCLR       0x51C
 #define NRF51_GPIO_REG_CNF_START    0x700
-#define NRF51_GPIO_REG_CNF_END      0x77F
+#define NRF51_GPIO_REG_CNF_END      0x77C
=20
 #define NRF51_GPIO_PULLDOWN 1
 #define NRF51_GPIO_PULLUP 3

Considering this change works for pre-Cedric patch and post, I'll post =
at official version shortly.

And hopefully this unblocks review of Cedric's patch...

Cameron Esfahani
dirty@apple.com

"The cake is a lie."

Common wisdom

> On Apr 1, 2020, at 4:23 AM, C=C3=A9dric Le Goater <clg@kaod.org> =
wrote:
>=20
> Hello,
>=20
> On 3/31/20 1:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 3/31/20 11:57 AM, Cameron Esfahani wrote:
>>> Philippe -
>>>  =46rom what I've seen, access size has nothing to do with =
alignment.
>>=20
>> Yes, I was wondering if you were using unaligned accesses.
>>=20
>> I *think* the correct fix is in the "memory: Support unaligned =
accesses on aligned-only models" patch from Andrew Jeffery:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg461247.html
>=20
> Here is an updated version I have been keeping since :=20
>=20
> 	=
https://github.com/legoater/qemu/commit/d57ac950c4be47a2bafd6c6a96dec2922c=
2ecd65
>=20
> which breaks qtest :
>=20
> 	microbit-test.c:307:test_nrf51_gpio: assertion failed (actual =3D=3D=
 0x01): (0 =3D=3D 1)
>=20
> I haven't had time to look at this closely but it would be nice to get =
this=20
> patch merged. It's a requirement for the Aspeed ADC model.
>=20
> Thanks,
>=20
> c.=20
>=20
>>>=20
>>> What the code in access_with_adjusted_size() will do is make sure =
that "size" is >=3D min_access_size and <=3D max_access_size.
>>>=20
>>> So reading 2-bytes from address 2 turns into reading 4-bytes from =
address 2: xhci_cap_read() is called with reg 2, size 4.
>>>=20
>>> But, due to the fact our change to support reg 2 only returns back =
2-bytes, and how the loops work in access_with_adjusted_size(), we only =
call xhci_cap_read() once.
>>>=20
>>> It seems like we should also change impl.min_access_size for =
xhci_cap_ops to be 2.
>>>=20
>>> But, after that, to support people doing strange things like reading =
traditionally 4-byte values as 2 2-byte values, we probably need to =
change xhci_cap_read() to handle every memory range in steps of 2-bytes.
>>>=20
>>> But I'll defer to Gerd on this...
>>>=20
>>> Cameron Esfahani
>>> dirty@apple.com
>>>=20
>>> "Americans are very skilled at creating a custom meaning from =
something that's mass-produced."
>>>=20
>>> Ann Powers
>>>=20
>>>=20
>>>> On Mar 31, 2020, at 12:52 AM, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>>>>=20
>>>> On 3/30/20 11:44 PM, Cameron Esfahani via wrote:
>>>>> macOS will read HCIVERSION separate from CAPLENGTH.  Add a =
distinct
>>>>> handler for that register.
>>>>=20
>>>> Apparently a fix for https://bugs.launchpad.net/qemu/+bug/1693050.
>>>>=20
>>>>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>>>>> ---
>>>>>   hw/usb/hcd-xhci.c | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>>>> index b330e36fe6..061f8438de 100644
>>>>> --- a/hw/usb/hcd-xhci.c
>>>>> +++ b/hw/usb/hcd-xhci.c
>>>>> @@ -2739,6 +2739,9 @@ static uint64_t xhci_cap_read(void *ptr, =
hwaddr reg, unsigned size)
>>>>>       case 0x00: /* HCIVERSION, CAPLENGTH */
>>>>>           ret =3D 0x01000000 | LEN_CAP;
>>>>>           break;
>>>>> +    case 0x02: /* HCIVERSION */
>>>>> +        ret =3D 0x0100;
>>>>> +        break;
>>>>=20
>>>> But we have:
>>>>=20
>>>> static const MemoryRegionOps xhci_cap_ops =3D {
>>>>     .read =3D xhci_cap_read,
>>>>     .write =3D xhci_cap_write,
>>>>     .valid.min_access_size =3D 1,
>>>>     .valid.max_access_size =3D 4,
>>>>     .impl.min_access_size =3D 4,
>>>>     .impl.max_access_size =3D 4,
>>>>     .endianness =3D DEVICE_LITTLE_ENDIAN,
>>>> };
>>>>=20
>>>> IIUC ".impl.min_access_size =3D 4" means the case 'reg =3D=3D 2' =
can not happen. It seems we have a bug in memory.c elsewhere.
>>>>=20
>>>> How can we reproduce?
>>>>=20
>>>> If not easy, can you share the backtrace of:
>>>>=20
>>>> -- >8 --
>>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>>> index b330e36fe6..d021129f3f 100644
>>>> --- a/hw/usb/hcd-xhci.c
>>>> +++ b/hw/usb/hcd-xhci.c
>>>> @@ -2735,6 +2735,7 @@ static uint64_t xhci_cap_read(void *ptr, =
hwaddr reg, unsigned size)
>>>>      XHCIState *xhci =3D ptr;
>>>>      uint32_t ret;
>>>>=20
>>>> +    assert(reg !=3D 2);
>>>>      switch (reg) {
>>>>      case 0x00: /* HCIVERSION, CAPLENGTH */
>>>>          ret =3D 0x01000000 | LEN_CAP;
>>>> ---
>>>>=20
>>>>>       case 0x04: /* HCSPARAMS 1 */
>>>>>           ret =3D ((xhci->numports_2+xhci->numports_3)<<24)
>>>>>               | (xhci->numintrs<<8) | xhci->numslots;
>>>=20
>>=20
>=20
>=20


