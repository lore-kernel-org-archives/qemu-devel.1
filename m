Received: from eggs.gnu.org ([2001:4830:134:3::10]:58322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwNq-0007KY-Rd
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwNm-0002XC-46
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:39:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxwNl-0002Ut-Td
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:39:46 -0400
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
	<20180906151227.25514-11-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02fe751d-661d-04ab-44ba-caf3469eebcd@redhat.com>
Date: Thu, 6 Sep 2018 10:39:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180906151227.25514-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] vl: list user creatable propeties if
 '?' as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 09/06/2018 10:12 AM, Marc-Andr=C3=A9 Lureau wrote:

Subject has typo and awkward grammar; I'd suggest:

vl: list user creatable properties when 'help' is argument

> Iterate over the writable class properties, sort and print them out
> with the description if available.
>=20
> Ex: qemu -object memory-backend-memfd,?

As elsewhere in the series, s/\?/help/

> memory-backend-memfd.dump=3Dbool (Set to 'off' to exclude from core dum=
p)
> memory-backend-memfd.host-nodes=3Dint (Binds memory to the list of NUMA=
 host nodes)
> memory-backend-memfd.hugetlb=3Dbool (Use huge pages)
> memory-backend-memfd.hugetlbsize=3Dint (Huge pages size (ex: 2M, 1G))
> memory-backend-memfd.merge=3Dbool (Mark memory as mergeable)
> memory-backend-memfd.policy=3DHostMemPolicy (Set the NUMA policy)
> memory-backend-memfd.prealloc=3Dbool (Preallocate memory)
> memory-backend-memfd.seal=3Dbool (Seal growing & shrinking)
> memory-backend-memfd.share=3Dbool (Mark the memory as private to QEMU o=
r shared)
> memory-backend-memfd.size=3Dint (Size of the memory region (ex: 500M))

Why "name=3Dtype (text)" here, but "name=3Dtype - text" in 2/10?=20
Consistency would be nice.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qom/object_interfaces.c |  6 +++---
>   vl.c                    | 45 ++++++++++++++++++++++++++++++++++++++--=
-
>   2 files changed, 45 insertions(+), 6 deletions(-)
>=20

> +++ b/vl.c
> @@ -2721,6 +2721,11 @@ static int machine_set_property(void *opaque,
>       return 0;
>   }
>  =20
> +static gint
> +pstrcmp(const char **a, const char **b)
> +{
> +    return g_strcmp0(*a, *b);
> +}

This is the second time your series has added this static helper. Should=20
it be a common helper instead?


> +        g_ptr_array_sort(array, (GCompareFunc)pstrcmp);
> +        for (i =3D 0; i < array->len; i++) {
> +            error_printf("%s\n", (char *)array->pdata[i]);
> +        }
> +        g_ptr_array_set_free_func(array, g_free);
> +        g_ptr_array_free(array, true);
> +        exit(0);

Again, printing to stderr then exiting with status 0 is awkward.  Print=20
to stdout when successfully offering help text.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
