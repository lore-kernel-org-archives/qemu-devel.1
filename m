Received: from eggs.gnu.org ([2001:4830:134:3::10]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dt1Ra-0003xh-Oa
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dt1RX-0001UN-MU
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:58:50 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:44150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dt1RX-0001TE-BC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:58:47 -0400
Received: by mail-pg0-x22a.google.com with SMTP id j16so2391852pga.1
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 17:58:46 -0700 (PDT)
References: <20170915084030.40988-1-aik@ozlabs.ru>
	<20170915084030.40988-12-aik@ozlabs.ru>
	<165a7fa9-6ebb-3e95-2d95-7df2f550f1de@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <14f70953-dc95-6845-04be-07ee1615117e@ozlabs.ru>
Date: Sat, 16 Sep 2017 10:58:40 +1000
MIME-Version: 1.0
In-Reply-To: <165a7fa9-6ebb-3e95-2d95-7df2f550f1de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 11/13] memory: Share FlatView's and
 dispatch trees between address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 15/09/17 19:25, Paolo Bonzini wrote:
> On 15/09/2017 10:40, Alexey Kardashevskiy wrote:
>> +
>> +static bool flatview_can_share(FlatView *old_view, FlatView *new_view)
>> +{
>> +    MemoryRegion *old_root = memory_region_unalias_entire(old_view->root);
>> +    MemoryRegion *new_root = memory_region_unalias_entire(new_view->root);
>> +
>> +    if (old_root == new_root) {
>> +        return true;
>> +    }
>> +
>> +    if (!old_root->enabled && !new_root->enabled) {
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
> 
> I think you can improve this by keeping the root in the address space
> (removing the previous patch).  Instead, the FlatView's root can be the
> one with resolved aliases.  Then old_root is just old_view->root, and if
> an empty FlatView has a NULL root this just becomes
> 
>    the_other_view->root == memory_region_unalias_entire(as->root);

Ok!


> 
>>
>> +
>> +    /* Build list of unique FlatViews, FV::root is the key */
>> +    QTAILQ_FOREACH(old_view, &flat_views, flat_views_link) {
>> +        found = false;
>> +        QTAILQ_FOREACH(new_view, &fvs_tmp, flat_views_link) {
>> +            if (flatview_can_share(old_view, new_view)) {
>> +                found = true;
>> +                break;
>> +            }
>> +        }
>> +        if (found) {
>> +            continue;
>> +        }
>> +
>> +        new_view = generate_memory_topology(old_view->root);
>> +        flatview_render_new(old_view, new_view);
>> +        QTAILQ_INSERT_TAIL(&fvs_tmp, new_view, flat_views_link);
>> +    }
> 
> I don't understand the algorithm here.  Why is it visiting &flat_views
> rather than the list of address spaces?  I would have thought it enough
> to do
> 
>    for each address space
>         if there is a (new) flat view that we can share
>             add a reference
>         else
>             render a new flat view and add it to fvs_tmp
> 
>    flat_views = fvs_tmp;
> 
>    for each address space
>         old_view = address_space_to_flatview(as);
>         find the new flat view to use in fvs_tmp
>         address_space_update_topology_pass(..., false);
>         address_space_update_topology_pass(..., true);
>         QTAILQ_REMOVE(&old_view->address_spaces, ...);
>         atomic_rcu_set(&as->current_map, new_view);
>         flatview_unref(old_view);
>         QTAILQ_INSERT_TAIL(&new_view->address_spaces, ...);
> 
> 
> It's also not clear to me what you need the FlatView's address_spaces
> list for.  (It's probably something trivial that I'm missing, or maybe
> it goes away with the previous change).


It is trivial - the first version added a global list of FVs and shared
them among ASes. Every transactoion_commit would produce a new FV and
replace it in all ASes which old FV was shared among. The decision whether
to share FV or not was made in address_space_init() which a very different
place in code.

In v2 I moved the sharing decision to the commit part and noooow having a
global list of FVs and ASes list in each FV seems redundant so I'll remove
it in v3, thanks for pointing out :)

And I'll probably drop FV allocation in address_space_init as it is going
to be rebuild at commit time anyway.


> 
>>
>>  AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
>>  {
>>      AddressSpace *as;
>>  
>> -    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>> -        if (root == address_space_root(as) && as->malloced) {
>> -            as->ref_count++;
>> -            return as;
>> -        }
>> -    }
>> -
>>      as = g_malloc0(sizeof *as);
>>      address_space_init(as, root, name);
>> -    as->malloced = true;
>> +
>>      return as;
>>  }
>>  
> 
> This belongs in the next patch;

By "this" you mean removal of "malloced", not the AS loop above, right?

> leaving as->malloced in
> do_address_space_destroy and the reference count in
> address_space_destroy is not a big complication.


But why would we want to leave them anyway?


thanks for the quick review!


-- 
Alexey
