Received: from eggs.gnu.org ([2001:4830:134:3::10]:40783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chW1K-0000nG-1k
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chW1G-00089h-VQ
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:39:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chW1G-00089X-Pp
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:39:50 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD5C6C056791
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 06:39:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-9-git-send-email-armbru@redhat.com>
	<6255319d-0a27-0909-00d1-059bae0ff8ef@redhat.com>
Date: Sat, 25 Feb 2017 07:39:47 +0100
In-Reply-To: <6255319d-0a27-0909-00d1-059bae0ff8ef@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 17:13:45 -0600")
Message-ID: <87zihau630.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/21] qmp: Improve QMP dispatch error
 messages
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
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/qmp-dispatch.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>
>> @@ -41,15 +41,17 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>>  
>>          if (!strcmp(arg_name, "execute")) {
>>              if (qobject_type(arg_obj) != QTYPE_QSTRING) {
>> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
>> -                           "execute", "string");
>> +                error_setg(errp,
>> +                           "QMP input object member '%s' must be %s",
>> +                           "execute", "a string");
>
> Any reason we can't inline this to:
>
> "QMP input object member 'execute' must be a string"
>
> ? It's not like we're translating the message.

Saves a few bytes.  Residual damage from my 8 bit days, I guess.

Inlined would probably be better for translating.

>>                  return NULL;
>>              }
>>              has_exec_key = true;
>>          } else if (!strcmp(arg_name, "arguments")) {
>>              if (qobject_type(arg_obj) != QTYPE_QDICT) {
>> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
>> -                           "arguments", "object");
>> +                error_setg(errp,
>> +                           "QMP input object member '%s' must be %s",
>> +                           "arguments", "an object");
>
> and again
>
> Then again, if you use my idea of a QAPI-generated visitor of each input
> wire object, you'd get whatever error message qobject-input normally
> gives, which may render these changes irrelevant.
>
> At any rate, the new wordings are nicer, whether or not you inline
> constant text.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
