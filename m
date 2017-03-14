Received: from eggs.gnu.org ([2001:4830:134:3::10]:48001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhy5-0000eL-PO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnhy4-0005hJ-HT
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:38:09 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cnhy4-0005fd-5o
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:38:08 -0400
Received: by mail-lf0-x244.google.com with SMTP id v2so13567257lfi.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-11-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:37:56 +0000
Message-ID: <CAJ+F1CKiostFih6p_7Msm33SjxuV9YNFOvcYkKiZqqLdM2q8jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 10/47] qapi2texi: Fix up output
 around #optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On Mon, Mar 13, 2017 at 10:23 AM Markus Armbruster <armbru@redhat.com>
wrote:

> We use tag #optional to mark optional members, like this:
>
>     # @name: #optional The name of the guest
>
> texi_body() strips #optional, but not whitespace around it.  For the
> above, we get in qemu-qmp-qapi.texi
>
>     @item @code{'name'} (optional)
>      The name of the guest
>     @end table
>
> The extra space can lead to artifacts in output, e.g in
> qemu-qmp-ref.7.pod
>
>     =3Ditem C<'name'> (optional)
>
>      The name of the guest
>
> and then in qemu-qmp-ref.7
>
>     .IX Item "name (optional)"
>     .Vb 1
>     \& The name of the guest
>     .Ve
>
> instead of intended plain
>
>     .IX Item "name (optional)"
>     The name of the guest
>
> Get rid of these artifacts by removing whitespace around #optional
> along with it.
>
> This turns three minus signs in qapi-schema.json into markup, because
> they're now at the beginning of the line.  Drop them, they're unwanted
> there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi-schema.json     | 6 +++---
>  scripts/qapi2texi.py | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 17c766e..52141cd 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3779,11 +3779,11 @@
>  #
>  # @dstport: #optional destination port - mandatory for udp, optional for
> ip
>  #
> -# @ipv6: #optional - force the use of ipv6
> +# @ipv6: #optional force the use of ipv6
>  #
> -# @udp: #optional - use the udp version of l2tpv3 encapsulation
> +# @udp: #optional use the udp version of l2tpv3 encapsulation
>  #
> -# @cookie64: #optional - use 64 bit coookies
> +# @cookie64: #optional use 64 bit coookies
>  #
>  # @counter: #optional have sequence counter
>  #
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 06d6abf..0f3e573 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -137,7 +137,8 @@ def texi_body(doc):
>              desc =3D str(section)
>              opt =3D ''
>              if "#optional" in desc:
> -                desc =3D desc.replace("#optional", "")
> +                desc =3D re.sub(r'^ *#optional *\n?|\n? *#optional
> *$|#optional',
> +                              '', desc)
>                  opt =3D ' (optional)'
>              body +=3D "@item @code{'%s'}%s\n%s\n" % (arg, opt,
>                                                     texi_format(desc))
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
