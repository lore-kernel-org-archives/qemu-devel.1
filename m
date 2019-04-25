Received: from eggs.gnu.org ([209.51.188.92]:37202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeez-0004hs-2e
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeex-0000ud-66
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:43:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJeev-0000px-7G
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:43:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id 10so9444091wmk.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:43:29 -0700 (PDT)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<20190408182748.1238-6-jan.bobek@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190408182748.1238-6-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:43:26 +0100
Message-ID: <87zhoeurnl.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 5/5] risu_i386: remove old unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Bobek <jan.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


Jan Bobek <jan.bobek@gmail.com> writes:

> The code being removed is a remnant of the past implementation; it has
> since been replaced by its more powerful, architecture-independent
> counterpart in reginfo.c.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_i386.c | 58 -----------------------------------------------------
>  1 file changed, 58 deletions(-)
>
> diff --git a/risu_i386.c b/risu_i386.c
> index eb4dff4..14b0db3 100644
> --- a/risu_i386.c
> +++ b/risu_i386.c
> @@ -16,13 +16,6 @@
>  #include "risu.h"
>  #include "risu_reginfo_i386.h"
>
> -struct reginfo master_ri, apprentice_ri;
> -
> -static int insn_is_ud2(uint32_t insn)
> -{
> -    return ((insn & 0xffff) =3D=3D 0x0b0f);
> -}
> -
>  void advance_pc(void *vuc)
>  {
>      ucontext_t *uc =3D (ucontext_t *) vuc;
> @@ -61,54 +54,3 @@ uintptr_t get_pc(struct reginfo *ri)
>  {
>      return ri->gregs[REG_EIP];
>  }
> -
> -int send_register_info(int sock, void *uc)
> -{
> -    struct reginfo ri;
> -    fill_reginfo(&ri, uc);
> -    return send_data_pkt(sock, &ri, sizeof(ri));
> -}
> -
> -/* Read register info from the socket and compare it with that from the
> - * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
> - * NB: called from a signal handler.
> - */
> -int recv_and_compare_register_info(int sock, void *uc)
> -{
> -    int resp;
> -    fill_reginfo(&master_ri, uc);
> -    recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri));
> -    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) !=3D 0) {
> -        /* mismatch */
> -        resp =3D 2;
> -    } else if (insn_is_ud2(master_ri.faulting_insn)) {
> -        /* end of test */
> -        resp =3D 1;
> -    } else {
> -        /* either successful match or expected undef */
> -        resp =3D 0;
> -    }
> -    send_response_byte(sock, resp);
> -    return resp;
> -}
> -
> -/* Print a useful report on the status of the last comparison
> - * done in recv_and_compare_register_info(). This is called on
> - * exit, so need not restrict itself to signal-safe functions.
> - * Should return 0 if it was a good match (ie end of test)
> - * and 1 for a mismatch.
> - */
> -int report_match_status(void)
> -{
> -    fprintf(stderr, "match status...\n");
> -    fprintf(stderr, "master reginfo:\n");
> -    dump_reginfo(&master_ri);
> -    fprintf(stderr, "apprentice reginfo:\n");
> -    dump_reginfo(&apprentice_ri);
> -    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) =3D=3D 0) {
> -        fprintf(stderr, "match!\n");
> -        return 0;
> -    }
> -    fprintf(stderr, "mismatch!\n");
> -    return 1;
> -}


--
Alex Benn=C3=A9e
