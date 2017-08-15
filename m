Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhVZ0-00086Y-Qm
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhVYx-0005kI-A6
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:42:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhVYx-0005jK-1c
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:42:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1501084908.git.alistair.francis@xilinx.com>
	<44655faac8ff8a48e1ed7a50ad0ac66bfd70975b.1501084908.git.alistair.francis@xilinx.com>
Date: Tue, 15 Aug 2017 08:42:45 +0200
In-Reply-To: <44655faac8ff8a48e1ed7a50ad0ac66bfd70975b.1501084908.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Wed, 26 Jul 2017 09:07:57 -0700")
Message-ID: <878tilwcuy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/5] Convert multi-line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com

Alistair Francis <alistair.francis@xilinx.com> writes:

> Convert all the multi-line uses of fprintf(stderr, "warning:"..."\n"...
> to use warn_report() instead. This helps standardise on a single
> method of printing warnings to the user.
>
> All of the warnings were changed using these commands:
>   find ./* -type f -exec sed -i \
>     'N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2=
);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"=
\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\=
1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("=
\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report=
("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_repo=
rt("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_r=
eport("\1"\2);|Ig}' \
>     {} +
>
> Indentation fixed up manually afterwards.
>
> Some of the lines were manually edited to reduce the line length to below
> 80 charecters. Some of the lines with newlines in the middle of the
> string were also manually edit to avoid checkpatch errrors.
>
> The #include lines were manually updated to allow the code to compile.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
> I couldn't figure out any nice way (it is possible with some more logic
> inside the sed apparently) to do this is one command, so I had to use
> all of the commands above.
[...]
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index 369c3df8a0..3985a92f02 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -125,8 +125,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, voi=
d *opaque)
>          rlimit_as.rlim_cur =3D rlimit_as.rlim_max;
>=20=20
>          if (rlimit_as.rlim_max !=3D RLIM_INFINITY) {
> -            fprintf(stderr, "Warning: QEMU's maximum size of virtual"
> -                    " memory is not infinity.\n");
> +            warn_report("QEMU's maximum size of virtual"
> +                        " memory is not infinity.");
>          }
>          if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZ=
E) {
>              mapcache->max_mcache_size =3D rlimit_as.rlim_max -

warning: implicit declaration of function =E2=80=98warn_report=E2=80=99 [-W=
implicit-function-declaration]

Please double-check for warnings.

[...]
