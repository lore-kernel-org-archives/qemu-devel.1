Received: from eggs.gnu.org ([2001:4830:134:3::10]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dg5vg-00029r-4J
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dg5vc-0001WY-Tx
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:08:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dg5vc-0001WQ-LM
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:08:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A4F2C07C586
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 09:08:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1502389816-29772-1-git-send-email-armbru@redhat.com>
	<17b1385e-c14f-d933-661f-56217077ff79@redhat.com>
Date: Fri, 11 Aug 2017 11:08:19 +0200
In-Reply-To: <17b1385e-c14f-d933-661f-56217077ff79@redhat.com> (Eric Blake's
	message of "Thu, 10 Aug 2017 13:47:42 -0500")
Message-ID: <87shgy4gl8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests/qmp-test: Add generic,
 basic test of query commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2017 01:30 PM, Markus Armbruster wrote:
>> A command is a query if it has no side effect and yields a result.
>> Such commands are typically named query-FOO, but there are exceptions.
>> 
>> The basic idea is to find candidates with query-qmp-schema, filter out
>> the ones that aren't queries with an explicit blacklist, and test the
>> remaining ones against a QEMU with no special arguments.
>> 
>> The current blacklist is just add-fd.
>
> I guess this is because it has no mandatory parameters.  Hmm - I wonder
> if introspection should flag WHICH commands require an fd over SCM
> rights (I guess just add-fd)

Actually, add-fd and getfd.

Their documentation neglects to explain how the two fit together.

Apropos documentation, here's a semi-random quote:

    # @fd: file descriptor of an already opened tap
    #
    # @fds: multiple file descriptors of already opened multiqueue capable
    # tap

This is close to useless unless you already know how everything works.

>                              - as that is a USEFUL piece of information
> to know (I can't call command XYZ unlss I also pass an fd) - and then
> you could use that real bit of the introspection rather than your
> blacklist as the mechanism for filtering this command (since anything
> that requires an fd is obviously not a query).

I doubt it's worth the trouble for just two commands.  But let's explore
how it could be done.

Naive attempt: the file descriptor is an implicit parameter, implicit
parameters don't show up in introspection, explicit ones do, so make it
one, say with a new built-in type.

The qemu_chr_fe_get_msgfd(&mon->chr) call moves from qmp_add_fd() to QMP
core.  Introspection shows the file descriptor parameter like any other
parameter.

Flaw: this kind of parameter must be passed differently than all the
others, namely with SCM_RIGHTS, not in JSON text.  Could this confuse
existing users of introspection?  Even if not: is it a good idea?

An obvious alternative is of course adding another optional member to
the command object, say a flag "takes file descriptors via SCM_RIGHTS".
Do we need to express the number of file descriptors it takes?  The
underlying infrastructure supports several (TCP_MAX_FDS in
char-socket.c), but the existing commands take just one.

>> query-qmp-schema reports a few commands that aren't actually
>> available.  See qmp_unregister_commands_hack() for details.  Work
>> around this flaw by accepting CommandNotFound errors, but add a TODO
>> to drop this when the flaw is fixed.
>> 
>> The test can't do queries with arguments, because it knows nothing
>> about the arguments.  No coverage for query-cpu-model-baseline,
>> query-cpu-model-comparison and query-cpu-model-expansion, because
>
> s/because//

Will fix.

>> query-rocker, query-rocker-ports, query-rocker-of-dpa-flows and
>> query-rocker-of-dpa-groups.
>> 
>> We get basic test coverage for the following commands:
>
> Cool!
>
>> 
>>     qom-list-types
>>     query-acpi-ospm-status
>>     query-balloon               (expected to fail)
>
>>     query-vm-generation-id      (expected to fail)
>
>> Most tested commands are expected to succeed.  The test does not check
>> the return value then.  A few commands are expected to fail because
>> they need special arguments to succeed, and this test is too dumb to
>> supply them.
>
> Sounds like it would just be a matter of adding additional command line
> parameters to the qemu being invoked for testing those commands?

In theory, setting up the state required for a query to succeed could be
too complex for this stupid test.

In practice, query-balloon should need just "-device virtio-balloon",
and query-vm-generation-id should need just "-device vmgenid" and ACPI
(I think).  Not all machines can do these devices.  Let's what I can do
in v2.

>> +static int query_error_class(const char *cmd)
>> +{
>> +    static struct {
>> +        const char *cmd;
>> +        int err_class;
>> +    } fails[] = {
>> +        { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
>> +        { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
>
> But even THIS level of testing of those commands is pretty good!
>
>
>> +static void test_query(const void *data)
>> +{
>> +    const char *cmd = data;
>> +    int expected_error_class = query_error_class(cmd);
>> +    QDict *resp, *error;
>> +    const char *error_class;
>> +
>> +    qtest_start("-nodefaults");
>> +
>> +    resp = qmp("{ 'execute': %s }", cmd);
>
> Oh fun - your patch and my libqtest cleanup series will collide :)

Mine should be trivial to rebase.

>> +static void qmp_schema_init(QmpSchema *schema)
>> +{
>> +    QDict *resp;
>> +    Visitor *qiv;
>> +    SchemaInfoList *tail;
>> +
>> +    qtest_start("-nodefaults");
>> +    resp = qmp("{ 'execute': 'query-qmp-schema' }");
>> +
>> +    qiv = qobject_input_visitor_new(qdict_get(resp, "return"));
>> +    visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);
>
> It's always fun to see this in action!  Our efforts to add automated
> introspection code generation have been WELL worth the cost in time.

It took a while to put it to productive use.  It's good to be there now.

> Overall, I like the patch.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
