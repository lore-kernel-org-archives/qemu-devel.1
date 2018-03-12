Received: from eggs.gnu.org ([2001:4830:134:3::10]:45539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQkg-0007oE-ME
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQkf-0007Rl-Px
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:56:46 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evQkf-0007R9-Ir
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:56:45 -0400
Received: by mail-wr0-x241.google.com with SMTP id h2so9133376wre.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:56:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-30-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-30-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 17:56:43 +0100
Message-ID: <CAJ+F1CLjTyxpFi9rs7b270c4Grz1XaM9TJCzRK8PJfskyKsh6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 29/29] postcopy shared docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Mar 8, 2018 at 8:58 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add some notes to the migration documentation for shared memory
> postcopy.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/devel/migration.rst | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index 9d1b7657f0..e32b087f6e 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -577,3 +577,44 @@ Postcopy now works with hugetlbfs backed memory:
>       hugepages works well, however 1GB hugepages are likely to be proble=
matic
>       since it takes ~1 second to transfer a 1GB hugepage across a 10Gbps=
 link,
>       and until the full page is transferred the destination thread is bl=
ocked.
> +
> +Postcopy with shared memory
> +---------------------------
> +
> +Postcopy migration with shared memory needs explicit support from the ot=
her
> +processes that share memory and from QEMU. There are restrictions on the=
 type of
> +memory that userfault can support shared.
> +
> +The Linux kernel userfault support works on `/dev/shm` memory and on `hu=
getlbfs`
> +(although the kernel doesn't provide an equivalent to `madvise(MADV_DONT=
NEED)`
> +for hugetlbfs which may be a problem in some configurations).
> +
> +The vhost-user code in QEMU supports clients that have Postcopy support,
> +and the `vhost-user-bridge` (in `tests/`) and the DPDK package have chan=
ges
> +to support postcopy.
> +
> +The client needs to open a userfaultfd and register the areas
> +of memory that it maps with userfault.  The client must then pass the
> +userfaultfd back to QEMU together with a mapping table that allows
> +fault addresses in the clients address space to be converted back to
> +RAMBlock/offsets.  The client's userfaultfd is added to the postcopy
> +fault-thread and page requests are made on behalf of the client by QEMU.
> +QEMU performs 'wake' operations on the client's userfaultfd to allow it
> +to continue after a page has arrived.
> +
> +.. note::
> +  There are two future improvements that would be nice:
> +    a) Some way to make QEMU ignorant of the addresses in the clients
> +       address space
> +    b) Avoiding the need for QEMU to perform ufd-wake calls after the
> +       pages have arrived
> +
> +Retro-fitting postcopy to existing clients is possible:
> +  a) A mechanism is needed for the registration with userfault as above,
> +     and the registration needs to be coordinated with the phases of
> +     postcopy.  In vhost-user extra messages are added to the existing
> +     control channel.
> +  b) Any thread that can block due to guest memory accesses must be
> +     identified and the implication understood; for example if the
> +     guest memory access is made while holding a lock then all other
> +     threads waiting for that lock will also be blocked.
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
