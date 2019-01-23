Received: from eggs.gnu.org ([209.51.188.92]:39897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmFq0-0007Bb-Gw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmFpz-0007g3-DM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:32:52 -0500
References: <20190122125133.1191-1-david@redhat.com>
	<20190122125133.1191-2-david@redhat.com>
	<533d81b9-5d85-d441-7900-c8bb10ee4b8a@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <77fffbf2-f1c2-ad74-db3e-28fb8856fc1d@redhat.com>
Date: Wed, 23 Jan 2019 11:32:48 +0100
MIME-Version: 1.0
In-Reply-To: <533d81b9-5d85-d441-7900-c8bb10ee4b8a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] s390x/pci: Fix primary bus number
 for PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23.01.19 11:26, Thomas Huth wrote:
> On 2019-01-22 13:51, David Hildenbrand wrote:
>> The primary bus number corresponds always to the bus number of the
>> bus the bridge is attached to.
>>
>> Right now, if we have two bridges attached to the same bus (e.g. root
>> bus) this is however not the case. Fix assignment.
>>
>> While at it
>> - Add a comment why we have to reassign durign every reset (which I
> 
> s/durign/during/
> 
>>   found to be supprising)
> 
> s/supprising/surprising/
> 
>> - Drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff. As we are
>>   setting it via a DFS and not via a BFS (as discussed e.g. in [1]), this
>>   is not necessary. The last number when we return is the highest
>>   number.
> 
> I think that explanation is slightly wrong / misleading. It's not about
> DFS vs. BFS, it's about guest code vs. QEMU code. If you do a bridge
> setup from the guest side, you've got to set the subordinate bus number
> to 0xff to make sure that the bridge forwards all config space accesses
> to the attached devices while you're scanning the devices that are
> attached to the bridge.
> But this code is not running in the guest, it is running in QEMU, and so
> it can access the config space of the attached devices directly via
> pci_default_write_config() - the write do not need to pass the parent
> bridge in this case, and thus the subordinate bus number in the bridge
> is ignored for the config space write access.

Indeed, I phrased that better in the spapr/pci patch I sent, What about
this:

"
The primary bus number corresponds always to the bus number of the
bus the bridge is attached to.

Right now, if we have two bridges attached to the same bus (e.g. root
bus) this is however not the case. The first bridge will have primary
bus 0, the second bridge primary bus 1, which is wrong. Fix the assignment.

While at it, drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff.
Setting it temporarily to that value (as discussed e.g. in [1]), is
only relevant for a running system that probes the buses. The value is
effectively unused for us just doing a DFS.

Also add a comment why we have to reassign during every reset (which I
found to be surprising.

Please note that hotplugging of bridges is in general still broken, will
be fixed next.
"

> 
>> Please note that hotplugging of bridges is in general still broken, will
>> be fixed next.
>>
>> [1] http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-pci-bus.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> With the commit message fixed:

@Conny can you fix up when applying if there are no other comments?

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks Thomas!


-- 

Thanks,

David / dhildenb
