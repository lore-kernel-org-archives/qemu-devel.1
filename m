Received: from eggs.gnu.org ([2001:4830:134:3::10]:37859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvIgb-0008Jv-LK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvIga-00013b-M3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:45 -0400
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
	<20170921185028.GK21016@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d48ef387-dd66-727d-aa9e-b1786efd30e5@redhat.com>
Date: Fri, 22 Sep 2017 09:47:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170921185028.GK21016@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 21.09.2017 20:50, Eduardo Habkost wrote:
> On Tue, Sep 19, 2017 at 10:55:53AM +0200, Thomas Huth wrote:
>> Historically we've marked all devices as hotpluggable by default. Howe=
ver,
>> most devices are not hotpluggable, and you also need a HotplugHandler =
to
>> support these devices. So if the user tries to "device_add" or "device=
_del"
>> such a non-hotpluggable device during runtime, either nothing really u=
sable
>> happens, or QEMU even crashes/aborts unexpectedly (see for example com=
mit
>> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
>> So let's change this dangerous default behaviour and mark the devices =
as
>> non-hotpluggable by default. Certain parent devices classes which are =
known
>> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable =3D=
 true",
>> so that devices that are derived from these classes continue to work a=
s
>> expected.
>=20
> These seem to be missing:
> * TYPE_CPU (or at least TYPE_X86_CPU and TYPE_S390_CPU)
> * TYPE_VIRTIO_SERIAL_PORT
> * TYPE_CCID_CARD
> * TYPE_XENSYSDEV

Thanks for the detailed examination, Eduardo! I'll rework my patch
accordingly...

> Also, I don't think we need to set it for TYPE_CPU_CORE, just for
> TYPE_SPAPR_CPU_CORE.

Ok - you're likely right. There is one other consumer of TYPE_CPU_CORE
beside spapr, which is the pnv machine, and as far as I can see, it does
not support CPU hotplugging yet. So it indeed makes more sense to set
this in TYPE_SPAPR_CPU_CORE only.

 Thomas
