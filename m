Received: from eggs.gnu.org ([2001:4830:134:3::10]:55658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZVmw-000779-Is
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZVmt-0002Pt-EB
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:57:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZVmt-0002PZ-7w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:56:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AE787BDB8
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 06:56:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
	<20181218182234.28876-3-armbru@redhat.com>
	<64220b68-3a4d-a285-968d-96d38026b8e3@redhat.com>
Date: Wed, 19 Dec 2018 07:56:52 +0100
In-Reply-To: <64220b68-3a4d-a285-968d-96d38026b8e3@redhat.com> (Eric Blake's
	message of "Tue, 18 Dec 2018 13:56:23 -0600")
Message-ID: <871s6engwb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH v2 02/15] qapi: Eliminate indirection
 through qmp_event_get_func_emit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 12/18/18 12:22 PM, Markus Armbruster wrote:
>> The qapi_event_send_FOO() functions emit events like this:
>>
>>      QMPEventFuncEmit emit;
>>
>>      emit = qmp_event_get_func_emit();
>>      if (!emit) {
>>          return;
>>      }
>>
>
>>      emit(QAPI_EVENT_FOO, qmp);
>>
>
>> More seriously: how does this work even now?  qemu-system-FOO wants
>> QAPIEvent, and passes a function taking that to
>> qmp_event_set_func_emit().  test-qmp-event wants test_QAPIEvent, and
>> passes a function taking that to qmp_event_set_func_emit().
>>
>> I works by type trickery, of course:
>
> s/I/It/

Of course.

>>
>>      typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);
>>
>>      void qmp_event_set_func_emit(QMPEventFuncEmit emit);
>>
>>      QMPEventFuncEmit qmp_event_get_func_emit(void);
>>
>> We use unsigned instead of the enumeration type.  Relies on both
>> enumerations boiling down to unsigned, which happens to be true for
>> the compilers we use.
>>
>> Clean this up as follows:
>>
>> * Generate qapi_event_send_FOO() that call PREFIX_qapi_event_emit()
>>    instead of the value of qmp_event_set_func_emit().
>>
>> * Generate a prototype for PREFIX_qapi_event_emit() into
>>    qapi-events.h.
>>
>> * PREFIX_ is empty for qapi/qapi-schema.json, and test_ for
>>    tests/qapi-schema/qapi-schema-test.json.  It's qga_ for
>>    qga/qapi-schema.json, and doc-good- for
>>    tests/qapi-schema/doc-good-qapi-doc.texi, but those don't define any
>>    events.
>
> Wait - PREFIX is qga_ or doc_good_...

Yes.

>> * Add a qapi_event_emit() that does nothing to stubs/monitor.c.  This
>>    takes care of all other programs that link code emitting QMP events.
>
> ...but the stub function is defined without a prefix?

It's defined with a prefix, except in the commit message ;)  Will fix,
thanks!
