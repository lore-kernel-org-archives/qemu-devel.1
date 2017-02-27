Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciDuT-0003vO-IO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciDuQ-0002cq-F8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:31:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciDuQ-0002cV-6d
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:31:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9374A7EBB8
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:31:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-13-git-send-email-armbru@redhat.com>
	<d05878a3-d77a-627d-9f94-a0fdf175e280@redhat.com>
Date: Mon, 27 Feb 2017 06:31:38 +0100
In-Reply-To: <d05878a3-d77a-627d-9f94-a0fdf175e280@redhat.com> (Eric Blake's
	message of "Sat, 25 Feb 2017 10:08:59 -0600")
Message-ID: <87varwnqrp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/21] qapi: Improve qobject input visitor
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/23/2017 03:45 PM, Markus Armbruster wrote:
>> Error messages refer to nodes of the QObject being visited by name.
>> Trouble is the names are sometimes less than helpful:
>> 
>
>> Improve error messages by referring to nodes by path instead, as
>> follows:
>> 
>> * The path of the root QObject is whatever @name argument got passed
>>   to the visitor, except NULL gets mapped to "<anonymous>".
>> 
>> * The path of a root QDict's member is the member key.
>> 
>> * The path of a root QList's member is "[%zu]", where %zu is the list
>>   index, starting at zero.
>> 
>> * The path of a non-root QDict's member is the path of the QDict
>>   concatenated with "." and the member key.
>> 
>> * The path of a non-root QList's member is the path of the QList
>>   concatenated with "[%zu]", where %zu is the list index.
>> 
>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/visitor.h       |   6 ---
>>  qapi/qobject-input-visitor.c | 121 +++++++++++++++++++++++++++++++------------
>>  2 files changed, 87 insertions(+), 40 deletions(-)
>> 
>
>> +typedef struct StackObject {
>> +    const char *name;            /* Name of @obj in its parent, if any */
>> +    QObject *obj;                /* QDict or QList being visited */
>>      void *qapi; /* sanity check that caller uses same pointer */
>>  
>> -    GHashTable *h;           /* If obj is dict: unvisited keys */
>> -    const QListEntry *entry; /* If obj is list: unvisited tail */
>> +    GHashTable *h;              /* If @obj is QDict: unvisited keys */
>> +    const QListEntry *entry;    /* If @obj is QList: unvisited tail */
>> +    unsigned index;             /* If @obj is QList: list index of @entry */
>
> Could perhaps make the QDict vs. QList fields shared through a union if
> we were tight on storage space or cache line pressure. I don't think
> that's the case, though, so no need to change it.
>
>> +static const char *full_name(QObjectInputVisitor *qiv, const char *name)
>> +{
>> +    StackObject *so;
>> +    char buf[32];
>> +
>> +    if (qiv->errname) {
>> +        g_string_truncate(qiv->errname, 0);
>> +    } else {
>> +        qiv->errname = g_string_new("");
>> +    }
>> +
>> +    QSLIST_FOREACH(so , &qiv->stack, node) {
>> +        if (qobject_type(so->obj) == QTYPE_QDICT) {
>> +            g_string_prepend(qiv->errname, name);
>> +            g_string_prepend_c(qiv->errname, '.');
>> +        } else {
>> +            snprintf(buf, sizeof(buf), "[%u]", so->index);
>> +            g_string_prepend(qiv->errname, buf);
>> +        }
>> +        name = so->name;
>> +    }
>
> Building the string from back to front requires quite a bit of memory
> reshuffling, as well as the temporary buffer for integer formatting. Is
> there any way to build it from front to back? But this code is only
> triggered on error paths, so I don't care if it is slow.  I'm fine with
> what you have.

I opted for simplicity over speed here.

The easiest way to support forward iteration would be making the stack
doubly linked.  Fairly cheap, but it's doubtful whether it would be an
amortized win.

An obvious alternative: measure the stack depth, allocate a char *[],
fill it with names back to front, format front to back.  Not too
complicated, but is it worth on an error path?

However, users exist that try one visit, and if it fails, another one.
For instance, set_pci_devfn() tries visit_type_str() first, then
visit_type_int32.  It should arguably use a suitable
visit_start_alternate() instead.

I think we should hunt down such visitor misuses before we complicate
error paths for speed.

In general,

    foo(..., &err);
    if (err) {
        error_free(err);
        ...
    }

is a performance anti-pattern, because it allocates and frees an Error
object, a message string and whatever it takes to build that just to
transmit one bit of information.

It's better to have foo() return something:

    if (foo(..., NULL)) {
        ...
    }

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
