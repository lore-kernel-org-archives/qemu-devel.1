Received: from eggs.gnu.org ([209.51.188.92]:51616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1guyL4-0004ik-C1
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1guyL0-0008Q1-Mz
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:40:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1guyKs-0008KJ-Gk
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:40:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id 2so14051228qtb.5
	for <qemu-devel@nongnu.org>; Sat, 16 Feb 2019 03:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20190215155709.15777-1-berrange@redhat.com>
	<20190215155709.15777-10-berrange@redhat.com>
In-Reply-To: <20190215155709.15777-10-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 16 Feb 2019 12:40:33 +0100
Message-ID: <CAMxuvay_hGH29jTt6tassyOgtNOis1beX9qBDPpqfMKzQvyV=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Fri, Feb 15, 2019 at 4:58 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> Add a QAuthZListFile object type that implements the QAuthZ interface. Th=
is
> built-in implementation is a proxy around the QAuthZList object type,
> initializing it from an external file, and optionally, automatically
> reloading it whenever it changes.
>
> To create an instance of this object via the QMP monitor, the syntax
> used would be:
>
>       {
>         "execute": "object-add",
>         "arguments": {
>           "qom-type": "authz-list-file",
>           "id": "authz0",
>           "props": {
>             "filename": "/etc/qemu/vnc.acl",
>             "refresh": true
>           }
>         }
>       }
>
> If "refresh" is "yes", inotify is used to monitor the file,
> automatically reloading changes. If an error occurs during reloading,
> all authorizations will fail until the file is next successfully
> loaded.
>
> The /etc/qemu/vnc.acl file would contain a JSON representation of a
> QAuthZList object
>
>     {
>       "rules": [
>          { "match": "fred", "policy": "allow", "format": "exact" },
>          { "match": "bob", "policy": "allow", "format": "exact" },
>          { "match": "danb", "policy": "deny", "format": "glob" },
>          { "match": "dan*", "policy": "allow", "format": "exact" },
>       ],
>       "policy": "deny"
>     }
>
> This sets up an authorization rule that allows 'fred', 'bob' and anyone
> whose name starts with 'dan', except for 'danb'. Everyone unmatched is
> denied.
>
> The object can be loaded on the comand line using
>
>    -object authz-list-file,id=3Dauthz0,filename=3D/etc/qemu/vnc.acl,refre=
sh=3Dyes
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  authz/Makefile.objs         |   1 +
>  authz/listfile.c            | 283 ++++++++++++++++++++++++++++++++++++
>  authz/trace-events          |   4 +
>  include/authz/listfile.h    | 111 ++++++++++++++
>  qemu-options.hx             |  46 ++++++
>  tests/Makefile.include      |   2 +
>  tests/test-authz-listfile.c | 195 +++++++++++++++++++++++++
>  7 files changed, 642 insertions(+)
>  create mode 100644 authz/listfile.c
>  create mode 100644 include/authz/listfile.h
>  create mode 100644 tests/test-authz-listfile.c
>
> diff --git a/authz/Makefile.objs b/authz/Makefile.objs
> index 921fa624d7..8351bf181d 100644
> --- a/authz/Makefile.objs
> +++ b/authz/Makefile.objs
> @@ -1,3 +1,4 @@
>  authz-obj-y +=3D base.o
>  authz-obj-y +=3D simple.o
>  authz-obj-y +=3D list.o
> +authz-obj-y +=3D listfile.o
> diff --git a/authz/listfile.c b/authz/listfile.c
> new file mode 100644
> index 0000000000..d4579767e7
> --- /dev/null
> +++ b/authz/listfile.c
> @@ -0,0 +1,283 @@
> +/*
> + * QEMU access control list file authorization driver
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "authz/listfile.h"
> +#include "authz/trace.h"
> +#include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/sockets.h"
> +#include "qemu/filemonitor.h"
> +#include "qom/object_interfaces.h"
> +#include "qapi/qapi-visit-authz.h"
> +#include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qobject.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qapi/qobject-input-visitor.h"
> +
> +
> +static bool
> +qauthz_list_file_is_allowed(QAuthZ *authz,
> +                            const char *identity,
> +                            Error **errp)
> +{
> +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(authz);
> +    if (fauthz->list) {
> +        return qauthz_is_allowed(fauthz->list, identity, errp);
> +    }
> +
> +    return false;
> +}
> +
> +
> +static QAuthZ *
> +qauthz_list_file_load(QAuthZListFile *fauthz, Error **errp)
> +{
> +    GError *err =3D NULL;
> +    gchar *content =3D NULL;
> +    gsize len;
> +    QObject *obj =3D NULL;
> +    QDict *pdict;
> +    Visitor *v =3D NULL;
> +    QAuthZ *ret =3D NULL;
> +
> +    trace_qauthz_list_file_load(fauthz, fauthz->filename);
> +    if (!g_file_get_contents(fauthz->filename, &content, &len, &err)) {
> +        error_setg(errp, "Unable to read '%s': %s",
> +                   fauthz->filename, err->message);
> +        goto cleanup;
> +    }
> +
> +    obj =3D qobject_from_json(content, errp);
> +    if (!obj) {
> +        goto cleanup;
> +    }
> +
> +    pdict =3D qobject_to(QDict, obj);
> +    if (!pdict) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "obj", "dict");
> +        goto cleanup;
> +    }
> +
> +    v =3D qobject_input_visitor_new(obj);
> +
> +    ret =3D (QAuthZ *)user_creatable_add_type(TYPE_QAUTHZ_LIST,
> +                                            NULL, pdict, v, errp);
> +
> + cleanup:
> +    visit_free(v);
> +    qobject_unref(obj);
> +    if (err) {
> +        g_error_free(err);
> +    }
> +    g_free(content);
> +    return ret;
> +}
> +
> +
> +static void
> +qauthz_list_file_event(int wd G_GNUC_UNUSED,
> +                       QFileMonitorEvent ev G_GNUC_UNUSED,
> +                       const char *name G_GNUC_UNUSED,
> +                       void *opaque)
> +{
> +    QAuthZListFile *fauthz =3D opaque;
> +    Error *err =3D NULL;
> +
> +    if (ev !=3D QFILE_MONITOR_EVENT_MODIFIED &&
> +        ev !=3D QFILE_MONITOR_EVENT_CREATED) {
> +        return;
> +    }
> +
> +    object_unref(OBJECT(fauthz->list));
> +    fauthz->list =3D qauthz_list_file_load(fauthz, &err);
> +    trace_qauthz_list_file_refresh(fauthz,
> +                                   fauthz->filename, fauthz->list ? 1 : =
0);
> +    if (!fauthz->list) {
> +        error_report_err(err);
> +    }
> +}
> +
> +static void
> +qauthz_list_file_complete(UserCreatable *uc, Error **errp)
> +{
> +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(uc);
> +    gchar *dir =3D NULL, *file =3D NULL;
> +
> +    fauthz->list =3D qauthz_list_file_load(fauthz, errp);
> +
> +    if (!fauthz->refresh) {
> +        return;
> +    }
> +
> +    fauthz->file_monitor =3D qemu_file_monitor_new(errp);
> +    if (!fauthz->file_monitor) {
> +        return;
> +    }
> +
> +    dir =3D g_path_get_dirname(fauthz->filename);
> +    if (g_str_equal(dir, ".")) {
> +        error_setg(errp, "Filename must be an absolute path");
> +        goto cleanup;
> +    }
> +    file =3D g_path_get_basename(fauthz->filename);
> +    if (g_str_equal(file, ".")) {
> +        error_setg(errp, "Path has no trailing filename component");
> +        goto cleanup;
> +    }
> +
> +    fauthz->file_watch =3D qemu_file_monitor_add_watch(
> +        fauthz->file_monitor, dir, file,
> +        qauthz_list_file_event, fauthz, errp);
> +    if (fauthz->file_watch < 0) {
> +        goto cleanup;
> +    }
> +
> + cleanup:
> +    g_free(file);
> +    g_free(dir);
> +}
> +
> +
> +static void
> +qauthz_list_file_prop_set_filename(Object *obj,
> +                                   const char *value,
> +                                   Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(obj);
> +
> +    g_free(fauthz->filename);
> +    fauthz->filename =3D g_strdup(value);
> +}
> +
> +
> +static char *
> +qauthz_list_file_prop_get_filename(Object *obj,
> +                                   Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(obj);
> +
> +    return g_strdup(fauthz->filename);
> +}
> +
> +
> +static void
> +qauthz_list_file_prop_set_refresh(Object *obj,
> +                                  bool value,
> +                                  Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(obj);
> +
> +    fauthz->refresh =3D value;
> +}
> +
> +
> +static bool
> +qauthz_list_file_prop_get_refresh(Object *obj,
> +                                  Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(obj);
> +
> +    return fauthz->refresh;
> +}
> +
> +
> +static void
> +qauthz_list_file_finalize(Object *obj)
> +{
> +    QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(obj);
> +
> +    object_unref(OBJECT(fauthz->list));
> +    g_free(fauthz->filename);
> +    qemu_file_monitor_free(fauthz->file_monitor);
> +}
> +
> +
> +static void
> +qauthz_list_file_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    QAuthZClass *authz =3D QAUTHZ_CLASS(oc);
> +
> +    ucc->complete =3D qauthz_list_file_complete;
> +
> +    object_class_property_add_str(oc, "filename",
> +                                  qauthz_list_file_prop_get_filename,
> +                                  qauthz_list_file_prop_set_filename,
> +                                  NULL);
> +    object_class_property_add_bool(oc, "refresh",
> +                                   qauthz_list_file_prop_get_refresh,
> +                                   qauthz_list_file_prop_set_refresh,
> +                                   NULL);
> +
> +    authz->is_allowed =3D qauthz_list_file_is_allowed;
> +}
> +
> +
> +static void
> +qauthz_list_file_init(Object *obj)
> +{
> +    QAuthZListFile *authz =3D QAUTHZ_LIST_FILE(obj);
> +
> +    authz->file_watch =3D -1;
> +#ifdef CONFIG_INOTIFY1
> +    authz->refresh =3D TRUE;
> +#endif
> +}
> +
> +
> +QAuthZListFile *qauthz_list_file_new(const char *id,
> +                                     const char *filename,
> +                                     bool refresh,
> +                                     Error **errp)
> +{
> +    return QAUTHZ_LIST_FILE(
> +        object_new_with_props(TYPE_QAUTHZ_LIST_FILE,
> +                              object_get_objects_root(),
> +                              id, errp,
> +                              "filename", filename,
> +                              "refresh", refresh ? "yes" : "no",
> +                              NULL));
> +}
> +
> +
> +static const TypeInfo qauthz_list_file_info =3D {
> +    .parent =3D TYPE_QAUTHZ,
> +    .name =3D TYPE_QAUTHZ_LIST_FILE,
> +    .instance_init =3D qauthz_list_file_init,
> +    .instance_size =3D sizeof(QAuthZListFile),
> +    .instance_finalize =3D qauthz_list_file_finalize,
> +    .class_size =3D sizeof(QAuthZListFileClass),
> +    .class_init =3D qauthz_list_file_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +
> +static void
> +qauthz_list_file_register_types(void)
> +{
> +    type_register_static(&qauthz_list_file_info);
> +}
> +
> +
> +type_init(qauthz_list_file_register_types);
> diff --git a/authz/trace-events b/authz/trace-events
> index a896d876e8..fb65349a90 100644
> --- a/authz/trace-events
> +++ b/authz/trace-events
> @@ -9,3 +9,7 @@ qauthz_simple_is_allowed(void *authz, const char *wantide=
ntity, const char *goti
>  # auth/list.c
>  qauthz_list_check_rule(void *authz, const char *identity, const char *ru=
le, int format, int policy) "AuthZ list %p check rule=3D%s identity=3D%s fo=
rmat=3D%d policy=3D%d"
>  qauthz_list_default_policy(void *authz, const char *identity, int policy=
) "AuthZ list %p default identity=3D%s policy=3D%d"
> +
> +# auth/listfile.c
> +qauthz_list_file_load(void *authz, const char *filename) "AuthZ file %p =
load filename=3D%s"
> +qauthz_list_file_refresh(void *authz, const char *filename, int success)=
 "AuthZ file %p load filename=3D%s success=3D%d"
> diff --git a/include/authz/listfile.h b/include/authz/listfile.h
> new file mode 100644
> index 0000000000..bcc8d80743
> --- /dev/null
> +++ b/include/authz/listfile.h
> @@ -0,0 +1,111 @@
> +/*
> + * QEMU list file authorization driver
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#ifndef QAUTHZ_LIST_FILE_H__
> +#define QAUTHZ_LIST_FILE_H__
> +
> +#include "authz/list.h"
> +#include "qapi/qapi-types-authz.h"
> +#include "qemu/filemonitor.h"
> +
> +#define TYPE_QAUTHZ_LIST_FILE "authz-list-file"
> +
> +#define QAUTHZ_LIST_FILE_CLASS(klass)                        \
> +    OBJECT_CLASS_CHECK(QAuthZListFileClass, (klass),        \
> +                       TYPE_QAUTHZ_LIST_FILE)
> +#define QAUTHZ_LIST_FILE_GET_CLASS(obj)              \
> +    OBJECT_GET_CLASS(QAuthZListFileClass, (obj),    \
> +                      TYPE_QAUTHZ_LIST_FILE)
> +#define QAUTHZ_LIST_FILE(obj) \
> +    INTERFACE_CHECK(QAuthZListFile, (obj),          \
> +                    TYPE_QAUTHZ_LIST_FILE)
> +
> +typedef struct QAuthZListFile QAuthZListFile;
> +typedef struct QAuthZListFileClass QAuthZListFileClass;
> +
> +
> +/**
> + * QAuthZListFile:
> + *
> + * This authorization driver provides a file mechanism
> + * for granting access by matching user names against a
> + * file of globs. Each match rule has an associated policy
> + * and a catch all policy applies if no rule matches
> + *
> + * To create an instance of this class via QMP:
> + *
> + *  {
> + *    "execute": "object-add",
> + *    "arguments": {
> + *      "qom-type": "authz-list-file",
> + *      "id": "authz0",
> + *      "props": {
> + *        "filename": "/etc/qemu/myvm-vnc.acl",
> + *        "refresh": true
> + *      }
> + *    }
> + *  }
> + *
> + * If 'refresh' is 'yes', inotify is used to monitor for changes
> + * to the file and auto-reload the rules.
> + *
> + * The myvm-vnc.acl file should contain the parameters for
> + * the QAuthZList object in JSON format:
> + *
> + *      {
> + *        "rules": [
> + *           { "match": "fred", "policy": "allow", "format": "exact" },
> + *           { "match": "bob", "policy": "allow", "format": "exact" },
> + *           { "match": "danb", "policy": "deny", "format": "exact" },
> + *           { "match": "dan*", "policy": "allow", "format": "glob" }
> + *        ],
> + *        "policy": "deny"
> + *      }
> + *
> + * The object can be created on the command line using
> + *
> + *   -object authz-list-file,id=3Dauthz0,\
> + *           filename=3D/etc/qemu/myvm-vnc.acl,refresh=3Dyes
> + *
> + */
> +struct QAuthZListFile {
> +    QAuthZ parent_obj;
> +
> +    QAuthZ *list;
> +    char *filename;
> +    bool refresh;
> +    QFileMonitor *file_monitor;
> +    int file_watch;
> +};
> +
> +
> +struct QAuthZListFileClass {
> +    QAuthZClass parent_class;
> +};
> +
> +
> +QAuthZListFile *qauthz_list_file_new(const char *id,
> +                                     const char *filename,
> +                                     bool refresh,
> +                                     Error **errp);
> +
> +
> +#endif /* QAUTHZ_LIST_FILE_H__ */
> +
> diff --git a/qemu-options.hx b/qemu-options.hx
> index a948cacc07..e34d30a013 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4384,6 +4384,52 @@ would look like:
>  Note the use of quotes due to the x509 distinguished name containing
>  whitespace, and escaping of ','.
>
> +@item -object authz-listfile,id=3D@var{id},filename=3D@var{path},refresh=
=3D@var{yes|no}
> +
> +Create an authorization object that will control access to network servi=
ces.
> +
> +The @option{filename} parameter is the fully qualified path to a file
> +containing the access control list rules in JSON format.
> +
> +An example set of rules that match against SASL usernames might look
> +like:
> +
> +@example
> +  @{
> +    "rules": [
> +       @{ "match": "fred", "policy": "allow", "format": "exact" @},
> +       @{ "match": "bob", "policy": "allow", "format": "exact" @},
> +       @{ "match": "danb", "policy": "deny", "format": "glob" @},
> +       @{ "match": "dan*", "policy": "allow", "format": "exact" @},
> +    ],
> +    "policy": "deny"
> +  @}
> +@end example
> +
> +When checking access the object will iterate over all the rules and
> +the first rule to match will have its @option{policy} value returned
> +as the result. If no rules match, then the default @option{policy}
> +value is returned.
> +
> +The rules can either be an exact string match, or they can use the
> +simple UNIX glob pattern matching to allow wildcards to be used.
> +
> +If @option{refresh} is set to true the file will be monitored
> +and automatically reloaded whenever its content changes.
> +
> +As with the @code{authz-simple} object, the format of the identity
> +strings being matched depends on the network service, but is usually
> +a TLS x509 distinguished name, or a SASL username.
> +
> +An example authorization object to validate a SASL username
> +would look like:
> +@example
> + # $QEMU \
> +     ...
> +     -object authz-simple,id=3Dauth0,filename=3D/etc/qemu/vnc-sasl.acl,r=
efresh=3Dyes
> +     ...
> +@end example
> +
>  @end table
>
>  ETEXI
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index c007968805..199e74d670 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -118,6 +118,7 @@ check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-fi=
lemonitor$(EXESUF)
>  check-unit-y +=3D tests/test-util-sockets$(EXESUF)
>  check-unit-y +=3D tests/test-authz-simple$(EXESUF)
>  check-unit-y +=3D tests/test-authz-list$(EXESUF)
> +check-unit-y +=3D tests/test-authz-listfile$(EXESUF)
>  check-unit-y +=3D tests/test-io-task$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-socket$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-file$(EXESUF)
> @@ -667,6 +668,7 @@ tests/test-util-sockets$(EXESUF): tests/test-util-soc=
kets.o \
>         tests/socket-helpers.o $(test-util-obj-y)
>  tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz=
-obj-y)
>  tests/test-authz-list$(EXESUF): tests/test-authz-list.o $(test-authz-obj=
-y)
> +tests/test-authz-listfile$(EXESUF): tests/test-authz-listfile.o $(test-a=
uthz-obj-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
>          tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
> diff --git a/tests/test-authz-listfile.c b/tests/test-authz-listfile.c
> new file mode 100644
> index 0000000000..1e452fef6d
> --- /dev/null
> +++ b/tests/test-authz-listfile.c
> @@ -0,0 +1,195 @@
> +/*
> + * QEMU list authorization object tests
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "authz/listfile.h"
> +
> +static char *workdir;
> +
> +static gchar *qemu_authz_listfile_test_save(const gchar *name,
> +                                            const gchar *cfg)
> +{
> +    gchar *path =3D g_strdup_printf("%s/default-deny.cfg", workdir);
> +    GError *gerr =3D NULL;
> +
> +    if (!g_file_set_contents(path, cfg, -1, &gerr)) {
> +        g_printerr("Unable to save config %s: %s\n",
> +                   path, gerr->message);
> +        g_error_free(gerr);
> +        g_free(path);
> +        rmdir(workdir);
> +        abort();
> +    }
> +
> +    return path;
> +}
> +
> +static void test_authz_default_deny(void)
> +{
> +    gchar *file =3D qemu_authz_listfile_test_save(
> +        "default-deny.cfg",
> +        "{ \"policy\": \"deny\" }");
> +    Error *local_err =3D NULL;
> +
> +    QAuthZListFile *auth =3D qauthz_list_file_new("auth0",
> +                                                file, false,
> +                                                &local_err);
> +    unlink(file);
> +    g_free(file);
> +    g_assert(local_err =3D=3D NULL);
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +static void test_authz_default_allow(void)
> +{
> +    gchar *file =3D qemu_authz_listfile_test_save(
> +        "default-allow.cfg",
> +        "{ \"policy\": \"allow\" }");
> +    Error *local_err =3D NULL;
> +
> +    QAuthZListFile *auth =3D qauthz_list_file_new("auth0",
> +                                                file, false,
> +                                                &local_err);
> +    unlink(file);
> +    g_free(file);
> +    g_assert(local_err =3D=3D NULL);
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +static void test_authz_explicit_deny(void)
> +{
> +    gchar *file =3D qemu_authz_listfile_test_save(
> +        "explicit-deny.cfg",
> +        "{ \"rules\": [ "
> +        "    { \"match\": \"fred\","
> +        "      \"policy\": \"deny\","
> +        "      \"format\": \"exact\" } ],"
> +        "  \"policy\": \"allow\" }");
> +    Error *local_err =3D NULL;
> +
> +    QAuthZListFile *auth =3D qauthz_list_file_new("auth0",
> +                                                file, false,
> +                                                &local_err);
> +    unlink(file);
> +    g_free(file);
> +    g_assert(local_err =3D=3D NULL);
> +
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +static void test_authz_explicit_allow(void)
> +{
> +    gchar *file =3D qemu_authz_listfile_test_save(
> +        "explicit-allow.cfg",
> +        "{ \"rules\": [ "
> +        "    { \"match\": \"fred\","
> +        "      \"policy\": \"allow\","
> +        "      \"format\": \"exact\" } ],"
> +        "  \"policy\": \"deny\" }");
> +    Error *local_err =3D NULL;
> +
> +    QAuthZListFile *auth =3D qauthz_list_file_new("auth0",
> +                                                file, false,
> +                                                &local_err);
> +    unlink(file);
> +    g_free(file);
> +    g_assert(local_err =3D=3D NULL);
> +
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +
> +static void test_authz_complex(void)
> +{
> +    gchar *file =3D qemu_authz_listfile_test_save(
> +        "complex.cfg",
> +        "{ \"rules\": [ "
> +        "    { \"match\": \"fred\","
> +        "      \"policy\": \"allow\","
> +        "      \"format\": \"exact\" },"
> +        "    { \"match\": \"bob\","
> +        "      \"policy\": \"allow\","
> +        "      \"format\": \"exact\" },"
> +        "    { \"match\": \"dan\","
> +        "      \"policy\": \"deny\","
> +        "      \"format\": \"exact\" },"
> +        "    { \"match\": \"dan*\","
> +        "      \"policy\": \"allow\","
> +        "      \"format\": \"glob\" } ],"
> +        "  \"policy\": \"deny\" }");
> +
> +    Error *local_err =3D NULL;
> +
> +    QAuthZListFile *auth =3D qauthz_list_file_new("auth0",
> +                                                file, false,
> +                                                &local_err);
> +    unlink(file);
> +    g_free(file);
> +    g_assert(local_err =3D=3D NULL);
> +
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "bob", &error_abort));
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "danb", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +    GError *gerr =3D NULL;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    workdir =3D g_dir_make_tmp("qemu-test-authz-listfile-XXXXXX",
> +                             &gerr);
> +    if (!workdir) {
> +        g_printerr("Unable to create temporary dir: %s\n",
> +                   gerr->message);
> +        g_error_free(gerr);
> +        abort();
> +    }
> +
> +    g_test_add_func("/auth/list/default/deny", test_authz_default_deny);
> +    g_test_add_func("/auth/list/default/allow", test_authz_default_allow=
);
> +    g_test_add_func("/auth/list/explicit/deny", test_authz_explicit_deny=
);
> +    g_test_add_func("/auth/list/explicit/allow", test_authz_explicit_all=
ow);
> +    g_test_add_func("/auth/list/complex", test_authz_complex);
> +
> +    ret =3D g_test_run();
> +
> +    rmdir(workdir);
> +    g_free(workdir);
> +
> +    return ret;
> +}
> --
> 2.20.1
>
