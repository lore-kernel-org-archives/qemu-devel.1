Received: from eggs.gnu.org ([2001:4830:134:3::10]:47739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvTaI-0006Zr-0d
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvTaE-0006HT-14
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:25:58 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:54696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvTaD-0006F6-QK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:25:53 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 19A0C9E112
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 21:25:49 +0200 (CEST)
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
	<20170921185028.GK21016@localhost.localdomain>
	<d48ef387-dd66-727d-aa9e-b1786efd30e5@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bed91e4f-9422-2e50-5288-a8f153a6fd2d@kaod.org>
Date: Fri, 22 Sep 2017 21:25:31 +0200
MIME-Version: 1.0
In-Reply-To: <d48ef387-dd66-727d-aa9e-b1786efd30e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 09/22/2017 09:47 AM, Thomas Huth wrote:
> On 21.09.2017 20:50, Eduardo Habkost wrote:
>> On Tue, Sep 19, 2017 at 10:55:53AM +0200, Thomas Huth wrote:
>>> Historically we've marked all devices as hotpluggable by default. However,
>>> most devices are not hotpluggable, and you also need a HotplugHandler to
>>> support these devices. So if the user tries to "device_add" or "device_del"
>>> such a non-hotpluggable device during runtime, either nothing really usable
>>> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
>>> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
>>> So let's change this dangerous default behaviour and mark the devices as
>>> non-hotpluggable by default. Certain parent devices classes which are known
>>> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
>>> so that devices that are derived from these classes continue to work as
>>> expected.
>>
>> These seem to be missing:
>> * TYPE_CPU (or at least TYPE_X86_CPU and TYPE_S390_CPU)
>> * TYPE_VIRTIO_SERIAL_PORT
>> * TYPE_CCID_CARD
>> * TYPE_XENSYSDEV
> 
> Thanks for the detailed examination, Eduardo! I'll rework my patch
> accordingly...
> 
>> Also, I don't think we need to set it for TYPE_CPU_CORE, just for
>> TYPE_SPAPR_CPU_CORE.
> 
> Ok - you're likely right. There is one other consumer of TYPE_CPU_CORE
> beside spapr, which is the pnv machine, and as far as I can see, it does
> not support CPU hotplugging yet. So it indeed makes more sense to set
> this in TYPE_SPAPR_CPU_CORE only.

I don't think pnv will ever support CPU hotplugging. The HW platform 
doesn't but CPU hot unplugging should be as CPU can fail and that
is supported by the firmware and Linux.

But I guess the right decision for pnv now is to just not support
CPU hotplug.

Thanks,

C. 
