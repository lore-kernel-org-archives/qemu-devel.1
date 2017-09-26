Received: from eggs.gnu.org ([2001:4830:134:3::10]:55727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwg6e-0004c2-Lc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwg6b-0008Mg-Fx
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwg6b-0008Kv-6g
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:00:17 -0400
Date: Mon, 25 Sep 2017 23:59:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170926025956.GB4115@localhost.localdomain>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
	<20170925175944.GD3030@localhost.localdomain>
	<CAFEAcA_3SpWNm0FCviD5fXOFmxF1jGAwYgD_cZgwUMMAMn4BOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_3SpWNm0FCviD5fXOFmxF1jGAwYgD_cZgwUMMAMn4BOQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On Mon, Sep 25, 2017 at 07:05:26PM +0100, Peter Maydell wrote:
> On 25 September 2017 at 18:59, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Finding the full list of devices that can be instantiated
> > internally at hotplug-time sounds tricky.
> 
> If we just diff "list of devices marked hotplug before this patch"
> against "list of devices marked hotplug after this patch" how
> big is the list? Can we just eyeball it to see what needs
> to be specialcased?

So, the full list quite big, ~1800 device types are affected by
this patch:

https://gist.github.com/ehabkost/bd8e25c6811ac81d947ad8ad5b557f5c#file-dev-types-diff-json

If we ignore the "-cpu" classes, there ~640 affected device
types.

However, if we look only at the direct children of TYPE_DEVICE,
we have:

$ grep '"parent": "device"' dev-types-diff.json 
-{"return": {"abstract": true, "name": "adb-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "apic-common", "parent": "device", "user-creatable": false, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "aspeed-soc", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "aux-slave", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "adb-device", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "apic-common", "parent": "device", "user-creatable": false, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "aspeed-soc", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "aux-slave", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"abstract": true, "name": "ccid-card", "parent": "device", "user-creatable": true, "hotpluggable": true}}
 {"return": {"abstract": true, "name": "ccw-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "cpu-core", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "cpu", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "cpu-core", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "cpu", "parent": "device", "user-creatable": false, "hotpluggable": false}}
-{"return": {"abstract": true, "name": "hda-codec", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "i2c-slave", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "hda-codec", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "i2c-slave", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"abstract": true, "name": "ics-base", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "ide-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "ics-base", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "ide-device", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"abstract": true, "name": "ipack-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "ipmi-bmc", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "isa-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "ipack-device", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "ipmi-bmc", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "isa-device", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"abstract": true, "name": "pci-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "pcmcia-card", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "pcmcia-card", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"abstract": true, "name": "s390-sclp-event-type", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "s390-sclp-event-type", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"abstract": true, "name": "s390-skeys", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"abstract": true, "name": "s390-storage_attributes", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"abstract": true, "name": "scsi-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "spapr-dr-connector", "parent": "device", "user-creatable": false, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "ssi-slave", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "sys-bus-device", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "spapr-dr-connector", "parent": "device", "user-creatable": false, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "ssi-slave", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"abstract": true, "name": "sys-bus-device", "parent": "device", "user-creatable": false, "hotpluggable": false}}
 {"return": {"abstract": true, "name": "usb-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"abstract": true, "name": "vio-spapr-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "vio-spapr-device", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"abstract": true, "name": "virtio-device", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"abstract": true, "name": "virtio-device", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"abstract": true, "name": "virtio-serial-port", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"name": "allwinner-a10", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"name": "allwinner-a10", "parent": "device", "user-creatable": false, "hotpluggable": false}}
-{"return": {"name": "aux-to-i2c-bridge", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "aux-to-i2c-bridge", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"name": "diag288", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "digic", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"name": "digic", "parent": "device", "user-creatable": false, "hotpluggable": false}}
-{"return": {"name": "floppy", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"name": "fsl,imx25", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"name": "fsl,imx31", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"name": "fsl,imx6", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "floppy", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"name": "fsl,imx25", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"name": "fsl,imx31", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"name": "fsl,imx6", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "icp", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "icp", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "loader", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "loader", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "migration", "parent": "device", "user-creatable": false, "hotpluggable": true}}
-{"return": {"name": "mmio_interface", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"name": "migration", "parent": "device", "user-creatable": false, "hotpluggable": false}}
+{"return": {"name": "mmio_interface", "parent": "device", "user-creatable": false, "hotpluggable": false}}
-{"return": {"name": "nand", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "nand", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "or-irq", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"name": "or-irq", "parent": "device", "user-creatable": false, "hotpluggable": false}}
 {"return": {"name": "pc-dimm", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"name": "pnv-lpc", "parent": "device", "user-creatable": true, "hotpluggable": true}}
-{"return": {"name": "pnv-occ", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "pnv-lpc", "parent": "device", "user-creatable": true, "hotpluggable": false}}
+{"return": {"name": "pnv-occ", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "qemu,register", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"name": "qemu,register", "parent": "device", "user-creatable": false, "hotpluggable": false}}
-{"return": {"name": "s390-ipl", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"name": "s390-ipl", "parent": "device", "user-creatable": false, "hotpluggable": false}}
 {"return": {"name": "sclp", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "sd-card", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "sd-card", "parent": "device", "user-creatable": true, "hotpluggable": false}}
 {"return": {"name": "spapr-rng", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "spapr-rtc", "parent": "device", "user-creatable": false, "hotpluggable": true}}
-{"return": {"name": "spapr-tce-table", "parent": "device", "user-creatable": false, "hotpluggable": true}}
+{"return": {"name": "spapr-rtc", "parent": "device", "user-creatable": false, "hotpluggable": false}}
+{"return": {"name": "spapr-tce-table", "parent": "device", "user-creatable": false, "hotpluggable": false}}
 {"return": {"name": "vmgenid", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "xlnx,zynqmp", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "xlnx,zynqmp", "parent": "device", "user-creatable": true, "hotpluggable": false}}
-{"return": {"name": "zpci", "parent": "device", "user-creatable": true, "hotpluggable": true}}
+{"return": {"name": "zpci", "parent": "device", "user-creatable": true, "hotpluggable": false}}

-- 
Eduardo
