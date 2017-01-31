Received: from eggs.gnu.org ([2001:4830:134:3::10]:33683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYdWK-00055m-IN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYdWJ-0003ZR-LN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:51:12 -0500
References: <1485880595-16376-1-git-send-email-thuth@redhat.com>
	<20170131103044.66316989@t450s.home>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5f0bafdc-6bb8-d936-e38c-5be92c46efc6@redhat.com>
Date: Tue, 31 Jan 2017 19:51:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170131103044.66316989@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/vfio: Add CONFIG switches for
 calxeda-xgmac and amd-xgbe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org

On 31.01.2017 18:30, Alex Williamson wrote:
> On Tue, 31 Jan 2017 17:36:35 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> Both devices seem to be specific to the ARM platform. It's confusing
>> for the users if they show up on other target architectures, too
>> (e.g. when the user runs QEMU with "-device ?" to get a list of
>> supported devices). Thus let's introduce proper configuration switches
>> so that the devices are only compiled and included when they are
>> really required.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak | 2 ++
>>  hw/vfio/Makefile.objs           | 4 ++--
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index 6de3e16..a78be51 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -94,6 +94,8 @@ CONFIG_VERSATILE_PCI=3Dy
>>  CONFIG_VERSATILE_I2C=3Dy
>> =20
>>  CONFIG_PCI_GENERIC=3Dy
>> +CONFIG_VFIO_XGMAC=3Dy
>> +CONFIG_VFIO_AMD_XGBE=3Dy
>> =20
>>  CONFIG_SDHCI=3Dy
>>  CONFIG_INTEGRATOR_DEBUG=3Dy
>> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
>> index c25e32b..05e7fbb 100644
>> --- a/hw/vfio/Makefile.objs
>> +++ b/hw/vfio/Makefile.objs
>> @@ -2,7 +2,7 @@ ifeq ($(CONFIG_LINUX), y)
>>  obj-$(CONFIG_SOFTMMU) +=3D common.o
>>  obj-$(CONFIG_PCI) +=3D pci.o pci-quirks.o
>>  obj-$(CONFIG_SOFTMMU) +=3D platform.o
>> -obj-$(CONFIG_SOFTMMU) +=3D calxeda-xgmac.o
>> -obj-$(CONFIG_SOFTMMU) +=3D amd-xgbe.o
>> +obj-$(CONFIG_VFIO_XGMAC) +=3D calxeda-xgmac.o
>> +obj-$(CONFIG_VFIO_AMD_XGBE) +=3D amd-xgbe.o
>>  obj-$(CONFIG_SOFTMMU) +=3D spapr.o
>>  endif
>=20
> I can't say that I fully agree that this is a good idea.  How many
> users are actually confused by this, versus the benefit of ensuring
> that it builds across all architectures?

Why do you want this to be build on all architectures? The devices are
only available on ARM as far as I know, so I can't see any real use for
this. And it slows down compilation time, too, if we compile it
everywhere (well, a little bit at least ;-)).

> Do we want to make platform also specific to ARM

I did not notice that one yet, since it does not show up in the "-device
?" help text (it's apparently an abstract device), so it also does not
really bother me.
But if I remove the device from the build, I get a funny error when I
try to view the device help text:

$ qemu-system-tricore -device ?
**
ERROR:/home/thuth/devel/qemu/qom/object.c:168:type_get_parent: assertion
failed: (type->parent_type !=3D NULL)
Aborted (core dumped)

So I guess we should rather keep that one for now.

> and spapr specific to ppc64?

I already tried that (with the already existing CONFIG_PSERIES), but the
code in common.c depends on the code in spapr.c, so it can't be removed
without reworking the code quite a bit. But spapr.c also does not really
bug me, since it does not register a type that shows up in the "-device
?" help text, so I think it is not worth the effort here.

 Thomas
