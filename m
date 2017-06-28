Received: from eggs.gnu.org ([2001:4830:134:3::10]:54813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQ9pw-0001z7-Jw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQ9pt-00026Z-Gg
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:04:40 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dQ9pt-00025z-9n
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:04:37 -0400
Received: by mail-wm0-x241.google.com with SMTP id 131so10484899wmq.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 03:04:35 -0700 (PDT)
Date: Wed, 28 Jun 2017 11:04:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170628100428.GA29104@stefanha-x1.localdomain>
References: <20170628083704.24997-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20170628083704.24997-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] exec: fix access to
 ram_list.dirty_memory when sync dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 04:37:04PM +0800, Haozhong Zhang wrote:
> In cpu_physical_memory_sync_dirty_bitmap(rb, start, ...), the 2nd
> argument 'start' is relative to the start of the ramblock 'rb'. When
> it's used to access the dirty memory bitmap of ram_list (i.e.
> ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]->blocks[]), an offset to
> the start of all RAM (i.e. rb->offset) should be added to it, which has
> however been missed since c/s 6b6712efcc. For a ramblock of host memory
> backend whose offset is not zero, cpu_physical_memory_sync_dirty_bitmap()
> synchronizes the incorrect part of the dirty memory bitmap of ram_list
> to the per ramblock dirty bitmap. As a result, a guest with host
> memory backend may crash after migration.
>=20
> Fix it by adding the offset of ramblock when accessing the dirty memory
> bitmap of ram_list in cpu_physical_memory_sync_dirty_bitmap().
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
> Changes in v2:
>  * Avoid shadowing variable 'offset'. (Paolo)
> ---
>  include/exec/ram_addr.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZU38sAAoJEJykq7OBq3PIDRUH/i/+/llsOXYm4MycUcMmU/V6
zQEJjkYm9ZGkBFYDe7oz3d8V3obey3JMvy0Q0pfMui+sYaAk97ZQozWw3SDO7w44
uhuq568zIlREtAiOOd8Rg0kEy69AUm7kyLksqbkyo3XxjWq47fQ6xc0ZyiILDmVc
MKoTceKWsReJ1TjVDvI0/f7jHn5KpFTEU7U1KeODgreRSCf65bKStBO6E5TYPOoB
ctZo8HZCd1tbyhJihl40fvP6vhv4zFyqUQzB7GQsybryefsgMFJdAo+JPobBCqF8
8uNSDiugfRddTSAAW2Pg5BL5WcNEUXo1jeDw0ky/6pqDZRAA+kRYRZ0yFCZszRU=
=rjru
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
