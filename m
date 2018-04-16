Received: from eggs.gnu.org ([2001:4830:134:3::10]:54059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f856C-0002r2-Hl
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8569-0003hs-CR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:27:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f8569-0003hU-5X
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:27:13 -0400
Date: Mon, 16 Apr 2018 16:27:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180416162706.43212a69@redhat.com>
In-Reply-To: <e483d218-0e93-4a2b-43ea-4a961e559c4d@redhat.com>
References: <20180329032149.44685-1-aik@ozlabs.ru>
	<bc4100f4-0a01-a526-c6ce-c2602a96e28a@redhat.com>
	<20180416152040.7b88b902@redhat.com>
	<e483d218-0e93-4a2b-43ea-4a961e559c4d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, 16 Apr 2018 15:30:39 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/04/2018 15:20, Igor Mammedov wrote:
> > Generally object doesn't need to know its own name,
> > we use it only for debugging and nice error reporting so far.
> > I'd rather have 'id' property at Object level so we won't have
> > to fish out ID from parent /which we aren't supposed to do and
> > which doesn't work in some cases/ when it's needed within
> > object itself.  
> 
> Having an 'id' at object level is also a mess, because that id is
> invalid after unparent.
I'd just consider 'id' as object name which is valid even if there
is no parent (during whole object lifecycle).
That would allow for object to have a reachable name vs getting NULL
when parent isn't set.
Maybe Object::id is overkill, but we probably could use NamedObject
where it's needed and avoid reverse engineering id from path.
 
> Since this is just for debugging use,
> object_get_canonical_path_component is the right function.  We can just
> make it return NULL if there is no parent.
looking at current use it out-grew just debugging usecases
and it's rather messy right now:

ram_backend_memory_alloc, throttle_group_obj_complete,
xlnx_zynqmp_create_rpu, spapr_drc.c:realize, iothread_complete,
memory_region_name


> Paolo
