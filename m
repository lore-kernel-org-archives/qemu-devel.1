Received: from eggs.gnu.org ([2001:4830:134:3::10]:46979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwmz8-0006sC-4x
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwmz4-0003qc-PZ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:21:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwmz4-0003qJ-Gg
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:20:58 -0400
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170926052650.GA10768@in.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1321f06e-c5d9-4f14-2459-6e1bbd8e0cdf@redhat.com>
Date: Tue, 26 Sep 2017 12:20:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170926052650.GA10768@in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Amit Shah <amit@kernel.org>

On 26.09.2017 07:26, Bharata B Rao wrote:
> On Fri, Sep 22, 2017 at 11:16:34AM +0200, Thomas Huth wrote:
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
> I see that the discussion has moved on, but want to note here that
> CPU hotplug on pseries breaks with this patch.
>=20
> (qemu) device_add host-spapr-cpu-core,core-id=3D8,id=3Dcore8
> Device 'host-powerpc64-cpu' does not support hotplugging
>=20
> (qemu) device_add POWER8E_v2.1-spapr-cpu-core,id=3Dcore8,core-id=3D8
> Device 'POWER8E_v2.1-powerpc64-cpu' does not support hotplugging

Sorry, my bad (again) - I missed that the spapr-cpu-core tries to
internally create some more devices, i.e. the powerpc64-cpu device and a
icp device. So they need to be marked as hotpluggable, too. I'll fix
this in my next version of the patch...
Anyway, thanks a lot for testing! (and memo ty myself: Do more testing
on your own before sending patches like this...)

> Hope I am not missing anything.

You just missed to add a proper qtest for "make check" for hot-pluggable
CPUs (hint, hint!) ;-) Apart from that, this failure was completely my
fault...

 Cheers,
  Thomas
