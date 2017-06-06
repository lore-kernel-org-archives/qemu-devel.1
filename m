Received: from eggs.gnu.org ([2001:4830:134:3::10]:43974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIHHh-0006bz-QN
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIHHe-0001Eq-Kf
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:24:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIHHe-0001Ed-CI
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:24:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1496746390.git.maozy.fnst@cn.fujitsu.com>
	<3579e47c4bb41476406e26685292aaa9153fcc77.1496746391.git.maozy.fnst@cn.fujitsu.com>
	<20170606145250.GG5016@thinpad.lan.raisama.net>
Date: Tue, 06 Jun 2017 18:24:26 +0200
In-Reply-To: <20170606145250.GG5016@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Tue, 6 Jun 2017 11:52:50 -0300")
Message-ID: <8760g9jd8l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/7] pci: Make errp the last parameter
 of pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, marcel@redhat.com, alex.williamson@redhat.com, dmitry@daynix.com, pbonzini@redhat.com, rth@twiddle.net

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Jun 06, 2017 at 07:26:30PM +0800, Mao Zhongyi wrote:
>> Add Error argument for pci_add_capability() to leverage the errp
>> to pass info on errors. This way is helpful for its callers to
>> make a better error handling when moving to 'realize'.
>> 
>> Cc: pbonzini@redhat.com
>> Cc: rth@twiddle.net
>> Cc: ehabkost@redhat.com
>> Cc: mst@redhat.com
>> CC: dmitry@daynix.com
>> Cc: jasowang@redhat.com
>> Cc: marcel@redhat.com
>> Cc: alex.williamson@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  hw/i386/amd_iommu.c       | 24 +++++++++++++++++-------
>>  hw/net/e1000e.c           |  7 ++++++-
>>  hw/net/eepro100.c         | 20 +++++++++++++++-----
>>  hw/pci-bridge/i82801b11.c |  1 +
>>  hw/pci/pci.c              | 10 ++++------
>>  hw/pci/pci_bridge.c       |  7 ++++++-
>>  hw/pci/pcie.c             | 10 ++++++++--
>>  hw/pci/shpc.c             |  5 ++++-
>>  hw/pci/slotid_cap.c       |  7 ++++++-
>>  hw/vfio/pci.c             |  3 ++-
>>  hw/virtio/virtio-pci.c    | 19 ++++++++++++++-----
>>  include/hw/pci/pci.h      |  3 ++-
>>  12 files changed, 85 insertions(+), 31 deletions(-)
>
>
> There are multiple places below that checks for errors like this:
>
>     function(...);
>     if (function succeeded) {
>        /* non-error code path here */
>        foo = bar;
>     }
>
> Sometimes it even includes another branch for the error path:
>
>     function(...);
>     if (function succeeded) {
>        /* non-error code path here */
>        foo = bar;
>     } else {
>        /* error path here */
>        return ret;
>     }
>
> I suggest doing this instead, for readability:
>
>     function(...)
>     if (function failed) {
>        return ...;  /* or: "goto out" */
>     }
>
>     /* non-error code path here */
>     foo = bar;

Yes, please.

>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 7b6d4ea..d93ffc2 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1158,13 +1158,23 @@ static void amdvi_realize(DeviceState *dev, Error **err)
>>      x86_iommu->type = TYPE_AMD;
>>      qdev_set_parent_bus(DEVICE(&s->pci), &bus->qbus);
>>      object_property_set_bool(OBJECT(&s->pci), true, "realized", err);
>> -    s->capab_offset = pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
>> -                                         AMDVI_CAPAB_SIZE);
>> -    assert(s->capab_offset > 0);
>> -    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_MSI, 0, AMDVI_CAPAB_REG_SIZE);
>> -    assert(ret > 0);
>> -    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_HT, 0, AMDVI_CAPAB_REG_SIZE);
>> -    assert(ret > 0);
>> +    ret = pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
>> +                                         AMDVI_CAPAB_SIZE, err);
>> +    if (ret < 0) {
>> +        return;
>
> Maybe adding a local_err variable is preferred instead of
> checking for (pos < 0), but I'm not sure it's necessary.
>
> Markus, what's the recommendation on those cases?  Should we use
> the negative return value to avoid adding an extra local_err
> variable, or should we add local_err anyway to match the existing
> style elsewhere?

Opinions and practice vary on this one.

I prefer checking the return value because it lets me avoid the
error_propagate() boiler-plate more often.

Having both an Error parameter and an error return value poses the
question whether the two agree.

You can assert they do, but it's distracting.  We generally don't.

When there's no success value to transmit, you avoid the problem by
making the function return void.  We used to favor that, but it has
turned out not to be a success, because it leads to cumbersome code.
For what it's worth, GLib wants you to transmit success / failure in the
return value, too:

https://developer.gnome.org/glib/unstable/glib-Error-Reporting.html#gerror-rules

[...]
