Received: from eggs.gnu.org ([2001:4830:134:3::10]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKsHB-0005Ey-RT
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dKsH7-0000xE-Sz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:18:57 -0400
References: <20170608172743.10132-1-lvivier@redhat.com>
	<20170608172743.10132-2-lvivier@redhat.com>
	<20170612143711.GK18542@umbus>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <655ad598-f23d-6f58-7f35-88d254551b10@redhat.com>
Date: Tue, 13 Jun 2017 22:18:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170612143711.GK18542@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: disable hotplugging without
 OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 12/06/2017 16:37, David Gibson wrote:
> On Thu, Jun 08, 2017 at 07:27:42PM +0200, Laurent Vivier wrote:
>> If the OS is not started, QEMU sends an event to the OS
>> that is lost and cannot be recovered. An unplug is not
>> able to restore QEMU in a coherent state.
>> So, while the OS is not started, disable CPU and memory hotplug.
>> We guess the OS is started if the CAS has been negotiated.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> It seems a pain to introduce a whole new (migrated) variable just to
> check this.  Could we instead tweak the allocation of spapr->ov5_cas,
> so it is NULL until CAS is completed?

I think it's a good idea to use ov5_cas, but we need to modify some
functions to manage the NULL pointer (spapr_ovec_test(),
spapr_ovec_populate_dt()), and I have some issues to manage the NULL
pointer in migration:

- with the previous releases, if it is NULL, we don't want to migrate it
because previous releases are not able to manage a NULL pointer, so we
don't migrate it (spapr_ov5_cas_needed() should be false if ov5_cas is
NULL) letting it to its default value (initialized but empty) in this
case on the destination,

- with the current version, if it is not NULL, we to want migrate it,
but the destination guest crashes because the pointer on the destination
is NULL and there is no memory the receive the data.

I think the problem is we can't migrate ov5_cas if it is not initialized
on the destination side[0]. Perhaps I've missed something but it seems a
NULL pointer can't be migrated and thus cannot be used as a state marker.

Any idea?

Thanks,
Laurent

[0] Perhaps we could use a VMSTATE_XXX() with a VMS_ALLOC flag instead
of VMSTATE_STRUCT_POINTER_V() to allocate the memory on the destination?
