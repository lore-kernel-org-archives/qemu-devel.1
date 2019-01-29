Received: from eggs.gnu.org ([209.51.188.92]:34564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goPNs-0000Hg-Fs
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goPNq-0005Of-Kh
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:08:44 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548689366-31916-1-git-send-email-thuth@redhat.com>
	<20190128170819.4998232d.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2e112213-373a-4b88-7dba-c5dbd58aba5b@redhat.com>
Date: Tue, 29 Jan 2019 10:08:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190128170819.4998232d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com, qemu-s390x@nongnu.org

On 2019-01-28 17:08, Cornelia Huck wrote:
> On Mon, 28 Jan 2019 16:29:26 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> Instead of hard-coding all config switches in the config file
>> default-configs/s390x-softmmu.mak, let's use the new Kconfig files
>> to express the necessary dependencies: The S390_CCW_VIRTIO config swit=
ch
>> for the "s390-ccw-virtio" machine now selects all non-optional devices=
.
>>
>> And since we already have the VIRTIO_PCI and VIRTIO_MMIO config switch=
es
>> for the other two virtio transports, this patch also introduces a new
>> config switch VIRTIO_CCW for the third, s390x-specific virtio transpor=
t,
>> so that all three virtio transports are now handled in the same way.
>=20
> I haven't found time to look at the Kconfig patches, so take the
> following with a generous amount of salt.
>=20
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  This goes on top of the curren Kconfig series:
>>
>>  Based-on: 1548410831-19553-1-git-send-email-pbonzini@redhat.com
>>
>>  default-configs/s390x-softmmu.mak | 12 ++++++++----
>>  hw/s390x/Kconfig                  |  4 ++++
>>  hw/s390x/Makefile.objs            |  2 +-
>>  hw/virtio/Kconfig                 |  4 ++++
>>  4 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x=
-softmmu.mak
>> index 2be5059..08b1683 100644
>> --- a/default-configs/s390x-softmmu.mak
>> +++ b/default-configs/s390x-softmmu.mak
>> @@ -1,9 +1,13 @@
>> -CONFIG_PCI=3Dy
>> +# Default configuration for s390x-softmmu
>> +
>> +# Optional devices:
>> +#
>>  CONFIG_VIRTIO_PCI=3Dy
>> -CONFIG_SCLPCONSOLE=3Dy
>>  CONFIG_TERMINAL3270=3Dy
>> -CONFIG_S390_FLIC=3Dy
>>  CONFIG_WDT_DIAG288=3Dy
>> -CONFIG_S390_CCW_VIRTIO=3Dy
>>  CONFIG_VFIO_CCW=3Dy
>>  CONFIG_VFIO_AP=3Dy
>=20
> This looks sensible.
>=20
>> +
>> +# Boards:
>> +#
>> +CONFIG_S390_CCW_VIRTIO=3Dy
>> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
>> index 303db7f..9a36c39 100644
>> --- a/hw/s390x/Kconfig
>> +++ b/hw/s390x/Kconfig
>> @@ -1,2 +1,6 @@
>>  config S390_CCW_VIRTIO
>>      bool
>> +    select PCI
>> +    select S390_FLIC
>> +    select SCLPCONSOLE
>> +    select VIRTIO_CCW
>=20
> This also makes sense. (I assume CONFIG_PCI, CONFIG_S390_FLIC, and
> CONFIG_SCLPCONSOLE are already defined in the base patch series.)

Yes, they are.

>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index a884aae..0dc798a 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -8,7 +8,7 @@ obj-y +=3D ipl.o
>>  obj-y +=3D css.o
>>  obj-y +=3D s390-virtio-ccw.o
>>  obj-y +=3D 3270-ccw.o
>=20
> Should this depend on TERMINAL3270 (at least in the future)?

Yes, this is related to TERMINAL3270 which is already used for
hw/char/terminal3270. So I think we could use $(CONFIG_TERMINAL3270)
here, too.

>> -obj-y +=3D virtio-ccw.o
>> +obj-$(CONFIG_VIRTIO_CCW) +=3D virtio-ccw.o
>>  obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-ccw-serial.o
>=20
> Hm. Should the individual device types depend both on VIRTIO_<device>
> and on VIRTIO_CCW? Making VIRTIO_<device> depend on VIRTIO_PCI ||
> VIRTIO_CCW || VIRTIO_MMIO is probably not enough, as we could be trying
> to build virtio-ccw devices if only VIRTIO_PCI is set (or virtio-pci
> devices if only VIRTIO_CCW is set, for that matter.)

You're right, the whole section should be fenced via

ifeq ($(CONFIG_VIRTIO_CCW),y)
...
endif

I'll update my patch accordingly and send a v2.

 Thanks,
  Thomas
