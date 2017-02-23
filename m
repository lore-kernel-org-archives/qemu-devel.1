Received: from eggs.gnu.org ([2001:4830:134:3::10]:56202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgpt4-000484-9e
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgpt3-0001tE-5o
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:40:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-4-git-send-email-armbru@redhat.com>
	<be675c58-2fda-c736-4fcb-e8de14071485@redhat.com>
Date: Thu, 23 Feb 2017 10:40:23 +0100
In-Reply-To: <be675c58-2fda-c736-4fcb-e8de14071485@redhat.com> (Eric Blake's
	message of "Wed, 22 Feb 2017 17:00:12 -0600")
Message-ID: <874lzlmeig.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 3/5] qapi: Permit scalar type
 conversions in QObjectInputVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/21/2017 03:01 PM, Markus Armbruster wrote:
>> From: "Daniel P. Berrange" <berrange@redhat.com>
>> 
>> Currently the QObjectInputVisitor assumes that all scalar values are
>> directly represented as the final types declared by the thing being
>> visited. i.e. it assumes an 'int' is using QInt, and a 'bool' is using
>> QBool, etc.  This is good when QObjectInputVisitor is fed a QObject
>> that came from a JSON document on the QMP monitor, as it will strictly
>> validate correctness.
>> 
>> To allow QObjectInputVisitor to be reused for visiting a QObject
>> originating from keyval_parse(), an alternative mode is needed where
>> all the scalars types are represented as QString and converted on the
>> fly to the final desired type.
>> 
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> Message-Id: <1475246744-29302-8-git-send-email-berrange@redhat.com>
>> 
>> Rebased, conflicts resolved, commit message updated to refer to
>> keyval_parse().
>> 
>> Control flow in qobject_input_type_number_autocast() simplified.
>> 
>> Additional tests in test-qemu-opts.c to verify QemuOpts compatibility.
>> To make the tests pass, use qemu_strtou64() instead of
>> parse_uint_full().
>> 
>> Use qemu_strtou64() and qemu_strtosz() instead of
>> parse_option_number() and parse_option_size() so we have to call
>> qobject_input_get_name() only when actually needed.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/qobject-input-visitor.h |  32 ++++-
>>  qapi/qobject-input-visitor.c         | 165 ++++++++++++++++++++++++
>>  tests/test-keyval.c                  | 241 +++++++++++++++++++++++++++++++++++
>>  tests/test-qobject-input-visitor.c   | 194 +++++++++++++++++++++++++++-
>>  4 files changed, 624 insertions(+), 8 deletions(-)
>> 
>
>> @@ -71,6 +72,7 @@ static const char *qobject_input_get_name(QObjectInputVisitor *qiv,
>>              g_string_prepend(qiv->errname, name);
>>              g_string_prepend_c(qiv->errname, '.');
>>          } else {
>> +            /* TODO needs to be .%zu for autocast */
>>              snprintf(buf, sizeof(buf), "[%zu]", so->index);
>
> Ah, the TODO means you started thinking about list integration, and
> that's part of why this is still RFC.
>
>
>> +static void qobject_input_type_bool_autocast(Visitor *v, const char *name,
>> +                                             bool *obj, Error **errp)
>> +{
>> +    QObjectInputVisitor *qiv = to_qiv(v);
>> +    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
>> +    QString *qstr;
>> +    const char *str;
>> +
>> +    if (!qobj) {
>> +        return;
>> +    }
>> +    qstr = qobject_to_qstring(qobj);
>> +    if (!qstr) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
>> +                   qobject_input_get_name(qiv, name), "string");
>> +        return;
>> +    }
>> +
>> +    str = qstring_get_str(qstr);
>> +    if (!strcmp(str, "on")) {
>> +        *obj = true;
>> +    } else if (!strcmp(str, "off")) {
>> +        *obj = false;
>
> Why are we reimplementing only a subset of parse_option_bool() here?

We're reimplementing parse_option_bool() exactly:

    static void parse_option_bool(const char *name, const char *value, bool *ret,
                                  Error **errp)
    {
        if (!strcmp(value, "on")) {
            *ret = 1;
        } else if (!strcmp(value, "off")) {
            *ret = 0;
        } else {
            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                       name, "'on' or 'off'");
        }
    }

You're probably thinking of opts_type_bool(), which recognizes
additional spellings.  But options visitor compatibility is a headache
left for later.

> Overall, most of the changes from Dan's original look sane.

Thanks!
