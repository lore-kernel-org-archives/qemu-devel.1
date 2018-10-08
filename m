Received: from eggs.gnu.org ([2001:4830:134:3::10]:41074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9dck-0001Yp-OK
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9dch-0007Dx-Ag
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:03:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1g9dcf-00079a-Qu
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:03:30 -0400
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-5-marcandre.lureau@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <96e94552-5875-24dd-04ff-e0a73cfa923c@redhat.com>
Date: Tue, 9 Oct 2018 00:03:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qNSFB1A3PfpK5Erjk3a6rrZ1oxlxj5Hyk"
Subject: Re: [Qemu-devel] [PATCH v2 04/12] qemu-option: improve
 qemu_opts_print_help() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qNSFB1A3PfpK5Erjk3a6rrZ1oxlxj5Hyk
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <96e94552-5875-24dd-04ff-e0a73cfa923c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/12] qemu-option: improve
 qemu_opts_print_help() output
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
 <20180907075948.26917-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180907075948.26917-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

First of all, this patch broke iotest 082.  But then again, all that'd
be needed is a correction of the reference output.

However:

On 07.09.18 09:59, Marc-Andr=C3=A9 Lureau wrote:
> Modify qemu_opts_print_help():
> - to print expected argument type
> - skip description if not available
> - sort lines
> - prefix with the list name (like qdev, to avoid confusion)

Is this really useful?  My main issue right now is this:

$ qemu-img amend -f qcow2 -o help
Creation options for 'qcow2':
qcow2-create-opts.backing_file=3Dstr - File name of a base image
qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
[...]

(The reason create is not affected is because it copies the options into
a new list.)

This is supposed to be a human-readable output.  I don't see how the
rather internal list name[1] really helps here.

([1] I suppose if you write a configuration file, these identifiers
become visible.  But you don't use "help" in a configuration file, so I
find that point becomes rather moot.)

So this is why I don't think it is a good idea to print this name.

Now if it helped to prevent confusion, OK, but without further
explanation I don't see how.  Is this because I can use "help" in places
where it's unclear to the user what exactly the "help" refers to?

Also, this is bikeshedding, but still, I don't like the dot notation
here.  It doesn't mean anything (I can't use
"qcow2-create-opts.backing_file", nor can I use
"virtio-blk-pci.iothread"), so I'd prefer a nice "human" prefix like
"(qcow2-create-opts) backing_file" or "qcow2-create-opts: ".

Actually, I don't like the whole notation.  It looks like code.  Here is
an excerpt from -device virtio-blk-pci,help:

virtio-blk-pci.iothread=3Dlink<iothread>
virtio-blk-pci.request-merging=3Dbool (on/off)
virtio-blk-pci.logical_block_size=3Duint16 (A power of two between 512 an=
d
32768)

