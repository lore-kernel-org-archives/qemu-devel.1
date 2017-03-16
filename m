Received: from eggs.gnu.org ([2001:4830:134:3::10]:51014)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cobwX-00007L-3G
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cobwT-0003Ma-35
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:24:17 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:51723 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cobwS-0003M6-PK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:24:13 -0400
From: Peter Lieven <pl@kamp.de>
Message-Id: <013DFFB1-F816-4BAC-8738-FEA6C2E3CBFC@kamp.de>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Date: Thu, 16 Mar 2017 21:24:20 +0100
In-Reply-To: <94b6f30b-4e91-1336-bad4-d5de16131407@redhat.com>
References: <1489680169-7638-1-git-send-email-pl@kamp.de>
	<94b6f30b-4e91-1336-bad4-d5de16131407@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH for-2.9] thread-pool: add
 missing qemu_bh_cancel in completion function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, berrange@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org


> Am 16.03.2017 um 17:18 schrieb Paolo Bonzini <pbonzini@redhat.com>:
>=20
>=20
>=20
> On 16/03/2017 17:02, Peter Lieven wrote:
>> commit 3c80ca15 fixed a deadlock scenarion with nested aio_poll =
invocations.
>>=20
>> However, the rescheduling of the completion BH introcuded unnecessary =
spinning
>> in the main-loop. On very fast file backends this can even lead to =
the
>> "WARNING: I/O thread spun for 1000 iterations" message popping up.
>>=20
>> Callgrind reports about 3-4% less instructions with this patch =
running
>> qemu-img bench on a ramdisk based VMDK file.
>>=20
>> Fixes: 3c80ca158c96ff902a30883a8933e755988948b1
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>> util/thread-pool.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>=20
>> diff --git a/util/thread-pool.c b/util/thread-pool.c
>> index ce6cd30..610646d 100644
>> --- a/util/thread-pool.c
>> +++ b/util/thread-pool.c
>> @@ -188,6 +188,13 @@ restart:
>>             aio_context_release(pool->ctx);
>>             elem->common.cb(elem->common.opaque, elem->ret);
>>             aio_context_acquire(pool->ctx);
>> +
>> +            /* We can safely cancel the completion_bh here =
regardless of someone
>> +             * else having scheduled it meanwhile because we reenter =
the
>> +             * completion function anyway (goto restart).
>> +             */
>> +            qemu_bh_cancel(pool->completion_bh);
>> +
>>             qemu_aio_unref(elem);
>>             goto restart;
>>         } else {
>>=20
>=20
> Right, this is the same thing that block/linux-aio.c does.


Okay, so you also think its safe to do this? As far as I have seen you =
have been working a lot on the aio code recently.

Thanks,
Peter=
