Received: from eggs.gnu.org ([2001:4830:134:3::10]:40566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAwRh-0003DM-Ey
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAwRe-0003SD-7T
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:49:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fAwRe-0003R2-1V
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:49:14 -0400
Date: Tue, 24 Apr 2018 12:49:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180424114908.GC2521@work-vm>
References: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
	<b2eaf385-1d60-a352-f970-7b47d2744d90@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2eaf385-1d60-a352-f970-7b47d2744d90@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: "Perez Blanco,
	Ricardo (Nokia - BE/Antwerp)" <ricardo.perez_blanco@nokia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>

* QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
>=20
>=20
> =E5=9C=A8 2018/4/13 16:05, Perez Blanco, Ricardo (Nokia - BE/Antwerp) =E5=
=86=99=E9=81=93:
> > Dear all,
> >=20
> > Here you can find my first contribution to qemu. Please, do not hesit=
ate to do any kind of remark.
> >=20
> > Based on ac4ba87ae0738d7a77708f8ce31ae2378ab99654
> >=20
> > Kind regards,
> >=20
> > Ricardo Perez Blanco
> >=20
> >>From 65df20cef2846d764a8a821574f5f3643391aac5 Mon Sep 17 00:00:00 200=
1
> > From: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> > Date: Wed, 11 Apr 2018 12:09:11 +0200
> > Subject: [PATCH] Show values and description when using "qom-list"
> >=20
> > For debugging purposes it is very useful to:
> >  - See the description of the field. This information is already fill=
ed
> >    in but not shown in "qom-list" command.
> >  - Display value of the field. So far, only well known types are
> >    implemented (string, str, int, uint, bool).
> Need we support other types like QList and QDict? I think yes and sugge=
st a new command
> to be introduced like qom-list-property or qom-get. The resorts may be:
> 	1) print the json string just as Alan's former patch
>         2) print the value step by step. Supposing property foo is a st=
ructure,
>            qom-list-property path foo prints its members as "mem1;mem2;=
mem3"
>            and qom-list-property path foo.mem1 prints mem1's value.
> And some properties don't have get/set callback set, which prompts as b=
elow if doing
> qom-get/set:
> (qemu) qom-get /machine kernel-irqchip
> Insufficient permission to perform this operation
> For these properties I think we may need to not show the value in qom-l=
ist.

So while I think it would be good to handle all the cases, I'd be happy
to take just the current enhancements to qom-list (once the cleanups that=
 Eric
suggested are fixed).  Being able to see even just the int/bool/strings
is very useful and something I've wanted for a while.

Dave

> Thanks!
>=20
> >=20
> > Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> > ---
> >  hmp.c          | 13 +++++++++++--
> >  qapi/misc.json |  4 +++-
> >  qmp.c          | 26 ++++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hmp.c b/hmp.c
> > index a25c7bd..967e0b2 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -2490,8 +2490,17 @@ void hmp_qom_list(Monitor *mon, const QDict *q=
dict)
> >          while (list !=3D NULL) {
> >              ObjectPropertyInfo *value =3D list->value;
> >=20
> > -            monitor_printf(mon, "%s (%s)\n",
> > -                           value->name, value->type);
> > +            monitor_printf(mon, "%s", value->name);
> > +            if (value->value) {
> > +                monitor_printf(mon, "=3D%s", value->value);
> > +            }
> > +            monitor_printf(mon, " (%s)", value->type);
> > +            if (value->description) {
> > +                monitor_printf(mon, "\r\t\t\t\t\t\t\t\t\t[Descriptio=
n: %s]",
> > +                               value->description);
> > +            }
> > +            monitor_printf(mon, "\n");
> > +
> >              list =3D list->next;
> >          }
> >          qapi_free_ObjectPropertyInfoList(start);
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 5636f4a..6b3b4de 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1328,10 +1328,12 @@
> >  #
> >  # @description: if specified, the description of the property.
> >  #
> > +# @value: if specified, the value of the property.
> > +#
> >  # Since: 1.2
> >  ##
> >  { 'struct': 'ObjectPropertyInfo',
> > -  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
> > +  'data': { 'name': 'str', 'type': 'str', '*description':'str', '*va=
lue':'str' } }
> >=20
> >  ##
> >  # @qom-list:
> > diff --git a/qmp.c b/qmp.c
> > index f722616..750b5d0 100644
> > --- a/qmp.c
> > +++ b/qmp.c
> > @@ -237,6 +237,32 @@ ObjectPropertyInfoList *qmp_qom_list(const char =
*path, Error **errp)
> >=20
> >          entry->value->name =3D g_strdup(prop->name);
> >          entry->value->type =3D g_strdup(prop->type);
> > +        if (prop->description) {
> > +            entry->value->description =3D g_strdup(prop->description=
);
> > +        }
> > +        if ((g_ascii_strncasecmp(entry->value->type, "string", 6) =3D=
=3D 0) ||
> > +            (g_ascii_strncasecmp(entry->value->type, "str", 3) =3D=3D=
 0)) {
> > +            Error **errp =3D NULL;
> > +            entry->value->value =3D g_strdup_printf("\"%s\"",
> > +                object_property_get_str(obj, entry->value->name, err=
p));
> > +        }
> > +        if (g_ascii_strncasecmp(entry->value->type, "int", 3) =3D=3D=
 0) {
> > +            Error **errp =3D NULL;
> > +            entry->value->value =3D g_strdup_printf("%ld",
> > +                object_property_get_int(obj, entry->value->name, err=
p));
> > +        }
> > +        if (g_ascii_strncasecmp(entry->value->type, "uint", 4) =3D=3D=
 0) {
> > +            Error **errp =3D NULL;
> > +            entry->value->value =3D g_strdup_printf("%lu",
> > +                object_property_get_uint(obj, entry->value->name, er=
rp));
> > +        }
> > +        if (g_ascii_strncasecmp(entry->value->type, "bool", 4) =3D=3D=
 0) {
> > +            Error **errp =3D NULL;
> > +            entry->value->value =3D g_strdup_printf("%s",
> > +               (object_property_get_bool(obj, entry->value->name, er=
rp) =3D=3D true)
> > +                ? "true" : "false");
> > +        }
> > +
> >      }
> >=20
> >      return props;
> > --
> > 1.8.3.1
> >=20
> >=20
>=20
> --=20
> Regards
> QingFeng Hao
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
