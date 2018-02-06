Received: from eggs.gnu.org ([2001:4830:134:3::10]:45124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiyqO-0008W4-D5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiyqI-0008Ke-IS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:43:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eiyqI-0008IL-A8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 03:43:06 -0500
References: <20180203084315.20497-1-armbru@redhat.com>
	<20180203084315.20497-15-armbru@redhat.com>
	<bbc2cc63-c192-020c-b9ff-78461c0efced@redhat.com>
	<87po5kx7w8.fsf@dusky.pond.sub.org>
	<9189012b-c77c-3b7c-8014-bf086d0b75a5@redhat.com>
	<87tvuvv77r.fsf@dusky.pond.sub.org>
	<CAKmqyKPaTGnqddcQ7SJw9PaEf2cVg2YMbEzcgwKfWZp39vfSxg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <31330a11-b19c-02d3-2973-d62c2eb11fc2@redhat.com>
Date: Tue, 6 Feb 2018 09:43:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPaTGnqddcQ7SJw9PaEf2cVg2YMbEzcgwKfWZp39vfSxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 14/14] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 05.02.2018 19:07, Alistair Francis wrote:
> On Mon, Feb 5, 2018 at 6:31 AM, Markus Armbruster <armbru@redhat.com> w=
rote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 05.02.2018 07:33, Markus Armbruster wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> On 03.02.2018 09:43, Markus Armbruster wrote:
>>>>>> From: Alistair Francis <alistair.francis@xilinx.com>
>>>>>>
>>>>>> Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
>>>>>> target/ppc/translate.c were manually remove. A fprintf() in
>>>>>> target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 =
and
>>>>>> fflush() was removed around the unimplemented log in
>>>>>> target/sh4/translate.c as well.
>>>>>>
>>>>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>>>>> [Trivial conflict with 6f1c2af641d resolved]
>>>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>>> ---
>>>>>>  target/cris/translate.c      |  2 +-
>>>>>>  target/ppc/translate.c       | 36 ++++++++++---------------------=
-----
>>>>>>  target/sh4/translate.c       |  7 ++-----
>>>>>>  target/unicore32/translate.c |  2 +-
>>>>>>  4 files changed, 14 insertions(+), 33 deletions(-)
>>>>>>
>>>>>> diff --git a/target/cris/translate.c b/target/cris/translate.c
>>>>>> index f51a731db9..ff31311ed0 100644
>>>>>> --- a/target/cris/translate.c
>>>>>> +++ b/target/cris/translate.c
>>>>>> @@ -137,7 +137,7 @@ typedef struct DisasContext {
>>>>>>
>>>>>>  static void gen_BUG(DisasContext *dc, const char *file, int line)
>>>>>>  {
>>>>>> -    fprintf(stderr, "BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>>>>> +    qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>>>>>      if (qemu_log_separate()) {
>>>>>>          qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>>>>>      }
>>>>>
>>>>> This one is still logging twice now.
>>>>
>>>> Hmm.
>>>>
>>>>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>>>>> index 4132f67bb1..172c9f2001 100644
>>>>>> --- a/target/ppc/translate.c
>>>>>> +++ b/target/ppc/translate.c
>>>>>> @@ -3933,12 +3933,8 @@ static inline void gen_op_mfspr(DisasContex=
t *ctx)
>>>>>>               * allowing userland application to read the PVR
>>>>>>               */
>>>>>>              if (sprn !=3D SPR_PVR) {
>>>>>> -                fprintf(stderr, "Trying to read privileged spr %d=
 (0x%03x) at "
>>>>>> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip =
- 4);
>>>>>> -                if (qemu_log_separate()) {
>>>>>> -                    qemu_log("Trying to read privileged spr %d (0=
x%03x) at "
>>>>>> -                             TARGET_FMT_lx "\n", sprn, sprn, ctx-=
>nip - 4);
>>>>>> -                }
>>>>>> +                qemu_log("Trying to read privileged spr %d (0x%03=
x) at "
>>>>>> +                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip=
 - 4);
>>>>>
>>>>> I wonder whether that should maybe rather be a
>>>>> qemu_log_mask(LOG_GUEST_ERROR, ...) instead? Well, but maybe that's
>>>>> subject to another patch...
>>>>
>>>> qemu_log_separate() appears to be always used like this
>>>>
>>>>     fprintf(stderr, ... the message ...);
>>>>     if (qemu_log_separate()) {
>>>>         qemu_log(... the same message ...);
>>>>     }
>>>>
>>>> Are you proposing to replace this pattern by
>>>>
>>>>     qemu_log_mask(LOG_GUEST_ERROR, ...the message ...);
>>>>
>>>> ?
>>>
>>> Not globally, only in target/ppc/translate.c. The wrong accesses to S=
PR
>>> (special purpose registers) there indicate that the guest has likely
>>> tried to do something wrong.
>>>
>>> Globally, I wonder whether it still makes sense to keep the
>>> qemu_log_separate() stuff - we rather want to get rid of all fprintfs=
,
>>> don't we?
>>
>> The qemu_log_separate() pattern feels wrong to me.  If we have a class
>> of messages that should go to stderr in addition to the log (unless th=
e
>> two are the same), then we should have a log level / mask / function /
>> whatever to do that.
>>
>> To expedite merging of the rest of the series, I'll drop this patch fr=
om
>> it.

Or maybe just drop the target/ppc parts?

>> Alistair, would you be willing to work with Thomas to revise this patc=
h?
>=20
> Yeah, I'm happy to.
>=20
> What do we think then? Just swap to qemu_log_mask() and
> error_report()? Or do we need something more?

IMHO just switching to qemu_log* and error_report should be sufficient.
At least for the target/ppc parts. If we also want to replace the other
spots that use qemu_log_separate(), that might need some more
discussions, but at least I think we should try to do everything with
error_report() and qemu_log* directly, without introducing yet another
wrapper function for this.

 Thomas
