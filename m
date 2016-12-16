Received: from eggs.gnu.org ([2001:4830:134:3::10]:32974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxeT-0001eQ-OD
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxeS-000529-Mk
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:54:41 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:34371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHxeS-00051F-HH
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:54:40 -0500
Received: by mail-vk0-x231.google.com with SMTP id x186so93349826vkd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:54:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209114830.9158-4-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
	<20161209114830.9158-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 18:54:19 +0000
Message-ID: <CAFEAcA_3hehGYfL+mR9ZMPdO_MhrzS2dD=6q7NHWiXM6Otea1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 03/10] risu: paramterise
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 9 December 2016 at 11:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

("parameterise" in subject)

> This is a precursor to record/playback support. Instead of passing the
> socket fd we now pass helper functions for reading/writing and
> responding. This will allow us to do the rest of the record/playback
> work without hacking up the arch specific stuff.
>
> I've also added a header packet with pc/risu op in it so we can keep
> better track of how things are going.

"also" tends to mean "I know this ought to be two patches really".
Can I ask you to split it up? I don't want to be too picky for
testing tool code, but this is a pretty big patch so I think it's
worth doing.

Missing signed-off-by line.

> ---
> v3
>   - new for v3
>   - arm, aarch64, ppc64
> ---
>  risu.c                 |  23 +++++++-
>  risu.h                 |  11 +++-
>  risu_aarch64.c         | 115 ++++++++++++++++++++++++--------------
>  risu_arm.c             | 147 +++++++++++++++++++++++++++++++------------=
------
>  risu_ppc64le.c         | 127 ++++++++++++++++++++++++++----------------
>  risu_reginfo_aarch64.h |   7 +++
>  risu_reginfo_arm.h     |   6 ++
>  risu_reginfo_ppc64le.h |   6 ++
>  8 files changed, 295 insertions(+), 147 deletions(-)
>
> diff --git a/risu.c b/risu.c
> index bcdc219..22571cd 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -47,9 +47,28 @@ void report_test_status(void *pc)
>     }
>  }
>
> +/* Master functions */
> +
> +int read_sock(void *ptr, size_t bytes)
> +{
> +   return recv_data_pkt(master_socket, ptr, bytes);
> +}
> +
> +void respond_sock(int r)
> +{
> +   send_response_byte(master_socket, r);
> +}
> +
> +/* Apprentice function */
> +
> +int write_sock(void *ptr, size_t bytes)
> +{
> +   return send_data_pkt(apprentice_socket, ptr, bytes);
> +}
> +
>  void master_sigill(int sig, siginfo_t *si, void *uc)
>  {
> -   switch (recv_and_compare_register_info(master_socket, uc))
> +   switch (recv_and_compare_register_info(read_sock, respond_sock, uc))
>     {
>        case 0:
>           /* match OK */
> @@ -63,7 +82,7 @@ void master_sigill(int sig, siginfo_t *si, void *uc)
>
>  void apprentice_sigill(int sig, siginfo_t *si, void *uc)
>  {
> -   switch (send_register_info(apprentice_socket, uc))
> +   switch (send_register_info(write_sock, uc))
>     {
>        case 0:
>           /* match OK */
> diff --git a/risu.h b/risu.h
> index e4bb323..b0178df 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -40,17 +40,24 @@ extern int ismaster;
>
>  /* Interface provided by CPU-specific code: */
>
> +/* To keep the read/write logic from multiplying across all arches
> + * we wrap up the function here to keep all the changes in one place
> + */
> +typedef int (*write_fn) (void *ptr, size_t bytes);
> +typedef int (*read_fn) (void *ptr, size_t bytes);
> +typedef void (*respond_fn) (int response);

I'm going to ask you to indulge a style preference:
typedefs for function pointers should be the type of the function:
 typedef int write_fn(void *ptr, size_t bytes);

and then when you're dealing with it you use the '*', eg
 int send_register_info(write_fn *writefn, void *uc);

I think it's clearer because it means the type name fits what it
is: a "write_fn" is a function, and a "write_fn *" is a pointer to
a function.

> diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
> index 166b76c..db51cb2 100644
> --- a/risu_reginfo_aarch64.h
> +++ b/risu_reginfo_aarch64.h
> @@ -28,6 +28,13 @@ struct reginfo
>      __uint128_t vregs[32];
>  };
>
> +typedef struct
> +{
> +    uint64_t pc;
> +    uint32_t risu_op;
> +} trace_header_t;
> +
> +
>  /* initialize structure from a ucontext */
>  void reginfo_init(struct reginfo *ri, ucontext_t *uc);
>
> diff --git a/risu_reginfo_arm.h b/risu_reginfo_arm.h
> index 80c28c6..7e7e408 100644
> --- a/risu_reginfo_arm.h
> +++ b/risu_reginfo_arm.h
> @@ -23,6 +23,12 @@ struct reginfo
>      uint32_t fpscr;
>  };
>
> +typedef struct
> +{
> +    uint32_t pc;
> +    uint32_t risu_op;
> +} trace_header_t;

Can we just transfer the PC as 64 bits on all architectures,
so we don't need to define a struct for each one?

> +
>  /* initialize a reginfo structure with data from uc */
>  void reginfo_init(struct reginfo *ri, ucontext_t *uc);
>
> diff --git a/risu_reginfo_ppc64le.h b/risu_reginfo_ppc64le.h
> index abe6002..49b4938 100644
> --- a/risu_reginfo_ppc64le.h
> +++ b/risu_reginfo_ppc64le.h
> @@ -25,6 +25,12 @@ struct reginfo
>      vrregset_t vrregs;
>  };
>
> +typedef struct
> +{
> +    uint64_t pc;
> +    uint32_t risu_op;
> +} trace_header_t;
> +
>  /* initialize structure from a ucontext */
>  void reginfo_init(struct reginfo *ri, ucontext_t *uc);
>
> --
> 2.11.0

thanks
-- PMM