I can imagine some ways this would be more readable to human users (and
I don't think ease of parsing is a high priority here), for instance:

virtio-blk-pci options:
iothread: link to object of type iothread
request-merging: bool (on/off)
logical_block_size: uint16 (A power of two between 512 and 32768)


(But it appears that transforming "link<iothread>" to something readable
wouldn't be easy.  Though then again, I really think it's unreadable
unless you know what it's supposed to mean.)


So my concrete requests are this:

1. If the ID is really useful, I would put it above the whole list in an
own line.  It's not useful to human readers to re-print it on every
single line.  It would be nice to have an option to disable this line,
however, if the caller has already printed something along the lines
(which qemu-img amend does).

2. Put some more whitespace into the whole thing, and make it less
robot-y overall.  I much prefer ": " when reading over "=3D" (even
programming languages do when it's about types, in fact).


I'm not writing a patch yet because maybe there is some reason to print
the ID on every single line.  So I'm just proposing first.

Max

> - drop 16-chars alignment, use a '-' as seperator for option name and
>   description
>=20
> For ex, "-spice help" output is changed from:
>=20
> port             No description available
> tls-port         No description available
> addr             No description available
> [...]
> gl               No description available
> rendernode       No description available
>=20
> to:
>=20
> spice.addr=3Dstr
> spice.agent-mouse=3Dbool (on/off)
> spice.disable-agent-file-xfer=3Dbool (on/off)
> [...]
> spice.x509-key-password=3Dstr
> spice.zlib-glz-wan-compression=3Dstr
>=20
> "qemu-img create -f qcow2 -o help", changed from:
>=20
> size             Virtual disk size
> compat           Compatibility level (0.10 or 1.1)
> backing_file     File name of a base image
> [...]
> lazy_refcounts   Postpone refcount updates
> refcount_bits    Width of a reference count entry in bits
>=20
> to:
>=20
> backing_file=3Dstr - File name of a base image
> backing_fmt=3Dstr - Image format of the base image
> cluster_size=3Dsize - qcow2 cluster size
> [...]
> refcount_bits=3Dnum - Width of a reference count entry in bits
> size=3Dsize - Virtual disk size
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  util/qemu-option.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>=20
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 557b6c6626..069de36d2c 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -208,17 +208,51 @@ out:
>      return result;
>  }
> =20
> +static const char *opt_type_to_string(enum QemuOptType type)
> +{
> +    switch (type) {
> +    case QEMU_OPT_STRING:
> +        return "str";
> +    case QEMU_OPT_BOOL:
> +        return "bool (on/off)";
> +    case QEMU_OPT_NUMBER:
> +        return "num";
> +    case QEMU_OPT_SIZE:
> +        return "size";
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
>  void qemu_opts_print_help(QemuOptsList *list)
>  {
>      QemuOptDesc *desc;
> +    int i;
> +    GPtrArray *array =3D g_ptr_array_new();
> =20
>      assert(list);
>      desc =3D list->desc;
>      while (desc && desc->name) {
> -        printf("%-16s %s\n", desc->name,
> -               desc->help ? desc->help : "No description available");
> +        GString *str =3D g_string_new(NULL);
> +        if (list->name) {
> +            g_string_append_printf(str, "%s.", list->name);
> +        }
> +        g_string_append_printf(str, "%s=3D%s", desc->name,
> +                               opt_type_to_string(desc->type));
> +        if (desc->help) {
> +            g_string_append_printf(str, " - %s", desc->help);
> +        }
> +        g_ptr_array_add(array, g_string_free(str, false));
>          desc++;
>      }
> +
> +    g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp);
> +    for (i =3D 0; i < array->len; i++) {
> +        printf("%s\n", (char *)array->pdata[i]);
> +    }
> +    g_ptr_array_set_free_func(array, g_free);
> +    g_ptr_array_free(array, true);
> +
>  }
>  /* ------------------------------------------------------------------ =
*/
> =20
>=20



--qNSFB1A3PfpK5Erjk3a6rrZ1oxlxj5Hyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu71CAACgkQ9AfbAGHV
z0A0pQgAs71UMe8Potc15t1Xlt58qCW2W3qfjbLZV1zFAdSdiAobXhsRLU6brTBj
bqoWmAz/7+lV5WmGJ4VaBmEZyE6n12IfdJV7zne8zCXX5pmbAv2AjKpMc2+5iiVg
mUqH/Ev3L7FtGmJFE+DeQo7IG+d+fwG1q61/M4JWMmbEEzR9c4QK2k28d9vcEJgZ
Kz50WvRE4/S7/E4IkdqrJVrxI+IYxzon0FAevArOCHa+/f/Qx1nc3ubYit3qBQed
tivat5h0akfHd/aqHXpSUTgrT9GnjCm6XnrOGBN38KrggS73g16PlMPeHboPJB2C
2lzpTHuy9RM2pGJgnuL+HmUy4qvu3A==
=dcax
-----END PGP SIGNATURE-----

--qNSFB1A3PfpK5Erjk3a6rrZ1oxlxj5Hyk--
