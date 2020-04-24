Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE2C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB35A2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB35A2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS0da-0001n1-O2
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jS0Tg-00030y-2a
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jS0TX-0007nN-7p
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:42:54 -0400
Received: from relay68.bu.edu ([128.197.228.73]:54803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jS0TW-0007ZR-Pg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:42:46 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 03OFfPji014429
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Apr 2020 11:41:30 -0400
Date: Fri, 24 Apr 2020 11:41:25 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/3] fuzz: Simplify how we compute available machines and
 types
Message-ID: <20200424154125.kxtyws52hx2ycix4@mozz.bu.edu>
References: <20200424071142.3525-1-armbru@redhat.com>
 <20200424071142.3525-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424071142.3525-3-armbru@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 11:42:43
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Received-From: 128.197.228.73
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200424 0911, Markus Armbruster wrote:
> apply_to_qlist(), apply_to_node() work with QObjects.  This is
> designed for use by tests/qtest/qos-test.c, which gets the data in
> that form via QMP.  Goes back to commit fc281c8020 "tests: qgraph API
> for the qtest driver framework".
> 
> Commit 275ab39d86 "fuzz: add support for qos-assisted fuzz targets"
> added another user: qtest/fuzz/qos_fuzz.c.  To get the data as
> QObjects, it uses qmp_marshal_query_machines() and
> qmp_marshal_qom_list_types().
> 
> All this code is rather cumbersome.  Switch to working with generated
> QAPI types instead:
> 
> * Replace apply_to_qlist() & friends by machines_apply_to_node() and
>   types_apply_to_node().
> 
> * Have qos_fuzz.c use qmp_query_machines() and qmp_qom_list_types()
>   instead.
> 
> * Have qos_test.c convert from QObject to the QAPI types.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thank you for looking at this!
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

