Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB73C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCD920708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqLDaul0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCD920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkCl-0000Rf-MV
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iwkBy-00081l-O4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iwkBw-0008Ph-3U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:03:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iwkBv-0008PG-Ua
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580292203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDnQRe19qKOU0D6AzNMHStk0WcCC38b2uAGbbdWPiLY=;
 b=QqLDaul0hGMKJsETk/rPx7UIgJZJmN8+wfepiKd+7sWL0nVQyxpIo/BlUcdpZlvMtBcdun
 iwqd0uDebXQvjgt5uJ/A25ghqDlz6RX2630AvH8bhhFBp9g8I+9wLPrT1eb5vXN66Wkms7
 7Hl7llPw8vNM+t6pKi+pLTsKZapBUkA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-q1E1cPboN8Ofc1zRBnBq9g-1; Wed, 29 Jan 2020 05:03:19 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so9873808wrr.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 02:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7azKD9j7Ke2mNQXZ02k1WcwXh6TXRUY/9Ch4l4ZZ5r4=;
 b=Fdv+a5NYJgcGfIWtDdtR0iYfKuE7de/SY8pYxv9ABnP2NIh5FssU0Q7tA1mDJ/qcpt
 EVf5wb36WB5DchDx2utO6IrSZTwZC5WDJv88pNNMYZ/BnxXV8hMvh7h5whAoMewjBIwt
 d8HLKIUM0JuEcMduuobdOukPGU64dGGYOYIQRizylKMexR3PYD93ShNOOVIcPB7XUbdp
 hALWPxjmVYjAX95D4D38d2IkdxVBkVUQ7tvtQpOT2uDqfuqEEM2E9EJfW2e9pGaJ4wqQ
 Nhd6GyHy6qHgBkOaIfBHpHq1GWtZDCawOIZ0PRyAn64754K5czu5NSOSAHJmHP/yCq9M
 kxhw==
X-Gm-Message-State: APjAAAWYJ2G1XiSwOPf6ftrpgVW3A0O+MW2uB6JoE6GIdillQ5TIz6m+
 XaZ8PABQ7UQpr5vdCXMasq/lNfnN1c0txRvkxaMQE/SrakC6CtJ9hrQp18d6m8nuVXPXloevUu0
 g1XWztlzedOtlkI8=
X-Received: by 2002:a7b:c242:: with SMTP id b2mr3272465wmj.19.1580292197933;
 Wed, 29 Jan 2020 02:03:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsGg3L/9yC65LHy5kcFM/K10Kz7POC/z+XWuzqNYcASvbaDLHSo51AlU/iNdotsXlIkCnlwQ==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr3272422wmj.19.1580292197525;
 Wed, 29 Jan 2020 02:03:17 -0800 (PST)
Received: from [10.200.153.153] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id u18sm2205483wrt.26.2020.01.29.02.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 02:03:17 -0800 (PST)
Subject: Re: [PATCH v8 10/21] libqos: move useful qos-test funcs to
 qos_external
