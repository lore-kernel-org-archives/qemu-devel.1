Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDbax-0005Md-4P
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDbas-0003BT-5b
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:05:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f4437f01-1eb2-d1c1-3df5-ee992fab2036@virtuozzo.com>
References: <4086b9ad1d1c912298f7c981f2c94a9f9a7026a3.1495536228.git.berto@igalia.com>
	<5925B107.1060404@virtuozzo.com>
	<f4437f01-1eb2-d1c1-3df5-ee992fab2036@virtuozzo.com>
Date: Wed, 24 May 2017 21:05:08 +0200
Message-ID: <w51inkqyt23.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 7/7] qcow2: Merge the writing of the COW
 regions with the guest data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

On Wed 24 May 2017 06:43:31 PM CEST, Anton Nefedov wrote:
>> +    if (m->data_qiov) {
>> +        qemu_iovec_reset(&qiov);
>> +        qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
>> +        qemu_iovec_concat(&qiov, m->data_qiov, 0, data_bytes);
>> +        qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
>
> Can it be a problem if (m->data_qiov->niov == IOV_MAX)?
> We had to add merge-iovecs code for the case (maybe there's better
> solution?)

You're right, good catch! I'll add a check for that. To be honest I
don't think that's likely to happen in practice, so if it does we can
simply fall back to the old behavior (separate writes).

> Also, will this work if allocation is split into several l2metas?
> e.g. one has cow_start.nb_bytes and another has cow_end.nb_bytes

The guest request will be merged with the first l2meta that has to copy
at least one of the two regions. It doesn't matter if the other one has
nb_bytes == 0.

Berto
