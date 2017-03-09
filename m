Received: from eggs.gnu.org ([2001:4830:134:3::10]:48457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clxB2-0000dx-UE
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clxAz-0004Wz-0m
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:28:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clxAy-0004Wh-QT
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:28:12 -0500
References: <1489017212-2990-1-git-send-email-mst@redhat.com>
	<1a475607-b876-d79a-5e0b-e1a4a006c65d@redhat.com>
	<a5ac15ac-b6df-6d3c-d898-177ed5e163d0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <add38c95-d7e0-ca6f-529c-3f3fe8d41527@redhat.com>
Date: Thu, 9 Mar 2017 13:28:09 +0100
MIME-Version: 1.0
In-Reply-To: <a5ac15ac-b6df-6d3c-d898-177ed5e163d0@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] qdev: add init order filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.a@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>



On 09/03/2017 13:11, Marcel Apfelbaum wrote:
> On 03/09/2017 01:13 PM, Paolo Bonzini wrote:
>>
>>
>> On 09/03/2017 00:59, Michael S. Tsirkin wrote:
>>> Allow forcing a specific order of initialization on
>>> devices created with -device.
>>> Helpful e.g. for built-in devices such as IOMMUs which must
>>> exist before all other devices.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>
>>> Looks like we have a ton of problems because devices
>>> are initialized in a random order, while we
>>> really want e.g. iommu to be initialized
>>> earlier than devices.
>>>
>>> This will be helpful for other things, e.g.
>>> real hardware often is initialized in a specific order,
>>> creating built-in devices for the board often
>>> has to happen in a specific order, etc.
>>
>> In the specific case of PCI bus_master_as there is a simple workaround
>> by placing a dummy container (which lets us build the AddressSpace) an=
d
>> then adding the alias region at machine_done time.
>>
>> This is exactly how MemoryListener is supposed to work, so I would sta=
rt
>> from there.
>>
>=20
> Hi Paolo,
>=20
> This will certainly solve virtio-pci ordering issue, but I am not sure
> it solves the vfio-pci problem. Here is a link to Alex's explanation:
>=20
> http://www.mail-archive.com/qemu-devel@nongnu.org/msg432365.html

Right, VFIO is more complicated (hence "in the specific case of PCI
bus_master_as").  I answered in that thread.

Paolo
