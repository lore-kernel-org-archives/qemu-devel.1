Received: from eggs.gnu.org ([2001:4830:134:3::10]:42376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUCYD-0001RC-DJ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUCYB-00080N-GL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:23:53 -0500
References: <20181128145455.11733-1-david@redhat.com>
	<20181204143345.10fea90e@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fb895afc-ffc1-7cfb-0cf5-97097eaaba9c@redhat.com>
Date: Tue, 4 Dec 2018 16:23:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181204143345.10fea90e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] qdev: Let the hotplug_unplug() caller
 delete the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On 04.12.18 14:33, Igor Mammedov wrote:
> On Wed, 28 Nov 2018 15:54:55 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> When unplugging a device, at one point the device will be destroyed
>> via object_unparent(). This will, one the one hand, unrealize the
>> device hierarchy to be removed, and on the other hand, destroy/free th=
e
>> device hierarchy.
>>
>> When chaining interrupt handlers, we want to overwrite a bus hotplug
>> handler by the machine hotplug handler, to be able to perform
>> some part of the plug/unplug and to forward the calls to the bus hotpl=
ug
>> handler.
>>
>> For now, the bus hotplug handler would trigger an object_unparent(), n=
ot
>> allowing us to perform some unplug action on a device after we forward=
ed
>> the call to the bus hotplug handler. The device would be gone at that
>> point.
>>
>> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>>     machine_unplug_handler(dev) {
>>         /* eventually do unplug stuff */
>>         bus_unplug_handler(dev) -> calls object_unparent(dev)
>>         /* dev is gone, we can't do more unplug stuff */
>>     }
>>
>> So move the object_unparent() to the original caller of the unplug. Fo=
r
>> now, keep the unrealize() at the original places of the
>> object_unparent().
>>
>> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>>     machine_unplug_handler(dev) {
>>         /* eventually do unplug stuff */
>>         bus_unplug_handler(dev) -> calls unrealize(dev)
>>         /* we can do more unplug stuff but device already unrealized *=
/
>>     }
>> object_unparent(dev)
>>
>> In the long run, every unplug action should be factored out of the
>> unrealize() function into the unplug handler (especially for PCI). The=
n
>> we can get rid of the additonal unrealize() calls and object_unparent(=
)
>> will properly unrealize the device hierarchy after the device has been
>> unplugged.
>>
>> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>>     machine_unplug_handler(dev) {
>>         /* eventually do unplug stuff */
>>         bus_unplug_handler(dev) -> only unplugs, does not unrealize
>>         /* we can do more unplug stuff */
>>     }
>> object_unparent(dev) -> will unrealize
>>
>>
>> The original approach was suggested by Igor Mammedov for the PCI
>> part, but I extended it to all hotplug handlers. I consider this one
>> step into the right direction.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> Sorry but I've lost track of all hotplug patches that where
> reviewed and pending form merge.
> Lets revisit this patch once those are merged to have a coherent
> view on how things stand.

At least from my side, there is only
 [PATCH v3 00/11] pci: hotplug handler reworks=E2=80=8B

--=20

Thanks,

David / dhildenb
