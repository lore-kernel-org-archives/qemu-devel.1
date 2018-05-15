Received: from eggs.gnu.org ([2001:4830:134:3::10]:35805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fISyY-0007GD-I7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fISyT-00070Y-MQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:58:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180511131953.12905-1-david@redhat.com>
	<20180511131953.12905-17-david@redhat.com>
	<20180511183405.GA19020@kermit-br-ibm-com>
	<20180511184356.GN13350@localhost.localdomain>
	<da24d0d8-2fde-989e-e760-ba853c5f9c80@redhat.com>
	<20180514230408.GA12837@kermit-br-ibm-com>
Date: Tue, 15 May 2018 07:58:09 +0200
In-Reply-To: <20180514230408.GA12837@kermit-br-ibm-com> (Murilo Opsfelder
	Araujo's message of "Mon, 14 May 2018 20:04:08 -0300")
Message-ID: <87po1xlatq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 16/17] s390x: initialize
 memory region for memory devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:

> On Sat, May 12, 2018 at 09:53:54AM +0200, David Hildenbrand wrote:
>> On 11.05.2018 20:43, Eduardo Habkost wrote:
>> > On Fri, May 11, 2018 at 03:34:05PM -0300, Murilo Opsfelder Araujo wrote:
>> >> On Fri, May 11, 2018 at 03:19:52PM +0200, David Hildenbrand wrote:
>> >>> While s390x has no real interface for communicating devices mapped into
>> >>> the physical address space of the guest, paravirtualized devices can
>> >>> easily expose the applicable address range themselves.
>> >>>
>> >>> So let's use the difference between maxram_size and ram_size as the size
>> >>> for our hotplug memory area (just as on other architectures).
>> >>>
>> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> >>> ---
>> >>>  hw/s390x/s390-virtio-ccw.c | 28 ++++++++++++++++++++++++++--
>> >>>  1 file changed, 26 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> >>> index ee0a2b124f..09b755282b 100644
>> >>> --- a/hw/s390x/s390-virtio-ccw.c
>> >>> +++ b/hw/s390x/s390-virtio-ccw.c
>> >>> @@ -157,9 +157,11 @@ static void virtio_ccw_register_hcalls(void)
>> >>>  #define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
>> >>>  #define SEG_MSK (~0xfffffULL)
>> >>>  #define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
>> >>> -static void s390_memory_init(ram_addr_t mem_size)
>> >>> +static void s390_memory_init(MachineState *machine)
>> >>>  {
>> >>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
>> >>>      MemoryRegion *sysmem = get_system_memory();
>> >>> +    ram_addr_t mem_size = machine->ram_size;
>> >>>      ram_addr_t chunk, offset = 0;
>> >>>      unsigned int number = 0;
>> >>>      gchar *name;
>> >>> @@ -181,6 +183,28 @@ static void s390_memory_init(ram_addr_t mem_size)
>> >>>      }
>> >>>      g_free(name);
>> >>>  
>> >>> +    /* always allocate the device memory information */
>> >>> +    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
>> >>
>> >> Is there any QEMU guideline/preference/recommendation in using g_new0
>> >> vs. g_malloc0?

Yes, there is: we prefer g_new(T, n) over g_malloc(sizeof(T) * n) even
when n==1.  Commit b45c03f585e explains:

    g_new(T, n) is neater than g_malloc(sizeof(T) * n).  It's also safer,
    for two reasons.  One, it catches multiplication overflowing size_t.
    Two, it returns T * rather than void *, which lets the compiler catch
    more type errors.

'One' doesn't apply when n==1.  'Two' does.

We're okay with things like T *v = g_malloc(sizeof(*v)).  Yes, 'two'
applies here as well, but screwups are relatively unlikely.

>> >> I recall Paolo suggesting g_new0 instead of g_malloc0 in another patch:
>> >>
>> >>   http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg02372.html
>> > 
>> 
>> This patch comes unmodified from my same queue, therefore the code looks
>> identical :)
>> 
>> > I don't see any reason to not use g_new0() instead of
>> > g_malloc0(sizeof(...)), as it's more readable.
>> 
>> I clearly favor g_malloc over g_new (except for arrays) for two simple
>> reasons
>> 
>> 1. No need to specify the type. Impossible to specify the wrong type.

Quite possible to specify the wrong size in other ways, and the type
checker can't save you then (that's 'two'), although Coverity might.

>> Easy to rename types.

Renaming a type is exactly as easy as renaming a variable or any other
identifer: you have to update all occurences.

>> 2. Every C developer should be able to understand what g_malloc() does.
>> This is not true for g_new. Especially as it might look strange for C++
>> developers (new vs. new[] - why don't we have g_new() vs. g_new_array())

I'm sympathetic of this argument in general, but not here.  g_malloc()
already differs from malloc(), and for good reasons.  Moreover, we use
g_new() all over the place; there's simply no way to avoid understanding
it.

>> I am a simple man, I prefer functions with one parameter if only one
>> parameter is needed :)

The second parameter is moderately ugly in the non-array case.  But then
GLib is full of ugly.  We'll live.

>> > But I don't think it's a problem that should block the patch from
>> > being merged.  We have hundreds of g_malloc*(sizeof(...)) calls
>> > in the tree.
>> 
>> I assume there are a lot of hard feelings about this. I will continue
>> using g_malloc() for scalars until the last user is removed from the
>> QEMU source code. Or there is a coding style statement about it (haven't
>> found one) ... or people start to curse me when I send patches :)
>
> Having g_malloc() for scalars and g_new() for arrays makes sense.

No.  Use g_new() with types, g_malloc() / g_malloc_n() with other
expressions.  When both are practical, consider preferring g_new() for
extra type checking.  Also consider readability.

> I understand and agree that using g_malloc() should not be a blocker for
> a patch, as Eduardo stated.

The assignment that triggered this sub-thread

    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));

is a matter of taste.  I'd prefer

    machine->device_memory = g_new0(DeviceMemoryState, 1);

myself, because I find it easier to read.  Giving the type checker the
actual type to work with is a nice bonus.

> Looking at the history, there are quite a few patches replacing
> g_malloc*() by g_new*() because "is safer against overflow" (see commit
> 071d4054770205ddb8a58a9e2735069d8fe52af1 as an example):
>
>     git log --oneline --grep=g_new
>
> Perhaps we just need to update "3. Low level memory management" section
> in HACKING file describing the situations where g_new() is preferred vs.
> g_malloc() and vice-versa; and use the agreed criteria to ack/nack
> patches.

We tend to update HACKING when we find ourselves debating the same
things over and over.  Perhaps this is such a case.
