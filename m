Received: from eggs.gnu.org ([2001:4830:134:3::10]:36317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiadZ-0002y3-Ek
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiadW-0006hp-DE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:52:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eiadW-0006fU-5c
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:52:18 -0500
References: <20180203084315.20497-1-armbru@redhat.com>
	<20180203084315.20497-15-armbru@redhat.com>
	<bbc2cc63-c192-020c-b9ff-78461c0efced@redhat.com>
	<87po5kx7w8.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9189012b-c77c-3b7c-8014-bf086d0b75a5@redhat.com>
Date: Mon, 5 Feb 2018 07:52:08 +0100
MIME-Version: 1.0
In-Reply-To: <87po5kx7w8.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, alistair.francis@xilinx.com

On 05.02.2018 07:33, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 03.02.2018 09:43, Markus Armbruster wrote:
>>> From: Alistair Francis <alistair.francis@xilinx.com>
>>>
>>> Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
>>> target/ppc/translate.c were manually remove. A fprintf() in
>>> target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 and
>>> fflush() was removed around the unimplemented log in
>>> target/sh4/translate.c as well.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> [Trivial conflict with 6f1c2af641d resolved]
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  target/cris/translate.c      |  2 +-
>>>  target/ppc/translate.c       | 36 ++++++++++------------------------=
--
>>>  target/sh4/translate.c       |  7 ++-----
>>>  target/unicore32/translate.c |  2 +-
>>>  4 files changed, 14 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/target/cris/translate.c b/target/cris/translate.c
>>> index f51a731db9..ff31311ed0 100644
>>> --- a/target/cris/translate.c
>>> +++ b/target/cris/translate.c
>>> @@ -137,7 +137,7 @@ typedef struct DisasContext {
>>> =20
>>>  static void gen_BUG(DisasContext *dc, const char *file, int line)
>>>  {
>>> -    fprintf(stderr, "BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>> +    qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>>      if (qemu_log_separate()) {
>>>          qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>>      }
>>
>> This one is still logging twice now.
>=20
> Hmm.
>=20
>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>> index 4132f67bb1..172c9f2001 100644
>>> --- a/target/ppc/translate.c
>>> +++ b/target/ppc/translate.c
>>> @@ -3933,12 +3933,8 @@ static inline void gen_op_mfspr(DisasContext *=
ctx)
>>>               * allowing userland application to read the PVR
>>>               */
>>>              if (sprn !=3D SPR_PVR) {
>>> -                fprintf(stderr, "Trying to read privileged spr %d (0=
x%03x) at "
>>> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4=
);
>>> -                if (qemu_log_separate()) {
>>> -                    qemu_log("Trying to read privileged spr %d (0x%0=
3x) at "
>>> -                             TARGET_FMT_lx "\n", sprn, sprn, ctx->ni=
p - 4);
>>> -                }
>>> +                qemu_log("Trying to read privileged spr %d (0x%03x) =
at "
>>> +                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - =
4);
>>
>> I wonder whether that should maybe rather be a
>> qemu_log_mask(LOG_GUEST_ERROR, ...) instead? Well, but maybe that's
>> subject to another patch...
>=20
> qemu_log_separate() appears to be always used like this
>=20
>     fprintf(stderr, ... the message ...);
>     if (qemu_log_separate()) {
>         qemu_log(... the same message ...);
>     }
>=20
> Are you proposing to replace this pattern by
>=20
>     qemu_log_mask(LOG_GUEST_ERROR, ...the message ...);
>=20
> ?

Not globally, only in target/ppc/translate.c. The wrong accesses to SPR
(special purpose registers) there indicate that the guest has likely
tried to do something wrong.

Globally, I wonder whether it still makes sense to keep the
qemu_log_separate() stuff - we rather want to get rid of all fprintfs,
don't we?

 Thomas
