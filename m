Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e1T9f-0001hK-5r
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e1T9b-0001ds-P4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:11:15 -0400
Date: Mon, 9 Oct 2017 09:11:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171009081101.GA2374@work-vm>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-32-f4bug@amsat.org>
	<87r2ucrcsi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87r2ucrcsi.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 31/88] QMP: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
>=20
> > From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > [PMD: more changes]
> > ---
> >  monitor.c                 | 14 +++++++-------
> >  qmp.c                     | 14 +++++++-------
> >  tests/test-qmp-commands.c | 14 +++++++-------
> >  3 files changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index fe0d1bdbb4..ea6a485f11 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -906,7 +906,7 @@ static void query_commands_cb(QmpCommand *cmd, vo=
id *opaque)
> >          return;
> >      }
> > =20
> > -    info =3D g_malloc0(sizeof(*info));
> > +    info =3D g_new0(CommandInfoList, 1);
> >      info->value =3D g_malloc0(sizeof(*info->value));
> >      info->value->name =3D g_strdup(cmd->name);
> >      info->next =3D *list;
>=20
> I'm not convinced rewriting
>=20
>        LHS =3D g_malloc(sizeof(*LHS));
>=20
> to
>=20
>        LHS =3D g_new(T, 1);
>=20
> where T is the type of LHS is worth the trouble.  The code before the
> rewrite is pretty idiomatic.  There's no possibility of integer overflo=
w
> g_new() could avoid.  The types are obviously correct, so the additiona=
l
> type checking is quite unlikely to catch anything.  That leaves the
> consistency argument.  I'm willing to hear it, but I feel it should be
> heard in a patch series that does nothing else.

The 'obviously correct' is the dodgy part of the argument here.
How many bugs do we right that are obviously wrong?

t.c:13:20: warning: initialization from incompatible pointer type [-Winco=
mpatible-pointer-types]
     struct c *pc =3D g_new(struct b, 1);

seems good to me.

Dave

> > @@ -1799,7 +1799,7 @@ static void hmp_wavcapture(Monitor *mon, const =
QDict *qdict)
> >      int nchannels =3D qdict_get_try_int(qdict, "nchannels", -1);
> >      CaptureState *s;
> > =20
> > -    s =3D g_malloc0 (sizeof (*s));
> > +    s =3D g_new0(CaptureState, 1);
> > =20
> >      freq =3D has_freq ? freq : 44100;
> >      bits =3D has_bits ? bits : 16;
>=20
> This hunk is HMP, not QMP.
>=20
> > @@ -1947,7 +1947,7 @@ void qmp_getfd(const char *fdname, Error **errp=
)
> >          return;
> >      }
> > =20
> > -    monfd =3D g_malloc0(sizeof(mon_fd_t));
> > +    monfd =3D g_new0(mon_fd_t, 1);
> >      monfd->name =3D g_strdup(fdname);
> >      monfd->fd =3D fd;
> > =20
> > @@ -2110,7 +2110,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
> >          QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
> >              FdsetFdInfoList *fdsetfd_info;
> > =20
> > -            fdsetfd_info =3D g_malloc0(sizeof(*fdsetfd_info));
> > +            fdsetfd_info =3D g_new0(FdsetFdInfoList, 1);
> >              fdsetfd_info->value =3D g_malloc0(sizeof(*fdsetfd_info->=
value));
> >              fdsetfd_info->value->fd =3D mon_fdset_fd->fd;
> >              if (mon_fdset_fd->opaque) {
> > @@ -2199,7 +2199,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool ha=
s_fdset_id, int64_t fdset_id,
> >          }
> >      }
> > =20
> > -    mon_fdset_fd =3D g_malloc0(sizeof(*mon_fdset_fd));
> > +    mon_fdset_fd =3D g_new0(MonFdsetFd, 1);
> >      mon_fdset_fd->fd =3D fd;
> >      mon_fdset_fd->removed =3D false;
> >      if (has_opaque) {
> > @@ -2207,7 +2207,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool ha=
s_fdset_id, int64_t fdset_id,
> >      }
> >      QLIST_INSERT_HEAD(&mon_fdset->fds, mon_fdset_fd, next);
> > =20
> > -    fdinfo =3D g_malloc0(sizeof(*fdinfo));
> > +    fdinfo =3D g_new0(AddfdInfo, 1);
> >      fdinfo->fdset_id =3D mon_fdset->id;
> >      fdinfo->fd =3D mon_fdset_fd->fd;
> > =20
> > @@ -4102,7 +4102,7 @@ void monitor_init(Chardev *chr, int flags)
> >          is_first_init =3D 0;
> >      }
> > =20
> > -    mon =3D g_malloc(sizeof(*mon));
> > +    mon =3D g_new(Monitor, 1);
> >      monitor_data_init(mon);
> > =20
> >      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
>=20
> This is monitor core, not QMP.
>=20
> > diff --git a/qmp.c b/qmp.c
> > index e8c303116a..e965020e37 100644
> > --- a/qmp.c
> > +++ b/qmp.c
> > @@ -232,7 +232,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *=
path, Error **errp)
> >      while ((prop =3D object_property_iter_next(&iter))) {
> >          ObjectPropertyInfoList *entry =3D g_malloc0(sizeof(*entry));
> > =20
> > -        entry->value =3D g_malloc0(sizeof(ObjectPropertyInfo));
> > +        entry->value =3D g_new0(ObjectPropertyInfo, 1);
> >          entry->next =3D props;
> >          props =3D entry;
> > =20
> > @@ -432,7 +432,7 @@ static void qom_list_types_tramp(ObjectClass *kla=
ss, void *data)
> >      ObjectTypeInfo *info;
> >      ObjectClass *parent =3D object_class_get_parent(klass);
> > =20
> > -    info =3D g_malloc0(sizeof(*info));
> > +    info =3D g_new0(ObjectTypeInfo, 1);
> >      info->name =3D g_strdup(object_class_get_name(klass));
> >      info->has_abstract =3D info->abstract =3D object_class_is_abstra=
ct(klass);
> >      if (parent) {
> > @@ -440,7 +440,7 @@ static void qom_list_types_tramp(ObjectClass *kla=
ss, void *data)
> >          info->parent =3D g_strdup(object_class_get_name(parent));
> >      }
> > =20
> > -    e =3D g_malloc0(sizeof(*e));
> > +    e =3D g_new0(ObjectTypeInfoList, 1);
> >      e->value =3D info;
> >      e->next =3D *pret;
> >      *pret =3D e;
> > @@ -490,7 +490,7 @@ static DevicePropertyInfo *make_device_property_i=
nfo(ObjectClass *klass,
> >                  return NULL;           /* no way to set it, don't sh=
ow */
> >              }
> > =20
> > -            info =3D g_malloc0(sizeof(*info));
> > +            info =3D g_new0(DevicePropertyInfo, 1);
> >              info->name =3D g_strdup(prop->name);
> >              info->type =3D default_type ? g_strdup(default_type)
> >                                        : g_strdup(prop->info->name);
> > @@ -502,7 +502,7 @@ static DevicePropertyInfo *make_device_property_i=
nfo(ObjectClass *klass,
> >      } while (klass !=3D object_class_by_name(TYPE_DEVICE));
> > =20
> >      /* Not a qdev property, use the default type */
> > -    info =3D g_malloc0(sizeof(*info));
> > +    info =3D g_new0(DevicePropertyInfo, 1);
> >      info->name =3D g_strdup(name);
> >      info->type =3D g_strdup(default_type);
> >      info->has_description =3D !!description;
> > @@ -568,7 +568,7 @@ DevicePropertyInfoList *qmp_device_list_propertie=
s(const char *typename,
> >              continue;
> >          }
> > =20
> > -        entry =3D g_malloc0(sizeof(*entry));
> > +        entry =3D g_new0(DevicePropertyInfoList, 1);
> >          entry->value =3D info;
> >          entry->next =3D prop_list;
> >          prop_list =3D entry;
> > @@ -712,7 +712,7 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error=
 **errp)
