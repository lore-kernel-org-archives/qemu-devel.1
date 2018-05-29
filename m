Received: from eggs.gnu.org ([2001:4830:134:3::10]:43178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNg2b-0005nP-HX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNg2W-0007rF-U7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:56:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fNg2W-0007qQ-L4
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:55:56 -0400
Date: Tue, 29 May 2018 11:55:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180529145545.GB8988@localhost.localdomain>
References: <20180521181435.GN25013@localhost.localdomain>
	<ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
	<20180521202616.GT25013@localhost.localdomain>
	<874liyivcs.fsf@dusky.pond.sub.org>
	<20180523122749.GC8988@localhost.localdomain>
	<87d0xmcqrl.fsf@dusky.pond.sub.org>
	<20180524185727.GI8988@localhost.localdomain>
	<87y3g8w8kc.fsf@dusky.pond.sub.org>
	<20180525203044.GO8988@localhost.localdomain>
	<87efhwp7jp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efhwp7jp.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7 1/3] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, dgilbert@redhat.com

On Mon, May 28, 2018 at 09:23:54AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
[...]
> > [1] Doing a:
> >   $ git grep 'STR.*machine, "'
> > on libvirt source is enough to find some code demonstrating where
> > query-machines is already lacking today:
[...]
> How can we get from this grep to a list of static or dynamic machine
> type capabilties?

Let's look at the code:


