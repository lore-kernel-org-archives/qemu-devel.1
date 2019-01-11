Received: from eggs.gnu.org ([209.51.188.92]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghyju-0003y3-7x
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghyjt-0006nu-DM
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:28:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghyjt-0006nL-4S
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:28:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D6E75AF69
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 15:28:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
	<20181218182234.28876-3-armbru@redhat.com>
	<64220b68-3a4d-a285-968d-96d38026b8e3@redhat.com>
	<871s6engwb.fsf@dusky.pond.sub.org>
Date: Fri, 11 Jan 2019 16:28:45 +0100
In-Reply-To: <871s6engwb.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 19 Dec 2018 07:56:52 +0100")
Message-ID: <87va2v1adu.fsf@dusky.pond.sub.org>
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

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 12/18/18 12:22 PM, Markus Armbruster wrote:
>>> The qapi_event_send_FOO() functions emit events like this:
>>>
>>>      QMPEventFuncEmit emit;
>>>
>>>      emit = qmp_event_get_func_emit();
>>>      if (!emit) {
>>>          return;
>>>      }
>>>
>>
>>>      emit(QAPI_EVENT_FOO, qmp);
>>>
>>
>>> More seriously: how does this work even now?  qemu-system-FOO wants
>>> QAPIEvent, and passes a function taking that to
>>> qmp_event_set_func_emit().  test-qmp-event wants test_QAPIEvent, and
>>> passes a function taking that to qmp_event_set_func_emit().
>>>
>>> I works by type trickery, of course:
>>
>> s/I/It/
>
> Of course.
>
>>>
>>>      typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);
>>>
>>>      void qmp_event_set_func_emit(QMPEventFuncEmit emit);
>>>
>>>      QMPEventFuncEmit qmp_event_get_func_emit(void);
>>>
>>> We use unsigned instead of the enumeration type.  Relies on both
>>> enumerations boiling down to unsigned, which happens to be true for
>>> the compilers we use.
>>>
>>> Clean this up as follows:
>>>
>>> * Generate qapi_event_send_FOO() that call PREFIX_qapi_event_emit()
>>>    instead of the value of qmp_event_set_func_emit().
>>>
>>> * Generate a prototype for PREFIX_qapi_event_emit() into
>>>    qapi-events.h.
>>>
>>> * PREFIX_ is empty for qapi/qapi-schema.json, and test_ for
>>>    tests/qapi-schema/qapi-schema-test.json.  It's qga_ for
>>>    qga/qapi-schema.json, and doc-good- for
>>>    tests/qapi-schema/doc-good-qapi-doc.texi, but those don't define any
>>>    events.

Make that doc-good.json.

>>
>> Wait - PREFIX is qga_ or doc_good_...
>
> Yes.
>
>>> * Add a qapi_event_emit() that does nothing to stubs/monitor.c.  This
>>>    takes care of all other programs that link code emitting QMP events.
>>
>> ...but the stub function is defined without a prefix?
>
> It's defined with a prefix, except in the commit message ;)  Will fix,
> thanks!

Nonsense.

Since PREFIX_ is empty for qapi/qapi-schema.json, the generated
qapi_event_send_EVENT for the EVENT defined there all call
qapi_event_emit().

The stub makes qapi_event_send_EVENT() work for any EVENT defined there
in programs that don't link (non-stub) monitor.c.

PREFIX is non-empty for the other two, but no events are defined there.
qga_qapi_event_emit() and doc_good_qapi_event_emit() are neither used
nor defined anywhere.

Clear now?
