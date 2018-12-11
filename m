Received: from eggs.gnu.org ([2001:4830:134:3::10]:54626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWlZs-00011T-T7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWlZl-0005ig-8I
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:12:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWlZf-0005di-8U
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:12:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7D7A30B8FB7
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 17:11:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-27-marcandre.lureau@redhat.com>
Date: Tue, 11 Dec 2018 18:11:51 +0100
In-Reply-To: <20181208111606.8505-27-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:16:05 +0400")
Message-ID: <87sgz4ng2w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 26/27] qapi: add more conditions
 to SPICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Now that member can be made conditional, let's make SPICE chardev
> conditional:
>
> * spiceport, spicevmc
>
>   Before and after the patch for !CONFIG_SPICE, the error is the
>   same ('spiceport' is not a valid char driver name).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/char.json | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index 24628331ec..77ed847972 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -332,8 +332,8 @@
>  ##
>  { 'struct': 'ChardevSpiceChannel',
>    'data': { 'type': 'str' },
> -  'base': 'ChardevCommon' }
> -# TODO: 'if': 'defined(CONFIG_SPICE)'
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevSpicePort:
> @@ -346,8 +346,8 @@
>  ##
>  { 'struct': 'ChardevSpicePort',
>    'data': { 'fqdn': 'str' },
> -  'base': 'ChardevCommon' }
> -# TODO: 'if': 'defined(CONFIG_SPICE)'
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevVC:
> @@ -404,10 +404,10 @@
>              'testdev': 'ChardevCommon',
>              'stdio': 'ChardevStdio',
>              'console': 'ChardevCommon',
> -            'spicevmc': 'ChardevSpiceChannel',
> -# TODO: { 'type': 'ChardevSpiceChannel', 'if': 'defined(CONFIG_SPICE)' },
> -            'spiceport': 'ChardevSpicePort',
> -# TODO: { 'type': 'ChardevSpicePort', 'if': 'defined(CONFIG_SPICE)' },
> +            'spicevmc': { 'type': 'ChardevSpiceChannel',
> +                          'if': 'defined(CONFIG_SPICE)' },
> +            'spiceport': { 'type': 'ChardevSpicePort',
> +                           'if': 'defined(CONFIG_SPICE)' },
>              'vc': 'ChardevVC',
>              'ringbuf': 'ChardevRingbuf',
>              # next one is just for compatibility

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewing this patch's effect on generated files led me to a few things.
None of them need to be addressed to get this series accepted.  I
actually recommend not to address them in this series, because that
could lead to further delays.

There's an opportunity for minor output beautification: back-to-back
#endif / #if like

    #endif /* defined(CONFIG_SPICE) */
    #if defined(CONFIG_SPICE)

in generated C could be omitted.

The generated documentation shows conditionals as

    If: 'defined(CONFIG_SPICE)'

We should at least explain this notation in the introduction.  Other
notation, too.  Predates this series.

Should we *strip* documentation for disabled stuff instead?
Complication: disabled everywhere, or just for a target?  We build the
documentation only once, and that's a feature.  We can therefore only
strip documentation for stuff that's disabled target-independently.
That's a bit more involved.
