Received: from eggs.gnu.org ([2001:4830:134:3::10]:38054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMKjB-0000lA-Nx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMKj7-0003Qs-MS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:30:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMKj5-0002zb-P3
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:30:36 -0500
Date: Mon, 12 Nov 2018 20:30:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181112223027.GZ12503@habkost.net>
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181111233622.8976-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 02/11] decodetree: Add multiple include
 guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Mon, Nov 12, 2018 at 12:36:13AM +0100, Philippe Mathieu-Daud=E9 wrote:
> It is necessary when splitting an ISA, or when using multiple ISAs.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> TODO: explain why, use case
> TODO: escape full path?
> ---
>  scripts/decodetree.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 0bc73b5990..5dea15e7a5 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -1030,7 +1030,11 @@ def main():
>      else:
>          output_fd =3D sys.stdout
> =20
> +    hdr_guard =3D filename.split(os.path.sep)[-1].upper().replace('.',=
 '_') + "_H"

Isn't
  filename.split(os.path.sep)[-1]
equivalent to
  os.path.basename(filename)
?


> +    hdr_guard =3D filename.split(os.path.sep)[-1].upper().replace('.',=
 '_') + "_H"
> +
>      output_autogen()
> +    output('#ifndef ' + hdr_guard + '\n')
> +    output('#define ' + hdr_guard + '\n')
>      for n in sorted(arguments.keys()):
>          f =3D arguments[n]
>          f.output_def()
> @@ -1066,6 +1070,7 @@ def main():
>      t.output_code(4, False, 0, 0)
> =20
>      output('}\n')
> +    output('#endif /* ' + hdr_guard + ' */\n')
> =20
>      if output_file:
>          output_fd.close()
> --=20
> 2.17.2
>=20

--=20
Eduardo
