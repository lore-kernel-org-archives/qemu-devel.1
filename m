Received: from eggs.gnu.org ([2001:4830:134:3::10]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXHe-0003YX-8S
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXHb-0001ZH-3L
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:22:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPXHa-0001Yy-RD
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:22:23 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFA1CC056793
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:22:22 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9dbb0df-1bdf-5aa1-aea9-cd6751e24a4e@redhat.com>
Date: Fri, 6 Jan 2017 10:22:19 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3iiWnHbgUoe8iasjNlqsHo4P3NSIeHmp2"
Subject: Re: [Qemu-devel] [PATCH 7/8] util: add qemu_opt_get_all() to get
 repeated opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3iiWnHbgUoe8iasjNlqsHo4P3NSIeHmp2
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <b9dbb0df-1bdf-5aa1-aea9-cd6751e24a4e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] util: add qemu_opt_get_all() to get
 repeated opts
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-8-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:07 AM, Daniel P. Berrange wrote:
> The QemuOpts parser accepts repeated option names, storing
> all the provided values. qemu_opt_get() then just returns
> the last value. There is no way to get the other values
> without using a callback function to iterate over all
> option names. Add a qemu_opt_get_all() method to return
> a string list of all values.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/qemu/option.h |  1 +
>  util/qemu-option.c    | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index 1f9e3f9..689e0a8 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -65,6 +65,7 @@ struct QemuOptsList {
>  };
> =20
>  const char *qemu_opt_get(QemuOpts *opts, const char *name);
> +size_t qemu_opt_get_all(QemuOpts *opts, const char *name, char ***vals=
);
>  char *qemu_opt_get_del(QemuOpts *opts, const char *name);
>  /**
>   * qemu_opt_has_help_opt:
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 3467dc2..0418d71 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -332,6 +332,28 @@ const char *qemu_opt_get(QemuOpts *opts, const cha=
r *name)
>      return opt ? opt->str : NULL;
>  }
> =20
> +size_t qemu_opt_get_all(QemuOpts *opts, const char *name, char ***vals=
)

Documentation would be nice, including that the caller must free two
levels of results.

> +{
> +    QemuOpt *opt;
> +    size_t nvals =3D 0;
> +
> +    *vals =3D NULL;
> +
> +    QTAILQ_FOREACH(opt, &opts->head, next) {
> +        if (!g_str_equal(opt->name, name)) {
> +            continue;
> +        }
> +
> +        *vals =3D g_renew(char *, *vals, nvals + 1);
> +        (*vals)[nvals++] =3D g_strdup(opt->str);

This one is noticeably O(n^2) if the user supplies LOTS of repeated
options on the command line.  Should we be smarter about the allocation,
since unlike DNS resolution, we don't have quite as much assurance that
the user won't be doing that?  You do have an upper bound that this
won't call g_renew() any more than the number of opts present in the
command-line argument that you could use for O(1) instead of O(n) list
allocations (the O(n^2) is caused by O(n) allocations coupled with O(n)
copying between allocations), but I don't know if we have easy access to
that value, nor if it is wasteful to over-allocate when the more common
case is that most of the opts are not equal to name.

> +    }
> +    if (nvals) {
> +        *vals =3D g_renew(char *, *vals, nvals + 1);
> +        (*vals)[nvals] =3D NULL;
> +    }
> +    return nvals;
> +}
> +
>  /* Get a known option (or its default) and remove it from the list
>   * all in one action. Return a malloced string of the option value.
>   * Result must be freed by caller with g_free().
>=20

The idea makes sense, though.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3iiWnHbgUoe8iasjNlqsHo4P3NSIeHmp2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb8Q7AAoJEKeha0olJ0NqYmQIAJJesWs+y51/zfSbf1UW2BHl
VTS9g99PEb4nzDuemkqIAoE6Uzf/lpo1/GA2L2irML+2YbAjmPCEb9LXbOhOOqsF
gfdFzBYwWQV83zTy3WM+jLrZL8w0Up+tSYvkSHQ7tVwBHvhpcCYgqBNZUcM6ny2e
LiDd+P15RinbU4TzWquazQxKYuFwDL2oL5IrlczoGYTVqJZfZLd2mxkoArEP5APu
Sl2bIT2v+Q7bLOJXgSCsJ5UldIHbcB/fG53L9ysrJw2nEbvR7lNnMTrUlDxQ6Red
OFT8dyjBLOxs6xMmIEiLwZj5yNBBc9ah8Aan/AhZOR/x1dqDTwLglOS34JMB+HA=
=woUw
-----END PGP SIGNATURE-----

--3iiWnHbgUoe8iasjNlqsHo4P3NSIeHmp2--
