Received: from eggs.gnu.org ([2001:4830:134:3::10]:49490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSUGz-0006T7-S9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSUGw-0007rK-Oa
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSUGw-0007qx-IK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:22:42 -0400
Date: Mon, 11 Jun 2018 18:22:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611212239.GB7451@localhost.localdomain>
References: <20180606165527.17365-1-berrange@redhat.com>
	<20180606165527.17365-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606165527.17365-4-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] i386: display known CPUID features
 linewrapped, in alphabetical order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 06, 2018 at 05:55:27PM +0100, Daniel P. Berrang=E9 wrote:
[...]
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cb074082b3..8043e41be8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3157,17 +3157,21 @@ static void x86_cpu_class_check_missing_feature=
s(X86CPUClass *xcc,
> =20
>  /* Print all cpuid feature names in featureset
>   */
> -static void listflags(FILE *f, fprintf_function print, const char **fe=
atureset)
> +static void listflags(FILE *f, fprintf_function print, GList *features=
)
>  {
> -    int bit;
> -    bool first =3D true;
> -
> -    for (bit =3D 0; bit < 32; bit++) {
> -        if (featureset[bit]) {
> -            print(f, "%s%s", first ? "" : " ", featureset[bit]);
> -            first =3D false;
> +    size_t len =3D 0;
> +    GList *tmp;
> +
> +    for (tmp =3D features; tmp; tmp =3D tmp->next) {
> +        const char *name =3D tmp->data;
> +        if ((len + strlen(name) + 1) >=3D 75) {
> +            print(f, "\n");
> +            len =3D 0;
>          }
> +        print(f, "%s%s", len =3D=3D 0 ? "  " : " ", name);
> +        len +=3D strlen(name) + 1;
>      }
> +    print(f, "\n");

I'd love to have generic helper functions to format text like
this, but that's not a reason to block this patch from being
included.  I will queue the series on x86-next.  Thanks!

--=20
Eduardo
