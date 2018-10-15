Received: from eggs.gnu.org ([2001:4830:134:3::10]:34995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gBzSV-0000MF-Gk
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gBzST-000568-4c
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gBzSR-00053p-Tz
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:46:40 -0400
Date: Mon, 15 Oct 2018 11:45:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181015114556.152d89cd.cohuck@redhat.com>
In-Reply-To: <20181013025435.25785-1-ehabkost@redhat.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

On Fri, 12 Oct 2018 23:54:35 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The current virtio-*-pci device types actually represent 3
> different types of devices:
> * virtio 1.0 non-transitional devices
> * virtio 1.0 transitional devices
> * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> 
> That would be just an annoyance if it didn't break our device/bus
> compatibility QMP interfaces.  With this multi-purpose device
> type, there's no way to tell management software that
> transitional devices and legacy devices require a Conventional
> PCI bus.
> 
> The multi-purpose device types would also prevent us from telling
> management software what's the PCI vendor/device ID for them,
> because their PCI IDs change at runtime depending on the bus
> where they were is plugged.
> 
> This patch adds separate device types for each of those virtio
> device flavors:
> 
> - virtio-*-pci: the existing multi-purpose device types
>   - Configurable using `disable-legacy` and `disable-modern`
>     properties
>   - Legacy driver support is automatically enabled/disabled
>     depending on the bus where it is plugged
>   - Supports Conventional PCI and PCI Express buses
>     (but Conventional PCI is incompatible with
>     disable-legacy=off)
>   - Changes PCI vendor/device IDs at runtime
> - virtio-*-pci-0.9: legacy virtio device
>   - Supports Conventional PCI buses only, because
>     it has a PIO BAR
> - virtio-*-pci-1.0-transitional: virtio-1.0 device supporting legacy drivers
>   - Supports Conventional PCI buses only, because
>     it has a PIO BAR
> - virtio-*-pci-1.0: modern-only
>   - Supports both Conventional PCI and PCI Express buses
> 
> All the types above will inherit from an abstract
> "virtio-*-pci-base" type, so existing code that doesn't care
> about the virtio version can use "virtio-*-pci-base" on type
> casts.

I get a crash when running 'make check'; might be missing a change to
virtio-input-host?

TEST: tests/device-introspect-test... (pid=28626)
  /s390x/device/introspect/list:                                       OK
  /s390x/device/introspect/list-fields:                                OK
  /s390x/device/introspect/none:                                       OK
  /s390x/device/introspect/abstract:                                   OK
  /s390x/device/introspect/abstract-interfaces:                        OK
  /s390x/device/introspect/concrete/defaults/none:                     /home/cohuck/git/qemu/hw/virtio/virtio-pci.c:2730:virtio_host_initfn: Object 0x5633a43a1480 is not an instance of type virtio-input-host-device-base
Broken pipe
/home/cohuck/git/qemu/tests/libqtest.c:125: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)

(...)
#2  0x00005633a2e92555 in object_dynamic_cast_assert (obj=0x5633a43a1480, 
    typename=0x5633a30a295c "virtio-input-host-device-base", 
    file=0x5633a30a2152 "/home/cohuck/git/qemu/hw/virtio/virtio-pci.c", 
    line=2730, func=0x5633a30a297a "virtio_host_initfn")
    at /home/cohuck/git/qemu/qom/object.c:702
#3  0x00005633a2e30fa3 in virtio_host_initfn (obj=0x5633a43a1480)
    at /home/cohuck/git/qemu/hw/virtio/virtio-pci.c:2730
#4  0x00005633a2e966a2 in object_init_with_type (obj=0x5633a43a1480, 
    ti=0x5633a42eb990) at /home/cohuck/git/qemu/qom/object.c:356
#5  0x00005633a2e91433 in object_initialize_with_type (data=0x5633a43a1480, 
    size=33632, type=0x5633a42eb990) at /home/cohuck/git/qemu/qom/object.c:391
#6  0x00005633a2e91db8 in object_new_with_type (type=<optimized out>)
    at /home/cohuck/git/qemu/qom/object.c:553
#7  object_new (typename=<optimized out>)
    at /home/cohuck/git/qemu/qom/object.c:563
#8  0x00005633a2dbfc49 in qmp_device_list_properties (
    typename=0x5633a437cb40 "virtio-input-host-pci-1.0-transitional", 
    errp=0x7ffd66276010) at /home/cohuck/git/qemu/qmp.c:513
(...)

> 
> A simple test script (tests/acceptance/virtio_version.py) is
> included, to check if the new device types are equivalent to
> using the `disable-legacy` and `disable-modern` options.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Reference to previous discussion that originated this idea:
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg558389.html
> ---
>  hw/virtio/virtio-pci.h             |  93 +++++++++---
>  hw/display/virtio-gpu-pci.c        |   8 +-
>  hw/display/virtio-vga.c            |  11 +-
>  hw/virtio/virtio-crypto-pci.c      |   8 +-
>  hw/virtio/virtio-pci.c             | 225 +++++++++++++++++++++--------
>  tests/acceptance/virtio_version.py | 138 ++++++++++++++++++
>  6 files changed, 390 insertions(+), 93 deletions(-)
>  create mode 100644 tests/acceptance/virtio_version.py

The approach makes sense to me, but I second the suggestion to use
something like 'modern' (or 'standard'?) instead of '1.0'.

Also, before someone asks: I don't think we need something like that
for virtio-ccw, as we (a) only support fencing newer revisions, not
older ones, and (b) the implications of using different virtio
revisions are localized to virtio-ccw only and do not have further
implications as for virtio-pci.
