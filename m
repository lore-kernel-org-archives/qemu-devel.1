Received: from eggs.gnu.org ([2001:4830:134:3::10]:53876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmkRF-00039h-Cn
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmkRE-0007t8-Gv
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:04:17 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:51418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmkRE-0007rk-9S
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:04:16 -0500
Date: Sat, 11 Mar 2017 12:04:15 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <920352018.1797331.1489251855464.JavaMail.zimbra@redhat.com>
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A0F91A@ORSMSX112.amr.corp.intel.com>
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<1489158897-9206-2-git-send-email-yang.zhong@intel.com>
	<53522014-8f70-9358-7d60-8b6c491c9611@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F91A@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
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
To: Anthony Xu <anthony.xu@intel.com>
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org, Chao P Peng <chao.p.peng@intel.com>


> > Subpages never have subregions, so the loop never runs.  The begin/comm=
it
> > pair then becomes:
> >=20
> >     ++memory_region_transaction_depth;
> >     --memory_region_transaction_depth;
> >     if (!memory_region_transaction_depth) {
> >         if (memory_region_update_pending) {
> >             ...
> >         } else if (ioeventfd_update_pending) {
> >             ...
> >         }
> >         // memory_region_clear_pending()
> >         memory_region_update_pending =3D false;
> >         ioeventfd_update_pending =3D false;
> >    }
> >=20
> > If memory_region_transaction_depth is > 0 the begin/commit pair does
> > nothing.
> >=20
> > But if memory_region_transaction_depth is =3D=3D 0, there should be no =
update
> > pending because the loop has never run.  So I don't see what your patch=
 can
> > change.
>=20
> As I mentioned in PATCH1, this patch is used to fix an issue after we rem=
ove
> the global lock in RCU callback. After global lock is removed, other thre=
ad
> may set up update pending, so memory_region_transaction_commit
> may try to rebuild PhysPageMap even the loop doesn=E2=80=99t run, other t=
hread may
> try to rebuild PhysPageMap at the same time, it is a race condition.
> subpage MemoryRegion is a specific MemoryRegion, it doesn't belong to any
> address space, it is only used to handle subpage. We may use a new struct=
ure
> other than MemoryRegion to handle subpage to make the logic more clearer.=
 After
> the change, RCU callback will not free any MemoryRegion.

This is not true.  Try hot-unplugging a device.

I'm all for reducing the scope of the global QEMU lock, but this needs a pl=
an
and a careful analysis of the involved data structures across _all_ instanc=
e_finalize
implementations.

Paolo
