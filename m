Received: from eggs.gnu.org ([2001:4830:134:3::10]:39866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZLTp-0005aw-It
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZLTm-0001XL-9X
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:56:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gZLTi-00011Q-Fw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:56:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6994F80F8E
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 19:56:27 +0000 (UTC)
References: <20181218182234.28876-1-armbru@redhat.com>
	<20181218182234.28876-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64220b68-3a4d-a285-968d-96d38026b8e3@redhat.com>
Date: Tue, 18 Dec 2018 13:56:23 -0600
MIME-Version: 1.0
In-Reply-To: <20181218182234.28876-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

On 12/18/18 12:22 PM, Markus Armbruster wrote:
> The qapi_event_send_FOO() functions emit events like this:
> 
>      QMPEventFuncEmit emit;
> 
>      emit = qmp_event_get_func_emit();
>      if (!emit) {
>          return;
>      }
> 

>      emit(QAPI_EVENT_FOO, qmp);
> 

> More seriously: how does this work even now?  qemu-system-FOO wants
> QAPIEvent, and passes a function taking that to
> qmp_event_set_func_emit().  test-qmp-event wants test_QAPIEvent, and
> passes a function taking that to qmp_event_set_func_emit().
> 
> I works by type trickery, of course:

s/I/It/

> 
>      typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);
> 
>      void qmp_event_set_func_emit(QMPEventFuncEmit emit);
> 
>      QMPEventFuncEmit qmp_event_get_func_emit(void);
> 
> We use unsigned instead of the enumeration type.  Relies on both
> enumerations boiling down to unsigned, which happens to be true for
> the compilers we use.
> 
> Clean this up as follows:
> 
> * Generate qapi_event_send_FOO() that call PREFIX_qapi_event_emit()
>    instead of the value of qmp_event_set_func_emit().
> 
> * Generate a prototype for PREFIX_qapi_event_emit() into
>    qapi-events.h.
> 
> * PREFIX_ is empty for qapi/qapi-schema.json, and test_ for
>    tests/qapi-schema/qapi-schema-test.json.  It's qga_ for
>    qga/qapi-schema.json, and doc-good- for
>    tests/qapi-schema/doc-good-qapi-doc.texi, but those don't define any
>    events.

Wait - PREFIX is qga_ or doc_good_...

> * Add a qapi_event_emit() that does nothing to stubs/monitor.c.  This
>    takes care of all other programs that link code emitting QMP events.

...but the stub function is defined without a prefix?

> +++ b/stubs/monitor.c
> @@ -1,5 +1,6 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-events.h"
>   #include "qemu-common.h"
>   #include "monitor/monitor.h"
>   
> @@ -14,3 +15,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>   void monitor_init(Chardev *chr, int flags)
>   {
>   }
> +
> +void qapi_event_emit(QAPIEvent event, QDict *qdict)
> +{
> +}
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
