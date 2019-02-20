Received: from eggs.gnu.org ([209.51.188.92]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwQ5h-0005hR-IU
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwQ5f-0003m4-Kn
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:31:05 -0500
References: <20190220000553.28438-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0250b8e4-bd65-9658-8996-50f83913d60b@redhat.com>
Date: Wed, 20 Feb 2019 12:30:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190220000553.28438-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: Restrict Linux-specific code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>

On 20/02/19 01:05, Philippe Mathieu-Daud=C3=A9 wrote:
> Some Linux specific code is missing guards, leading to
> build failure on OSX:
>=20
>   $ sudo brew install libiscsi
>   $ ./configure && make
>   [...]
>     CC      block/iscsi.o
>   qemu/block/iscsi.c:338:24: error: 'iscsi_aiocb_info' defined but not =
used [-Werror=3Dunused-const-variable=3D]
>    static const AIOCBInfo iscsi_aiocb_info =3D {
>                           ^~~~~~~~~~~~~~~~
>   qemu/block/iscsi.c:168:1: error: 'iscsi_schedule_bh' defined but not =
used [-Werror=3Dunused-function]
>    iscsi_schedule_bh(IscsiAIOCB *acb)
>    ^~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>=20
> Add guards to restrict this code for Linux.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> There are various Linux specific code, we could split it out to
> another file such block/iscsi-lnx.o and guard with Makefile,
> but that's another patch.
>=20
>  block/iscsi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index ff473206e6..85daa9a481 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -145,6 +145,8 @@ static const unsigned iscsi_retry_times[] =3D {8, 3=
2, 128, 512, 2048, 8192, 32768}
>   * unallocated. */
>  #define ISCSI_CHECKALLOC_THRES 64
> =20
> +#ifdef __linux__
> +
>  static void
>  iscsi_bh_cb(void *p)
>  {
> @@ -172,6 +174,8 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
>      qemu_bh_schedule(acb->bh);
>  }
> =20
> +#endif
> +
>  static void iscsi_co_generic_bh_cb(void *opaque)
>  {
>      struct IscsiTask *iTask =3D opaque;
> @@ -290,6 +294,8 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsi=
lun, struct IscsiTask *iTask)
>      };
>  }
> =20
> +#ifdef __linux__
> +
>  /* Called (via iscsi_service) with QemuMutex held. */
>  static void
>  iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *com=
mand_data,
> @@ -338,6 +344,7 @@ static const AIOCBInfo iscsi_aiocb_info =3D {
>      .cancel_async       =3D iscsi_aio_cancel,
>  };
> =20
> +#endif
> =20
>  static void iscsi_process_read(void *arg);
>  static void iscsi_process_write(void *arg);
>=20

Queued, thanks.

Paolo
