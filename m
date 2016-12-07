Received: from eggs.gnu.org ([2001:4830:134:3::10]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEa7k-0008R2-9R
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEa7g-0005zl-3H
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cEa7f-0005zT-Qa
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:10:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481055300-14239-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1481055300-14239-3-git-send-email-mdroth@linux.vnet.ibm.com>
	<20161207091227.GC21167@redhat.com>
Date: Wed, 07 Dec 2016 12:10:47 +0100
In-Reply-To: <20161207091227.GC21167@redhat.com> (Daniel P. Berrange's message
	of "Wed, 7 Dec 2016 09:12:27 +0000")
Message-ID: <87h96ghu4o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.8 2/2] tests: check-qom-proplist: add
 checks for cmdline-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, bharata.rao@gmail.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Tue, Dec 06, 2016 at 02:15:00PM -0600, Michael Roth wrote:
>> check-qom-proplist originally added tests for verifying that
>> object-creation helpers object_new_with_{props,propv} behaved in
>> similar fashion to the "traditional" method involving setting each
>> individual property separately after object creation rather than
>> in via a single call.
>> 
>> Another similar "helper" for creating Objects exists in the form of
>> objects specified via -object command-line parameters. By that
>> rationale, we extend check-qom-proplist to include similar checks
>> for command-line-created objects by employing the same
>> qemu_opts_parse()-based parsing the vl.c employs.
>> 
>> This parser has a side-effect of parsing the object's options into
>> a QemuOpt structure and registering this in the global QemuOptsList
>> using the Object's ID. This can conflict with future Object instances
>> that attempt to use the same ID if we don't ensure this is cleaned
>> up as part of Object finalization, so we add specific checks for this
>> scenario in addition to the normal sanity checks.
>> 
>> Suggested-by: Daniel Berrange <berrange@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Daniel Berrange <berrange@redhat.com>
>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> ---
>>  tests/check-qom-proplist.c | 54 +++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 53 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
>> index a16cefc..087ce21 100644
>> --- a/tests/check-qom-proplist.c
>> +++ b/tests/check-qom-proplist.c
>> @@ -23,6 +23,9 @@
>>  #include "qapi/error.h"
>>  #include "qom/object.h"
>>  #include "qemu/module.h"
>> +#include "qemu/option.h"
>> +#include "qemu/config-file.h"
>> +#include "qom/object_interfaces.h"
>>  
>>  
>>  #define TYPE_DUMMY "qemu-dummy"
>> @@ -162,6 +165,10 @@ static const TypeInfo dummy_info = {
>>      .instance_finalize = dummy_finalize,
>>      .class_size = sizeof(DummyObjectClass),
>>      .class_init = dummy_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { TYPE_USER_CREATABLE },
>> +        { }
>> +    }
>>  };
>>  
>>  
>> @@ -291,7 +298,6 @@ static void dummy_backend_init(Object *obj)
>>  {
>>  }
>>  
>> -
>>  static const TypeInfo dummy_dev_info = {
>>      .name          = TYPE_DUMMY_DEV,
>>      .parent        = TYPE_OBJECT,
>> @@ -320,6 +326,14 @@ static const TypeInfo dummy_backend_info = {
>>      .class_size = sizeof(DummyBackendClass),
>>  };
>>  
>> +static QemuOptsList qemu_object_opts = {
>> +    .name = "object",
>> +    .implied_opt_name = "qom-type",
>> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
>> +    .desc = {
>> +        { }
>> +    },
>> +};
>>  
>>  
>>  static void test_dummy_createv(void)
>> @@ -388,6 +402,43 @@ static void test_dummy_createlist(void)
>>      object_unparent(OBJECT(dobj));
>>  }
>>  
>> +static void test_dummy_createcmdl(void)
>> +{
>> +    QemuOpts *opts;
>> +    DummyObject *dobj;
>> +    Error *err = NULL;
>> +    const char *params = TYPE_DUMMY \
>> +                         ",id=dev0," \
>> +                         "bv=yes,sv=Hiss hiss hiss,av=platypus";
>> +
>> +    qemu_add_opts(&qemu_object_opts);
>> +    opts = qemu_opts_parse(&qemu_object_opts, params, true, &err);
>> +    g_assert(err == NULL);
>> +    g_assert(opts);
>> +
>> +    dobj = DUMMY_OBJECT(user_creatable_add_opts(opts, &err));
>> +    g_assert(err == NULL);
>> +    g_assert(dobj);
>> +    g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
>> +    g_assert(dobj->bv == true);
>> +    g_assert(dobj->av == DUMMY_PLATYPUS);
>> +
>> +    user_creatable_del("dev0", &err);
>> +    g_assert(err == NULL);
>> +    error_free(err);
>> +
>> +    /* cmdline-parsing via qemu_opts_parse() results in a QemuOpts entry
>> +     * corresponding to the Object's ID to be added to the QemuOptsList
>> +     * for objects. To avoid having this entry conflict with future
>> +     * Objects using the same ID (which can happen in cases where
>> +     * qemu_opts_parse() is used to parse the object params, such as
>> +     * with hmp_object_add() at the time of this comment), we check
>> +     * for this in user_creatable_del() and remove the QemuOpts if it
>> +     * is present. The below check ensures this works as expected.
>> +     */
>> +    g_assert(qemu_opts_find(&qemu_object_opts, "dev0") == NULL);
>> +}
>> +
>>  static void test_dummy_badenum(void)
>>  {
>>      Error *err = NULL;
>> @@ -525,6 +576,7 @@ int main(int argc, char **argv)
>>  
>>      g_test_add_func("/qom/proplist/createlist", test_dummy_createlist);
>>      g_test_add_func("/qom/proplist/createv", test_dummy_createv);
>> +    g_test_add_func("/qom/proplist/createcmdline", test_dummy_createcmdl);
>>      g_test_add_func("/qom/proplist/badenum", test_dummy_badenum);
>>      g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
>>      g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>
>
> except that this should be squashed into the previous commit - tests should
> always be in the same commit as the new code that they're verifying.

Not sure how particular we are about that.

When neither test nor fix is trivial, I personally like to commit the
test first, defanged so it doesn't blow up make check, with a suitable
FIXME comment.  The fix then resolves the FIXME.
