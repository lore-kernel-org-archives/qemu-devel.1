Received: from eggs.gnu.org ([209.51.188.92]:48026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyvso-0003OZ-6v
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gyvsn-0004U0-GN
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:52:10 -0500
MIME-Version: 1.0
References: <20190227012132.16271-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190227012132.16271-1-david@gibson.dropbear.id.au>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Feb 2019 10:51:54 +0100
Message-ID: <CAJ+F1CKmkJ5NcfjT31ChVis7zNdiOWgvXHGAc_S7Zrx0EVr4Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Allow -sandbox off with --disable-seccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Eduardo Otubo <otubo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Feb 27, 2019 at 2:22 AM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> At present, when seccomp support is compiled out with --disable-seccomp
> we fail with an error if the user puts -sandbox on the command line.
>
> That kind of makes sense, but it's a bit strange that we reject a request
> to disable sandboxing with "-sandbox off" saying we don't support
> sandboxing.
>
> This puts in a small sandbox to (correctly) silently ignore -sandbox off
> when we don't have sandboxing support compiled in.  This makes life easie=
r
> for testcases, since they can safely specify "-sandbox off" without havin=
g
> to care if the qemu they're using is compiled with sandbox support or not=
.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 502857a176..9d5f1b7ebb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3857,9 +3857,11 @@ int main(int argc, char **argv, char **envp)
>                      exit(1);
>                  }
>  #else
> -                error_report("-sandbox support is not enabled "
> -                             "in this QEMU binary");
> -                exit(1);
> +                if (!g_str_equal(optarg, "off")) {
> +                    error_report("-sandbox support is not enabled "
> +                                 "in this QEMU binary");
> +                    exit(1);
> +                }
>  #endif
>                  break;
>              case QEMU_OPTION_add_fd:
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
