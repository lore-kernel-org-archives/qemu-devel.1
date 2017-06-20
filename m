Received: from eggs.gnu.org ([2001:4830:134:3::10]:41551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJvK-0001Sj-AP
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJvF-0000MZ-O1
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:14:30 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJvF-0000MF-Ha
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:14:25 -0400
Received: by mail-wr0-x233.google.com with SMTP id r103so92953301wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:14:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-11-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-11-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:14:03 +0100
Message-ID: <CAFEAcA9oPkE_5TVO6ameGqYO9b_jGXFn-yrPp3tjfnS5x8adCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 10/13] risu: handle trace through
 stdin/stdout
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
> Trace files can get quite large so it would be useful to be able to
> just capture the trace stream with stdin/stdout for processing in a
> pipe line. The sort of case where this is useful is for building
> static binaries where zlib support is missing for whatever reason.
>
> It can also be used in testing pipelines.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  risu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/risu.c b/risu.c
> index 93c274b..e94b54b 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -312,7 +312,11 @@ int main(int argc, char **argv)
>
>      if (ismaster) {
>          if (trace) {
> -            master_fd =3D open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
> +            if (strncmp(trace_fn, "-", strlen(trace_fn))=3D=3D0) {

Why not just strcmp() ?

> +                master_fd =3D fileno(stdout);

   =3D STDOUT_FILENO;

> +            } else {
> +                master_fd =3D open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
> +            }
>          } else {
>              fprintf(stderr, "master port %d\n", port);
>              master_fd =3D master_connect(port);
> @@ -320,7 +324,11 @@ int main(int argc, char **argv)
>          return master();
>      } else {
>          if (trace) {
> -            apprentice_fd =3D open(trace_fn, O_RDONLY);
> +            if (strncmp(trace_fn, "-", strlen(trace_fn))=3D=3D0) {
> +                apprentice_fd =3D fileno(stdin);

 =3D STDIN_FILENO;

> +            } else {
> +                apprentice_fd =3D open(trace_fn, O_RDONLY);
> +            }
>          } else {
>              fprintf(stderr, "apprentice host %s port %d\n", hostname, po=
rt);
>              apprentice_fd =3D apprentice_connect(hostname, port);
> --
> 2.13.0
>

thanks
-- PMM