To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-11-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41e7f9ff-fedb-6557-42d0-d9766549c104@redhat.com>
Date: Wed, 29 Jan 2020 11:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200129053357.27454-11-alxndr@bu.edu>
Content-Language: en-US
X-MC-Unique: q1E1cPboN8Ofc1zRBnBq9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/20 06:34, Bulekov, Alexander wrote:
> The moved functions are not specific to qos-test and might be useful
> elsewhere. For example the virtual-device fuzzer makes use of them for
> qos-assisted fuzz-targets.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/qtest/Makefile.include      |   1 +
>  tests/qtest/libqos/qos_external.c | 168 ++++++++++++++++++++++++++++++
>  tests/qtest/libqos/qos_external.h |  28 +++++
>  tests/qtest/qos-test.c            | 132 +----------------------
>  4 files changed, 198 insertions(+), 131 deletions(-)
>  create mode 100644 tests/qtest/libqos/qos_external.c
>  create mode 100644 tests/qtest/libqos/qos_external.h
>=20
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index 08a48c1252..bdc93d3866 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -172,6 +172,7 @@ libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-p=
c-obj-y) tests/qtest/libqos/u
>  # qos devices:
>  libqos-obj-y =3D  $(libqgraph-obj-y)
>  libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> +libqos-obj-y +=3D tests/qtest/libqos/qos_external.o
>  libqos-obj-y +=3D tests/qtest/libqos/e1000e.o
>  libqos-obj-y +=3D tests/qtest/libqos/i2c.o
>  libqos-obj-y +=3D tests/qtest/libqos/i2c-imx.o
> diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_e=
xternal.c
> new file mode 100644
> index 0000000000..398556dde0
> --- /dev/null
> +++ b/tests/qtest/libqos/qos_external.c
> @@ -0,0 +1,168 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gma=
il.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include <getopt.h>
> +#include "libqtest.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qbool.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qemu/module.h"
> +#include "qapi/qmp/qlist.h"
> +#include "libqos/malloc.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/qgraph_internal.h"
> +#include "libqos/qos_external.h"
> +
> +
> +
> +void apply_to_node(const char *name, bool is_machine, bool is_abstract)
> +{
> +    char *machine_name =3D NULL;
> +    if (is_machine) {
> +        const char *arch =3D qtest_get_arch();
> +        machine_name =3D g_strconcat(arch, "/", name, NULL);
> +        name =3D machine_name;
> +    }
> +    qos_graph_node_set_availability(name, true);
> +    if (is_abstract) {
> +        qos_delete_cmd_line(name);
> +    }
> +    g_free(machine_name);
> +}

This can be static.

> +
> +/**
> + * apply_to_qlist(): using QMP queries QEMU for a list of
> + * machines and devices available, and sets the respective node
> + * as true. If a node is found, also all its produced and contained
> + * child are marked available.
> + *
> + * See qos_graph_node_set_availability() for more info
> + */
> +void apply_to_qlist(QList *list, bool is_machine)

I think this could be split in two functions with a nicer API, for example

void mark_machines_available(QList *list);
void mark_devices_available(QList *list);

It's okay if internally they just call apply_to_qlist(list, true/false),

only the API would be nicer.
Also feel free to move it to tests/libqos/qgraph.c and
tests/libqos/qgraph_internal.h.  It's probably a good idea to rename
qgraph.h to qgraph-object.h, and qgraph_internal.h to qgraph.h while at it.

Paolo


