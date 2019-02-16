Received: from eggs.gnu.org ([209.51.188.92]:50898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1guyFc-0003pf-IC
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1guyFW-0005Af-Rj
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:35:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1guyFW-00059Q-LS
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:35:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id r21so7314586qkl.11
	for <qemu-devel@nongnu.org>; Sat, 16 Feb 2019 03:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20190215155709.15777-1-berrange@redhat.com>
	<20190215155709.15777-9-berrange@redhat.com>
In-Reply-To: <20190215155709.15777-9-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 16 Feb 2019 12:35:01 +0100
Message-ID: <CAMxuvaxYb2z-UPAwOdJ3yisb0dTpqj2t60=w8Vg2t=9PHhgzXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 08/11] authz: add QAuthZList object type
 for an access control list
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
> From: "Daniel P. Berrange" <berrange@redhat.com>
>
> Add a QAuthZList object type that implements the QAuthZ interface. This
> built-in implementation maintains a trivial access control list with a
> sequence of match rules and a final default policy. This replicates the
> functionality currently provided by the qemu_acl module.
>
> To create an instance of this object via the QMP monitor, the syntax
> used would be:
>
>   {
>     "execute": "object-add",
>     "arguments": {
>       "qom-type": "authz-list",
>       "id": "authz0",
>       "props": {
>         "rules": [
>            { "match": "fred", "policy": "allow", "format": "exact" },
>            { "match": "bob", "policy": "allow", "format": "exact" },
>            { "match": "danb", "policy": "deny", "format": "glob" },
>            { "match": "dan*", "policy": "allow", "format": "exact" },
>         ],
>         "policy": "deny"
>       }
>     }
>   }
>
> This sets up an authorization rule that allows 'fred', 'bob' and anyone
> whose name starts with 'dan', except for 'danb'. Everyone unmatched is
> denied.
>
> It is not currently possible to create this via -object, since there is
> no syntax supported to specify non-scalar properties for objects. This
> is likely to be addressed by later support for using JSON with -object,
> or an equivalent approach.
>
> In any case the future "authz-listfile" object can be used from the
> CLI and is likely a better choice, as it allows the ACL to be refreshed
> automatically on change.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  MAINTAINERS             |   1 +
>  Makefile.objs           |   2 +-
>  authz/Makefile.objs     |   1 +
>  authz/list.c            | 271 ++++++++++++++++++++++++++++++++++++++++
>  authz/trace-events      |   4 +
>  include/authz/list.h    | 106 ++++++++++++++++
>  qapi/authz.json         |  58 +++++++++
>  qapi/qapi-schema.json   |   1 +
>  tests/Makefile.include  |   2 +
>  tests/test-authz-list.c | 159 +++++++++++++++++++++++
>  10 files changed, 604 insertions(+), 1 deletion(-)
>  create mode 100644 authz/list.c
>  create mode 100644 include/authz/list.h
>  create mode 100644 qapi/authz.json
>  create mode 100644 tests/test-authz-list.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3941c1fbe4..8525230a9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2076,6 +2076,7 @@ User authorization
>  M: Daniel P. Berrange <berrange@redhat.com>
>  S: Maintained
>  F: authz/
> +F: qapi/authz.json
>  F: include/authz/
>  F: tests/test-authz-*
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 68910f8169..dda63341cd 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -1,6 +1,6 @@
>  QAPI_MODULES =3D block-core block char common crypto introspect job migr=
ation
>  QAPI_MODULES +=3D misc net rdma rocker run-state sockets tpm trace trans=
action
> -QAPI_MODULES +=3D ui
> +QAPI_MODULES +=3D ui authz
>
>  #######################################################################
>  # Common libraries for tools and emulators
> diff --git a/authz/Makefile.objs b/authz/Makefile.objs
> index 2a75d53840..921fa624d7 100644
> --- a/authz/Makefile.objs
> +++ b/authz/Makefile.objs
> @@ -1,2 +1,3 @@
>  authz-obj-y +=3D base.o
>  authz-obj-y +=3D simple.o
> +authz-obj-y +=3D list.o
> diff --git a/authz/list.c b/authz/list.c
> new file mode 100644
> index 0000000000..dc6b0fec13
> --- /dev/null
> +++ b/authz/list.c
> @@ -0,0 +1,271 @@
> +/*
> + * QEMU access control list authorization driver
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
> +#include "authz/list.h"
> +#include "authz/trace.h"
> +#include "qom/object_interfaces.h"
> +#include "qapi/qapi-visit-authz.h"
> +
> +static bool qauthz_list_is_allowed(QAuthZ *authz,
> +                                   const char *identity,
> +                                   Error **errp)
> +{
> +    QAuthZList *lauthz =3D QAUTHZ_LIST(authz);
> +    QAuthZListRuleList *rules =3D lauthz->rules;
> +
> +    while (rules) {
> +        QAuthZListRule *rule =3D rules->value;
> +        QAuthZListFormat format =3D rule->has_format ? rule->format :
> +            QAUTHZ_LIST_FORMAT_EXACT;
> +
> +        trace_qauthz_list_check_rule(authz, rule->match, identity,
> +                                     format, rule->policy);
> +        switch (format) {
> +        case QAUTHZ_LIST_FORMAT_EXACT:
> +            if (g_str_equal(rule->match, identity)) {
> +                return rule->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
> +            }
> +            break;
> +        case QAUTHZ_LIST_FORMAT_GLOB:
> +            if (g_pattern_match_simple(rule->match, identity)) {
> +                return rule->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
> +            }
> +            break;
> +        default:
> +            g_warn_if_reached();
> +            return false;
> +        }
> +        rules =3D rules->next;
> +    }
> +
> +    trace_qauthz_list_default_policy(authz, identity, lauthz->policy);
> +    return lauthz->policy =3D=3D QAUTHZ_LIST_POLICY_ALLOW;
> +}
> +
> +
> +static void
> +qauthz_list_prop_set_policy(Object *obj,
> +                            int value,
> +                            Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
> +
> +    lauthz->policy =3D value;
> +}
> +
> +
> +static int
> +qauthz_list_prop_get_policy(Object *obj,
> +                            Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
> +
> +    return lauthz->policy;
> +}
> +
> +
> +static void
> +qauthz_list_prop_get_rules(Object *obj, Visitor *v, const char *name,
> +                           void *opaque, Error **errp)
> +{
> +    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
> +
> +    visit_type_QAuthZListRuleList(v, name, &lauthz->rules, errp);
> +}
> +
> +static void
> +qauthz_list_prop_set_rules(Object *obj, Visitor *v, const char *name,
> +                           void *opaque, Error **errp)
> +{
> +    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
> +    QAuthZListRuleList *oldrules;
> +
> +    oldrules =3D lauthz->rules;
> +    visit_type_QAuthZListRuleList(v, name, &lauthz->rules, errp);
> +
> +    qapi_free_QAuthZListRuleList(oldrules);
> +}
> +
> +
> +static void
> +qauthz_list_finalize(Object *obj)
> +{
> +    QAuthZList *lauthz =3D QAUTHZ_LIST(obj);
> +
> +    qapi_free_QAuthZListRuleList(lauthz->rules);
> +}
> +
> +
> +static void
> +qauthz_list_class_init(ObjectClass *oc, void *data)
> +{
> +    QAuthZClass *authz =3D QAUTHZ_CLASS(oc);
> +
> +    object_class_property_add_enum(oc, "policy",
> +                                   "QAuthZListPolicy",
> +                                   &QAuthZListPolicy_lookup,
> +                                   qauthz_list_prop_get_policy,
> +                                   qauthz_list_prop_set_policy,
> +                                   NULL);
> +
> +    object_class_property_add(oc, "rules", "QAuthZListRule",
> +                              qauthz_list_prop_get_rules,
> +                              qauthz_list_prop_set_rules,
> +                              NULL, NULL, NULL);
> +
> +    authz->is_allowed =3D qauthz_list_is_allowed;
> +}
> +
> +
> +QAuthZList *qauthz_list_new(const char *id,
> +                            QAuthZListPolicy policy,
> +                            Error **errp)
> +{
> +    return QAUTHZ_LIST(
> +        object_new_with_props(TYPE_QAUTHZ_LIST,
> +                              object_get_objects_root(),
> +                              id, errp,
> +                              "policy", QAuthZListPolicy_str(policy),
> +                              NULL));
> +}
> +
> +ssize_t qauthz_list_append_rule(QAuthZList *auth,
> +                                const char *match,
> +                                QAuthZListPolicy policy,
> +                                QAuthZListFormat format,
> +                                Error **errp)
> +{
> +    QAuthZListRule *rule;
> +    QAuthZListRuleList *rules, *tmp;
> +    size_t i =3D 0;
> +
> +    rule =3D g_new0(QAuthZListRule, 1);
> +    rule->policy =3D policy;
> +    rule->match =3D g_strdup(match);
> +    rule->format =3D format;
> +    rule->has_format =3D true;
> +
> +    tmp =3D g_new0(QAuthZListRuleList, 1);
> +    tmp->value =3D rule;
> +
> +    rules =3D auth->rules;
> +    if (rules) {
> +        while (rules->next) {
> +            i++;
> +            rules =3D rules->next;
> +        }
> +        rules->next =3D tmp;
> +        return i + 1;
> +    } else {
> +        auth->rules =3D tmp;
> +        return 0;
> +    }
> +}
> +
> +
> +ssize_t qauthz_list_insert_rule(QAuthZList *auth,
> +                                const char *match,
> +                                QAuthZListPolicy policy,
> +                                QAuthZListFormat format,
> +                                size_t index,
> +                                Error **errp)
> +{
> +    QAuthZListRule *rule;
> +    QAuthZListRuleList *rules, *tmp;
> +    size_t i =3D 0;
> +
> +    rule =3D g_new0(QAuthZListRule, 1);
> +    rule->policy =3D policy;
> +    rule->match =3D g_strdup(match);
> +    rule->format =3D format;
> +    rule->has_format =3D true;
> +
> +    tmp =3D g_new0(QAuthZListRuleList, 1);
> +    tmp->value =3D rule;
> +
> +    rules =3D auth->rules;
> +    if (rules && index > 0) {
> +        while (rules->next && i < (index - 1)) {
> +            i++;
> +            rules =3D rules->next;
> +        }
> +        tmp->next =3D rules->next;
> +        rules->next =3D tmp;
> +        return i + 1;
> +    } else {
> +        tmp->next =3D auth->rules;
> +        auth->rules =3D tmp;
> +        return 0;
> +    }
> +}
> +
> +
> +ssize_t qauthz_list_delete_rule(QAuthZList *auth, const char *match)
> +{
> +    QAuthZListRule *rule;
> +    QAuthZListRuleList *rules, *prev;
> +    size_t i =3D 0;
> +
> +    prev =3D NULL;
> +    rules =3D auth->rules;
> +    while (rules) {
> +        rule =3D rules->value;
> +        if (g_str_equal(rule->match, match)) {
> +            if (prev) {
> +                prev->next =3D rules->next;
> +            } else {
> +                auth->rules =3D rules->next;
> +            }
> +            rules->next =3D NULL;
> +            qapi_free_QAuthZListRuleList(rules);
> +            return i;
> +        }
> +        prev =3D rules;
> +        rules =3D rules->next;
> +        i++;
> +    }
> +
> +    return -1;
> +}
> +
> +
> +static const TypeInfo qauthz_list_info =3D {
> +    .parent =3D TYPE_QAUTHZ,
> +    .name =3D TYPE_QAUTHZ_LIST,
> +    .instance_size =3D sizeof(QAuthZList),
> +    .instance_finalize =3D qauthz_list_finalize,
> +    .class_size =3D sizeof(QAuthZListClass),
> +    .class_init =3D qauthz_list_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +
> +static void
> +qauthz_list_register_types(void)
> +{
> +    type_register_static(&qauthz_list_info);
> +}
> +
> +
> +type_init(qauthz_list_register_types);
> diff --git a/authz/trace-events b/authz/trace-events
> index 1ef796c1e1..a896d876e8 100644
> --- a/authz/trace-events
> +++ b/authz/trace-events
> @@ -5,3 +5,7 @@ qauthz_is_allowed(void *authz, const char *identity, bool=
 allowed) "AuthZ %p che
>
>  # auth/simple.c
>  qauthz_simple_is_allowed(void *authz, const char *wantidentity, const ch=
ar *gotidentity) "AuthZ simple %p check want identity=3D%s got identity=3D%=
s"
> +
> +# auth/list.c
> +qauthz_list_check_rule(void *authz, const char *identity, const char *ru=
le, int format, int policy) "AuthZ list %p check rule=3D%s identity=3D%s fo=
rmat=3D%d policy=3D%d"
> +qauthz_list_default_policy(void *authz, const char *identity, int policy=
) "AuthZ list %p default identity=3D%s policy=3D%d"
> diff --git a/include/authz/list.h b/include/authz/list.h
> new file mode 100644
> index 0000000000..a7225a747c
> --- /dev/null
> +++ b/include/authz/list.h
> @@ -0,0 +1,106 @@
> +/*
> + * QEMU list authorization driver
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
> +#ifndef QAUTHZ_LIST_H__
> +#define QAUTHZ_LIST_H__
> +
> +#include "authz/base.h"
> +#include "qapi/qapi-types-authz.h"
> +
> +#define TYPE_QAUTHZ_LIST "authz-list"
> +
> +#define QAUTHZ_LIST_CLASS(klass)                        \
> +    OBJECT_CLASS_CHECK(QAuthZListClass, (klass),        \
> +                       TYPE_QAUTHZ_LIST)
> +#define QAUTHZ_LIST_GET_CLASS(obj)              \
> +    OBJECT_GET_CLASS(QAuthZListClass, (obj),    \
> +                      TYPE_QAUTHZ_LIST)
> +#define QAUTHZ_LIST(obj) \
> +    INTERFACE_CHECK(QAuthZList, (obj),          \
> +                    TYPE_QAUTHZ_LIST)
> +
> +typedef struct QAuthZList QAuthZList;
> +typedef struct QAuthZListClass QAuthZListClass;
> +
> +
> +/**
> + * QAuthZList:
> + *
> + * This authorization driver provides a list mechanism
> + * for granting access by matching user names against a
> + * list of globs. Each match rule has an associated policy
> + * and a catch all policy applies if no rule matches
> + *
> + * To create an instance of this class via QMP:
> + *
> + *  {
> + *    "execute": "object-add",
> + *    "arguments": {
> + *      "qom-type": "authz-list",
> + *      "id": "authz0",
> + *      "props": {
> + *        "rules": [
> + *           { "match": "fred", "policy": "allow", "format": "exact" },
> + *           { "match": "bob", "policy": "allow", "format": "exact" },
> + *           { "match": "danb", "policy": "deny", "format": "exact" },
> + *           { "match": "dan*", "policy": "allow", "format": "glob" }
> + *        ],
> + *        "policy": "deny"
> + *      }
> + *    }
> + *  }
> + *
> + */
> +struct QAuthZList {
> +    QAuthZ parent_obj;
> +
> +    QAuthZListPolicy policy;
> +    QAuthZListRuleList *rules;
> +};
> +
> +
> +struct QAuthZListClass {
> +    QAuthZClass parent_class;
> +};
> +
> +
> +QAuthZList *qauthz_list_new(const char *id,
> +                            QAuthZListPolicy policy,
> +                            Error **errp);
> +
> +ssize_t qauthz_list_append_rule(QAuthZList *auth,
> +                                const char *match,
> +                                QAuthZListPolicy policy,
> +                                QAuthZListFormat format,
> +                                Error **errp);
> +
> +ssize_t qauthz_list_insert_rule(QAuthZList *auth,
> +                                const char *match,
> +                                QAuthZListPolicy policy,
> +                                QAuthZListFormat format,
> +                                size_t index,
> +                                Error **errp);
> +
> +ssize_t qauthz_list_delete_rule(QAuthZList *auth,
> +                                const char *match);
> +
> +
> +#endif /* QAUTHZ_LIST_H__ */
> +
> diff --git a/qapi/authz.json b/qapi/authz.json
> new file mode 100644
> index 0000000000..55468de8a8
> --- /dev/null
> +++ b/qapi/authz.json
> @@ -0,0 +1,58 @@
> +# -*- Mode: Python -*-
> +#
> +# QAPI authz definitions
> +
> +##
> +# @QAuthZListPolicy:
> +#
> +# The authorization policy result
> +#
> +# @deny: deny access
> +# @allow: allow access
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'QAuthZListPolicy',
> +  'prefix': 'QAUTHZ_LIST_POLICY',
> +  'data': ['deny', 'allow']}
> +
> +##
> +# @QAuthZListFormat:
> +#
> +# The authorization policy result
> +#
> +# @exact: an exact string match
> +# @glob: string with ? and * shell wildcard support
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'QAuthZListFormat',
> +  'prefix': 'QAUTHZ_LIST_FORMAT',
> +  'data': ['exact', 'glob']}
> +
> +##
> +# @QAuthZListRule:
> +#
> +# A single authorization rule.
> +#
> +# @match: a glob to match against a user identity
> +# @policy: the result to return if @match evaluates to true
> +# @format: (optional) the format of the @match rule (default 'exact')
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'QAuthZListRule',
> +  'data': {'match': 'str',
> +           'policy': 'QAuthZListPolicy',
> +           '*format': 'QAuthZListFormat'}}
> +
> +##
> +# @QAuthZListRuleListHack:
> +#
> +# Not exposed via QMP; hack to generate QAuthZListRuleList
> +# for use internally by the code.
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'QAuthZListRuleListHack',
> +  'data': { 'unused': ['QAuthZListRule'] } }
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 1845aa78ff..1f7201cd81 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -92,6 +92,7 @@
>  { 'include': 'rocker.json' }
>  { 'include': 'tpm.json' }
>  { 'include': 'ui.json' }
> +{ 'include': 'authz.json' }
>  { 'include': 'migration.json' }
>  { 'include': 'transaction.json' }
>  { 'include': 'trace.json' }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index df1cd255a9..c007968805 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -117,6 +117,7 @@ check-unit-y +=3D tests/test-timed-average$(EXESUF)
>  check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
>  check-unit-y +=3D tests/test-util-sockets$(EXESUF)
>  check-unit-y +=3D tests/test-authz-simple$(EXESUF)
> +check-unit-y +=3D tests/test-authz-list$(EXESUF)
>  check-unit-y +=3D tests/test-io-task$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-socket$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-file$(EXESUF)
> @@ -665,6 +666,7 @@ tests/test-util-filemonitor$(EXESUF): tests/test-util=
-filemonitor.o \
>  tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
>         tests/socket-helpers.o $(test-util-obj-y)
>  tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz=
-obj-y)
> +tests/test-authz-list$(EXESUF): tests/test-authz-list.o $(test-authz-obj=
-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
>          tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
> diff --git a/tests/test-authz-list.c b/tests/test-authz-list.c
> new file mode 100644
> index 0000000000..24347a6ac3
> --- /dev/null
> +++ b/tests/test-authz-list.c
> @@ -0,0 +1,159 @@
> +/*
> + * QEMU list file authorization object tests
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
> +
> +#include "authz/list.h"
> +
> +static void test_authz_default_deny(void)
> +{
> +    QAuthZList *auth =3D qauthz_list_new("auth0",
> +                                       QAUTHZ_LIST_POLICY_DENY,
> +                                       &error_abort);
> +
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +static void test_authz_default_allow(void)
> +{
> +    QAuthZList *auth =3D qauthz_list_new("auth0",
> +                                       QAUTHZ_LIST_POLICY_ALLOW,
> +                                       &error_abort);
> +
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +static void test_authz_explicit_deny(void)
> +{
> +    QAuthZList *auth =3D qauthz_list_new("auth0",
> +                                       QAUTHZ_LIST_POLICY_ALLOW,
> +                                       &error_abort);
> +
> +    qauthz_list_append_rule(auth, "fred", QAUTHZ_LIST_POLICY_DENY,
> +                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
> +
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +static void test_authz_explicit_allow(void)
> +{
> +    QAuthZList *auth =3D qauthz_list_new("auth0",
> +                                       QAUTHZ_LIST_POLICY_DENY,
> +                                       &error_abort);
> +
> +    qauthz_list_append_rule(auth, "fred", QAUTHZ_LIST_POLICY_ALLOW,
> +                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
> +
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +
> +static void test_authz_complex(void)
> +{
> +    QAuthZList *auth =3D qauthz_list_new("auth0",
> +                                       QAUTHZ_LIST_POLICY_DENY,
> +                                       &error_abort);
> +
> +    qauthz_list_append_rule(auth, "fred", QAUTHZ_LIST_POLICY_ALLOW,
> +                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
> +    qauthz_list_append_rule(auth, "bob", QAUTHZ_LIST_POLICY_ALLOW,
> +                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
> +    qauthz_list_append_rule(auth, "dan", QAUTHZ_LIST_POLICY_DENY,
> +                            QAUTHZ_LIST_FORMAT_EXACT, &error_abort);
> +    qauthz_list_append_rule(auth, "dan*", QAUTHZ_LIST_POLICY_ALLOW,
> +                            QAUTHZ_LIST_FORMAT_GLOB, &error_abort);
> +
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "fred", &error_abort));
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "bob", &error_abort));
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "danb", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +static void test_authz_add_remove(void)
> +{
> +    QAuthZList *auth =3D qauthz_list_new("auth0",
> +                                       QAUTHZ_LIST_POLICY_ALLOW,
> +                                       &error_abort);
> +
> +    g_assert_cmpint(qauthz_list_append_rule(auth, "fred",
> +                                            QAUTHZ_LIST_POLICY_ALLOW,
> +                                            QAUTHZ_LIST_FORMAT_EXACT,
> +                                            &error_abort),
> +                    =3D=3D, 0);
> +    g_assert_cmpint(qauthz_list_append_rule(auth, "bob",
> +                                            QAUTHZ_LIST_POLICY_ALLOW,
> +                                            QAUTHZ_LIST_FORMAT_EXACT,
> +                                            &error_abort),
> +                    =3D=3D, 1);
> +    g_assert_cmpint(qauthz_list_append_rule(auth, "dan",
> +                                            QAUTHZ_LIST_POLICY_DENY,
> +                                            QAUTHZ_LIST_FORMAT_EXACT,
> +                                            &error_abort),
> +                    =3D=3D, 2);
> +    g_assert_cmpint(qauthz_list_append_rule(auth, "frank",
> +                                            QAUTHZ_LIST_POLICY_DENY,
> +                                            QAUTHZ_LIST_FORMAT_EXACT,
> +                                            &error_abort),
> +                    =3D=3D, 3);
> +
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
> +
> +    g_assert_cmpint(qauthz_list_delete_rule(auth, "dan"),
> +                    =3D=3D, 2);
> +
> +    g_assert(qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
> +
> +    g_assert_cmpint(qauthz_list_insert_rule(auth, "dan",
> +                                            QAUTHZ_LIST_POLICY_DENY,
> +                                            QAUTHZ_LIST_FORMAT_EXACT,
> +                                            2,
> +                                            &error_abort),
> +                    =3D=3D, 2);
> +
> +    g_assert(!qauthz_is_allowed(QAUTHZ(auth), "dan", &error_abort));
> +
> +    object_unparent(OBJECT(auth));
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    g_test_add_func("/auth/list/default/deny", test_authz_default_deny);
> +    g_test_add_func("/auth/list/default/allow", test_authz_default_allow=
);
> +    g_test_add_func("/auth/list/explicit/deny", test_authz_explicit_deny=
);
> +    g_test_add_func("/auth/list/explicit/allow", test_authz_explicit_all=
ow);
> +    g_test_add_func("/auth/list/complex", test_authz_complex);
> +    g_test_add_func("/auth/list/add-remove", test_authz_add_remove);
> +
> +    return g_test_run();
> +}
> --
> 2.20.1
>
