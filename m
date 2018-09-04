Received: from eggs.gnu.org ([2001:4830:134:3::10]:43733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fx7LC-0001Je-K8
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fx7L8-0007K0-Ib
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:09:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fx7L5-0007Hz-OA
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:09:36 -0400
Date: Tue, 4 Sep 2018 10:09:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180904090928.GA2529@work-vm>
References: <5ab76c3e-9310-0e08-2f1b-4ff52bf229f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5ab76c3e-9310-0e08-2f1b-4ff52bf229f8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] migration: make sure to run iterate
 precopy during the bulk stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Quan Xu <quan.xu0@gmail.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, kvm <kvm@vger.kernel.org>

* Quan Xu (quan.xu0@gmail.com) wrote:
> From 8dbf7370e7ea1caab0b769d0d4dcdd072d14d421 Mon Sep 17 00:00:00 2001
> From: Quan Xu <quan.xu0@gmail.com>
> Date: Wed, 29 Aug 2018 21:33:14 +0800
> Subject: [PATCH RFC] migration: make sure to run iterate precopy during=
 the
> =A0bulk stage
>=20
> Since the bulk stage assumes in (migration_bitmap_find_dirty) that ever=
y
> page is dirty, return a rough total ram as pending size to make sure th=
at
> migration thread continues to run iterate precopy during the bulk stage=
.
>=20
> Otherwise the downtime grows unpredictably, as migration thread needs t=
o
> send both the rest of pages and dirty pages during complete precopy.
>=20
> Signed-off-by: Quan Xu <quan.xu0@gmail.com>

Hi,
  Can you explain a bit more about the problem you're seeing?
I think you're saying it's exiting the iteration near the end of
the bulk stage, before it's done the first sync?

> ---
> =A0migration/ram.c | 3 ++-
> =A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 79c8942..cfa304c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3308,7 +3308,8 @@ static void ram_save_pending(QEMUFile *f, void
> *opaque, uint64_t max_size,
> =A0=A0=A0=A0=A0=A0=A0=A0 /* We can do postcopy, and all the data is pos=
tcopiable */
> =A0=A0=A0=A0=A0=A0=A0=A0 *res_compatible +=3D remaining_size;
> =A0=A0=A0=A0 } else {
> -=A0=A0=A0=A0=A0=A0=A0 *res_precopy_only +=3D remaining_size;
> +=A0=A0=A0=A0=A0=A0=A0 *res_precopy_only +=3D (rs->ram_bulk_stage ?
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ram_bytes_total() : remaining_size);

So that's assuming that the whole of RAM is dirty, even if we're
near the end of the bulk stage?

Dave

> =A0=A0=A0=A0 }
> =A0}
>=20
> --
> 1.8.3.1
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
