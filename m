Received: from eggs.gnu.org ([209.51.188.92]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hJztx-00074U-Fu
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hJztv-0006QT-GL
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:24:25 -0400
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <57c36dca-c4d6-9b70-7799-0be96325d7c5@yandex-team.ru>
Date: Fri, 26 Apr 2019 15:24:15 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] aio context ownership during bdrv_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?eWMtY29yZSAo0YDQsNGB0YHRi9C70Lo=?= =?UTF-8?B?0LAp?= <yc-core@yandex-team.ru>

I can't figure out ownership of aio context during bdrv_close().

As far as I understand bdrv_unref() shold be called with acquired aio 
context to prevent concurrent operations (at least most usages in 
blockdev.c explicitly acquire and release context, but not all).

But if refcount reaches zero and bs is going to be deleted in 
bdrv_close() we need to ensure that drain is finished data is flushed 
and there are no more pending coroutines and bottomhalves, so drain and 
flush functions can enter coroutine and perform yield in several places. 
As a result control returns to coroutine caller that will release aio 
context and when completion bh will continue cleanup process it will be 
executed without ownership of context. Is this a valid situation?

Moreover if yield happens bs that is being deleted has zero refcount but 
is still present in lists graph_bdrv_states and all_bdrv_states and can 
be accidentally accessed. Shouldn't we remove it from these lists ASAP 
when deletion process starts as we do from monitor_bdrv_states?
