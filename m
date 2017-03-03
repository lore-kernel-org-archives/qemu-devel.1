Received: from eggs.gnu.org ([2001:4830:134:3::10]:58501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjtDX-0007gr-E1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjtDU-0003CD-A5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjtDU-0003C3-1O
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:16 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 287BC83F3E
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:50:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-26-git-send-email-armbru@redhat.com>
	<82622f99-91d8-7ae0-2a38-53b49e200f72@redhat.com>
Date: Fri, 03 Mar 2017 20:50:12 +0100
In-Reply-To: <82622f99-91d8-7ae0-2a38-53b49e200f72@redhat.com> (Eric Blake's
	message of "Fri, 3 Mar 2017 13:15:05 -0600")
Message-ID: <87zih2i1hn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 25/28] qapi: Make input visitors detect
 unvisited list tails
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

> On 03/03/2017 06:32 AM, Markus Armbruster wrote:
>> Fix the design flaw demonstrated in the previous commit: new method
>> check_list() lets input visitors report that unvisited input remains
>> for a list, exactly like check_struct() lets them report that
>> unvisited input remains for a struct or union.
>> 
>> Implement the method for the qobject input visitor (straightforward),
>> and the string input visitor (less so, due to the magic list syntax
>> there).  The opts visitor's list magic is even more impenetrable, and
>> all I can do there today is a stub with a FIXME comment.  No worse
>> than before.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Didn't I already review this one?
>
> Ah, there's my R-b:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07614.html

Oops!  My apologies...

> But since it disappeared again, I had another look.
>
>> +++ b/qapi/qobject-input-visitor.c
>> @@ -51,7 +51,8 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
>>      return container_of(v, QObjectInputVisitor, visitor);
>>  }
>>  
>> -static const char *full_name(QObjectInputVisitor *qiv, const char *name)
>> +static const char *full_name_nth(QObjectInputVisitor *qiv, const char *name,
>> +                                 int n)
>>  {
>>      StackObject *so;
>>      char buf[32];
>> @@ -63,8 +64,10 @@ static const char *full_name(QObjectInputVisitor *qiv, const char *name)
>>      }
>>  
>>      QSLIST_FOREACH(so , &qiv->stack, node) {
>> -        if (qobject_type(so->obj) == QTYPE_QDICT) {
>> -            g_string_prepend(qiv->errname, name);
>> +        if (n) {
>> +            n--;
>> +        } else if (qobject_type(so->obj) == QTYPE_QDICT) {
>> +            g_string_prepend(qiv->errname, name ?: "<anonymous>");
>>              g_string_prepend_c(qiv->errname, '.');
>>          } else {
>>              snprintf(buf, sizeof(buf), "[%u]", so->index);
>> @@ -72,18 +75,24 @@ static const char *full_name(QObjectInputVisitor *qiv, const char *name)
>>          }
>>          name = so->name;
>>      }
>> +    assert(!n);
>
> If I'm reading this right, your use of n-- in the loop followed by the
> post-condition is to assert that QSLIST_FOREACH() iterated n times, but
> lets see what callers pass for n:

At least @n times.

>>  
>>      if (name) {
>>          g_string_prepend(qiv->errname, name);
>>      } else if (qiv->errname->str[0] == '.') {
>>          g_string_erase(qiv->errname, 0, 1);
>> -    } else {
>> +    } else if (!qiv->errname->str[0]) {
>>          return "<anonymous>";
>>      }
>>  
>>      return qiv->errname->str;
>>  }
>>  
>> +static const char *full_name(QObjectInputVisitor *qiv, const char *name)
>> +{
>> +    return full_name_nth(qiv, name, 0);
>> +}
>
> One caller passes 0,
>
>
>> +static void qobject_input_check_list(Visitor *v, Error **errp)
>> +{
>> +    QObjectInputVisitor *qiv = to_qiv(v);
>> +    StackObject *tos = QSLIST_FIRST(&qiv->stack);
>> +
>> +    assert(tos && tos->obj && qobject_type(tos->obj) == QTYPE_QLIST);
>> +
>> +    if (tos->entry) {
>> +        error_setg(errp, "Only %u list elements expected in %s",
>> +                   tos->index + 1, full_name_nth(qiv, NULL, 1));
>
> the other passes 1.  No other calls.  Did we really need an integer,
> where we use n--, or would a bool have done as well?

Since I actually use only 0 and 1, a bool would do, but would it make
the code simpler?

> At any rate, since I've already reviewed it once, you can add R-b, but
> we may want a followup to make it less confusing.

Would renaming the function to full_name_but_n() help?
