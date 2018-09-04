Received: from eggs.gnu.org ([2001:4830:134:3::10]:44473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fx7Nr-0003ww-2y
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fx7Nn-0008EC-3P
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fx7Nm-0008E6-V2
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:12:23 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <5ab76c3e-9310-0e08-2f1b-4ff52bf229f8@gmail.com> (Quan Xu's
	message of "Wed, 29 Aug 2018 21:40:50 +0800")
References: <5ab76c3e-9310-0e08-2f1b-4ff52bf229f8@gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 04 Sep 2018 11:12:18 +0200
Message-ID: <87va7lvd71.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, kvm <kvm@vger.kernel.org>

Quan Xu <quan.xu0@gmail.com> wrote:
> From 8dbf7370e7ea1caab0b769d0d4dcdd072d14d421 Mon Sep 17 00:00:00 2001
> From: Quan Xu <quan.xu0@gmail.com>
> Date: Wed, 29 Aug 2018 21:33:14 +0800
> Subject: [PATCH RFC] migration: make sure to run iterate precopy during t=
he
> =C2=A0bulk stage
>
> Since the bulk stage assumes in (migration_bitmap_find_dirty) that every
> page is dirty, return a rough total ram as pending size to make sure that
> migration thread continues to run iterate precopy during the bulk stage.
>
> Otherwise the downtime grows unpredictably, as migration thread needs to
> send both the rest of pages and dirty pages during complete precopy.
>
> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> ---
> =C2=A0migration/ram.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 79c8942..cfa304c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3308,7 +3308,8 @@ static void ram_save_pending(QEMUFile *f, void
> *opaque, uint64_t max_size,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We can do postcopy, a=
nd all the data is postcopiable */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *res_compatible +=3D rem=
aining_size;
> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *res_precopy_only +=3D remain=
ing_size;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *res_precopy_only +=3D (rs->r=
am_bulk_stage ?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ram_bytes_total() : remaining_size);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}

Hi

I don't oppose the change.
But what I don't understand is _why_ it is needed (or to say it
otherwise, how it worked until now).   I was wondering about the opposit
direction, and just initialize the number of dirty pages at the
beggining of the loop and then let decrease it for each processed page.

I don't remember either how big was the speedud of not walking the
bitmap on the 1st stage to start with.

Later, Juan.
