Received: from eggs.gnu.org ([2001:4830:134:3::10]:49010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOQOC-0000OP-B6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOQOB-00044H-AT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:25:24 -0400
References: <20180525235509.11282-1-jsnow@redhat.com>
	<20180525235509.11282-4-jsnow@redhat.com>
	<91fa0944-d11d-894f-a1aa-03b1fd186f1a@amsat.org>
	<acfc53d7-228f-2e95-5946-f7faf0c7f2e3@redhat.com>
	<555ec873-cc3a-deb5-93aa-057823d413d6@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <3bacf011-4dcd-eff2-e4b2-241758654ff0@redhat.com>
Date: Thu, 31 May 2018 12:25:17 -0400
MIME-Version: 1.0
In-Reply-To: <555ec873-cc3a-deb5-93aa-057823d413d6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/16] ahci: make port read traces more
 descriptive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 05/30/2018 05:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/30/2018 05:17 PM, John Snow wrote:
>> On 05/26/2018 12:44 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi John,
>>>
>>> On 05/25/2018 08:54 PM, John Snow wrote:
>>>> A trace is added to let us watch unimplemented registers specificall=
y,
>>>> as these are more likely to cause us trouble. Otherwise, the port re=
ad
>>>> traces now tell us what register is getting hit, which is nicer.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  hw/ide/ahci.c       | 5 +++--
>>>>  hw/ide/trace-events | 3 ++-
>>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>>>> index 5187bf34ad..57c80a2fe9 100644
>>>> --- a/hw/ide/ahci.c
>>>> +++ b/hw/ide/ahci.c
>>>> @@ -46,7 +46,6 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
>>>>  static void ahci_unmap_clb_address(AHCIDevice *ad);
>>>>  static void ahci_unmap_fis_address(AHCIDevice *ad);
>>>> =20
>>>> -__attribute__((__unused__)) /* TODO */
>>>>  static const char *AHCIPortReg_lookup[AHCI_PORT_REG__COUNT] =3D {
>>>>      [AHCI_PORT_REG_LST_ADDR]    =3D "PxCLB",
>>>>      [AHCI_PORT_REG_LST_ADDR_HI] =3D "PxCLBU",
>>>> @@ -149,10 +148,12 @@ static uint32_t ahci_port_read(AHCIState *s, i=
nt port, int offset)
>>>>          val =3D pr->cmd_issue;
>>>>          break;
>>>>      default:
>>>> +        trace_ahci_port_read_unimpl(s, port, AHCIPortReg_lookup[reg=
num],
>>>> +                                    offset);
>>>
>>> I personally prefer qemu_log_mask(LOG_UNIMP) here.
>>>
>>> Rational is when trying firmware, one might want to know which
>>> unimplemented features access the firmware, without having to dig int=
o
>>> trace events, and the "-d unimp" command line option just works.
>>>
>>
>> For reads, it's ambiguous. Some of the registers we've specifically no=
t
>> implemented because if they are unsupported they are supposed to retur=
n
>> 0, which we do here. The default behavior is generally correct.
>>
>> In this case, the trace really is just kind of an informative /
>> debugging statement we probably aren't too interested in unless we're
>> diagnosing some AHCI problem specifically -- and I don't want to turn =
on
>> all unimp messages to see these.
>>
>>> (same apply for the write() function later in this series).
>>>
>>
>> For writes it's actually definitely unhandled and I might actually
>> prefer both the trace and the log -- if we support "-d unimp" on the
>> command line to hunt for known stubs getting probed, this is certainly
>> one of those places we want to know about.
>=20
> I agree to "both the trace and the log".
>=20
> Whether or not you add qemu_log_mask(LOG_UNIMP) beyond the traces:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20

1. Do you intend to R-B the whole series, or just this patch?
2. Is it your intention that I add the log to the read trace as well? My
inclination is to only add it to the write.

--js