> +{
> +    const QListEntry *p;
> +    const char *name;
> +    bool abstract;
> +    QDict *minfo;
> +    QObject *qobj;
> +    QString *qstr;
> +    QBool *qbool;
> +
> +    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
> +        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
> +        qobj =3D qdict_get(minfo, "name");
> +        qstr =3D qobject_to(QString, qobj);
> +        name =3D qstring_get_str(qstr);
> +
> +        qobj =3D qdict_get(minfo, "abstract");
> +        if (qobj) {
> +            qbool =3D qobject_to(QBool, qobj);
> +            abstract =3D qbool_get_bool(qbool);
> +        } else {
> +            abstract =3D false;
> +        }
> +
> +        apply_to_node(name, is_machine, abstract);
> +        qobj =3D qdict_get(minfo, "alias");
> +        if (qobj) {
> +            qstr =3D qobject_to(QString, qobj);
> +            name =3D qstring_get_str(qstr);
> +            apply_to_node(name, is_machine, abstract);
> +        }
> +    }
> +}
> +
> +QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
> +{
> +    return obj->get_driver(obj, "memory");
> +}
> +
> +/**
> + * allocate_objects(): given an array of nodes @arg,
> + * walks the path invoking all constructors and
> + * passing the corresponding parameter in order to
> + * continue the objects allocation.
> + * Once the test is reached, return the object it consumes.
> + *
> + * Since the machine and QEDGE_CONSUMED_BY nodes allocate
> + * memory in the constructor, g_test_queue_destroy is used so
> + * that after execution they can be safely free'd.  (The test's
> + * ->before callback is also welcome to use g_test_queue_destroy).
> + *
> + * Note: as specified in walk_path() too, @arg is an array of
> + * char *, where arg[0] is a pointer to the command line
> + * string that will be used to properly start QEMU when executing
> + * the test, and the remaining elements represent the actual objects
> + * that will be allocated.
> + */
> +void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p=
_alloc)
> +{
> +    int current =3D 0;
> +    QGuestAllocator *alloc;
> +    QOSGraphObject *parent =3D NULL;
> +    QOSGraphEdge *edge;
> +    QOSGraphNode *node;
> +    void *edge_arg;
> +    void *obj;
> +
> +    node =3D qos_graph_get_node(path[current]);
> +    g_assert(node->type =3D=3D QNODE_MACHINE);
> +
> +    obj =3D qos_machine_new(node, qts);
> +    qos_object_queue_destroy(obj);
> +
> +    alloc =3D get_machine_allocator(obj);
> +    if (p_alloc) {
> +        *p_alloc =3D alloc;
> +    }
> +
> +    for (;;) {
> +        if (node->type !=3D QNODE_INTERFACE) {
> +            qos_object_start_hw(obj);
> +            parent =3D obj;
> +        }
> +
> +        /* follow edge and get object for next node constructor */
> +        current++;
> +        edge =3D qos_graph_get_edge(path[current - 1], path[current]);
> +        node =3D qos_graph_get_node(path[current]);
> +
> +        if (node->type =3D=3D QNODE_TEST) {
> +            g_assert(qos_graph_edge_get_type(edge) =3D=3D QEDGE_CONSUMED=
_BY);
> +            return obj;
> +        }
> +
> +        switch (qos_graph_edge_get_type(edge)) {
> +        case QEDGE_PRODUCES:
> +            obj =3D parent->get_driver(parent, path[current]);
> +            break;
> +
> +        case QEDGE_CONSUMED_BY:
> +            edge_arg =3D qos_graph_edge_get_arg(edge);
> +            obj =3D qos_driver_new(node, obj, alloc, edge_arg);
> +            qos_object_queue_destroy(obj);
> +            break;
> +
> +        case QEDGE_CONTAINS:
> +            obj =3D parent->get_device(parent, path[current]);
> +            break;
> +        }
> +    }
> +}
> +
> diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_e=
xternal.h
> new file mode 100644
> index 0000000000..7b44930c55
> --- /dev/null
> +++ b/tests/qtest/libqos/qos_external.h
> @@ -0,0 +1,28 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gma=
il.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
> + */
> +
> +#ifndef QOS_EXTERNAL_H
> +#define QOS_EXTERNAL_H
> +#include "libqos/qgraph.h"
> +
> +void apply_to_node(const char *name, bool is_machine, bool is_abstract);
> +void apply_to_qlist(QList *list, bool is_machine);
> +QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
> +void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p=
_alloc);
> +
> +#endif
> diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
> index fd70d73ea5..ad193f43a5 100644
> --- a/tests/qtest/qos-test.c
> +++ b/tests/qtest/qos-test.c
> @@ -27,65 +27,11 @@
>  #include "libqos/malloc.h"
>  #include "libqos/qgraph.h"
>  #include "libqos/qgraph_internal.h"
> +#include "libqos/qos_external.h"
> =20
>  static char *old_path;
> =20
> -static void apply_to_node(const char *name, bool is_machine, bool is_abs=
tract)
> -{
> -    char *machine_name =3D NULL;
> -    if (is_machine) {
> -        const char *arch =3D qtest_get_arch();
> -        machine_name =3D g_strconcat(arch, "/", name, NULL);
> -        name =3D machine_name;
> -    }
> -    qos_graph_node_set_availability(name, true);
> -    if (is_abstract) {
> -        qos_delete_cmd_line(name);
> -    }
> -    g_free(machine_name);
> -}
> =20
> -/**
> - * apply_to_qlist(): using QMP queries QEMU for a list of
> - * machines and devices available, and sets the respective node
> - * as true. If a node is found, also all its produced and contained
> - * child are marked available.
> - *
> - * See qos_graph_node_set_availability() for more info
> - */
> -static void apply_to_qlist(QList *list, bool is_machine)
> -{
> -    const QListEntry *p;
> -    const char *name;
> -    bool abstract;
> -    QDict *minfo;
> -    QObject *qobj;
> -    QString *qstr;
> -    QBool *qbool;
> -
> -    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
> -        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
> -        qobj =3D qdict_get(minfo, "name");
> -        qstr =3D qobject_to(QString, qobj);
> -        name =3D qstring_get_str(qstr);
> -
> -        qobj =3D qdict_get(minfo, "abstract");
> -        if (qobj) {
> -            qbool =3D qobject_to(QBool, qobj);
> -            abstract =3D qbool_get_bool(qbool);
> -        } else {
> -            abstract =3D false;
> -        }
> -
> -        apply_to_node(name, is_machine, abstract);
> -        qobj =3D qdict_get(minfo, "alias");
> -        if (qobj) {
> -            qstr =3D qobject_to(QString, qobj);
> -            name =3D qstring_get_str(qstr);
> -            apply_to_node(name, is_machine, abstract);
> -        }
> -    }
> -}
> =20
>  /**
>   * qos_set_machines_devices_available(): sets availability of qgraph
> @@ -129,10 +75,6 @@ static void qos_set_machines_devices_available(void)
>      qobject_unref(response);
>  }
> =20
> -static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
> -{
> -    return obj->get_driver(obj, "memory");
> -}
> =20
>  static void restart_qemu_or_continue(char *path)
>  {
> @@ -159,78 +101,6 @@ void qos_invalidate_command_line(void)
>      old_path =3D NULL;
>  }
> =20
> -/**
> - * allocate_objects(): given an array of nodes @arg,
> - * walks the path invoking all constructors and
> - * passing the corresponding parameter in order to
> - * continue the objects allocation.
> - * Once the test is reached, return the object it consumes.
> - *
> - * Since the machine and QEDGE_CONSUMED_BY nodes allocate
> - * memory in the constructor, g_test_queue_destroy is used so
> - * that after execution they can be safely free'd.  (The test's
> - * ->before callback is also welcome to use g_test_queue_destroy).
> - *
> - * Note: as specified in walk_path() too, @arg is an array of
> - * char *, where arg[0] is a pointer to the command line
> - * string that will be used to properly start QEMU when executing
> - * the test, and the remaining elements represent the actual objects
> - * that will be allocated.
> - */
> -static void *allocate_objects(QTestState *qts, char **path, QGuestAlloca=
tor **p_alloc)
> -{
> -    int current =3D 0;
> -    QGuestAllocator *alloc;
> -    QOSGraphObject *parent =3D NULL;
> -    QOSGraphEdge *edge;
> -    QOSGraphNode *node;
> -    void *edge_arg;
> -    void *obj;
> -
> -    node =3D qos_graph_get_node(path[current]);
> -    g_assert(node->type =3D=3D QNODE_MACHINE);
> -
> -    obj =3D qos_machine_new(node, qts);
> -    qos_object_queue_destroy(obj);
> -
> -    alloc =3D get_machine_allocator(obj);
> -    if (p_alloc) {
> -        *p_alloc =3D alloc;
> -    }
> -
> -    for (;;) {
> -        if (node->type !=3D QNODE_INTERFACE) {
> -            qos_object_start_hw(obj);
> -            parent =3D obj;
> -        }
> -
> -        /* follow edge and get object for next node constructor */
> -        current++;
> -        edge =3D qos_graph_get_edge(path[current - 1], path[current]);
> -        node =3D qos_graph_get_node(path[current]);
> -
> -        if (node->type =3D=3D QNODE_TEST) {
> -            g_assert(qos_graph_edge_get_type(edge) =3D=3D QEDGE_CONSUMED=
_BY);
> -            return obj;
> -        }
> -
> -        switch (qos_graph_edge_get_type(edge)) {
> -        case QEDGE_PRODUCES:
> -            obj =3D parent->get_driver(parent, path[current]);
> -            break;
> -
> -        case QEDGE_CONSUMED_BY:
> -            edge_arg =3D qos_graph_edge_get_arg(edge);
> -            obj =3D qos_driver_new(node, obj, alloc, edge_arg);
> -            qos_object_queue_destroy(obj);
> -            break;
> -
> -        case QEDGE_CONTAINS:
> -            obj =3D parent->get_device(parent, path[current]);
> -            break;
> -        }
> -    }
> -}
> =20
>  /* The argument to run_one_test, which is the test function that is regi=
stered
>   * with GTest, is a vector of strings.  The first item is the initial co=
mmand
>=20


