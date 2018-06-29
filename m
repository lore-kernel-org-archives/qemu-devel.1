Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZ0DY-0003pi-Pk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fZ0DV-0006TP-MY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:42:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fZ0DV-0006QR-GM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:42:05 -0400
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-5-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a30c2d7-b6b7-c6e9-1c70-0fd4a90bca0c@redhat.com>
Date: Fri, 29 Jun 2018 15:41:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 04/46] checkpatch: Recognize IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Pasi Savanainen <pasi.savanainen@nixu.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Joe Perches <joe@perches.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org

On 06/25/2018 07:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Do not match the IEC binary prefix as camelcase typedefs.
>=20
> This fixes:
>=20
>      ERROR: "foo * bar" should be "foo *bar"
>      #310: FILE: hw/ppc/ppc440_uc.c:564:
>      +        size =3D 8 * MiB * sh;
>      total: 1 errors, 0 warnings, 433 lines checked
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   scripts/checkpatch.pl | 1 +
>   1 file changed, 1 insertion(+)

Warning - my perl regex-fu is weak; but I'll give this a shot.

>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e3d8c2cdfc..223681bfd0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -242,6 +242,7 @@ our $UTF8	=3D qr{
>   # There are still some false positives, but this catches most
>   # common cases.
>   our $typeTypedefs =3D qr{(?x:
> +        (?![KMGTPE]iB)                      # IEC binary prefix (do no=
t match)

I had to (re-)read 'perldoc perlretut', but found what I was looking=20
for.  You are adding a zero-length negated lookahead assertion that=20
anything matching the pattern [KMGTPE]iB is not matched to the rest of=20
the regex.

>           [A-Z][A-Z\d_]*[a-z][A-Za-z\d_]*     # camelcase
>           | [A-Z][A-Z\d_]*AIOCB               # all uppercase
>           | [A-Z][A-Z\d_]*CPU                 # all uppercase

and the rest of this regex is picking out any sequence that the code=20
should treat as a typedef.  Ergo, with your negative lookahead, we are=20
no longer treating the numeric mixed-case constants as typedefs, and the=20
rest of the script that warns on formatting issues where a typedef=20
appears to be used with a '*' for creating a pointer no longer trigger.

Since that's enough to shut up the false positives you were seeing, then=20
it looks right to me.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
