Received: from eggs.gnu.org ([2001:4830:134:3::10]:49001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clG4d-00047x-LU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clG4Y-00031S-Nc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:26:47 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clG4Y-00031L-HW
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:26:42 -0500
Received: by mail-qk0-x243.google.com with SMTP id v125so1110961qkh.1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 06:26:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-11-git-send-email-armbru@redhat.com>
	<dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
	<87efycduf0.fsf@dusky.pond.sub.org>
	<52bc1274-8d93-d477-a3e3-d3b7b5094d7a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e09b7c61-b2dc-757a-b7b0-c093f543c4f3@amsat.org>
Date: Tue, 7 Mar 2017 11:26:38 -0300
MIME-Version: 1.0
In-Reply-To: <52bc1274-8d93-d477-a3e3-d3b7b5094d7a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 03/07/2017 11:21 AM, Eric Blake wrote:
> On 03/05/2017 02:01 AM, Markus Armbruster wrote:
>
>> Since substantial other work depends on this series, it needs to go in
>> sooner rather than later.  I'm therefore *dropping* this patch from the
>> series.  We can then bikeshed^Wpolish to our heart's content without
>> holding up other work.
>>
>> That said: what about this?
>>
>> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
>> index dc50212..5ad36f8 100644
>> --- a/qapi/qmp-dispatch.c
>> +++ b/qapi/qmp-dispatch.c
>> @@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>>
>>      dict = qobject_to_qdict(request);
>>      if (!dict) {
>> -        error_setg(errp, "Expected '%s' in QMP input", "object");
>> +        error_setg(errp, "QMP input must be a JSON object");
>>          return NULL;
>>      }
>>
>> @@ -41,26 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>>
>>          if (!strcmp(arg_name, "execute")) {
>>              if (qobject_type(arg_obj) != QTYPE_QSTRING) {
>> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
>> -                           "execute", "string");
>> +                error_setg(errp,
>> +                           "QMP input member 'execute' must be a string");
>>                  return NULL;
>>              }
>>              has_exec_key = true;
>>          } else if (!strcmp(arg_name, "arguments")) {
>>              if (qobject_type(arg_obj) != QTYPE_QDICT) {
>> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
>> -                           "arguments", "object");
>> +                error_setg(errp,
>> +                           "QMP input member 'arguments' must be an object");
>>                  return NULL;
>>              }
>>          } else {
>> -            error_setg(errp, "QMP input object member '%s' is unexpected",
>> +            error_setg(errp, "QMP input member '%s' is unexpected",
>>                         arg_name);
>>              return NULL;
>>          }
>>      }
>>
>>      if (!has_exec_key) {
>> -        error_setg(errp, "Expected '%s' in QMP input", "execute");
>> +        error_setg(errp, "QMP input lacks member 'execute'");
>>          return NULL;
>>      }
>>
>>
>>
>
> Based on the rest of this sub-thread, I'm making it explicit that you
> can add:
> Reviewed-by: Eric Blake <eblake@redhat.com>

this is not a blocking issue, this code is OK, no need to drop!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
