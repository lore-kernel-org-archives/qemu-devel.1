Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA4C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB8320663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMYsqJ+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB8320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4aG-0008Gd-Fz
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE4YD-0005ed-8G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE4YB-00082Y-Bx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:14:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE4YB-0007zf-3G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584422035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ith7mBSY65RNqwBdbnfyPugMiAPzZvvFPElrgsO5sWM=;
 b=JMYsqJ+/2nyqNZFJ8/CGwb1bvyf4NJS0Hmjpv+lwqdR7aX5WYNY3eEWVvs4Pea4S/E6UWf
 80vFibhO5EB5J2nYbZSnw1sCk4lQWnriLdPXrKV24oUMdgOhH5vmYpnKehTr2C2EJJDTgA
 Lj05rkdrcuVeizBQwtqtT6fNEOYbakU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-2A-S_NoFPrafVr4hGQfXBA-1; Tue, 17 Mar 2020 01:13:52 -0400
X-MC-Unique: 2A-S_NoFPrafVr4hGQfXBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D4541857BE1;
 Tue, 17 Mar 2020 05:13:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 725011001B3F;
 Tue, 17 Mar 2020 05:13:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0EF081138404; Mon, 16 Mar 2020 20:46:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v3 28/34] qapi: Implement deprecated-output=hide for QMP
 command results
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-29-armbru@redhat.com>
 <CAJ+F1CLBSXK=hxSEd7odAjA3YKZfFk6+yb+kJSyOmpeC_sJrsg@mail.gmail.com>
Date: Mon, 16 Mar 2020 20:46:48 +0100
In-Reply-To: <CAJ+F1CLBSXK=hxSEd7odAjA3YKZfFk6+yb+kJSyOmpeC_sJrsg@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 16 Mar 2020
 18:53:21 +0100")
