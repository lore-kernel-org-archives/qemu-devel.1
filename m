Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EDBC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C33F206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoTxtq1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C33F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inPyK-0005DF-5t
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inPwM-0003e1-7w
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inPwJ-0005Ys-MI
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:36:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inPwJ-0005W0-GI
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 11:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578069403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2sinjnwqrrmEZjXX7Kj0QQVvik1TAflLW5NnJnLBgo=;
 b=DoTxtq1b3NS1l8Jq5VBiIQntYPTUPkWJcXeire+6zWcSG5bt88X2P4BnAVWgxHpCSV9Djq
 CuNJfCs+JjurM/bl457GPj5dUfnjZgYwpFM9XUHI7/HBmksB2wakCBTv/M8/aq8p90ar+q
 SP4QdvAKJxlPDUkxj0olEkb/YhcxAPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-ZYajTEXrPy-c9zqwXtsKaA-1; Fri, 03 Jan 2020 11:36:41 -0500
Received: by mail-wm1-f69.google.com with SMTP id c4so1567585wmb.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 08:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2bOQfgH2KfOs3aYrX/NTbmBuio4776Ajt9RP5SEJqoU=;
 b=kmUN4Gsv2ci08RUQqdf+PSNVcIFha7XsbmwxBYd24xda+pWZW44F7gw5gmqYdI2ny2
 zC5YJ+DaCbUuQkW5nyGfVUHJjDFwnPDMoBzgC1EZCs/afCdpyAWjXPWM2DW2nILDZn5l
 XhCMzuFGwuDqolEU/M4Zg9etuBiXVoNG8RYeszTNfOBrIlJdXueqvowIv7UgBqy1MJUU
 Urb9tNgFNxwic5KdlocWkPoPYg4cPeuRwNs1VAInqVe7+654azUMCM8kEfw6AXckwjrS
 boMn7OHw0F3xlUQUALuPh8CRkaogxvmNyQFd/4j2Y0W4JQzNmb/S18cZsvN/bBszcm6u
 clWA==
X-Gm-Message-State: APjAAAWjP8JAotOcD44wxpVuD+IpslNu/slU1twxI9njqS2f0/7j4v3b
 YufrJPrbcaygYm8QvXhPYOZm7JZ+RR6eP0/YeKqA+Yv/q/Taw4tEb6CxElnKIO1NnndFdH7diR0
 XXfOuRCnpRo0P6G8=
X-Received: by 2002:a5d:4983:: with SMTP id r3mr89576382wrq.134.1578069400273; 
 Fri, 03 Jan 2020 08:36:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxt5JCM2o7UxK6cjtrcSqIJCbvSn3y3EiMBuB54R6UHNrE5ojjk+2pnJKFMMXFrf8cTqphwQ==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr89576360wrq.134.1578069399938; 
 Fri, 03 Jan 2020 08:36:39 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id o194sm12999653wme.45.2020.01.03.08.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 08:36:39 -0800 (PST)
Subject: Re: [PATCH v6 10/21] libqos: move useful qos-test funcs to
 qos_external
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-11-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8850b024-796a-b704-79df-6f76c7fb4264@redhat.com>
Date: Fri, 3 Jan 2020 17:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-11-alxndr@bu.edu>
Content-Language: en-US
X-MC-Unique: ZYajTEXrPy-c9zqwXtsKaA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 10:34 PM, Oleinik, Alexander wrote:
> The moved functions are not specific to qos-test and might be useful
> elsewhere. For example the virtual-device fuzzer makes use of them for
> qos-assisted fuzz-targets.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/Makefile.include      |   1 +
>   tests/libqos/qos_external.c | 168 ++++++++++++++++++++++++++++++++++++
>   tests/libqos/qos_external.h |  28 ++++++
>   tests/qos-test.c            | 140 ++----------------------------
>   4 files changed, 202 insertions(+), 135 deletions(-)
>   create mode 100644 tests/libqos/qos_external.c
>   create mode 100644 tests/libqos/qos_external.h
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 031240df4b..79534e9b85 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -718,6 +718,7 @@ libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-p=
c-obj-y) tests/libqos/usb.o
>   # Devices
>   libqos-obj-y =3D $(libqgraph-obj-y)
>   libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> +libqos-obj-y +=3D tests/libqos/qos_external.o
>   libqos-obj-y +=3D tests/libqos/e1000e.o
>   libqos-obj-y +=3D tests/libqos/i2c.o
>   libqos-obj-y +=3D tests/libqos/i2c-imx.o
> diff --git a/tests/libqos/qos_external.c b/tests/libqos/qos_external.c
> new file mode 100644
> index 0000000000..398556dde0
> --- /dev/null
> +++ b/tests/libqos/qos_external.c
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
> diff --git a/tests/libqos/qos_external.h b/tests/libqos/qos_external.h
> new file mode 100644
> index 0000000000..7b44930c55
> --- /dev/null
> +++ b/tests/libqos/qos_external.h
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
> diff --git a/tests/qos-test.c b/tests/qos-test.c
> index fd70d73ea5..9d02b83e24 100644
> --- a/tests/qos-test.c
> +++ b/tests/qos-test.c
> @@ -27,65 +27,11 @@
>   #include "libqos/malloc.h"
>   #include "libqos/qgraph.h"
>   #include "libqos/qgraph_internal.h"
> +#include "libqos/qos_external.h"
>  =20
>   static char *old_path;
>  =20
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
>  =20
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
>  =20
>   /**
>    * qos_set_machines_devices_available(): sets availability of qgraph
> @@ -129,10 +75,6 @@ static void qos_set_machines_devices_available(void)
>       qobject_unref(response);
>   }
>  =20
> -static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
> -{
> -    return obj->get_driver(obj, "memory");
> -}
>  =20
>   static void restart_qemu_or_continue(char *path)
>   {
> @@ -159,78 +101,6 @@ void qos_invalidate_command_line(void)
>       old_path =3D NULL;
>   }
>  =20
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
>  =20
>   /* The argument to run_one_test, which is the test function that is reg=
istered
>    * with GTest, is a vector of strings.  The first item is the initial c=
ommand
> @@ -239,14 +109,14 @@ static void *allocate_objects(QTestState *qts, char=
 **path, QGuestAllocator **p_
>    */
>   static char **current_path;
>  =20
> -const char *qos_get_current_command_line(void)
> +void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
>   {
> -    return current_path[0];
> +    return allocate_objects(qts, current_path + 1, p_alloc);
>   }
>  =20
> -void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
> +const char *qos_get_current_command_line(void)
>   {
> -    return allocate_objects(qts, current_path + 1, p_alloc);
> +    return current_path[0];

I'm not sure why you switched these functions, this is confusing (and=20
unrelated to the patch description). Can you keep the unmodified?
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>   }
>  =20
>   /**
>=20


