Received: from eggs.gnu.org ([209.51.188.92]:48188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjhmg-0003oS-5F
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjhmb-0005Hc-ND
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:46:52 -0500
References: <20190114103110.10909-1-david@redhat.com>
	<20190114103110.10909-5-david@redhat.com>
	<e897906c-9e69-16e2-9039-1e55fbac576e@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <97628b9a-7636-7cdd-1121-314c94f4008a@redhat.com>
Date: Wed, 16 Jan 2019 10:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <e897906c-9e69-16e2-9039-1e55fbac576e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] s390x/pci: Ignore the unplug call
 if we already have a release_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 15.01.19 23:53, Collin Walling wrote:
> On 1/14/19 5:31 AM, David Hildenbrand wrote:
>> ... otherwise two successive calls to qdev_unplug() (e.g. by an impati=
ent
>> user) will effectively overwrite pbdev->release_timer, resulting in a
>> memory leak. We are already processing the unplug.
>>
>=20
> Does QEMU not have a way to detect if a device is already in the proces=
s=20
> of being unplugged? Seems like not having that kind of protection could=
=20
> cause many problems.
>=20
> Perhaps that effort would be arduous.

No, there is no such thing. E.g. on some architectures it might even be
desirable to send multiple unplug requests to the guest. Say you want to
remove a DIMM. Could be that the guest cannot remove it right now, so it
NACKs the requests. Later you want to retry, so you send another
requests. This means we cannot really track pending unplug requests (and
might not even want to do so).

Regarding hotplug_handler_unplug(), the expectation is that once the
function returns without an error, the device was removed (or is ready
to be removed). So here, tracking a pending removal is not necessary.

See patch #5 where I properly convert what we have on s390x pci to
unplug requests.

>=20
>> If there is already a release_timer, the unplug will be performed afte=
r
>> the timeout.
>>
>> Can be easily triggered by
>> (hmp) device_add virtio-mouse-pci,id=3Dtest
>> (hmp) stop
>> (hmp) device_del test
>> (hmp) device_del test
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 59325cae3b..34a9cb2a80 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -972,6 +972,9 @@ static void s390_pcihost_unplug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>>       case ZPCI_FS_STANDBY:
>>           break;
>>       default:
>> +        if (pbdev->release_timer) {
>> +            return;
>> +        }
>>           s390_pci_generate_plug_event(HP_EVENT_DECONFIGURE_REQUEST,
>>                                        pbdev->fh, pbdev->fid);
>>           pbdev->release_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>
>=20
> Looks good to me.

Thanks!

>=20
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>=20


--=20

Thanks,

David / dhildenb
