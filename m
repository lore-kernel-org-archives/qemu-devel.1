Received: from eggs.gnu.org ([2001:4830:134:3::10]:34658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co4Pu-0006gt-Qv
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co4Pr-0001nx-N7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:36:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1co4Pr-0001nd-EX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:36:19 -0400
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<1489158897-9206-2-git-send-email-yang.zhong@intel.com>
	<53522014-8f70-9358-7d60-8b6c491c9611@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F91A@ORSMSX112.amr.corp.intel.com>
	<920352018.1797331.1489251855464.JavaMail.zimbra@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A13045@ORSMSX112.amr.corp.intel.com>
	<991a0f3d-5e1f-d17c-a8f3-a42c02ac2f17@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A1561C@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f05fe113-c286-19b0-f5bc-ee2c1ea05568@redhat.com>
Date: Wed, 15 Mar 2017 09:36:16 +0100
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A1561C@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "Zhong, Yang" <yang.zhong@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>



On 14/03/2017 22:23, Xu, Anthony wrote:
>> flatview_unref can call object_unref and thus reach:
>=20
> Okay,  flatview_unref is the one you worried about,
>=20
> Flatview_unref is registered as a RCU callback only in address_space_up=
date_topology,
> Strangely, it is registered as a RCU callback, and is called directly i=
n this function.=20
> Basially flatview_unref is called twice for old view.

The first unref is done after as->current_map is overwritten.
as->current_map is accessed under RCU, so it needs call_rcu.  It
balances the initial reference that is present since flatview_init.

The second unref is done to balance the flatview_ref in
address_space_get_flatview.

> There are some comments,=20
> but it is not clear to me, is this a bug or by design? Is flatview_dest=
roy called in current thread=20
> or RCU thread?

You cannot know, because there are also other callers of
address_space_get_flatview.  Usually it's from the RCU thread.

> Let me split the patch, Do you think below patch is correct?
>=20
> --- a/memory.c
> +++ b/memory.c
> @@ -1503,15 +1503,9 @@ static void memory_region_finalize(Object *obj)
>       * and cause an infinite loop.
>       */
>      mr->enabled =3D false;
> -    memory_region_transaction_begin();
> -    while (!QTAILQ_EMPTY(&mr->subregions)) {
> -        MemoryRegion *subregion =3D QTAILQ_FIRST(&mr->subregions);
> -        memory_region_del_subregion(mr, subregion);
> -    }
> -    memory_region_transaction_commit();
> -
> +    assert(QTAILQ_EMPTY(&mr->subregions));
>      mr->destructor(mr);
> -    memory_region_clear_coalescing(m
> +    assert(QTAILQ_EMPTY(&mr->coalesced));
>      g_free((char *)mr->name);
>      g_free(mr->ioeventfds);
>  }

No.  Callers can:

- let memory_region_finalize remove subregions (commit 2e2b8eb, "memory:
allow destroying a non-empty MemoryRegion", 2015-10-09)

- let memory_region_finalize disable coalesced I/O (in fact there are no
callers of memory_region_clear_coalescing outside memory.c)

> Then let us take a look at flatview_unref, memory_region_unref may call=
 any QOM finalize through=20
> Object_unref(mr->owner), that's your concern, I got it. It is way too c=
omplicated to look at each QOM=20
> object release callbacks and each QOM property release callbacks.  I ga=
ve up this path.
> How about fall back to synchronize_rcu?

I'm afraid it would be too slow, but you can test.

Something like the kernel's synchronize_rcu_expedited would work, but we
don't have anything like that in QEMU yet.

> As for address space, the RCU read lock is used to protect PhysPageMap,=
 but not the regular MemoryRegions,

Nope.  The RCU read lock protects all MemoryRegions through
flatview_unref: RCU keeps the FlatView alive, and the FlatView keeps
MemoryRegions alive.

Hence...

> The MemoryRegions returned from address_space_translate are regular Mem=
oryRegions, so=20
> address_space_write_continue and address_space_read_continue don't need=
 RCU read lock.

... this is wrong too.

Paolo
