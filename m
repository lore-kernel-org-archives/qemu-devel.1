Received: from eggs.gnu.org ([2001:4830:134:3::10]:52619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYIMm-0004fy-JD
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYIMi-0005KL-U0
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:15:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYIMi-0005K1-Ne
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:15:52 -0500
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-2-pbonzini@redhat.com>
	<20170130151859.GL2118@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75db602a-4cbe-f75b-9001-2949a99da341@redhat.com>
Date: Mon, 30 Jan 2017 15:15:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170130151859.GL2118@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/17] aio: introduce aio_co_schedule and
 aio_co_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com



On 30/01/2017 10:18, Stefan Hajnoczi wrote:
> On Fri, Jan 20, 2017 at 05:43:06PM +0100, Paolo Bonzini wrote:
>> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int=
.h
>> index 14d4f1d..1efa356 100644
>> --- a/include/qemu/coroutine_int.h
>> +++ b/include/qemu/coroutine_int.h
>> @@ -40,12 +40,20 @@ struct Coroutine {
>>      CoroutineEntry *entry;
>>      void *entry_arg;
>>      Coroutine *caller;
>> +
>> +    /* Only used when the coroutine has terminated.  */
>>      QSLIST_ENTRY(Coroutine) pool_next;
>>      size_t locks_held;
>=20
> locks_held is used when the coroutine is running.  Please add a newline
> to separate it from pool_next.
>=20
>> =20
>> -    /* Coroutines that should be woken up when we yield or terminate =
*/
>> +    /* Coroutines that should be woken up when we yield or terminate.
>> +     * Only used when the coroutine is running.
>> +     */
>>      QSIMPLEQ_HEAD(, Coroutine) co_queue_wakeup;
>> +
>> +    /* Only used when the coroutine is sleeping.  */
>=20
> "running", "yielded", and "terminated" are terms with specific meanings=
.
> Is "sleeping" a subset of "yielded" where the coroutine is waiting for =
a
> mutex or its AioContext to schedule it?

No, I'll just change it to "has yielded".

>> +static void test_multi_co_schedule_entry(void *opaque)
>=20
> Missing coroutine_fn.
>=20
>> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
>> index d2f529b..cb87997 100644
>> --- a/tests/test-vmstate.c
>> +++ b/tests/test-vmstate.c
>> @@ -33,17 +33,6 @@
>>  static char temp_file[] =3D "/tmp/vmst.test.XXXXXX";
>>  static int temp_fd;
>> =20
>> -/* Fake yield_until_fd_readable() implementation so we don't have to =
pull the
>> - * coroutine code as dependency.
>> - */
>> -void yield_until_fd_readable(int fd)
>> -{
>> -    fd_set fds;
>> -    FD_ZERO(&fds);
>> -    FD_SET(fd, &fds);
>> -    select(fd + 1, &fds, NULL, NULL, NULL);
>> -}
>> -
>> =20
>>  /* Duplicate temp_fd and seek to the beginning of the file */
>>  static QEMUFile *open_test_file(bool write)
>=20
> This should be a separate patch.

Yes, it probably doesn't have to be in this series either.

Paolo
