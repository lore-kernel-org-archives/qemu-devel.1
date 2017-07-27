Received: from eggs.gnu.org ([2001:4830:134:3::10]:47194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1daYVh-0006Vh-VX
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1daYVc-0006Mk-VV
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1daYVc-0006M8-MB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:26:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E097D69A2
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 02:26:32 +0000 (UTC)
Date: Thu, 27 Jul 2017 10:19:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170727021917.GN1595@pxdev.xzpeter.org>
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
	<1499847223-8078-5-git-send-email-peterx@redhat.com>
	<0850f338-98a2-614a-c8bd-3407c9b5a485@redhat.com>
	<20170714043241.GK27284@pxdev.xzpeter.org>
	<14784c80-2b88-1994-9d50-7d39dc72a808@redhat.com>
	<20170717015327.GQ27284@pxdev.xzpeter.org>
	<20170726233613-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170726233613-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] intel_iommu: implement mru list for
 iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Wed, Jul 26, 2017 at 11:37:13PM +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 17, 2017 at 09:53:27AM +0800, Peter Xu wrote:
> > On Fri, Jul 14, 2017 at 03:28:09PM +0800, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2017=E5=B9=B407=E6=9C=8814=E6=97=A5 12:32, Peter Xu wrote:
> > > >On Thu, Jul 13, 2017 at 04:48:42PM +0800, Jason Wang wrote:
> > > >>
> > > >>On 2017=E5=B9=B407=E6=9C=8812=E6=97=A5 16:13, Peter Xu wrote:
> > > >>>It is not wise to disgard all the IOTLB cache when cache size re=
aches
> > > >>>max, but that's what we do now. A slightly better (but still sim=
ple) way
> > > >>>to do this is, we just throw away the least recent used cache en=
try.
> > > >>>
> > > >>>This patch implemented MRU list algorithm for VT-d IOTLB. The ma=
in logic
> > > >>>is to maintain a Most Recently Used list for the IOTLB entries. =
The hash
> > > >>>table is still used for lookup, though a new list field is added=
 to each
> > > >>>IOTLB entry for a iotlb MRU list. For each active IOTLB entry, i=
t's both
> > > >>>in the hash table in s->iotlb, and also linked into the MRU list=
 of
> > > >>>s->iotlb_head. The hash helps in fast lookup, and the MRU list h=
elps in
> > > >>>knowing whether the cache is still hot.
> > > >>>
> > > >>>After we have such a MRU list, replacing all the iterators of IO=
TLB
> > > >>>entries by using list iterations rather than hash table iteratio=
ns.
> > > >>Any reason of doing this, I thought hashtable was even a little b=
it faster?
> > > >Could I ask why?
> > > >
> > > >I thought they are merely the same (when iterating all the items)?
> > > >
> > >=20
> > > Ok, looks like I was wrong, but it they are merely the same, why bo=
ther?
> >=20
> > Because imho looping over list needs fewer LOCs and is also more
> > direct. E.g., for domain flush, hash needs this:
> >=20
> > static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer valu=
e,
> >                                           gpointer user_data)
> > {
> >     VTDIOTLBEntry *entry =3D (VTDIOTLBEntry *)value;
> >     uint16_t domain_id =3D *(uint16_t *)user_data;
> >     return entry->domain_id =3D=3D domain_id;
> > }
> >=20
> > Then:
> >=20
> >     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
> >                                 &domain_id);
> >=20
> > For list it is only:
> >=20
> >     FOREACH_IOTLB_SAFE(entry, s, entry_n) {
> >         if (entry->domain_id =3D=3D domain_id) {
> >             vtd_iotlb_remove_entry(s, entry);
> >         }
> >     }
> >=20
> > Thanks,
>=20
> Well the LOC seems to have gone up with this patch.
> If we are trying to simplify code, please state this
> in commit log.

Ok. I can split the patch into two (one to introduce MRU list, one to
replace the iterations of hash tables) if it will be needed in the
future. Currently since we don't have plan to merge it, I'll put it
aside for now. Thanks.

--=20
Peter Xu
