Received: from eggs.gnu.org ([2001:4830:134:3::10]:36893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRLSn-0001S0-8f
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRLSi-0001bv-A2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:09:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRLSi-0001bY-3w
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:09:20 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2BB6C056791
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:09:19 +0000 (UTC)
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-3-pbonzini@redhat.com>
	<20170111154800.GB31132@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db85355d-153f-e13b-1a30-5c0ada6b34d0@redhat.com>
Date: Wed, 11 Jan 2017 17:09:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170111154800.GB31132@lemon>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-thread: introduce QemuLockCnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com



On 11/01/2017 16:48, Fam Zheng wrote:
> On Wed, 01/04 14:26, Paolo Bonzini wrote:
>> +For example, QEMU uses QemuLockCnt to manage an AioContext's list of
>> +bottom halves and file descriptor handlers.  Modifications to the lis=
t
>> +of file descriptor handlers are rare.  Creation of a new bottom half =
is
>> +frequent and can happen on a fast path; however: 1) it is almost neve=
r
>> +concurrent with a visit to the list of bottom halves;=20
>=20
> Isn't it common that thread A is busy notifying thread B with BH, and t=
hread B
> is busy processing the notification? In that case creation and visiting=
 the BH
> list are concurrent.

For multi-threaded cases you may can create the BH just once
(thread-pool does it, and aio_co_schedule will be there in the next part
of the work to simplify "remote" qemu_coroutine_enter).

The case where thread A creates the bottom half does occur with rbd.c,
but then, the next point applies:

>> 2) it only has
>> +three instructions in the critical path, two assignments and a smp_wm=
b().
>> +
>> +/**
>> + * qemu_lockcnt_dec: possibly decrement a QemuLockCnt's counter and l=
ock it.
>=20
> s/qemu_lockcnt_dec/qemu_lockcnt_dec_if_lock/

Oops, I'll wait for full review and send v4.

>> + * @lockcnt: the lockcnt to operate on
>> + *
>> + * If the count is 1, decrement the count to zero, lock
>> + * the mutex and return true.  Otherwise, return false.
>> + */
>> +bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
>> +
>> +/**
>> + * qemu_lockcnt_lock: lock a QemuLockCnt's mutex.
>> + * @lockcnt: the lockcnt to operate on
>> + *
>> + * Remember that concurrent visits are not blocked unless the count i=
s
>> + * also zero.  You can use qemu_lockcnt_count to check for this insid=
e a
>> + * critical section.
>> + */
>> +void qemu_lockcnt_lock(QemuLockCnt *lockcnt);
>> diff --git a/util/lockcnt.c b/util/lockcnt.c
>> new file mode 100644
>> index 0000000..78ed1e4
>> --- /dev/null
>> +++ b/util/lockcnt.c
>> @@ -0,0 +1,113 @@
>> +/*
>> + * QemuLockCnt implementation
>> + *
>> + * Copyright Red Hat, Inc. 2015
>=20
> 2015, 2016?

Or 2017 even. :)

Paolo

>> + *
>> + * Author:
>> + *   Paolo Bonzini <pbonzini@redhat.com>
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qemu/thread.h"
>> +#include "qemu/atomic.h"