> ---
>  tests/qtest/libqos/qos_external.h |  8 +++-
>  tests/qtest/fuzz/qos_fuzz.c       | 34 ++++-----------
>  tests/qtest/libqos/qos_external.c | 70 +++++++++++--------------------
>  tests/qtest/qos-test.c            | 29 +++++++++----
>  4 files changed, 59 insertions(+), 82 deletions(-)
> 
> diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_external.h
> index 7b44930c55..f63388cb30 100644
> --- a/tests/qtest/libqos/qos_external.h
> +++ b/tests/qtest/libqos/qos_external.h
> @@ -20,8 +20,12 @@
>  #define QOS_EXTERNAL_H
>  #include "libqos/qgraph.h"
>  
> -void apply_to_node(const char *name, bool is_machine, bool is_abstract);
> -void apply_to_qlist(QList *list, bool is_machine);
> +#include "libqos/malloc.h"
> +#include "qapi/qapi-types-machine.h"
> +#include "qapi/qapi-types-qom.h"
> +
> +void machines_apply_to_node(MachineInfoList *mach_info);
> +void types_apply_to_node(ObjectTypeInfoList *type_info);
>  QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
>  void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p_alloc);
>  
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index af28c92866..87eadb0889 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -36,7 +36,6 @@
>  
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/qapi-commands-qom.h"
> -#include "qapi/qmp/qlist.h"
>  
>  
>  void *fuzz_qos_obj;
> @@ -45,34 +44,19 @@ QGuestAllocator *fuzz_qos_alloc;
>  static const char *fuzz_target_name;
>  static char **fuzz_path_vec;
>  
> -/*
> - * Replaced the qmp commands with direct qmp_marshal calls.
> - * Probably there is a better way to do this
> - */
>  static void qos_set_machines_devices_available(void)
>  {
> -    QDict *req = qdict_new();
> -    QObject *response;
> -    QDict *args = qdict_new();
> -    QList *lst;
> +    MachineInfoList *mach_info;
> +    ObjectTypeInfoList *type_info;
>  
> -    qmp_marshal_query_machines(NULL, &response, &error_abort);
> -    lst = qobject_to(QList, response);
> -    apply_to_qlist(lst, true);
> +    mach_info = qmp_query_machines(&error_abort);
> +    machines_apply_to_node(mach_info);
> +    qapi_free_MachineInfoList(mach_info);
>  
> -    qobject_unref(response);
> -
> -
> -    qdict_put_str(req, "execute", "qom-list-types");
> -    qdict_put_str(args, "implements", "device");
> -    qdict_put_bool(args, "abstract", true);
> -    qdict_put_obj(req, "arguments", (QObject *) args);
> -
> -    qmp_marshal_qom_list_types(args, &response, &error_abort);
> -    lst = qobject_to(QList, response);
> -    apply_to_qlist(lst, false);
> -    qobject_unref(response);
> -    qobject_unref(req);
> +    type_info = qmp_qom_list_types(true, "device", true, true,
> +                                   &error_abort);
> +    types_apply_to_node(type_info);
> +    qapi_free_ObjectTypeInfoList(type_info);
>  }
>  
>  static char **current_path;
> diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_external.c
> index 398556dde0..c707dac3b9 100644
> --- a/tests/qtest/libqos/qos_external.c
> +++ b/tests/qtest/libqos/qos_external.c
> @@ -29,62 +29,40 @@
>  #include "libqos/qgraph_internal.h"
>  #include "libqos/qos_external.h"
>  
> -
> -
> -void apply_to_node(const char *name, bool is_machine, bool is_abstract)
> +static void machine_apply_to_node(const char *name)
>  {
> -    char *machine_name = NULL;
> -    if (is_machine) {
> -        const char *arch = qtest_get_arch();
> -        machine_name = g_strconcat(arch, "/", name, NULL);
> -        name = machine_name;
> +    char *machine_name = g_strconcat(qtest_get_arch(), "/", name, NULL);
> +
> +    qos_graph_node_set_availability(machine_name, true);
> +    g_free(machine_name);
> +}
> +
> +void machines_apply_to_node(MachineInfoList *mach_info)
> +{
> +    MachineInfoList *tail;
> +
> +    for (tail = mach_info; tail; tail = tail->next) {
> +        machine_apply_to_node(tail->value->name);
> +        if (tail->value->alias) {
> +            machine_apply_to_node(tail->value->alias);
> +        }
>      }
> +}
> +
> +static void type_apply_to_node(const char *name, bool is_abstract)
> +{
>      qos_graph_node_set_availability(name, true);
>      if (is_abstract) {
>          qos_delete_cmd_line(name);
>      }
> -    g_free(machine_name);
>  }
>  
> -/**
> - * apply_to_qlist(): using QMP queries QEMU for a list of
> - * machines and devices available, and sets the respective node
> - * as true. If a node is found, also all its produced and contained
> - * child are marked available.
> - *
> - * See qos_graph_node_set_availability() for more info
> - */
> -void apply_to_qlist(QList *list, bool is_machine)
> +void types_apply_to_node(ObjectTypeInfoList *type_info)
>  {
> -    const QListEntry *p;
> -    const char *name;
> -    bool abstract;
> -    QDict *minfo;
> -    QObject *qobj;
> -    QString *qstr;
> -    QBool *qbool;
> +    ObjectTypeInfoList *tail;
>  
> -    for (p = qlist_first(list); p; p = qlist_next(p)) {
> -        minfo = qobject_to(QDict, qlist_entry_obj(p));
> -        qobj = qdict_get(minfo, "name");
> -        qstr = qobject_to(QString, qobj);
> -        name = qstring_get_str(qstr);
> -
> -        qobj = qdict_get(minfo, "abstract");
> -        if (qobj) {
> -            qbool = qobject_to(QBool, qobj);
> -            abstract = qbool_get_bool(qbool);
> -        } else {
> -            abstract = false;
> -        }
> -
> -        apply_to_node(name, is_machine, abstract);
> -        qobj = qdict_get(minfo, "alias");
> -        if (qobj) {
> -            qstr = qobject_to(QString, qobj);
> -            name = qstring_get_str(qstr);
> -            apply_to_node(name, is_machine, abstract);
> -        }
> +    for (tail = type_info; tail; tail = tail->next) {
> +        type_apply_to_node(tail->value->name, tail->value->abstract);
>      }
>  }
>  
> diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
> index ad193f43a5..3062a13557 100644
> --- a/tests/qtest/qos-test.c
> +++ b/tests/qtest/qos-test.c
> @@ -19,11 +19,12 @@
>  #include "qemu/osdep.h"
>  #include <getopt.h>
>  #include "libqtest-single.h"
> +#include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qbool.h"
> -#include "qapi/qmp/qstring.h"
>  #include "qemu/module.h"
> -#include "qapi/qmp/qlist.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-visit-qom.h"
>  #include "libqos/malloc.h"
>  #include "libqos/qgraph.h"
>  #include "libqos/qgraph_internal.h"
> @@ -51,13 +52,20 @@ static void qos_set_machines_devices_available(void)
>  {
>      QDict *response;
>      QDict *args = qdict_new();
> -    QList *list;
> +    QObject *ret;
> +    Visitor *v;
> +    MachineInfoList *mach_info;
> +    ObjectTypeInfoList *type_info;
>  
>      qtest_start("-machine none");
>      response = qmp("{ 'execute': 'query-machines' }");
> -    list = qdict_get_qlist(response, "return");
> +    ret = qdict_get(response, "return");
>  
> -    apply_to_qlist(list, true);
> +    v = qobject_input_visitor_new(ret);
> +    visit_type_MachineInfoList(v, NULL, &mach_info, &error_abort);
> +    visit_free(v);
> +    machines_apply_to_node(mach_info);
> +    qapi_free_MachineInfoList(mach_info);
>  
>      qobject_unref(response);
>  
> @@ -66,10 +74,13 @@ static void qos_set_machines_devices_available(void)
>  
>      response = qmp("{'execute': 'qom-list-types',"
>                     " 'arguments': %p }", args);
> -    g_assert(qdict_haskey(response, "return"));
> -    list = qdict_get_qlist(response, "return");
> +    ret = qdict_get(response, "return");
>  
> -    apply_to_qlist(list, false);
> +    v = qobject_input_visitor_new(ret);
> +    visit_type_ObjectTypeInfoList(v, NULL, &type_info, &error_abort);
> +    visit_free(v);
> +    types_apply_to_node(type_info);
> +    qapi_free_ObjectTypeInfoList(type_info);
>  
>      qtest_end();
>      qobject_unref(response);
> -- 
> 2.21.1
> 

