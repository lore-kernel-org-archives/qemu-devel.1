Received: from eggs.gnu.org ([2001:4830:134:3::10]:56423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwJC-0004uT-Mm
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwJ7-0007km-Vh
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:35:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxwJ7-0007ja-R3
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:34:57 -0400
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
	<20180906151227.25514-9-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94f06791-7f50-7464-29a0-fdb5c960139a@redhat.com>
Date: Thu, 6 Sep 2018 10:34:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180906151227.25514-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] vl: handle -object ?
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

In the subject, s/\?/help/

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   vl.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>=20
> diff --git a/vl.c b/vl.c
> index 5ba06adf78..8a5fd0c81f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2731,6 +2731,19 @@ static int machine_set_property(void *opaque,
>    */
>   static bool object_create_initial(const char *type)
>   {
> +    if (is_help_option(type)) {
> +        GSList *l, *list;
> +
> +        error_printf("List of user creatable objects:\n");
> +        list =3D object_class_get_list_sorted(TYPE_USER_CREATABLE, fal=
se);
> +        for (l =3D list; l !=3D NULL; l =3D l->next) {
> +            ObjectClass *oc =3D OBJECT_CLASS(l->data);
> +            error_printf("%s\n", object_class_get_name(oc));

This prints to stderr,

> +        }
> +        g_slist_free(list);
> +        exit(0);

then exits with status 0.  I'd much rather successful help text be=20
printed to stdout.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
