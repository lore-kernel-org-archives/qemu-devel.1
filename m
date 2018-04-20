Received: from eggs.gnu.org ([2001:4830:134:3::10]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9Qb5-0005QN-40
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9Qb2-0001ap-02
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:36:43 -0400
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-4-git-send-email-thuth@redhat.com>
	<bc5533dc-9471-7dac-6aba-9014e9961376@linux.vnet.ibm.com>
	<b0bb6918-0047-9a53-b03f-bff5669daaaa@redhat.com>
	<2d59a139-3bdd-4b4e-882c-5cf845488eda@linux.vnet.ibm.com>
	<475ea222-cc03-16e4-0f50-f89cf2bfae6f@redhat.com>
	<0b6af02e-6e5b-76bb-a0d0-30038ad5a265@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a001b146-7091-63e6-a845-e276494cc518@redhat.com>
Date: Fri, 20 Apr 2018 09:36:33 +0200
MIME-Version: 1.0
In-Reply-To: <0b6af02e-6e5b-76bb-a0d0-30038ad5a265@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.13 3/4]
 pc-bios/s390-ccw/net: Add support for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 20.04.2018 08:53, Viktor VM Mihajlovski wrote:
> On 19.04.2018 18:55, Thomas Huth wrote:
>> On 19.04.2018 14:40, Viktor VM Mihajlovski wrote:
[...]
>>>>> That's interesting because treating the bootfile as pxe-ish config =
is
>>>>> what DPM does. Which means that with this change the processor
>>>>> architecture type 0x1f (Basic) will turn into a superset of 0x20
>>>>> (Extended).
>>>>
>>>> Is there any reference available what "basic" and "extended" exactly
>>>> mean? I just know that there are these two values registered by you =
at
>>>> the IANA:
>>>>
>>>> https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters=
.xhtml#processor-architecture
>>>>
>>>> ... but I haven't seen a description of the differences of these two
>>>> values yet.
>>>>
>>> Yep, the IANA stuff is pretty terse for all architectures. In a
>>> nutshell: 0x1f is standard DHCP-based boot (bootfile is a single
>>> executable binary) and 0x20 serves a pxe-style config file instead.
>>
>> Can 0x20 also still handle binary files, or only pxe-style config file=
s?
>>
> Unfortunately, DPM has no support for binaries which was the reason we
> ended up with two different identifiers

Ok, so switching to 0x20 is not an option for us here.

>>> In fact, "processor architecture identifier" is a misnomer, as it
>>> describes a pair of processor architecture and firmware.
>>
>> Yeah, I know ... it's even worse nowadays, it's processor + firmware +
>> TCP/IP protocol (HTTP vs. TFTP) ... we should have properly untangled
>> that when doing RFC 5970, but it was already hard enough to get that
>> accepted in the current shape, so we missed to clean up the mess from
>> RFC 4578 / PXE :-(
>>
>>> Since the QEMU firmware has two significant extensions now (insfile a=
nd
>>> direct config file loading), it might be worthwhile to add a new
>>> identifier value (say s390 QEMU PC-BIOS or similar) announcing the ne=
w
>>> capabilities, so that a boot server admin can setup her system accord=
ingly.
>>
>> Not sure ... too many processory-architecture-type entries might also
>> rather be too confusing for the users? ... so if 0x20 can also handle
>> binary files like 0x1f, I'd maybe simply go with 0x20 and mainly promo=
te
>> pxelinux config files in the documentation?
>>
> Well, if we don't add another identifier, and I feel reluctant about it
> as well for the reasons you wrote, we may stick with 0x1f and consider
> the additional capabilities as being optional (for special needs only).

I tend to stay with 0x1f, since booting binaries is still the "primary"
interface (the first check for the "default" or "# " magic keywords is
not 100% reliable, since the config file could also start with another
command, and the probing of pxelinux.cfg/* files is only tried afterwards=
).

 Thomas
