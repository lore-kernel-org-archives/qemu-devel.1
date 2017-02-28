Received: from eggs.gnu.org ([2001:4830:134:3::10]:40106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cidN4-0006Gp-79
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cidN3-0001aR-4Z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:42:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cidN2-0001aK-SZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:42:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2A13128D
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 08:42:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-13-git-send-email-armbru@redhat.com>
	<ed45fe0d-edd5-e201-e876-11af0c3e954a@redhat.com>
Date: Tue, 28 Feb 2017 09:42:54 +0100
In-Reply-To: <ed45fe0d-edd5-e201-e876-11af0c3e954a@redhat.com> (Eric Blake's
	message of "Mon, 27 Feb 2017 10:45:48 -0600")
Message-ID: <87mvd61zap.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 12/26] qapi: Improve qobject input
 visitor error reporting
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

> On 02/26/2017 03:43 PM, Markus Armbruster wrote:
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
>
> %zu here, but...
>
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/visitor.h       |   6 ---
>>  qapi/qobject-input-visitor.c | 121 +++++++++++++++++++++++++++++++------------
>>  2 files changed, 87 insertions(+), 40 deletions(-)
>> 
>
>>  
>> -typedef struct StackObject
>> -{
>> -    QObject *obj; /* Object being visited */
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
>> +    QSLIST_FOREACH(so , &qiv->stack, node) {
>> +        if (qobject_type(so->obj) == QTYPE_QDICT) {
>> +            g_string_prepend(qiv->errname, name);
>> +            g_string_prepend_c(qiv->errname, '.');
>> +        } else {
>> +            snprintf(buf, sizeof(buf), "[%u]", so->index);
>
> ...%u here.  Minor inconsistency in the commit message, but I'm okay
> mere 'unsigned' in the code, as we'd probably have other problems long
> before hitting a list with 2 billion entries, even on platforms where
> size_t is 64-bit.

Good catch.  I'll touch up the commit message.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
