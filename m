Received: from eggs.gnu.org ([2001:4830:134:3::10]:46264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXU3r-0003Fx-Jg
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXU3q-0006ea-83
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:19 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-3-git-send-email-armbru@redhat.com>
	<7d0832cf-34c8-9c21-f6fd-104738331f14@redhat.com>
Date: Tue, 18 Jul 2017 17:05:06 +0200
In-Reply-To: <7d0832cf-34c8-9c21-f6fd-104738331f14@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 09:36:02 -0500")
Message-ID: <87h8y9vl99.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 02/10] qapi: Use QNull for a more
 regular visit_type_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>> Make visit_type_null() take an @obj argument like its buddies.  This
>> helps keeing the next commit simple.
>
> s/keeing/keep/

Will fix.

>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/qapi/qobject-output-visitor.c
>> @@ -187,7 +187,8 @@ static void qobject_output_type_any(Visitor *v, const char *name,
>>      qobject_output_add_obj(qov, name, *obj);
>>  }
>>  
>> -static void qobject_output_type_null(Visitor *v, const char *name, Error **errp)
>> +static void qobject_output_type_null(Visitor *v, const char *name,
>> +                                     QNull **obj, Error **errp)
>>  {
>>      QObjectOutputVisitor *qov = to_qov(v);
>>      qobject_output_add(qov, name, qnull());
>
> would it be any better to call qobject_output_add(qov, name,
> QINCREF(*obj)) here, to ensure we are indeed passing in an appropriate
> QNull reference?  But your patch is at least self-consistent in stating
> we ignore obj in output visitors.

A QAPI schema type is connected to a C type (QAPI-generated except for a
few built-in types) and a QObject type.

For QAPI schema type 'null', the QObject type is QNull.

The C type is also QNull, but this is arbitrary.  We could just as well
generate a C struct type for the purpose.  All we need is some non-null
pointer value.  I'm lazy, so I grabbed one we already have: qnull_.

qnull_ is kind of nice because "allocation" / "deallocation" merely
increment / decrement its reference count.

A separate struct could be made less efficient (allocate / deallocate an
instance of the struct) or more efficient (make it a singleton without a
reference count).

To actually answer your question: I didn't feel like coupling the value
qobject_output_type_null() creates to the value it receives, even though
both are actually _qnull.

Precedence for coupling: qobject_output_type_any().  But that one's
different, because the choice of QObject as C type for 'any' is
essential instead of arbitrary.

Does this make some sense?

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