$ git grep -W 'STR.*machine, "'
src/libxl/libxl_capabilities.c=libxlMakeDomainOSCaps(const char *machine,
src/libxl/libxl_capabilities.c-                      virDomainCapsOSPtr os,
src/libxl/libxl_capabilities.c-                      virFirmwarePtr *firmwares,
src/libxl/libxl_capabilities.c-                      size_t nfirmwares)
src/libxl/libxl_capabilities.c-{
src/libxl/libxl_capabilities.c-    virDomainCapsLoaderPtr capsLoader = &os->loader;
src/libxl/libxl_capabilities.c-    size_t i;
src/libxl/libxl_capabilities.c-
src/libxl/libxl_capabilities.c-    os->supported = true;
src/libxl/libxl_capabilities.c-
src/libxl/libxl_capabilities.c:    if (STREQ(machine, "xenpv"))
src/libxl/libxl_capabilities.c-        return 0;

I don't understand why this one is here, but we can find out what
we could add to query-machines to make this unnecessary.


[...]
--
src/libxl/libxl_capabilities.c=libxlMakeDomainCapabilities(virDomainCapsPtr domCaps,
src/libxl/libxl_capabilities.c-                            virFirmwarePtr *firmwares,
src/libxl/libxl_capabilities.c-                            size_t nfirmwares)
src/libxl/libxl_capabilities.c-{
src/libxl/libxl_capabilities.c-    virDomainCapsOSPtr os = &domCaps->os;
src/libxl/libxl_capabilities.c-    virDomainCapsDeviceDiskPtr disk = &domCaps->disk;
src/libxl/libxl_capabilities.c-    virDomainCapsDeviceGraphicsPtr graphics = &domCaps->graphics;
src/libxl/libxl_capabilities.c-    virDomainCapsDeviceVideoPtr video = &domCaps->video;
src/libxl/libxl_capabilities.c-    virDomainCapsDeviceHostdevPtr hostdev = &domCaps->hostdev;
src/libxl/libxl_capabilities.c-
src/libxl/libxl_capabilities.c:    if (STREQ(domCaps->machine, "xenfv"))
src/libxl/libxl_capabilities.c-        domCaps->maxvcpus = HVM_MAX_VCPUS;
src/libxl/libxl_capabilities.c-    else
src/libxl/libxl_capabilities.c-        domCaps->maxvcpus = PV_MAX_VCPUS;

Looks like libvirt isn't using MachineInfo::cpu-max.  libvirt
bug, or workaround for QEMU limitation?


[...]
--
src/libxl/libxl_driver.c=libxlConnectGetDomainCapabilities(virConnectPtr conn,
src/libxl/libxl_driver.c-                                  const char *emulatorbin,
src/libxl/libxl_driver.c-                                  const char *arch_str,
src/libxl/libxl_driver.c-                                  const char *machine,
src/libxl/libxl_driver.c-                                  const char *virttype_str,
src/libxl/libxl_driver.c-                                  unsigned int flags)
src/libxl/libxl_driver.c-{
[...]
src/libxl/libxl_driver.c-    if (machine) {
src/libxl/libxl_driver.c:        if (STRNEQ(machine, "xenpv") && STRNEQ(machine, "xenfv")) {
src/libxl/libxl_driver.c-            virReportError(VIR_ERR_INVALID_ARG, "%s",
src/libxl/libxl_driver.c-                           _("Xen only supports 'xenpv' and 'xenfv' machines"));


Not sure if this should be encoded in QEMU.  accel=xen works with
other PC machines, doesn't it?


[...]
--
src/qemu/qemu_capabilities.c=bool virQEMUCapsHasPCIMultiBus(virQEMUCapsPtr qemuCaps,
src/qemu/qemu_capabilities.c-                               const virDomainDef *def)
src/qemu/qemu_capabilities.c-{
src/qemu/qemu_capabilities.c-    /* x86_64 and i686 support PCI-multibus on all machine types
src/qemu/qemu_capabilities.c-     * since forever */
src/qemu/qemu_capabilities.c-    if (ARCH_IS_X86(def->os.arch))
src/qemu/qemu_capabilities.c-        return true;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-    if (def->os.arch == VIR_ARCH_PPC ||
src/qemu/qemu_capabilities.c-        ARCH_IS_PPC64(def->os.arch)) {
src/qemu/qemu_capabilities.c-        /*
src/qemu/qemu_capabilities.c-         * Usage of pci.0 naming:
src/qemu/qemu_capabilities.c-         *
src/qemu/qemu_capabilities.c-         *    ref405ep: no pci
src/qemu/qemu_capabilities.c-         *       taihu: no pci
src/qemu/qemu_capabilities.c-         *      bamboo: 1.1.0
src/qemu/qemu_capabilities.c-         *       mac99: 2.0.0
src/qemu/qemu_capabilities.c-         *     g3beige: 2.0.0
src/qemu/qemu_capabilities.c-         *        prep: 1.4.0
src/qemu/qemu_capabilities.c-         *     pseries: 2.0.0
src/qemu/qemu_capabilities.c-         *   mpc8544ds: forever
src/qemu/qemu_capabilities.c-         * virtex-m507: no pci
src/qemu/qemu_capabilities.c-         *     ppce500: 1.6.0
src/qemu/qemu_capabilities.c-         */
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-        /* We do not store the qemu version in domain status XML.
src/qemu/qemu_capabilities.c-         * Hope the user is using a QEMU new enough to use 'pci.0',
src/qemu/qemu_capabilities.c-         * otherwise the results of this function will be wrong
src/qemu/qemu_capabilities.c-         * for domains already running at the time of daemon
src/qemu/qemu_capabilities.c-         * restart */
src/qemu/qemu_capabilities.c-        if (qemuCaps->version == 0)
src/qemu/qemu_capabilities.c-            return true;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-        if (qemuCaps->version >= 2000000)
src/qemu/qemu_capabilities.c-            return true;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-        if (qemuCaps->version >= 1006000 &&
src/qemu/qemu_capabilities.c:            STREQ(def->os.machine, "ppce500"))
src/qemu/qemu_capabilities.c-            return true;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-        if (qemuCaps->version >= 1004000 &&
src/qemu/qemu_capabilities.c:            STREQ(def->os.machine, "prep"))
src/qemu/qemu_capabilities.c-            return true;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-        if (qemuCaps->version >= 1001000 &&
src/qemu/qemu_capabilities.c:            STREQ(def->os.machine, "bamboo"))
src/qemu/qemu_capabilities.c-            return true;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c:        if (STREQ(def->os.machine, "mpc8544ds"))
src/qemu/qemu_capabilities.c-            return true;

This is due to the lack of bus information on query-machines.


[...]
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-        return false;
src/qemu/qemu_capabilities.c-    }
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-    /* If 'virt' supports PCI, it supports multibus.
src/qemu/qemu_capabilities.c-     * No extra conditions here for simplicity.
src/qemu/qemu_capabilities.c-     */
src/qemu/qemu_capabilities.c-    if (qemuDomainIsVirt(def))
src/qemu/qemu_capabilities.c-        return true;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-    return false;
src/qemu/qemu_capabilities.c-}
--
src/qemu/qemu_capabilities.c=virQEMUCapsSupportsVmport(virQEMUCapsPtr qemuCaps,
src/qemu/qemu_capabilities.c-                          const virDomainDef *def)
src/qemu/qemu_capabilities.c-{
src/qemu/qemu_capabilities.c-    if (!virQEMUCapsGet(qemuCaps, QEMU_CAPS_MACHINE_VMPORT_OPT))
src/qemu/qemu_capabilities.c-        return false;
src/qemu/qemu_capabilities.c-
src/qemu/qemu_capabilities.c-    return qemuDomainIsI440FX(def) ||
src/qemu/qemu_capabilities.c-        qemuDomainIsQ35(def) ||
src/qemu/qemu_capabilities.c:        STREQ(def->os.machine, "isapc");
src/qemu/qemu_capabilities.c-}

Lack of bus information on query-machines?


--
src/qemu/qemu_command.c=qemuBuildMemballoonCommandLine(virCommandPtr cmd,
src/qemu/qemu_command.c-                               const virDomainDef *def,
src/qemu/qemu_command.c-                               virQEMUCapsPtr qemuCaps)
src/qemu/qemu_command.c-{
src/qemu/qemu_command.c-    virBuffer buf = VIR_BUFFER_INITIALIZER;
src/qemu/qemu_command.c-
src/qemu/qemu_command.c:    if (STRPREFIX(def->os.machine, "s390-virtio") &&
src/qemu/qemu_command.c-        virQEMUCapsGet(qemuCaps, QEMU_CAPS_VIRTIO_S390) && def->memballoon)
src/qemu/qemu_command.c-        def->memballoon->model = VIR_DOMAIN_MEMBALLOON_MODEL_NONE;


Lack of bus information on query-machines?


[...]
--
src/qemu/qemu_domain.c=qemuDomainDefAddDefaultDevices(virDomainDefPtr def,
src/qemu/qemu_domain.c-                               virQEMUCapsPtr qemuCaps)
src/qemu/qemu_domain.c-{
[...]
src/qemu/qemu_domain.c:        if (STREQ(def->os.machine, "isapc")) {
src/qemu/qemu_domain.c-            addDefaultUSB = false;


Lack of bus/defaults information on query-machines?

This whole function is a collection of cases where
bus/device/defaults information is missing on query-machines:

src/qemu/qemu_domain.c-            break;
src/qemu/qemu_domain.c-        }
src/qemu/qemu_domain.c-        if (qemuDomainIsQ35(def)) {
src/qemu/qemu_domain.c-            addPCIeRoot = true;
src/qemu/qemu_domain.c-            addImplicitSATA = true;
[...]
src/qemu/qemu_domain.c-        if (qemuDomainIsI440FX(def))
src/qemu/qemu_domain.c-            addPCIRoot = true;
[...]
src/qemu/qemu_domain.c-        break;
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-    case VIR_ARCH_ARMV7L:
src/qemu/qemu_domain.c-    case VIR_ARCH_AARCH64:
src/qemu/qemu_domain.c-        addDefaultUSB = false;
src/qemu/qemu_domain.c-        addDefaultMemballoon = false;
src/qemu/qemu_domain.c-        if (qemuDomainIsVirt(def))
src/qemu/qemu_domain.c-            addPCIeRoot = virQEMUCapsGet(qemuCaps, QEMU_CAPS_OBJECT_GPEX);
src/qemu/qemu_domain.c-        break;
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-    case VIR_ARCH_PPC64:
src/qemu/qemu_domain.c-    case VIR_ARCH_PPC64LE:
src/qemu/qemu_domain.c-        addPCIRoot = true;
src/qemu/qemu_domain.c-        addDefaultUSBKBD = true;
src/qemu/qemu_domain.c-        addDefaultUSBMouse = true;
src/qemu/qemu_domain.c-        /* For pSeries guests, the firmware provides the same
src/qemu/qemu_domain.c-         * functionality as the pvpanic device, so automatically
src/qemu/qemu_domain.c-         * add the definition if not already present */
src/qemu/qemu_domain.c-        if (qemuDomainIsPSeries(def))
src/qemu/qemu_domain.c-            addPanicDevice = true;
src/qemu/qemu_domain.c-        break;
[...]
--
src/qemu/qemu_domain.c=qemuDomainDefaultNetModel(const virDomainDef *def,
src/qemu/qemu_domain.c-                          virQEMUCapsPtr qemuCaps)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c-    if (ARCH_IS_S390(def->os.arch))
src/qemu/qemu_domain.c-        return "virtio";
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-    if (def->os.arch == VIR_ARCH_ARMV7L ||
src/qemu/qemu_domain.c-        def->os.arch == VIR_ARCH_AARCH64) {
src/qemu/qemu_domain.c:        if (STREQ(def->os.machine, "versatilepb"))
src/qemu/qemu_domain.c-            return "smc91c111";
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-        if (qemuDomainIsVirt(def))
src/qemu/qemu_domain.c-            return "virtio";
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-        /* Incomplete. vexpress (and a few others) use this, but not all
src/qemu/qemu_domain.c-         * arm boards */
src/qemu/qemu_domain.c-        return "lan9118";


Lack of bus/defaults information on query-machines?

[...]
--
src/qemu/qemu_domain.c=qemuDomainMachineIsQ35(const char *machine)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c:    return (STRPREFIX(machine, "pc-q35") ||
src/qemu/qemu_domain.c:            STREQ(machine, "q35"));
src/qemu/qemu_domain.c-}

Need to grep for callers of this function.

--
src/qemu/qemu_domain.c=qemuDomainMachineIsI440FX(const char *machine)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c:    return (STREQ(machine, "pc") ||
src/qemu/qemu_domain.c:            STRPREFIX(machine, "pc-0.") ||
src/qemu/qemu_domain.c:            STRPREFIX(machine, "pc-1.") ||
src/qemu/qemu_domain.c:            STRPREFIX(machine, "pc-i440") ||
src/qemu/qemu_domain.c:            STRPREFIX(machine, "rhel"));
src/qemu/qemu_domain.c-}

Need to grep for callers of this function.

---
src/qemu/qemu_domain.c=qemuDomainMachineNeedsFDC(const char *machine)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c:    const char *p = STRSKIP(machine, "pc-q35-");
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-    if (p) {
src/qemu/qemu_domain.c-        if (STRPREFIX(p, "1.") ||
src/qemu/qemu_domain.c-            STRPREFIX(p, "2.0") ||
src/qemu/qemu_domain.c-            STRPREFIX(p, "2.1") ||
src/qemu/qemu_domain.c-            STRPREFIX(p, "2.2") ||
src/qemu/qemu_domain.c-            STRPREFIX(p, "2.3"))
src/qemu/qemu_domain.c-            return false;
src/qemu/qemu_domain.c-        return true;
src/qemu/qemu_domain.c-    }
src/qemu/qemu_domain.c-    return false;
src/qemu/qemu_domain.c-}

Lack of bus/defaults information on query-machines.


--
src/qemu/qemu_domain.c=qemuDomainMachineIsS390CCW(const char *machine)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c:    return STRPREFIX(machine, "s390-ccw");
src/qemu/qemu_domain.c-}

Need to grep for callers of this function.


--
src/qemu/qemu_domain.c=qemuDomainMachineIsVirt(const char *machine,
src/qemu/qemu_domain.c-                        const virArch arch)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c-    if (arch != VIR_ARCH_ARMV7L &&
src/qemu/qemu_domain.c-        arch != VIR_ARCH_AARCH64)
src/qemu/qemu_domain.c-        return false;
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c:    if (STRNEQ(machine, "virt") &&
src/qemu/qemu_domain.c:        !STRPREFIX(machine, "virt-"))
src/qemu/qemu_domain.c-        return false;
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-    return true;
src/qemu/qemu_domain.c-}

Need to grep for callers of this function.

--
src/qemu/qemu_domain.c=qemuDomainMachineIsPSeries(const char *machine,
src/qemu/qemu_domain.c-                           const virArch arch)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c-    if (!ARCH_IS_PPC64(arch))
src/qemu/qemu_domain.c-        return false;
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c:    if (STRNEQ(machine, "pseries") &&
src/qemu/qemu_domain.c:        !STRPREFIX(machine, "pseries-"))
src/qemu/qemu_domain.c-        return false;
src/qemu/qemu_domain.c-
src/qemu/qemu_domain.c-    return true;
src/qemu/qemu_domain.c-}

Need to grep for callers of this function.


--
src/qemu/qemu_domain.c=qemuDomainMachineHasBuiltinIDE(const char *machine)
src/qemu/qemu_domain.c-{
src/qemu/qemu_domain.c-    return qemuDomainMachineIsI440FX(machine) ||
src/qemu/qemu_domain.c:        STREQ(machine, "malta") ||
src/qemu/qemu_domain.c:        STREQ(machine, "sun4u") ||
src/qemu/qemu_domain.c:        STREQ(machine, "g3beige");
src/qemu/qemu_domain.c-}

Lack of bus/defaults information on query-machines.


[...]
--
src/qemu/qemu_domain_address.c=qemuDomainAssignARMVirtioMMIOAddresses(virDomainDefPtr def,
src/qemu/qemu_domain_address.c-                                       virQEMUCapsPtr qemuCaps)
src/qemu/qemu_domain_address.c-{
src/qemu/qemu_domain_address.c-    if (def->os.arch != VIR_ARCH_ARMV7L &&
src/qemu/qemu_domain_address.c-        def->os.arch != VIR_ARCH_AARCH64)
src/qemu/qemu_domain_address.c-        return;
src/qemu/qemu_domain_address.c-
src/qemu/qemu_domain_address.c:    if (!(STRPREFIX(def->os.machine, "vexpress-") ||
src/qemu/qemu_domain_address.c-          qemuDomainIsVirt(def)))
src/qemu/qemu_domain_address.c-        return;

Lack of bus/device/defaults information on query-machines?

[...]
--
src/qemu/qemu_domain_address.c=qemuDomainSupportsPCI(virDomainDefPtr def,
src/qemu/qemu_domain_address.c-                      virQEMUCapsPtr qemuCaps)
src/qemu/qemu_domain_address.c-{
src/qemu/qemu_domain_address.c-    if ((def->os.arch != VIR_ARCH_ARMV7L) && (def->os.arch != VIR_ARCH_AARCH64))
src/qemu/qemu_domain_address.c-        return true;
src/qemu/qemu_domain_address.c-
src/qemu/qemu_domain_address.c:    if (STREQ(def->os.machine, "versatilepb"))
src/qemu/qemu_domain_address.c-        return true;
src/qemu/qemu_domain_address.c-
src/qemu/qemu_domain_address.c-    if (qemuDomainIsVirt(def) &&
src/qemu/qemu_domain_address.c-        virQEMUCapsGet(qemuCaps, QEMU_CAPS_OBJECT_GPEX))
src/qemu/qemu_domain_address.c-        return true;
src/qemu/qemu_domain_address.c-

Lack of bus information on query-machines.

[...]

-- 
Eduardo
