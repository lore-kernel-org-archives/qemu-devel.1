Received: from eggs.gnu.org ([2001:4830:134:3::10]:57792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dheRl-0008Ec-Ms
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dheRh-0002wv-9J
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:12:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dheRh-0002wT-07
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:11:57 -0400
Date: Tue, 15 Aug 2017 18:11:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170815181147.3e50a711@nial.brq.redhat.com>
In-Reply-To: <CAPHE7Nrr9Y-F37PWS=rTS5hak09-_3v_R-T7KG+zQuy2L8U0jg@mail.gmail.com>
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<20170728121044.15488-3-vadim.galitsyn@profitbricks.com>
	<20170815095114.014299c2@nial.brq.redhat.com>
	<CAPHE7Nrr9Y-F37PWS=rTS5hak09-_3v_R-T7KG+zQuy2L8U0jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/3] qmp: introduce
 query-memory-size-summary command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

On Tue, 15 Aug 2017 17:43:00 +0200
Vadim Galitsyn <vadim.galitsyn@profitbricks.com> wrote:

> Hi Guys,
> 
> Thank you for the input!
> 
> > "hotunpluggable" is ugly.  What about just "pluggable"?  
> 
> Markus, I think "pluggable" is a bit misleading here. Some people can take
> it like a maximum amount of memory that can be hot-added to a guest (i.e.,
> difference between static memory size and value specified with "-m
> ...,maxmem=XXX"). I would say:
> 
>   mem_info->plugged_memory = get_plugged_memory_size();
> 
> ..since it reflects actual amount which was already hot-added. Agree?
> 
> > this could be done without wrapper  
> 
> Igor, your approach changes command behaviour a little. First of all it
> turns it in command which can fail. As far as I understand we wanted to
> avoid this.
> 
> Wrapper is needed in order to "error_abort" command only in case if (a)
> CONFIG_MEM_HOTPLUG  is enabled, but (b) QOM data is somehow corrupted.
> If CONFIG_MEM_HOTPLUG
> is disabled for target, it does not mean to report an error -- in this case
> value simply not reported and no error path triggered.
Ok,
keeping current approach is also fine.

> 
> I agree with the rest of comments and will provide changes with the next
> version.
> Could you please leave a comment(s) if you agree or not (before I submit
> next version)?
> 
> Thank you in advance,
> Vadim
> 
> 
> On Tue, Aug 15, 2017 at 9:51 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 28 Jul 2017 14:10:43 +0200
> > Vadim Galitsyn <vadim.galitsyn@profitbricks.com> wrote:
> >  
> > > Command above provides the following memory information in bytes:
> > >
> > >   * base-memory - size of "base" memory specified with command line  
> > option -m.  
> > >
> > >   * hotunpluggable-memory - amount of memory that was hot-plugged.
> > >     If target does not have CONFIG_MEM_HOTPLUG enabled, no
> > >     value is reported.
> > >
> > > Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com
> > >
> > > Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
> > > Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> > > Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> > > Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Cc: Markus Armbruster <armbru@redhat.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > Cc: Eric Blake <eblake@redhat.com>
> > > Cc: qemu-devel@nongnu.org
> > > ---
> > >  hw/mem/pc-dimm.c                                   |  5 +++++
> > >  include/hw/mem/pc-dimm.h                           |  1 +
> > >  qapi-schema.json                                   | 25  
> > ++++++++++++++++++++++  
> > >  qmp.c                                              | 13 +++++++++++
> > >  stubs/Makefile.objs                                |  2 +-
> > >  stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} |  5 +++++
> > >  6 files changed, 50 insertions(+), 1 deletion(-)
> > >  rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (64%)
> > >
> > > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > > index ea67b461c2..1df8b7ee57 100644
> > > --- a/hw/mem/pc-dimm.c
> > > +++ b/hw/mem/pc-dimm.c
> > > @@ -159,6 +159,11 @@ uint64_t pc_existing_dimms_capacity(Error **errp)
> > >      return cap.size;
> > >  }
> > >
> > > +uint64_t get_existing_hotpluggable_memory_size(void)
> > > +{
> > > +    return pc_existing_dimms_capacity(&error_abort);
> > > +}
> > > +
> > >  int qmp_pc_dimm_device_list(Object *obj, void *opaque)
> > >  {
> > >      MemoryDeviceInfoList ***prev = opaque;
> > > diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> > > index 1e483f2670..52c6b5e641 100644
> > > --- a/include/hw/mem/pc-dimm.h
> > > +++ b/include/hw/mem/pc-dimm.h
> > > @@ -95,6 +95,7 @@ int pc_dimm_get_free_slot(const int *hint, int  
> > max_slots, Error **errp);  
> > >
> > >  int qmp_pc_dimm_device_list(Object *obj, void *opaque);
> > >  uint64_t pc_existing_dimms_capacity(Error **errp);
> > > +uint64_t get_existing_hotpluggable_memory_size(void);
> > >  void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> > >                           MemoryRegion *mr, uint64_t align, Error  
> > **errp);  
> > >  void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
> > > diff --git a/qapi-schema.json b/qapi-schema.json
> > > index 9c6c3e1a53..bbedf1a7bc 100644
> > > --- a/qapi-schema.json
> > > +++ b/qapi-schema.json
> > > @@ -4407,6 +4407,31 @@
> > >    'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool',
> > >              '*unavailable-features': [ 'str' ], 'typename': 'str' } }
> > >
> > > +##
> > > +# @MemoryInfo:
> > > +#
> > > +# Actual memory information in bytes.
> > > +#
> > > +# @base-memory: size of "base" memory specified with command line
> > > +#               option -m.
> > > +#
> > > +# @hotunpluggable-memory: size memory that can be hot-unplugged.
> > > +#
> > > +# Since: 2.10.0
> > > +##
> > > +{ 'struct': 'MemoryInfo',
> > > +  'data'  : { 'base-memory': 'size', '*hotunpluggable-memory': 'size' }  
> > }  
> > > +
> > > +##
> > > +# @query-memory-size-summary:
> > > +#
> > > +# Return the amount of initially allocated and hot-plugged (if
> > > +# enabled) memory in bytes.
> > > +#
> > > +# Since: 2.10.0
> > > +##
> > > +{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
> > > +
> > >  ##
> > >  # @query-cpu-definitions:
> > >  #
> > > diff --git a/qmp.c b/qmp.c
> > > index b86201e349..682d950440 100644
> > > --- a/qmp.c
> > > +++ b/qmp.c
> > > @@ -709,3 +709,16 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error  
> > **errp)  
> > >
> > >      return head;
> > >  }
> > > +
> > > +MemoryInfo *qmp_query_memory_size_summary(Error **errp)
> > > +{
> > > +    MemoryInfo *mem_info = g_malloc0(sizeof(MemoryInfo));
> > > +
> > > +    mem_info->base_memory = ram_size;
> > > +
> > > +    mem_info->hotunpluggable_memory = get_existing_hotpluggable_  
> > memory_size();
> > this could be done without wrapper:
> > mem_info->hotunpluggable_memory = pc_existing_dimms_capacity(&local_error)
> >  
> > > +    mem_info->has_hotunpluggable_memory =
> > > +        (mem_info->hotunpluggable_memory != (uint64_t)-1);  
> >
> > mem_info->has_hotunpluggable_memory = !local_error;
> > if (local_error)
> >   cleanup
> >
> > and defining stub:
> >
> > uint64_t pc_existing_dimms_capacity(Error **errp) {
> >      error_setg(errp, "not implemented");
> >      return 0;
> > }
> >  
> > > +
> > > +    return mem_info;
> > > +}
> > > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > > index f5b47bfd74..f7cab5b11c 100644
> > > --- a/stubs/Makefile.objs
> > > +++ b/stubs/Makefile.objs
> > > @@ -32,7 +32,7 @@ stub-obj-y += uuid.o
> > >  stub-obj-y += vm-stop.o
> > >  stub-obj-y += vmstate.o
> > >  stub-obj-$(CONFIG_WIN32) += fd-register.o
> > > -stub-obj-y += qmp_pc_dimm_device_list.o
> > > +stub-obj-y += qmp_pc_dimm.o
> > >  stub-obj-y += target-monitor-defs.o
> > >  stub-obj-y += target-get-monitor-def.o
> > >  stub-obj-y += pc_madt_cpu_entry.o
> > > diff --git a/stubs/qmp_pc_dimm_device_list.c b/stubs/qmp_pc_dimm.c
> > > similarity index 64%
> > > rename from stubs/qmp_pc_dimm_device_list.c
> > > rename to stubs/qmp_pc_dimm.c
> > > index def211564d..1d1e008b58 100644
> > > --- a/stubs/qmp_pc_dimm_device_list.c
> > > +++ b/stubs/qmp_pc_dimm.c
> > > @@ -6,3 +6,8 @@ int qmp_pc_dimm_device_list(Object *obj, void *opaque)
> > >  {
> > >     return 0;
> > >  }
> > > +
> > > +uint64_t get_existing_hotpluggable_memory_size(void)
> > > +{
> > > +    return (uint64_t)-1;
> > > +}  
> >
> >  
