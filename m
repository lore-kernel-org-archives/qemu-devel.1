Received: from eggs.gnu.org ([2001:4830:134:3::10]:60639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiaLe-0005rw-15
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiaLa-00037k-TW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:33:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eiaLa-00037K-KF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:33:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180203084315.20497-1-armbru@redhat.com>
	<20180203084315.20497-15-armbru@redhat.com>
	<bbc2cc63-c192-020c-b9ff-78461c0efced@redhat.com>
Date: Mon, 05 Feb 2018 07:33:43 +0100
In-Reply-To: <bbc2cc63-c192-020c-b9ff-78461c0efced@redhat.com> (Thomas Huth's
	message of "Sat, 3 Feb 2018 21:23:31 +0100")
Message-ID: <87po5kx7w8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, alistair.francis@xilinx.com

Thomas Huth <thuth@redhat.com> writes:

> On 03.02.2018 09:43, Markus Armbruster wrote:
>> From: Alistair Francis <alistair.francis@xilinx.com>
>>=20
>> Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
>> target/ppc/translate.c were manually remove. A fprintf() in
>> target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 and
>> fflush() was removed around the unimplemented log in
>> target/sh4/translate.c as well.
>>=20
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> [Trivial conflict with 6f1c2af641d resolved]
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  target/cris/translate.c      |  2 +-
>>  target/ppc/translate.c       | 36 ++++++++++--------------------------
>>  target/sh4/translate.c       |  7 ++-----
>>  target/unicore32/translate.c |  2 +-
>>  4 files changed, 14 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/target/cris/translate.c b/target/cris/translate.c
>> index f51a731db9..ff31311ed0 100644
>> --- a/target/cris/translate.c
>> +++ b/target/cris/translate.c
>> @@ -137,7 +137,7 @@ typedef struct DisasContext {
>>=20=20
>>  static void gen_BUG(DisasContext *dc, const char *file, int line)
>>  {
>> -    fprintf(stderr, "BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>> +    qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>      if (qemu_log_separate()) {
>>          qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
>>      }
>
> This one is still logging twice now.

Hmm.

>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 4132f67bb1..172c9f2001 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -3933,12 +3933,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
>>               * allowing userland application to read the PVR
>>               */
>>              if (sprn !=3D SPR_PVR) {
>> -                fprintf(stderr, "Trying to read privileged spr %d (0x%0=
3x) at "
>> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
>> -                if (qemu_log_separate()) {
>> -                    qemu_log("Trying to read privileged spr %d (0x%03x)=
 at "
>> -                             TARGET_FMT_lx "\n", sprn, sprn, ctx->nip -=
 4);
>> -                }
>> +                qemu_log("Trying to read privileged spr %d (0x%03x) at "
>> +                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
>
> I wonder whether that should maybe rather be a
> qemu_log_mask(LOG_GUEST_ERROR, ...) instead? Well, but maybe that's
> subject to another patch...

qemu_log_separate() appears to be always used like this

    fprintf(stderr, ... the message ...);
    if (qemu_log_separate()) {
        qemu_log(... the same message ...);
    }

Are you proposing to replace this pattern by

    qemu_log_mask(LOG_GUEST_ERROR, ...the message ...);

?

>>              }
>>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
>>          }
[...]
