Received: from eggs.gnu.org ([2001:4830:134:3::10]:36558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDRHz-0006dm-Sr
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDRHw-0004fI-LG
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:41:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDRHw-0004ej-Ai
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:41:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1-v6so3811460wrs.4
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 02:41:48 -0700 (PDT)
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-10-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b1d61bfd-cc34-2103-35a1-86bd828e7a93@redhat.com>
Date: Fri, 19 Oct 2018 11:41:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181009130442.26296-10-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 09/10/2018 15:04, Daniel P. Berrangé wrote:
> Add a QAuthZListFile object type that implements the QAuthZ interface. This
> built-in implementation is a proxy around the QAtuhZList object type,
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
>           "parameters": {
>             "filename": "/etc/qemu/vnc.acl",
> 	    "refresh": "yes"
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
>    -object authz-list-file,id=authz0,filename=/etc/qemu/vnc.acl,refresh=yes
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  authz/Makefile.objs      |   1 +
>  authz/listfile.c         | 284 +++++++++++++++++++++++++++++++++++++++
>  authz/trace-events       |   4 +
>  include/authz/listfile.h | 110 +++++++++++++++
>  qemu-options.hx          |  47 +++++++
>  5 files changed, 446 insertions(+)
>  create mode 100644 authz/listfile.c
>  create mode 100644 include/authz/listfile.h
> 
> diff --git a/authz/Makefile.objs b/authz/Makefile.objs
> index 921fa624d7..8351bf181d 100644
> --- a/authz/Makefile.objs
> +++ b/authz/Makefile.objs
> @@ -1,3 +1,4 @@
>  authz-obj-y += base.o
>  authz-obj-y += simple.o
>  authz-obj-y += list.o
> +authz-obj-y += listfile.o
> diff --git a/authz/listfile.c b/authz/listfile.c
> new file mode 100644
> index 0000000000..5bd3e37f7e
> --- /dev/null
> +++ b/authz/listfile.c
> @@ -0,0 +1,284 @@
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
> +    QAuthZListFile *fauthz = QAUTHZ_LIST_FILE(authz);
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
> +    GError *err = NULL;
> +    gchar *content = NULL;
> +    gsize len;
> +    QObject *obj = NULL;
> +    QDict *pdict;
> +    Visitor *v = NULL;
> +    QAuthZ *ret = NULL;
> +
> +    trace_qauthz_list_file_load(fauthz, fauthz->filename);
> +    if (!g_file_get_contents(fauthz->filename, &content, &len, &err)) {
> +        error_setg(errp, "Unable to read '%s': %s",
> +                   fauthz->filename, err->message);
> +        goto cleanup;
> +    }
> +
> +    obj = qobject_from_json(content, errp);
> +    if (!obj) {
> +        goto cleanup;
> +    }
> +
> +    pdict = qobject_to(QDict, obj);
> +    if (!pdict) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "obj", "dict");
> +        goto cleanup;
> +    }
> +
> +    v = qobject_input_visitor_new(obj);
> +
> +    ret = (QAuthZ *)user_creatable_add_type(TYPE_QAUTHZ_LIST,
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
> +    QAuthZListFile *fauthz = opaque;
> +    Error *err = NULL;
> +
> +    if (ev != QFILE_MONITOR_EVENT_MODIFIED &&
> +        ev != QFILE_MONITOR_EVENT_CREATED)

You missed:

                                              {

> +        return;

       }

> +
> +    object_unref(OBJECT(fauthz->list));
> +    fauthz->list = qauthz_list_file_load(fauthz, &err);
> +    trace_qauthz_list_file_refresh(fauthz,
> +                                   fauthz->filename, fauthz->list ? 1 : 0);
> +    if (!fauthz->list) {
> +        error_report_err(err);
> +    }
> +}
> +
> +static void
> +qauthz_list_file_complete(UserCreatable *uc, Error **errp)
> +{
> +    QAuthZListFile *fauthz = QAUTHZ_LIST_FILE(uc);
> +
> +    fauthz->list = qauthz_list_file_load(fauthz, errp);
> +
> +    if (fauthz->refresh) {

Can we invert this condition?

> +        gchar *dir, *file;
> +        fauthz->file_monitor = qemu_file_monitor_get_instance(errp);
> +        if (!fauthz->file_monitor) {
> +            return;
> +        }
> +
> +        dir = g_path_get_dirname(fauthz->filename);
> +        if (g_str_equal(dir, ".")) {
> +            error_setg(errp, "Filename must be an absolute path");

What about:

               goto cleanup;

> +            g_free(dir);
> +            return;
> +        }
> +        file = g_path_get_basename(fauthz->filename);
> +        if (g_str_equal(file, ".")) {
> +            error_setg(errp, "Path has no trailing filename component");

               goto cleanup;

> +            g_free(file);
> +            g_free(dir);
> +            return;
> +        }
> +
> +        fauthz->file_watch = qemu_file_monitor_add_watch(
> +            fauthz->file_monitor, dir, file,
> +            qauthz_list_file_event, fauthz, errp);
> +        g_free(file);
> +        g_free(dir);
> +        if (fauthz->file_watch < 0) {

Is this really useful? Do you plan to add more code here?

> +            return;
> +        }
> +    }
> +}
> +
> +
> +static void
> +qauthz_list_file_prop_set_filename(Object *obj,
> +                                   const char *value,
> +                                   Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *authz = QAUTHZ_LIST_FILE(obj);
> +
> +    authz->filename = g_strdup(value);
> +}
> +
> +
> +static char *
> +qauthz_list_file_prop_get_filename(Object *obj,
> +                                   Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *authz = QAUTHZ_LIST_FILE(obj);
> +
> +    return g_strdup(authz->filename);
> +}
> +
> +
> +static void
> +qauthz_list_file_prop_set_refresh(Object *obj,
> +                                  bool value,
> +                                  Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *authz = QAUTHZ_LIST_FILE(obj);
> +
> +    authz->refresh = value;
> +}
> +
> +
> +static bool
> +qauthz_list_file_prop_get_refresh(Object *obj,
> +                                  Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZListFile *authz = QAUTHZ_LIST_FILE(obj);
> +
> +    return authz->refresh;
> +}
> +
> +
> +static void
> +qauthz_list_file_finalize(Object *obj)
> +{
> +    QAuthZListFile *authz = QAUTHZ_LIST_FILE(obj);
> +
> +    if (authz->file_watch != -1 && authz->file_monitor) {
> +        gchar *dir = g_path_get_dirname(authz->filename);
> +        qemu_file_monitor_remove_watch(authz->file_monitor,
> +                                       dir,
> +                                       authz->file_watch);
> +        g_free(dir);
> +    }
> +    object_unref(OBJECT(authz->list));
> +    g_free(authz->filename);
> +}
> +
> +
> +static void
> +qauthz_list_file_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +    QAuthZClass *authz = QAUTHZ_CLASS(oc);
> +
> +    ucc->complete = qauthz_list_file_complete;
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
> +    authz->is_allowed = qauthz_list_file_is_allowed;
> +}
> +
> +
> +static void
> +qauthz_list_file_init(Object *obj)
> +{
> +    QAuthZListFile *authz = QAUTHZ_LIST_FILE(obj);
> +
> +    authz->file_watch = -1;
> +#ifdef CONFIG_INOTIFY1
> +    authz->refresh = TRUE;
> +#endif
> +}
> +
> +
> +QAuthZListFile *qauthz_list_file_new(const char *id,
> +                                     const char *filename,
> +                                     Error **errp)
> +{
> +    return QAUTHZ_LIST_FILE(
> +        object_new_with_props(TYPE_QAUTHZ_LIST_FILE,
> +                              object_get_objects_root(),
> +                              id, errp,
> +                              "filename", filename,
> +                              NULL));
> +}
> +
> +
> +static const TypeInfo qauthz_list_file_info = {
> +    .parent = TYPE_QAUTHZ_LIST,
> +    .name = TYPE_QAUTHZ_LIST_FILE,
> +    .instance_init = qauthz_list_file_init,
> +    .instance_size = sizeof(QAuthZListFile),
> +    .instance_finalize = qauthz_list_file_finalize,
> +    .class_size = sizeof(QAuthZListFileClass),
> +    .class_init = qauthz_list_file_class_init,
> +    .interfaces = (InterfaceInfo[]) {
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
> @@ -9,3 +9,7 @@ qauthz_simple_is_allowed(void *authz, const char *wantidentity, const char *goti
>  # auth/list.c
>  qauthz_list_check_rule(void *authz, const char *identity, const char *rule, int format, int policy) "AuthZ list %p check rule=%s identity=%s format=%d policy=%d"
>  qauthz_list_default_policy(void *authz, const char *identity, int policy) "AuthZ list %p default identity=%s policy=%d"
> +
> +# auth/listfile.c
> +qauthz_list_file_load(void *authz, const char *filename) "AuthZ file %p load filename=%s"
> +qauthz_list_file_refresh(void *authz, const char *filename, int success) "AuthZ file %p load filename=%s success=%d"
> diff --git a/include/authz/listfile.h b/include/authz/listfile.h
> new file mode 100644
> index 0000000000..244aadc064
> --- /dev/null
> +++ b/include/authz/listfile.h
> @@ -0,0 +1,110 @@
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
> + *      "parameters": {
> + *        "filename": "/etc/qemu/myvm-vnc.acl",
> + *        "refresh": "yes"
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
> + *   -object authz-list-file,id=authz0,\
> + *           filename=/etc/qemu/myvm-vnc.acl,refresh=yes
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
> +                                     Error **errp);
> +
> +
> +#endif /* QAUTHZ_LIST_FILE_H__ */
> +
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ef38ff19e2..fcf7d627fc 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4398,6 +4398,53 @@ would look like:
>       ...
>  @end example
>  
> +
> +@item -object authz-listfile,id=@var{id},filename=@var{path},refresh=@var{yes|no}
> +
> +Create an authorization object that will control access to network services.
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
> +     -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes
> +     ...
> +@end example
> +
>  @end table
>  
>  ETEXI
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