> > =20
> >  MemoryInfo *qmp_query_memory_size_summary(Error **errp)
> >  {
> > -    MemoryInfo *mem_info =3D g_malloc0(sizeof(MemoryInfo));
> > +    MemoryInfo *mem_info =3D g_new0(MemoryInfo, 1);
> > =20
> >      mem_info->base_memory =3D ram_size;
> > =20
> > diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
> > index 904c89d4d4..e715c45a23 100644
> > --- a/tests/test-qmp-commands.c
> > +++ b/tests/test-qmp-commands.c
> > @@ -28,8 +28,8 @@ UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
> >                                Error **errp)
> >  {
> >      UserDefTwo *ret;
> > -    UserDefOne *ud1c =3D g_malloc0(sizeof(UserDefOne));
> > -    UserDefOne *ud1d =3D g_malloc0(sizeof(UserDefOne));
> > +    UserDefOne *ud1c =3D g_new0(UserDefOne, 1);
> > +    UserDefOne *ud1d =3D g_new0(UserDefOne, 1);
> > =20
> >      ud1c->string =3D strdup(ud1a->string);
> >      ud1c->integer =3D ud1a->integer;
> > @@ -209,23 +209,23 @@ static void test_dealloc_types(void)
> >      UserDefOne *ud1test, *ud1a, *ud1b;
> >      UserDefOneList *ud1list;
> > =20
> > -    ud1test =3D g_malloc0(sizeof(UserDefOne));
> > +    ud1test =3D g_new0(UserDefOne, 1);
> >      ud1test->integer =3D 42;
> >      ud1test->string =3D g_strdup("hi there 42");
> > =20
> >      qapi_free_UserDefOne(ud1test);
> > =20
> > -    ud1a =3D g_malloc0(sizeof(UserDefOne));
> > +    ud1a =3D g_new0(UserDefOne, 1);
> >      ud1a->integer =3D 43;
> >      ud1a->string =3D g_strdup("hi there 43");
> > =20
> > -    ud1b =3D g_malloc0(sizeof(UserDefOne));
> > +    ud1b =3D g_new0(UserDefOne, 1);
> >      ud1b->integer =3D 44;
> >      ud1b->string =3D g_strdup("hi there 44");
> > =20
> > -    ud1list =3D g_malloc0(sizeof(UserDefOneList));
> > +    ud1list =3D g_new0(UserDefOneList, 1);
> >      ud1list->value =3D ud1a;
> > -    ud1list->next =3D g_malloc0(sizeof(UserDefOneList));
> > +    ud1list->next =3D g_new0(UserDefOneList, 1);
> >      ud1list->next->value =3D ud1b;
> > =20
> >      qapi_free_UserDefOneList(ud1list);
>=20
> Could squash together with PATCH 79 and call the result "monitor: Use
> g_new() family of functions".
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
