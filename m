Received: from eggs.gnu.org ([2001:4830:134:3::10]:54266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffB2V-0000yb-KF
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffB2Q-0006rn-Nx
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ffB2Q-0006r8-IM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:28:10 -0400
Date: Mon, 16 Jul 2018 18:28:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716212804.GS914@localhost.localdomain>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180514171913.17664-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180514171913.17664-3-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] i386: only parse the initrd_filename
 once for multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, May 14, 2018 at 06:19:12PM +0100, Daniel P. Berrang=E9 wrote:
> The multiboot code parses the initrd_filename twice, first to count how
> many entries there are, and second to process each entry. This changes
> the first loop to store the parse module names in a list, and the secon=
d
> loop can now use these names. This avoids having to pass NULL to the
> get_opt_value() method which means it can safely assume a non-NULL para=
m.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
[...]
> @@ -352,10 +350,10 @@ int load_multiboot(FWCfgState *fw_cfg,
>              mb_debug("mod_start: %p\nmod_end:   %p\n  cmdline: "TARGET=
_FMT_plx,
>                       (char *)mbs.mb_buf + offs,
>                       (char *)mbs.mb_buf + offs + mb_mod_length, c);
> -            initrd_filename =3D next_initrd+1;
>              g_free(one_file);
> -            one_file =3D NULL;
> -        } while (not_last);
> +            tmpl =3D tmpl->next;
> +        }
> +        g_list_free(mods);

I thought this would cause double free of tmpl->data, but
g_list_free() won't free the elements' data.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queueing on x86-next.

--=20
Eduardo