Message-ID: <87bloww09j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Sun, Mar 15, 2020 at 4:11 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> This policy suppresses deprecated bits in output, and thus permits
>> "testing the future".  Implement it for QMP command results.  Example:
>> when QEMU is run with -compat deprecated-output=3Dhide, then
>>
>>     {"execute": "query-cpus-fast"}
>>
>> yields
>>
>>     {"return": [{"thread-id": 9805, "props": {"core-id": 0, "thread-id":=
 0, "socket-id": 0}, "qom-path": "/machine/unattached/device[0]", "cpu-inde=
x": 0, "target": "x86_64"}]}
>>
>> instead of
>>
>>     {"return": [{"arch": "x86", "thread-id": 22436, "props": {"core-id":=
 0, "thread-id": 0, "socket-id": 0}, "qom-path": "/machine/unattached/devic=
e[0]", "cpu-index": 0, "target": "x86_64"}]}
>>
>> Note the suppression of deprecated member "arch".
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/qobject-output-visitor.h   |  9 ++++++
>>  include/qapi/visitor-impl.h             |  3 ++
>>  include/qapi/visitor.h                  |  9 ++++++
>>  qapi/qapi-visit-core.c                  |  9 ++++++
>>  qapi/qobject-output-visitor.c           | 19 +++++++++++
>>  tests/test-qmp-cmds.c                   | 42 ++++++++++++++++++++++---
>>  qapi/trace-events                       |  1 +
>>  scripts/qapi/commands.py                |  2 +-
>>  scripts/qapi/visit.py                   | 12 +++++++
>>  tests/qapi-schema/qapi-schema-test.json | 17 +++++-----
>>  tests/qapi-schema/qapi-schema-test.out  | 18 +++++------
>>  11 files changed, 118 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobjec=
t-output-visitor.h
>> index 2b1726baf5..29f4ea6aad 100644
>> --- a/include/qapi/qobject-output-visitor.h
>> +++ b/include/qapi/qobject-output-visitor.h
>> @@ -53,4 +53,13 @@ typedef struct QObjectOutputVisitor QObjectOutputVisi=
tor;
>>   */
>>  Visitor *qobject_output_visitor_new(QObject **result);
>>
>> +/*
>> + * Create a QObject output visitor for @obj for use with QMP
>> + *
>> + * This is like qobject_output_visitor_new(), except it obeys the
>> + * policy for handling deprecated management interfaces set with
>> + * -compat.
>> + */
>> +Visitor *qobject_output_visitor_new_qmp(QObject **result);
>> +
>>  #endif
>> diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
>> index 8ccb3b6c20..a6b26b7a5b 100644
>> --- a/include/qapi/visitor-impl.h
>> +++ b/include/qapi/visitor-impl.h
>> @@ -110,6 +110,9 @@ struct Visitor
>>         The core takes care of the return type in the public interface. =
*/
>>      void (*optional)(Visitor *v, const char *name, bool *present);
>>
>> +    /* Optional */
>> +    bool (*deprecated)(Visitor *v, const char *name);
>> +
>>      /* Must be set */
>>      VisitorType type;
>>
>> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
>> index c5b23851a1..c89d51b2a4 100644
>> --- a/include/qapi/visitor.h
>> +++ b/include/qapi/visitor.h
>> @@ -449,6 +449,15 @@ void visit_end_alternate(Visitor *v, void **obj);
>>   */
>>  bool visit_optional(Visitor *v, const char *name, bool *present);
>>
>> +/*
>> + * Should we visit deprecated member @name?
>> + *
>> + * @name must not be NULL.  This function is only useful between
>> + * visit_start_struct() and visit_end_struct(), since only objects
>> + * have deprecated members.
>> + */
>> +bool visit_deprecated(Visitor *v, const char *name);
>> +
>>  /*
>>   * Visit an enum value.
>>   *
>> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
>> index 5365561b07..501b3ccdef 100644
>> --- a/qapi/qapi-visit-core.c
>> +++ b/qapi/qapi-visit-core.c
>> @@ -137,6 +137,15 @@ bool visit_optional(Visitor *v, const char *name, b=
ool *present)
>>      return *present;
>>  }
>>
>> +bool visit_deprecated(Visitor *v, const char *name)
>> +{
>> +    trace_visit_deprecated(v, name);
>> +    if (v->deprecated) {
>> +        return v->deprecated(v, name);
>> +    }
>> +    return true;
>> +}
>> +
>>  bool visit_is_input(Visitor *v)
>>  {
>>      return v->type =3D=3D VISITOR_INPUT;
>> diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor=
.c
>> index 26d7be5ec9..84cee17596 100644
>> --- a/qapi/qobject-output-visitor.c
>> +++ b/qapi/qobject-output-visitor.c
>> @@ -13,6 +13,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qapi/compat-policy.h"
>>  #include "qapi/qobject-output-visitor.h"
>>  #include "qapi/visitor-impl.h"
>>  #include "qemu/queue.h"
>> @@ -31,6 +32,8 @@ typedef struct QStackEntry {
>>
>>  struct QObjectOutputVisitor {
>>      Visitor visitor;
>> +    CompatPolicyOutput deprecated_policy;
>> +
>>      QSLIST_HEAD(, QStackEntry) stack; /* Stack of unfinished containers=
 */
>>      QObject *root; /* Root of the output visit */
>>      QObject **result; /* User's storage location for result */
>> @@ -198,6 +201,13 @@ static void qobject_output_type_null(Visitor *v, co=
nst char *name,
>>      qobject_output_add(qov, name, qnull());
>>  }
>>
>> +static bool qobject_output_deprecated(Visitor *v, const char *name)
>> +{
>> +    QObjectOutputVisitor *qov =3D to_qov(v);
>> +
>> +    return qov->deprecated_policy !=3D COMPAT_POLICY_OUTPUT_HIDE;
>> +}
>> +
>>  /* Finish building, and return the root object.
>>   * The root object is never null. The caller becomes the object's
>>   * owner, and should use qobject_unref() when done with it.  */
>> @@ -247,6 +257,7 @@ Visitor *qobject_output_visitor_new(QObject **result=
)
>>      v->visitor.type_number =3D qobject_output_type_number;
>>      v->visitor.type_any =3D qobject_output_type_any;
>>      v->visitor.type_null =3D qobject_output_type_null;
>> +    v->visitor.deprecated =3D qobject_output_deprecated;
>>      v->visitor.complete =3D qobject_output_complete;
>>      v->visitor.free =3D qobject_output_free;
>>
>> @@ -255,3 +266,11 @@ Visitor *qobject_output_visitor_new(QObject **resul=
t)
>>
>>      return &v->visitor;
>>  }
>> +
>> +Visitor *qobject_output_visitor_new_qmp(QObject **result)
>> +{
>> +    QObjectOutputVisitor *v =3D to_qov(qobject_output_visitor_new(resul=
t));
>> +
>> +    v->deprecated_policy =3D compat_policy.deprecated_output;
>> +    return &v->visitor;
>> +}
>> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
>> index d12ff47e26..82d599630c 100644
>> --- a/tests/test-qmp-cmds.c
>> +++ b/tests/test-qmp-cmds.c
>> @@ -1,4 +1,5 @@
>>  #include "qemu/osdep.h"
>> +#include "qapi/compat-policy.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qjson.h"
>>  #include "qapi/qmp/qnum.h"
>> @@ -45,12 +46,17 @@ void qmp_user_def_cmd1(UserDefOne * ud1, Error **err=
p)
>>  {
>>  }
>>
>> -void qmp_test_features0(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
>> -                       FeatureStruct2 *fs2, FeatureStruct3 *fs3,
>> -                       FeatureStruct4 *fs4, CondFeatureStruct1 *cfs1,
>> -                       CondFeatureStruct2 *cfs2, CondFeatureStruct3 *cf=
s3,
>> -                       Error **errp)
>> +FeatureStruct1 *qmp_test_features0(bool has_fs0, FeatureStruct0 *fs0,
>> +                                   bool has_fs1, FeatureStruct1 *fs1,
>> +                                   bool has_fs2, FeatureStruct2 *fs2,
>> +                                   bool has_fs3, FeatureStruct3 *fs3,
>> +                                   bool has_fs4, FeatureStruct4 *fs4,
>> +                                   bool has_cfs1, CondFeatureStruct1 *c=
fs1,
>> +                                   bool has_cfs2, CondFeatureStruct2 *c=
fs2,
>> +                                   bool has_cfs3, CondFeatureStruct3 *c=
fs3,
>> +                                   Error **errp)
>>  {
>> +    return g_new(FeatureStruct1, 1);
>>  }
>>
>>  void qmp_test_command_features1(Error **errp)
>> @@ -271,6 +277,30 @@ static void test_dispatch_cmd_io(void)
>>      qobject_unref(ret3);
>>  }
>>
>> +static void test_dispatch_cmd_ret_deprecated(void)
>> +{
>> +    const char *cmd =3D "{ 'execute': 'test-features0' }";
>> +    QDict *ret;
>> +
>> +    memset(&compat_policy, 0, sizeof(compat_policy));
>> +
>> +    /* default accept */
>> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
>> +    assert(ret && qdict_size(ret) =3D=3D 1);
>> +    qobject_unref(ret);
>> +
>> +    compat_policy.has_deprecated_output =3D true;
>> +    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_ACCEPT;
>> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
>> +    assert(ret && qdict_size(ret) =3D=3D 1);
>> +    qobject_unref(ret);
>> +
>> +    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_HIDE;
>> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
>> +    assert(ret && qdict_size(ret) =3D=3D 0);
>> +    qobject_unref(ret);
>> +}
>> +
>>  /* test generated dealloc functions for generated types */
>>  static void test_dealloc_types(void)
>>  {
>> @@ -345,6 +375,8 @@ int main(int argc, char **argv)
>>      g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
>>      g_test_add_func("/qmp/dispatch_cmd_success_response",
>>                      test_dispatch_cmd_success_response);
>> +    g_test_add_func("/qmp/dispatch_cmd_ret_deprecated",
>> +                    test_dispatch_cmd_ret_deprecated);
>>      g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
>>      g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
>>
>> diff --git a/qapi/trace-events b/qapi/trace-events
>> index 5eb4afa110..eff1fbd199 100644
>> --- a/qapi/trace-events
>> +++ b/qapi/trace-events
>> @@ -17,6 +17,7 @@ visit_start_alternate(void *v, const char *name, void =
*obj, size_t size) "v=3D%p n
>>  visit_end_alternate(void *v, void *obj) "v=3D%p obj=3D%p"
>>
>>  visit_optional(void *v, const char *name, bool *present) "v=3D%p name=
=3D%s present=3D%p"
>> +visit_deprecated(void *v, const char *name) "v=3D%p name=3D%s"
>>
>>  visit_type_enum(void *v, const char *name, int *obj) "v=3D%p name=3D%s =
obj=3D%p"
>>  visit_type_int(void *v, const char *name, int64_t *obj) "v=3D%p name=3D=
%s obj=3D%p"
>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> index bc30876c88..35b79c554d 100644
>> --- a/scripts/qapi/commands.py
>> +++ b/scripts/qapi/commands.py
>> @@ -69,7 +69,7 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s r=
et_in, QObject **ret_out,
>>      Error *err =3D NULL;
>>      Visitor *v;
>>
>> -    v =3D qobject_output_visitor_new(ret_out);
>> +    v =3D qobject_output_visitor_new_qmp(ret_out);
>>      visit_type_%(c_name)s(v, "unused", &ret_in, &err);
>>      if (!err) {
>>          visit_complete(v, ret_out);
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 23d9194aa4..21df3abed2 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -56,6 +56,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_nam=
e)s *obj, Error **errp)
>>                       c_type=3Dbase.c_name())
>>
>>      for memb in members:
>> +        deprecated =3D 'deprecated' in [f.name for f in memb.features]
>>          ret +=3D gen_if(memb.ifcond)
>>          if memb.optional:
>>              ret +=3D mcgen('''
>> @@ -63,6 +64,12 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_na=
me)s *obj, Error **errp)
>>  ''',
>>                           name=3Dmemb.name, c_name=3Dc_name(memb.name))
>>              push_indent()
>> +        if deprecated:
>> +            ret +=3D mcgen('''
>> +    if (visit_deprecated(v, "%(name)s")) {
>
> Do you have a compelling case where the "name" would change the
> deprecation policy? I think that could be more confusing than
> necessary, say if x- name wouldn't follow the policy.

Yes, that would be a bad idea.

Intended use is error messages, just like we do elsewhere.  The output
visitor's method qobject_output_deprecated() can't fail, but the input
visitor's method can; see PATCH 33.

[...]


