Received: from eggs.gnu.org ([2001:4830:134:3::10]:40420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cimpf-0003SR-Ol
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cimpe-0006tm-Q1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:49:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-18-git-send-email-armbru@redhat.com>
	<20170228171823.GS4090@noname.redhat.com>
Date: Tue, 28 Feb 2017 19:48:58 +0100
In-Reply-To: <20170228171823.GS4090@noname.redhat.com> (Kevin Wolf's message
	of "Tue, 28 Feb 2017 18:18:23 +0100")
Message-ID: <87h93ejgmd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/24] qapi: New
 qobject_input_visitor_new_str() for convenience
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/qobject-input-visitor.h | 12 ++++++++++++
>>  qapi/qobject-input-visitor.c         | 33 +++++++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>> 
>> diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-input-visitor.h
>> index 282f9d2..b399285 100644
>> --- a/include/qapi/qobject-input-visitor.h
>> +++ b/include/qapi/qobject-input-visitor.h
>> @@ -68,4 +68,16 @@ Visitor *qobject_input_visitor_new(QObject *obj);
>>   */
>>  Visitor *qobject_input_visitor_new_keyval(QObject *obj);
>>  
>> +/*
>> + * Create a QObject input visitor for parsing @str.
>> + *
>> + * If @str looks like JSON, parse it as JSON, else as KEY=VALUE,...
>> + * @implied_key applies to KEY=VALUE, and works as in keyval_parse().
>> + * On failure, store an error through @errp and return NULL.
>> + * On success, return a new QObject input visitor for the parse.
>> + */
>> +Visitor *qobject_input_visitor_new_str(const char *str,
>> +                                       const char *implied_key,
>> +                                       Error **errp);
>> +
>>  #endif
>> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
>> index 3db5850..64a08d3 100644
>> --- a/qapi/qobject-input-visitor.c
>> +++ b/qapi/qobject-input-visitor.c
>> @@ -18,9 +18,11 @@
>>  #include "qapi/visitor-impl.h"
>>  #include "qemu/queue.h"
>>  #include "qemu-common.h"
>> +#include "qapi/qmp/qjson.h"
>>  #include "qapi/qmp/types.h"
>>  #include "qapi/qmp/qerror.h"
>>  #include "qemu/cutils.h"
>> +#include "qemu/option.h"
>>  
>>  typedef struct StackObject {
>>      const char *name;            /* Name of @obj in its parent, if any */
>> @@ -655,3 +657,34 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
>>  
>>      return &v->visitor;
>>  }
>> +
>> +Visitor *qobject_input_visitor_new_str(const char *str,
>> +                                       const char *implied_key,
>> +                                       Error **errp)
>> +{
>> +    bool is_json = str[0] == '{';
>
> Should the keyval_parse() grammar just forbid { in key names then (and
> ideally employ assertions to enforce this) to avoid any ambiguity here?
> therwise the behaviour might depend on the order of options in a
> key/value string, which could be somewhat confusing.

You're absolutely right.  Fortunately, PATCH 23 does.  I guess the
easiest fix is to move it before this one.

>> +    QObject *obj;
>> +    QDict *args;
>> +    Visitor *v;
>> +
>> +    if (is_json) {
>> +        obj = qobject_from_json(str, errp);
>> +        if (!obj) {
>> +            /* Work around qobject_from_json() lossage TODO fix that */
>> +            if (errp && !*errp) {
>> +                error_setg(errp, "JSON parse error");
>> +                return NULL;
>> +            }
>> +            return NULL;
>> +        }
>> +        args = qobject_to_qdict(obj);
>> +        assert(args);
>> +        v = qobject_input_visitor_new(QOBJECT(args));
>> +    } else {
>> +        args = keyval_parse(optarg, implied_key, errp);
>> +        v = qobject_input_visitor_new_keyval(QOBJECT(args));
>
> If keyval_parse() fails and returns args == NULL, won't we run into the
> assertion in qobject_input_visitor_base_new() now?

Lacks error checking, will fix.

>> +    }
>> +    QDECREF(args);
>> +
>> +    return v;
>> +}
>
> Kevin

Thanks!
