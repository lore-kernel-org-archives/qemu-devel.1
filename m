Received: from eggs.gnu.org ([2001:4830:134:3::10]:48092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMiGT-0000sq-JS
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gMiGO-00088Y-0t
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:38:37 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-2-git-send-email-marcolso@amazon.com>
	<94e0cf20-1a15-e4d0-cc68-cc7247067914@redhat.com>
	<5d567a8f-ccde-96b2-1650-4fd9723e1fb9@amazon.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c4decd95-9380-af27-9eab-759ab2a3f14e@redhat.com>
Date: Tue, 13 Nov 2018 18:38:18 -0500
MIME-Version: 1.0
In-Reply-To: <5d567a8f-ccde-96b2-1650-4fd9723e1fb9@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] blkdebug: Extend rule check for
 additional types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 11/13/18 6:34 PM, Marc Olson wrote:
> On 11/13/18 3:22 PM, John Snow wrote:
>>
>> On 11/12/18 2:06 AM, Marc Olson via Qemu-devel wrote:
>>> Break out the more common parts of the BlkdebugRule struct, and make
>>> rule_check() more explicit about operating only on error injection ty=
pes
>>> so that additional rule types can be added in the future.
>>>
>>> Signed-off-by: Marc Olson <marcolso@amazon.com>
>>> ---
>>> =C2=A0 block/blkdebug.c | 59
>>> +++++++++++++++++++++++++++++---------------------------
>>> =C2=A0 1 file changed, 31 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>>> index 327049b..7739849 100644
>>> --- a/block/blkdebug.c
>>> +++ b/block/blkdebug.c
>>> @@ -73,13 +73,13 @@ typedef struct BlkdebugRule {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlkdebugEvent event;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int action;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int state;
>>> +=C2=A0=C2=A0=C2=A0 int once;
>>> +=C2=A0=C2=A0=C2=A0 int64_t offset;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int error;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int immediately;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
nt once;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
nt64_t offset;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } inject;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } inject_error;
>> ...pulling out "once" and "offset" from inject_error (renamed inject) =
to
>> shared properties. Fine, though this looks like it could use more love=
.
>> Not your doing.
>>
>> This adds new dead fields for set_state and suspend which will now wor=
k,
>> but hopefully not do anything.
>=20
>=20
> I think set_state was already there?
>=20

Yes, I just mean to say that "once" and "offset" now get defined for
set_state tagged rules, and could theoretically be specified by the user
(I think?) I don't think it will change anything. Just pointing it out
in case anyone knows better than I do.

>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int new_state;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } set_state;
>>> @@ -182,16 +182,16 @@ static int add_rule(void *opaque, QemuOpts
>>> *opts, Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .state=C2=A0 =3D=
 qemu_opt_get_number(opts, "state", 0),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 rule->once =3D qemu_opt_get_bool(opts, "on=
ce", 0);
>>> +=C2=A0=C2=A0=C2=A0 sector =3D qemu_opt_get_number(opts, "sector", -1=
);
>>> +=C2=A0=C2=A0=C2=A0 rule->offset =3D sector =3D=3D -1 ? -1 : sector *=
 BDRV_SECTOR_SIZE;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Parse action-specific options */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (d->action) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ACTION_INJECT_ERROR:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject.erro=
r =3D qemu_opt_get_number(opts,
>>> "errno", EIO);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject.once=
=C2=A0 =3D qemu_opt_get_bool(opts, "once",
>>> 0);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject.imme=
diately =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject_erro=
r.error =3D qemu_opt_get_number(opts,
>>> "errno", EIO);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject_erro=
r.immediately =3D
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 qemu_opt_get_bool(opts, "immediately", 0);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sector =3D qemu_opt_get_n=
umber(opts, "sector", -1);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject.offs=
et =3D
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ector =3D=3D -1 ? -1 : sector * BDRV_SECTOR_SIZE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ACTION_SET_STATE:
>>> @@ -474,38 +474,41 @@ static int rule_check(BlockDriverState *bs,
>>> uint64_t offset, uint64_t bytes)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVBlkdebugState *s =3D bs->opaque;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlkdebugRule *rule =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 BlkdebugRule *error_rule =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool immediately;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(rule, &s->acti=
ve_rules, active_next) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t inject_offset =3D=
 rule->options.inject.offset;
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inject_offset =3D=3D =
-1 ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
bytes && inject_offset >=3D offset &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 inject_offset < offset + bytes))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rule->offset =3D=3D -=
1 ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
bytes && rule->offset >=3D offset &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 rule->offset < offset + bytes))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (rule->action =3D=3D ACTION_INJECT_ERROR) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_rule =3D rule;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!rule) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (error_rule) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 immediately =3D error_rul=
e->options.inject_error.immediately;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D error_rule->opt=
ions.inject_error.error;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 immediately =3D rule->options.inject.immed=
iately;
>>> -=C2=A0=C2=A0=C2=A0 error =3D rule->options.inject.error;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error_rule->once) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Q=
SIMPLEQ_REMOVE(&s->active_rules, error_rule,
>>> BlkdebugRule, active_next);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
emove_rule(error_rule);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (rule->options.inject.once) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE(&s->activ=
e_rules, rule, BlkdebugRule,
>>> active_next);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remove_rule(rule);
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error && !immediately=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
io_co_schedule(qemu_get_current_aio_context(),
>>> qemu_coroutine_self());
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q=
emu_coroutine_yield();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (error && !immediately) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_co_schedule(qemu_get_=
current_aio_context(),
>>> qemu_coroutine_self());
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_yield();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -error;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> Bit messy as a diff, but it seems to check out. As a bonus we now
>> actually check the tag of the rules we're iterating through, so that
>> seems like an improvement.
>=20
>=20
> Unfortunately git made a bit of a mess out of the diff.
>=20
>>
>> Reviewed-By: John Snow <jsnow@redhat.com>
>>
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return -error;
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static int coroutine_fn
>>>
