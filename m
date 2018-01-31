Received: from eggs.gnu.org ([2001:4830:134:3::10]:33640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egnUR-0007TU-Oc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egnUN-0003KY-N1
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:11:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egnUN-0003K8-Gz
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:11:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C95261B9C
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:11:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-9-armbru@redhat.com>
	<6bffa91e-e573-3777-c7a9-86b72d548247@redhat.com>
Date: Wed, 31 Jan 2018 09:11:24 +0100
In-Reply-To: <6bffa91e-e573-3777-c7a9-86b72d548247@redhat.com> (Eric Blake's
	message of "Tue, 30 Jan 2018 11:02:24 -0600")
Message-ID: <87372m78ib.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/18] qdict qlist: Make most helper macros
 functions
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

> On 01/30/2018 04:21 AM, Markus Armbruster wrote:
>> The macro expansions of qdict_put_TYPE() and qlist_append_TYPE() need
>> qbool.h, qnull.h, qnum.h and qstring.h to compile.  We include qnull.h
>> and qnum.h in the headers, but not qbool.h and qstring.h.  Works,
>> because we include those wherever the macros get used.
>> 
>> Open-coding these helpers is of dubious value.  Turn them into
>> functions and drop the includes from the headers.
>> 
>> This cleanup makes the number of objects depending on qapi/qmp/qnum.h
>> from 4548 (out of 4739) to 46 in my "build everything" tree.  For
>> qapi/qmp/qnull.h, the number drops from 4549 to 21.
>
> Impressive!
>
>
>> +++ b/qobject/qdict.c
>> @@ -14,6 +14,7 @@
>>  #include "qapi/qmp/qnum.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qbool.h"
>> +#include "qapi/qmp/qnull.h"
>>  #include "qapi/qmp/qstring.h"
>>  #include "qapi/qmp/qobject.h"
>>  #include "qapi/error.h"
>> @@ -143,6 +144,26 @@ void qdict_put_obj(QDict *qdict, const char *key, QObject *value)
>>      }
>>  }
>>  
>> +void qdict_put_int(QDict *qdict, const char *key, int64_t value)
>> +{
>> +    qdict_put(qdict, key, qnum_from_int(value));
>> +}
>
> If I'm not mistaken (although I didn't actually test), this triggers a
> false positive in scripts/coccinelle/qobject.cocci, no?  Is there a
> convenient way to tell coccinelle that a rewrite pattern applies
> everywhere except for where the pattern itself is implemented?  But even

I figure it's possible, but too much trouble to be worthwhile.

> if not, we can always use manual inspection when rerunning Coccinelle to
> make sure we don't turn these into infinite loops.

Yup.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
