Received: from eggs.gnu.org ([2001:4830:134:3::10]:60211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJOy-0007YT-Tj
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJOx-0005Ln-Ci
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:41:04 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJOx-0005Ko-0q
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:41:03 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y25so52871223wrd.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 06:41:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-8-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 14:40:41 +0100
Message-ID: <CAFEAcA_-tsYN5FMeyE4_XuJMoR=UKQgD4EAoju6+nHcWA6NySA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 07/13] risu: paramterise
 send/receive functions
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
> This is a precursor to record/playback support. Instead of passing the
> socket fd we now pass helper functions for reading/writing and
> responding. This will allow us to do the rest of the record/playback
> cleanly outside of the main worker function.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v5
>   - re-base without tab/format cleanps
> v4
>   - split header code
>   - fix formatting foo-bar's
> v3
>   - new for v3
>   - arm, aarch64, ppc64
> ---
>  reginfo.c | 39 +++++++++++++++++++--------------------
>  risu.c    | 23 +++++++++++++++++++++--
>  risu.h    | 11 +++++++++--
>  3 files changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/reginfo.c b/reginfo.c
> index 31bb99f..90cea8f 100644
> --- a/reginfo.c
> +++ b/reginfo.c
> @@ -21,7 +21,7 @@ uint8_t apprentice_memblock[MEMBLOCKLEN];
>  static int mem_used;
>  static int packet_mismatch;
>
> -int send_register_info(int sock, void *uc)
> +int send_register_info(write_fn write_fn, void *uc)
>  {
>      struct reginfo ri;
>      int op;
> @@ -29,24 +29,25 @@ int send_register_info(int sock, void *uc)
>      op =3D get_risuop(&ri);
>
>      switch (op) {
> -    case OP_COMPARE:
>      case OP_TESTEND:
> -    default:
> -        /* Do a simple register compare on (a) explicit request
> -         * (b) end of test (c) a non-risuop UNDEF
> -         */
> -        return send_data_pkt(sock, &ri, sizeof(ri));
> +        write_fn(&ri, sizeof(ri));
> +        return 1;

Why the change from "return write function's return value"
to "ignore return value and always return 1" for OP_TESTEND ?

>      case OP_COMPAREMEM:
> -        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
> +        return write_fn(memblock, MEMBLOCKLEN);
>          break;

...here we still just pass the return value through, for instance.

> +    case OP_COMPARE:
> +    default:
> +        /* Do a simple register compare on (a) explicit request
> +         * (b) end of test (c) a non-risuop UNDEF
> +         */
> +        return write_fn(&ri, sizeof(ri));
>      }
>      return 0;
>  }
> @@ -59,7 +60,7 @@ int send_register_info(int sock, void *uc)
>   * that says whether it is register or memory data, so if the two
>   * sides get out of sync then we will fail obscurely.
>   */
> -int recv_and_compare_register_info(int sock, void *uc)
> +int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, =
void *uc)
>  {
>      int resp =3D 0, op;
>
> @@ -73,36 +74,34 @@ int recv_and_compare_register_info(int sock, void *uc=
)
>          /* Do a simple register compare on (a) explicit request
>           * (b) end of test (c) a non-risuop UNDEF
>           */
> -        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) =
{
> +        if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
>              packet_mismatch =3D 1;
>              resp =3D 2;
> -
>          } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
>              /* register mismatch */
>              resp =3D 2;
> -
>          } else if (op =3D=3D OP_TESTEND) {
>              resp =3D 1;
>          }
> -        send_response_byte(sock, resp);
> +        resp_fn(resp);
>          break;
>      case OP_SETMEMBLOCK:
> -        memblock =3D (void *) (uintptr_t) get_reginfo_paramreg(&master_r=
i);
> +        memblock =3D (void *)(uintptr_t)get_reginfo_paramreg(&master_ri)=
;
>          break;
>      case OP_GETMEMBLOCK:
>          set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
> -                              (uintptr_t) memblock);
> +                              (uintptr_t)memblock);
>          break;
>      case OP_COMPAREMEM:
>          mem_used =3D 1;
> -        if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
> +        if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
>              packet_mismatch =3D 1;
>              resp =3D 2;
>          } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) !=
=3D 0) {
>              /* memory mismatch */
>              resp =3D 2;
>          }
> -        send_response_byte(sock, resp);
> +        resp_fn(resp);
>          break;
>      }
>
> diff --git a/risu.c b/risu.c
> index a10422a..88e586c 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -37,9 +37,28 @@ sigjmp_buf jmpbuf;
>  /* Should we test for FP exception status bits? */
>  int test_fp_exc;
>
> +/* Master functions */
> +
> +int read_sock(void *ptr, size_t bytes)
> +{
> +    return recv_data_pkt(master_socket, ptr, bytes);
> +}
> +
> +void respond_sock(int r)
> +{
> +    send_response_byte(master_socket, r);
> +}
> +
> +/* Apprentice function */
> +
> +int write_sock(void *ptr, size_t bytes)
> +{
> +    return send_data_pkt(apprentice_socket, ptr, bytes);
> +}
> +
>  void master_sigill(int sig, siginfo_t *si, void *uc)
>  {
> -    switch (recv_and_compare_register_info(master_socket, uc)) {
> +    switch (recv_and_compare_register_info(read_sock, respond_sock, uc))=
 {
>      case 0:
>          /* match OK */
>          advance_pc(uc);
> @@ -52,7 +71,7 @@ void master_sigill(int sig, siginfo_t *si, void *uc)
>
>  void apprentice_sigill(int sig, siginfo_t *si, void *uc)
>  {
> -    switch (send_register_info(apprentice_socket, uc)) {
> +    switch (send_register_info(write_sock, uc)) {
>      case 0:
>          /* match OK */
>          advance_pc(uc);
> diff --git a/risu.h b/risu.h
> index 78a7313..32241bc 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -53,17 +53,24 @@ struct reginfo;
>
>  /* Functions operating on reginfo */
>
> +/* To keep the read/write logic from multiplying across all arches
> + * we wrap up the function here to keep all the changes in one place
> + */

Stale comment? The calling code is not per-arch any more.

> +typedef int (*write_fn) (void *ptr, size_t bytes);
> +typedef int (*read_fn) (void *ptr, size_t bytes);
> +typedef void (*respond_fn) (int response);
> +
>  /* Send the register information from the struct ucontext down the socke=
t.
>   * Return the response code from the master.
>   * NB: called from a signal handler.
>   */
> -int send_register_info(int sock, void *uc);
> +int send_register_info(write_fn write_fn, void *uc);
>
>  /* Read register info from the socket and compare it with that from the
>   * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
>   * NB: called from a signal handler.
>   */
> -int recv_and_compare_register_info(int sock, void *uc);
> +int recv_and_compare_register_info(read_fn read_fn, respond_fn respond, =
void *uc);
>
>  /* Print a useful report on the status of the last comparison
>   * done in recv_and_compare_register_info(). This is called on
> --
> 2.13.0
>

thanks
-- PMM
