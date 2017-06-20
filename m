Received: from eggs.gnu.org ([2001:4830:134:3::10]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJdI-00060Q-24
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJdG-0002tf-Od
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:55:52 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJdG-0002t8-Eo
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:55:50 -0400
Received: by mail-wr0-x232.google.com with SMTP id c11so36945398wrc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 06:55:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-9-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 14:55:28 +0100
Message-ID: <CAFEAcA-wdfpzc-w6xKNH65KSsO01GXdyq-Nx9gKBWQoW_BJd_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 08/13] risu: add header to trace
 stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> I've also added a header packet with pc/risu op in it so we can keep
> better track of how things are going.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v5
>   - re-base without formatting fixes
>   - dropped fprintfs in signal context
> v4
>   - split from previous patch
> ---
>  reginfo.c      | 94 +++++++++++++++++++++++++++++++++++++---------------=
------
>  risu.h         |  9 ++++++
>  risu_aarch64.c |  5 ++++
>  risu_arm.c     |  5 ++++
>  risu_m68k.c    |  5 ++++
>  risu_ppc64.c   |  5 ++++
>  6 files changed, 89 insertions(+), 34 deletions(-)
>
> diff --git a/reginfo.c b/reginfo.c
> index 90cea8f..4ff937f 100644
> --- a/reginfo.c
> +++ b/reginfo.c
> @@ -24,10 +24,19 @@ static int packet_mismatch;
>  int send_register_info(write_fn write_fn, void *uc)
>  {
>      struct reginfo ri;
> +    trace_header_t header;
>      int op;
> +
>      reginfo_init(&ri, uc);
>      op =3D get_risuop(&ri);
>
> +    /* Write a header with PC/op to keep in sync */
> +    header.pc =3D get_pc(&ri);
> +    header.risu_op =3D op;
> +    if (write_fn(&header, sizeof(header)) !=3D 0) {
> +        return -1;
> +    }
> +
>      switch (op) {
>      case OP_TESTEND:
>          write_fn(&ri, sizeof(ri));
> @@ -63,46 +72,63 @@ int send_register_info(write_fn write_fn, void *uc)
>  int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, =
void *uc)
>  {
>      int resp =3D 0, op;
> +    trace_header_t header;
>
>      reginfo_init(&master_ri, uc);
>      op =3D get_risuop(&master_ri);
>
> -    switch (op) {
> -    case OP_COMPARE:
> -    case OP_TESTEND:
> -    default:
> -        /* Do a simple register compare on (a) explicit request
> -         * (b) end of test (c) a non-risuop UNDEF
> -         */
> -        if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
> -            packet_mismatch =3D 1;
> -            resp =3D 2;
> -        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
> -            /* register mismatch */
> -            resp =3D 2;
> -        } else if (op =3D=3D OP_TESTEND) {
> -            resp =3D 1;
> -        }
> -        resp_fn(resp);
> -        break;
> -    case OP_SETMEMBLOCK:
> -        memblock =3D (void *)(uintptr_t)get_reginfo_paramreg(&master_ri)=
;
> -        break;
> -    case OP_GETMEMBLOCK:
> -        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
> -                              (uintptr_t)memblock);
> -        break;
> -    case OP_COMPAREMEM:
> -        mem_used =3D 1;
> -        if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
> -            packet_mismatch =3D 1;
> -            resp =3D 2;
> -        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) !=
=3D 0) {
> -            /* memory mismatch */
> -            resp =3D 2;
> +    if (read_fn(&header, sizeof(header)) !=3D 0) {
> +        return -1;
> +    }
> +
> +    if (header.risu_op =3D=3D op ) {

Stray extra space.

> +
> +        /* send OK for the header */
> +        resp_fn(0);
> +
> +        switch (op) {
> +        case OP_COMPARE:
> +        case OP_TESTEND:
> +        default:
> +            /* Do a simple register compare on (a) explicit request
> +             * (b) end of test (c) a non-risuop UNDEF
> +             */
> +            if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
> +                packet_mismatch =3D 1;
> +                resp =3D 2;
> +
> +            } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
> +                /* register mismatch */
> +                resp =3D 2;
> +
> +            } else if (op =3D=3D OP_TESTEND) {
> +                resp =3D 1;
> +            }
> +            resp_fn(resp);
> +            break;
> +        case OP_SETMEMBLOCK:
> +            memblock =3D (void *)(uintptr_t)get_reginfo_paramreg(&master=
_ri);
> +            break;
> +        case OP_GETMEMBLOCK:
> +            set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
> +                                  (uintptr_t)memblock);
> +            break;
> +        case OP_COMPAREMEM:
> +            mem_used =3D 1;
> +            if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
> +                packet_mismatch =3D 1;
> +                resp =3D 2;
> +            } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN=
) !=3D 0) {
> +                /* memory mismatch */
> +                resp =3D 2;
> +            }
> +            resp_fn(resp);
> +            break;
>          }
> +    } else {
> +        /* We are out of sync */
> +        resp =3D 2;
>          resp_fn(resp);
> -        break;

This is probably easier to read if structured the other way
up, so:

     if (header.risu_op !=3D op) {
        /* out of sync */
        ...
        return resp;
     }

and then you can leave the rest of the function alone.


>      }
>
>      return resp;
> diff --git a/risu.h b/risu.h
> index 32241bc..e9e70ab 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -51,6 +51,12 @@ extern int ismaster;
>
>  struct reginfo;
>
> +typedef struct
> +{
> +   uintptr_t pc;
> +   uint32_t risu_op;
> +} trace_header_t;
> +
>  /* Functions operating on reginfo */
>
>  /* To keep the read/write logic from multiplying across all arches
> @@ -102,6 +108,9 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri);
>   */
>  int get_risuop(struct reginfo *ri);
>
> +/* Return the PC from a reginfo */
> +uintptr_t get_pc(struct reginfo *ri);
> +
>  /* initialize structure from a ucontext */
>  void reginfo_init(struct reginfo *ri, ucontext_t *uc);
>
> diff --git a/risu_aarch64.c b/risu_aarch64.c
> index 9c6809d..492d141 100644
> --- a/risu_aarch64.c
> +++ b/risu_aarch64.c
> @@ -40,3 +40,8 @@ int get_risuop(struct reginfo *ri)
>      uint32_t risukey =3D 0x00005af0;
>      return (key !=3D risukey) ? -1 : op;
>  }
> +
> +uintptr_t get_pc(struct reginfo *ri)
> +{
> +   return ri->pc;

Indent here (and in some of the other versions of this
function) isn't matching the standard set up in earlier patches.

> +}
> diff --git a/risu_arm.c b/risu_arm.c
> index a55c6c2..5fcb2a5 100644
> --- a/risu_arm.c
> +++ b/risu_arm.c
> @@ -68,3 +68,8 @@ int get_risuop(struct reginfo *ri)
>      uint32_t risukey =3D (isz =3D=3D 2) ? 0xdee0 : 0xe7fe5af0;
>      return (key !=3D risukey) ? -1 : op;
>  }
> +
> +uintptr_t get_pc(struct reginfo *ri)
> +{
> +   return ri->gpreg[15];
> +}
> diff --git a/risu_m68k.c b/risu_m68k.c
> index 0bf5c14..1056eef 100644
> --- a/risu_m68k.c
> +++ b/risu_m68k.c
> @@ -33,3 +33,8 @@ int get_risuop(struct reginfo *ri)
>      uint32_t risukey =3D 0x4afc7000;
>      return (key !=3D risukey) ? -1 : op;
>  }
> +
> +uintptr_t get_pc(struct reginfo *ri)
> +{
> +    return ri->gregs[R_PC];
> +}
> diff --git a/risu_ppc64.c b/risu_ppc64.c
> index eb60573..83f8d1f 100644
> --- a/risu_ppc64.c
> +++ b/risu_ppc64.c
> @@ -38,3 +38,8 @@ int get_risuop(struct reginfo *ri)
>      uint32_t risukey =3D 0x00005af0;
>      return (key !=3D risukey) ? -1 : op;
>  }
> +
> +uintptr_t get_pc(struct reginfo *ri)
> +{
> +   return ri->nip;
> +}
> --

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
