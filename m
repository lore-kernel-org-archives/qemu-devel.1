Received: from eggs.gnu.org ([2001:4830:134:3::10]:60712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekPHP-0006Sa-7t
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekPHN-0007sd-UQ
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:08:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180209152412.23626-1-pbonzini@redhat.com>
	<1b0c7678-21b1-562e-5315-f6a761f21237@amsat.org>
Date: Sat, 10 Feb 2018 08:08:42 +0100
In-Reply-To: <1b0c7678-21b1-562e-5315-f6a761f21237@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 9 Feb 2018 12:48:06
	-0300")
Message-ID: <87r2ptjp8l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/nvme: fix Coverity reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 02/09/2018 12:24 PM, Paolo Bonzini wrote:
>> 1) string not null terminated in sysfs_find_group_file
>
> CID 1385854
>
>>=20
>> 2) NULL pointer dereference and dead local variable in nvme_init.
>
> CID 1385855
>
>>=20
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  block/nvme.c        | 14 ++++++--------
>>  util/vfio-helpers.c |  2 +-
>>  2 files changed, 7 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/block/nvme.c b/block/nvme.c
>> index e9d0e218fc..ce217ffc81 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -553,7 +553,6 @@ static int nvme_init(BlockDriverState *bs, const cha=
r *device, int namespace,
>>      uint64_t cap;
>>      uint64_t timeout_ms;
>>      uint64_t deadline, now;
>> -    Error *local_err =3D NULL;
>>=20=20
>>      qemu_co_mutex_init(&s->dma_map_lock);
>>      qemu_co_queue_init(&s->dma_flush_queue);
>> @@ -645,11 +644,6 @@ static int nvme_init(BlockDriverState *bs, const ch=
ar *device, int namespace,
>>                             false, nvme_handle_event, nvme_poll_cb);
>>=20=20
>>      nvme_identify(bs, namespace, errp);
>
> The problem seems local_err is not used as nvme_identify() argument;
> however this big function uses both errp and local_err so maybe clean it
> to keep one style is better.
>
> Isn't local_err + error_propagate() the cleaner way?

Cleaner no, actually correct, probably.

Passing errp directly is okay in certain circumstances.  Quote
include/qapi/error.h:

 * Receive an error and pass it on to the caller:
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *         error_propagate(errp, err);
 *     }
 * where Error **errp is a parameter, by convention the last one.
 *
 * Do *not* "optimize" this to
 *     foo(arg, errp);
 *     if (*errp) { // WRONG!
 *         handle the error...
 *     }
 * because errp may be NULL!
 *
 * But when all you do with the error is pass it on, please use
 *     foo(arg, errp);
 * for readability.

However, ...
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        ret =3D -EIO;
>> -        goto fail_handler;
>> -    }

... if nvme_identify() fails and sets an error, we now continue ...

>>=20=20
>>      /* Set up command queues. */
>>      if (!nvme_add_io_queue(bs, errp)) {

... to this call, where errp points to non-null.  That's wrong, because
it'll crash when nvme_add_io_queue() tries to set an error.
include/qapi/error.h again:

 * Receive and accumulate multiple errors (first one wins):
 *     Error *err =3D NULL, *local_err =3D NULL;
 *     foo(arg, &err);
 *     bar(arg, &local_err);
 *     error_propagate(&err, local_err);
 *     if (err) {
 *         handle the error...
 *     }
 *
 * Do *not* "optimize" this to
 *     foo(arg, &err);
 *     bar(arg, &err); // WRONG!
 *     if (err) {
 *         handle the error...
 *     }
 * because this may pass a non-null err to bar().

I doubt you want to accumulate here.

[...]
