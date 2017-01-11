Received: from eggs.gnu.org ([2001:4830:134:3::10]:32972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRL8C-0001zt-Tz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRL89-0001SV-MY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:48:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cRL89-0001S9-Gs
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 10:48:05 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D51264D99
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 15:48:05 +0000 (UTC)
Date: Wed, 11 Jan 2017 23:48:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170111154800.GB31132@lemon>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104132625.28059-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-thread: introduce QemuLockCnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, 01/04 14:26, Paolo Bonzini wrote:
> +For example, QEMU uses QemuLockCnt to manage an AioContext's list of
> +bottom halves and file descriptor handlers.  Modifications to the list
> +of file descriptor handlers are rare.  Creation of a new bottom half is
> +frequent and can happen on a fast path; however: 1) it is almost never
> +concurrent with a visit to the list of bottom halves; 

Isn't it common that thread A is busy notifying thread B with BH, and thread B
is busy processing the notification? In that case creation and visiting the BH
list are concurrent.

> 2) it only has
> +three instructions in the critical path, two assignments and a smp_wmb().
> +
> +/**
> + * qemu_lockcnt_dec: possibly decrement a QemuLockCnt's counter and lock it.

s/qemu_lockcnt_dec/qemu_lockcnt_dec_if_lock/

> + * @lockcnt: the lockcnt to operate on
> + *
> + * If the count is 1, decrement the count to zero, lock
> + * the mutex and return true.  Otherwise, return false.
> + */
> +bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_lock: lock a QemuLockCnt's mutex.
> + * @lockcnt: the lockcnt to operate on
> + *
> + * Remember that concurrent visits are not blocked unless the count is
> + * also zero.  You can use qemu_lockcnt_count to check for this inside a
> + * critical section.
> + */
> +void qemu_lockcnt_lock(QemuLockCnt *lockcnt);
> diff --git a/util/lockcnt.c b/util/lockcnt.c
> new file mode 100644
> index 0000000..78ed1e4
> --- /dev/null
> +++ b/util/lockcnt.c
> @@ -0,0 +1,113 @@
> +/*
> + * QemuLockCnt implementation
> + *
> + * Copyright Red Hat, Inc. 2015

2015, 2016?

> + *
> + * Author:
> + *   Paolo Bonzini <pbonzini@redhat.com>
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/thread.h"
> +#include "qemu/atomic.h"
