Received: from eggs.gnu.org ([2001:4830:134:3::10]:59351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fQCG5-0007NM-3Z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fQCG1-0002B6-5j
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fQCG1-0002Ax-0E
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:44:17 -0400
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<53c37321-52d2-732c-19fb-8f6a9542c714@gmail.com>
	<20180605132948.GH32286@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5f7fad87-73dd-ef75-bb1d-983d36e42073@redhat.com>
Date: Tue, 5 Jun 2018 15:44:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180605132948.GH32286@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, rth@twiddle.net

On 06/05/18 15:29, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 05, 2018 at 04:20:46PM +0300, Marcel Apfelbaum wrote:
>>
>>
>> On 06/05/2018 11:43 AM, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Jun 05, 2018 at 09:27:46AM +0200, Gerd Hoffmann wrote:
>>>>    Hi,
>>>>
>>>>>>    Add to that shortcuts like -cdrom
>>>>>> stop working,
>>>>> Maybe is fixable.
>>>> Already fixed for ages.
>>>>
>>>>> I see marking Q35 as the default machine a first step.
>>>> Maybe the better option is to go the arm route:  Just don't define a
>>>> default, so users have to specify pc or q35.  That will make them no=
tice
>>>> there is a world beside 'pc', and we also avoid breaking things
>>>> silently.
>>
>> It can work, sure. And we can add user hints: "Use q35 for ...., selec=
t pc
>> if..."
>>
>>> If QEMU removes the default, then libvirt will have to hardcode
>>> 'pc' as the default to maintain back compatibility, so I don't
>>> think that ends up as a net win
>>
>> Can't libvirt preserve 'pc' for existing domains, while defaulting to =
q35
>> the creation of new domains ? This way it aligns with Gerd's proposal =
of no
>> default x86 machine.
>=20
> Existing domains wasn't the case I was concerned about. Consider you ha=
ve
> libvirt 4.4.0 intsalled and you deploy a *new* domain from a prebuilt
> disk image "foo". Now update to a libvirt or QEMU which changes to q35
> and try to deploy another new domain from the same prebuilt disk
> image "foo". It may not work now if that disk image doesn't support
> q35. That would be a regression from the user's POV, whether libvirt or
> qemu has changed the default.

How about:
- "create new domain with empty disk" --> i440fx now, q35 later
- "create new domain from domain XML and disk image" --> whatever the
  domain definition dictates
- "create new domain from disk image and no domain XML" --> assume
  i440fx forever (with a detailed board / device config that's used for
  all legacy (definition-less) disk images)
- convince disk image distributors to provide their domain definitions
  with their disks (need not be libvirt domain XML, other definitions
  might work)
- write converters from those other definition formats to libvirt XML,
  or QEMU cfg file?

(I'm with Markus:
<http://mid.mail-archive.com/87o9h6hb59.fsf@dusky.pond.sub.org>. Not
specifically about OVF, but disk image providers need to start exposing
their QEMU configs. And I think they should do that in whatever format
their management stack supports.)

Just my two cents, feel free to ignore.

Thanks
Laszlo
