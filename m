Received: from eggs.gnu.org ([2001:4830:134:3::10]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ejYRC-0007jj-Hk
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ejYRB-0004t1-HR
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:43:34 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:39203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1ejYRB-0004sD-8H
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:43:33 -0500
Received: by mail-oi0-x22e.google.com with SMTP id j188so1929672oib.6
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:43:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207183717.GW2665@work-vm>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-8-haozhong.zhang@intel.com>
	<20180207115406.GD2665@work-vm>
	<20180207121525.5pyrld36k5xbm373@hz-desktop>
	<20180207130355.GH2665@work-vm>
	<20180207132023.yuf2lp3jrhg2qytz@hz-desktop>
	<20180207132412.GJ2665@work-vm>
	<CAPcyv4j7s6M6RNKKOQqrOkovsp0Z4uAXFjURBeG5QSp_-uzm+w@mail.gmail.com>
	<20180207180848.GU2665@work-vm>
	<CAPcyv4jyxDwfODnKL-jvbMboCQVQv41+ts98PkyjP8n_Vn_+nw@mail.gmail.com>
	<20180207183717.GW2665@work-vm>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 7 Feb 2018 14:43:31 -0800
Message-ID: <CAPcyv4idQNgGV0EyRuCenGSU2_OCZS50Z3LHO_ExMTakL-n1ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 7/8] migration/ram: ensure write
 persistence on loading compressed pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Feb 7, 2018 at 10:37 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Dan Williams (dan.j.williams@intel.com) wrote:
>> On Wed, Feb 7, 2018 at 10:08 AM, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>> > * Dan Williams (dan.j.williams@intel.com) wrote:
>> >> On Wed, Feb 7, 2018 at 5:24 AM, Dr. David Alan Gilbert
>> >> <dgilbert@redhat.com> wrote:
>> >> > * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
>> >> >> On 02/07/18 13:03 +0000, Dr. David Alan Gilbert wrote:
>> >> >> > * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
>> >> >> > > On 02/07/18 11:54 +0000, Dr. David Alan Gilbert wrote:
>> >> >> > > > * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
>> >> >> > > > > When loading a compressed page to persistent memory, flush CPU cache
>> >> >> > > > > after the data is decompressed. Combined with a call to pmem_drain()
>> >> >> > > > > at the end of memory loading, we can guarantee those compressed pages
>> >> >> > > > > are persistently loaded to PMEM.
>> >> >> > > >
>> >> >> > > > Can you explain why this can use the flush and doesn't need the special
>> >> >> > > > memset?
>> >> >> > >
>> >> >> > > The best approach to ensure the write persistence is to operate pmem
>> >> >> > > all via libpmem, e.g., pmem_memcpy_nodrain() + pmem_drain(). However,
>> >> >> > > the write to pmem in this case is performed by uncompress() which is
>> >> >> > > implemented out of QEMU and libpmem. It may or may not use libpmem,
>> >> >> > > which is not controlled by QEMU. Therefore, we have to use the less
>> >> >> > > optimal approach, that is to flush cache for all pmem addresses that
>> >> >> > > uncompress() may have written, i.e.,/e.g., memcpy() and/or memset() in
>> >> >> > > uncompress(), and pmem_flush() + pmem_drain() in QEMU.
>> >> >> >
>> >> >> > In what way is it less optimal?
>> >> >> > If that's a legal thing to do, then why not just do a pmem_flush +
>> >> >> > pmem_drain right at the end of the ram loading and leave all the rest of
>> >> >> > the code untouched?
>> >> >>
>> >> >> For example, the implementation pmem_memcpy_nodrain() prefers to use
>> >> >> movnt instructions w/o flush to write pmem if those instructions are
>> >> >> available, and falls back to memcpy() + flush if movnt are not
>> >> >> available, so I suppose the latter is less optimal.
>> >> >
>> >> > But if you use normal memcpy calls to copy a few GB of RAM in an
>> >> > incoming migrate and then do a single flush at the end, isn't that
>> >> > better?
>> >>
>> >> Not really, because now you've needlessly polluted the cache and are
>> >> spending CPU looping over the cachelines that could have been bypassed
>> >> with movnt.
>> >
>> > What's different in the pmem case?   Isn't what you've said true in the
>> > normal migrate case as well?
>> >
>>
>> In the normal migrate case the memory is volatile so once the copy is
>> globally visiable you're done. In the pmem case the migration is not
>> complete until the persistent state is synchronized.
>>
>> Note, I'm talking in generalities because I don't know the deeper
>> details of the migrate flow.
>
> On the receive side of a migrate, during a normal precopy migrate
> (without xbzrle) nothing is going to be reading that RAM until
> the whole RAM load has completed anyway - so we're not benefiting from
> it being in the caches either.
>
> In the pmem case, again since nothing is going to be reading from that
> RAM until the end anyway, why bother flushing as we go as opposed to at
> the end?

Flushing at the end implies doing a large loop flushing the caches at
the end of the transfer because the x86 ISA only exposes a
line-by-line flush to unprivileged code rather than a full cache flush
like what the kernel can do with wbinvd. So, better to flush as we go
rather than incur the overhead of the loop at the end. I.e. I'm
assuming it is more efficient to do 'movnt' in the first instance and
not worry about the flush loop.
