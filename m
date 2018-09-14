Received: from eggs.gnu.org ([2001:4830:134:3::10]:45737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0uzB-0002XK-F5
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 16:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0uz9-0008Q3-1x
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 16:46:41 -0400
References: <1535087186-9643-1-git-send-email-marcolso@amazon.com>
	<1536107089-9829-1-git-send-email-marcolso@amazon.com>
	<b3b33650-0dab-429c-f93d-f9dc651a8fad@amazon.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a6e8c2da-f7bc-2cbb-4b94-d3e1d603b736@redhat.com>
Date: Fri, 14 Sep 2018 16:46:30 -0400
MIME-Version: 1.0
In-Reply-To: <b3b33650-0dab-429c-f93d-f9dc651a8fad@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] blkdebug: Add support for
 latency rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2018 12:48 PM, Marc Olson wrote:
> Are there further thoughts on this patch?
>=20

The CI tools may have missed it since it appears to have been sent in
reply to the V1 instead of as a new thread. When you send a revision
out, can you send it as its own thread?

(We're also in a bit of a logjam at the moment with no pull requests
having been processed recently, so we're a bit gummed up.)

Some comments below.

>=20
> On 09/04/2018 05:24 PM, Marc Olson wrote:
>> Sometimes storage devices can be slow to respond, due to media errors,
>> firmware
>> issues, SSD garbage collection, etc. This patch adds a new rule type t=
o
>> blkdebug that allows injection of latency to I/O operations. Similar
>> to error
>> injection rules, latency rules can be specified with or without an
>> offset, and
>> can also apply upon state transitions.
>>
>> Signed-off-by: Marc Olson <marcolso@amazon.com>
>>
>> ---
>> v2:
>> - Change so that delay rules are executed before error rules
>> - Add QMP support
>> - Add tests
>> ---
>> =C2=A0 block/blkdebug.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 119
>> +++++++++++++++++++++++++++++++++++----------
>> =C2=A0 docs/devel/blkdebug.txt=C2=A0=C2=A0=C2=A0 |=C2=A0 30 +++++++++-=
--
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 39 +++++++++++++--
>> =C2=A0 tests/qemu-iotests/071=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 63 +++++=
+++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/071.out |=C2=A0 31 ++++++++++++
>> =C2=A0 5 files changed, 244 insertions(+), 38 deletions(-)
>>
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 0759452..1785fe3 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -65,6 +65,7 @@ typedef struct BlkdebugSuspendedReq {
>> =C2=A0 =C2=A0 enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACTION_INJECT_ERROR,
>> +=C2=A0=C2=A0=C2=A0 ACTION_DELAY,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACTION_SET_STATE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACTION_SUSPEND,
>> =C2=A0 };
>> @@ -73,14 +74,17 @@ typedef struct BlkdebugRule {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlkdebugEvent event;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int action;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int state;
>> +=C2=A0=C2=A0=C2=A0 int once;
>> +=C2=A0=C2=A0=C2=A0 int64_t offset;

Hm, I guess we're just promoting these to universal values that might
exist for any of the rule types, but not allowing the user to set them
for rules where it doesn't make sense.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int immediately;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t once;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t64_t offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } inject;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t64_t latency;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } delay;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int new_state;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } set_state;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>> @@ -123,6 +127,33 @@ static QemuOptsList inject_error_opts =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 };
>> =C2=A0 +static QemuOptsList delay_opts =3D {
>> +=C2=A0=C2=A0=C2=A0 .name =3D "delay",
>> +=C2=A0=C2=A0=C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(delay_opts.head)=
,
>> +=C2=A0=C2=A0=C2=A0 .desc =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D "event",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D "state",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .t=
ype =3D QEMU_OPT_NUMBER,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D "latency",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .t=
ype =3D QEMU_OPT_NUMBER,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D "sector",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .t=
ype =3D QEMU_OPT_NUMBER,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D "once",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .t=
ype =3D QEMU_OPT_BOOL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* end of list */ }
>> +=C2=A0=C2=A0=C2=A0 },
>> +};
>> +
>> =C2=A0 static QemuOptsList set_state_opts =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "set-state",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(set_s=
tate_opts.head),
>> @@ -145,6 +176,7 @@ static QemuOptsList set_state_opts =3D {
>> =C2=A0 =C2=A0 static QemuOptsList *config_groups[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &inject_error_opts,
>> +=C2=A0=C2=A0=C2=A0 &delay_opts,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &set_state_opts,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>> =C2=A0 };
>> @@ -182,16 +214,21 @@ static int add_rule(void *opaque, QemuOpts
>> *opts, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .state=C2=A0 =3D=
 qemu_opt_get_number(opts, "state", 0),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 rule->once=C2=A0 =3D qemu_opt_get_bool(opts=
, "once", 0);
>> +=C2=A0=C2=A0=C2=A0 sector =3D qemu_opt_get_number(opts, "sector", -1)=
;
>> +=C2=A0=C2=A0=C2=A0 rule->offset =3D sector =3D=3D -1 ? -1 : sector * =
BDRV_SECTOR_SIZE;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Parse action-specific options */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (d->action) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ACTION_INJECT_ERROR:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.i=
nject.error =3D qemu_opt_get_number(opts,
>> "errno", EIO);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject.once=C2=
=A0 =3D qemu_opt_get_bool(opts, "once", 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.i=
nject.immediately =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qemu_opt_get_bool(opts, "immediately", 0);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sector =3D qemu_opt_get_nu=
mber(opts, "sector", -1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.inject.offse=
t =3D
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 se=
ctor =3D=3D -1 ? -1 : sector * BDRV_SECTOR_SIZE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +
>> +=C2=A0=C2=A0=C2=A0 case ACTION_DELAY:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule->options.delay.latenc=
y =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_opt_get_number(opts, "latency", 100) * SCALE_US;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ACTION_SET_STATE:
>> @@ -264,6 +301,14 @@ static int read_config(BDRVBlkdebugState *s,
>> const char *filename,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 d.action =3D ACTION_DELAY;
>> +=C2=A0=C2=A0=C2=A0 qemu_opts_foreach(&delay_opts, add_rule, &d, &loca=
l_err);
>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loca=
l_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.action =3D ACTION_SET_STATE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opts_foreach(&set_state_opts, add_=
rule, &d, &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>> @@ -275,6 +320,7 @@ static int read_config(BDRVBlkdebugState *s, const
>> char *filename,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> =C2=A0 fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opts_reset(&inject_error_opts);
>> +=C2=A0=C2=A0=C2=A0 qemu_opts_reset(&delay_opts);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_opts_reset(&set_state_opts);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (f) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose(f);
>> @@ -473,39 +519,61 @@ out:
>> =C2=A0 static int rule_check(BlockDriverState *bs, uint64_t offset,
>> uint64_t bytes)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVBlkdebugState *s =3D bs->opaque;
>> -=C2=A0=C2=A0=C2=A0 BlkdebugRule *rule =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 BlkdebugRule *rule =3D NULL, *delay_rule =3D NULL,=
 *error_rule =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 int64_t latency;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool immediately;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(rule, &s->activ=
e_rules, active_next) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t inject_offset =3D=
 rule->options.inject.offset;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inject_offset =3D=3D -=
1 ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (b=
ytes && inject_offset >=3D offset &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 inject_offset < offset + bytes))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rule->offset =3D=3D -1=
 ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (b=
ytes && rule->offset >=3D offset &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 rule->offset < offset + bytes))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!error_rule && rule->action =3D=3D ACTION_INJECT_ERROR) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_rule =3D rule;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else if (!delay_rule && rule->action =3D=3D ACTION_DELAY) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 delay_rule =3D rule;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (error_rule && delay_rule) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!rule || !rule->options.inject.error) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (delay_rule) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency =3D delay_rule->op=
tions.delay.latency;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 immediately =3D rule->options.inject.immedi=
ately;
>> -=C2=A0=C2=A0=C2=A0 error =3D rule->options.inject.error;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (delay_rule->once) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QS=
IMPLEQ_REMOVE(&s->active_rules, delay_rule,
>> BlkdebugRule, active_next);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
move_rule(delay_rule);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (rule->options.inject.once) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_REMOVE(&s->active=
_rules, rule, BlkdebugRule,
>> active_next);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remove_rule(rule);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (latency !=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_co_sleep_ns(QEMU_CLOCK_REALTIME, latency);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!immediately) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_co_schedule(qemu_get_c=
urrent_aio_context(),
>> qemu_coroutine_self());
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_yield();
>> +=C2=A0=C2=A0=C2=A0 if (error_rule) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D error_rule->opti=
ons.inject.error;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 immediately =3D error_rule=
->options.inject.immediately;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error_rule->once) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QS=
IMPLEQ_REMOVE(&s->active_rules, error_rule,
>> BlkdebugRule, active_next);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
move_rule(error_rule);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error && !immediately)=
 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ai=
o_co_schedule(qemu_get_current_aio_context(),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qemu_coroutine_self());
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_coroutine_yield();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return -error;
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }

That's a big hunk of stuff all changing at once, it might have been nice
to do this in two passes:

1. refactor the loop to look for error rules, then
2. add login in for the delay rules.

It looks like we change the handling of error rules just a little bit;
before if (!rule->options.inject.error) we return 0 immediately, but now
we actually check for `once` and remove the the rule first.

I think that's probably fine; isn't it? It's not as if the error will
show up if it wasn't there already, so that's probably an improvement.

The delay rule looks fine.

>> =C2=A0 =C2=A0 static int coroutine_fn
>> @@ -694,6 +762,7 @@ static bool process_rule(BlockDriverState *bs,
>> struct BlkdebugRule *rule,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Take the action */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (rule->action) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ACTION_INJECT_ERROR:
>> +=C2=A0=C2=A0=C2=A0 case ACTION_DELAY:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!injected) =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 QSIMPLEQ_INIT(&s->active_rules);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 injected =3D true;
>> diff --git a/docs/devel/blkdebug.txt b/docs/devel/blkdebug.txt
>> index 43d8e8f..1befcf8 100644
>> --- a/docs/devel/blkdebug.txt
>> +++ b/docs/devel/blkdebug.txt
>> @@ -24,7 +24,7 @@ This way, all error paths can be tested to make sure
>> they are correct.
>> =C2=A0 Rules
>> =C2=A0 -----
>> =C2=A0 The blkdebug block driver takes a list of "rules" that tell the
>> error injection
>> -engine when to fail an I/O request.
>> +engine when to fail (inject-error) or add latency to (delay) an I/O
>> request.
>> =C2=A0 =C2=A0 Each I/O request is evaluated against the rules.=C2=A0 I=
f a rule
>> matches the request
>> =C2=A0 then its "action" is executed.
>> @@ -33,17 +33,25 @@ Rules can be placed in a configuration file; the
>> configuration file
>> =C2=A0 follows the same .ini-like format used by QEMU's -readconfig op=
tion,
>> and
>> =C2=A0 each section of the file represents a rule.
>> =C2=A0 -The following configuration file defines a single rule:
>> +The following configuration file defines multiple rules:
>> =C2=A0 =C2=A0=C2=A0=C2=A0 $ cat blkdebug.conf
>> =C2=A0=C2=A0=C2=A0 [inject-error]
>> =C2=A0=C2=A0=C2=A0 event =3D "read_aio"
>> =C2=A0=C2=A0=C2=A0 errno =3D "28"
>> =C2=A0 -This rule fails all aio read requests with ENOSPC (28).=C2=A0 =
Note that
>> the errno
>> -value depends on the host.=C2=A0 On Linux, see
>> +=C2=A0 [delay]
>> +=C2=A0 event =3D "read_aio"
>> +=C2=A0 sector =3D "2048"
>> +=C2=A0 latency =3D "500000"
>> +
>> +The error rule fails all aio read requests with ENOSPC (28).=C2=A0 No=
te
>> that the
>> +errno value depends on the host.=C2=A0 On Linux, see
>> =C2=A0 /usr/include/asm-generic/errno-base.h for errno values.
>> =C2=A0 +The delay rule adds 500 ms of latency to a read I/O request
>> containing sector
>> +2048.
>> +
>> =C2=A0 Invoke QEMU as follows:
>> =C2=A0 =C2=A0=C2=A0=C2=A0 $ qemu-system-x86_64
>> @@ -60,21 +68,27 @@ Rules support the following attributes:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rul=
e to match.=C2=A0 See the "State transitions" section for
>> information
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on =
states.
>> =C2=A0 -=C2=A0 errno - the numeric errno value to return when a reques=
t matches
>> this rule.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The errno valu=
es depend on the host since the numeric
>> values are not
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 standarized in=
 the POSIX specification.
>> -
>> =C2=A0=C2=A0=C2=A0 sector - (optional) a sector number that the reques=
t must overlap
>> in order to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 match this rule
>> =C2=A0 =C2=A0=C2=A0=C2=A0 once - (optional, default "off") only execut=
e this action on the
>> first
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 matching =
request
>> =C2=A0 +Error injection rules support the following attributes:

The section rewrite here actually makes it a little less clear which
rules support which attributes, it might be time for a heavier rewrite.

This is OK for now, though, I think...

>> +
>> +=C2=A0 errno - the numeric errno value to return when a request match=
es
>> this rule.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The errno valu=
es depend on the host since the numeric
>> values are not
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 standarized in=
 the POSIX specification.
>> +
>> =C2=A0=C2=A0=C2=A0 immediately - (optional, default "off") return a NU=
LL BlockAIOCB
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pointer and fail without an errno instead.=
=C2=A0 This
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exercises the code path where BlockAIOCB f=
ails and the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 caller's BlockCompletionFunc is not invoke=
d.
>> =C2=A0 +Delay rules support the following attribute:
>> +
>> +=C2=A0 latency - the delay to add to an I/O request, in microseconds.
>> +
>> =C2=A0 Events
>> =C2=A0 ------
>> =C2=A0 Block drivers provide information about the type of I/O request=
 they
>> are about
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 4c7a37a..819e3f9 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2941,11 +2941,11 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'refblock_alloc_write_blocks',
>> 'refblock_alloc_write_table',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'refblock_alloc_switch_table', 'cluster_alloc',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'f=
lush_to_disk', 'pwritev_rmw_head',
>> 'pwritev_rmw_after_head',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'p=
writev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'p=
writev_zero', 'pwritev_done', 'empty_image_prepare',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'l=
1_shrink_write_table', 'l1_shrink_free_l2_clusters',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'c=
or_write'] }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'f=
lush_to_disk', 'preadv', 'pwritev_rmw_head',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'p=
writev_rmw_after_head', 'pwritev_rmw_tail',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'p=
writev_rmw_after_tail', 'pwritev', 'pwritev_zero',
>> 'pwritev_done',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'e=
mpty_image_prepare', 'l1_shrink_write_table',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'l=
1_shrink_free_l2_clusters', 'cor_write'] }

Is this an unrelated change that snuck in? If it's intentional, you
ought to justify it in a standalone commit with a commit message
containing the rationale.

>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @BlkdebugInjectErrorOptions:
>> @@ -2980,6 +2980,34 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*immediately': 'bool' } }
>> =C2=A0 =C2=A0 ##
>> +# @BlkdebugDelayOptions:
>> +#
>> +# Describes a single latency injection for blkdebug.
>> +#
>> +# @event:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trigger event
>> +#
>> +# @state:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the state identifier bl=
kdebug needs to be in to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 actually trigger the event; defaults to "any"
>> +#
>> +# @latency:=C2=A0=C2=A0=C2=A0=C2=A0 The delay to add to an I/O, in mi=
croseconds.
>> +#
>> +# @sector:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specifies the sector index w=
hich has to be affected
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 in order to actually trigger the event; defaults to "any
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sector"
>> +#
>> +# @once:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disables further e=
vents after this one has been
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 triggered; defaults to false
>> +#
>> +# Since: 3.0

3.1, sorry :)

>> +##
>> +{ 'struct': 'BlkdebugDelayOptions',
>> +=C2=A0 'data': { 'event': 'BlkdebugEvent',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
state': 'int',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
latency': 'int',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
sector': 'int',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
once': 'bool' } }
>> +
>> +##
>> =C2=A0 # @BlkdebugSetStateOptions:
>> =C2=A0 #
>> =C2=A0 # Describes a single state-change event for blkdebug.
>> @@ -3049,6 +3077,7 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*opt-discard': 'int32', '*max-discard': 'int32',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*inject-error': ['BlkdebugInjectErrorOptions'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
delay': ['BlkdebugDelayOptions'],
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*set-state': ['BlkdebugSetStateOptions'] } }
>> =C2=A0 =C2=A0 ##
>> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
>> index 48b4955..3d0610c 100755
>> --- a/tests/qemu-iotests/071
>> +++ b/tests/qemu-iotests/071
>> @@ -100,6 +100,69 @@ $QEMU_IO -c "open -o
>> driver=3D$IMGFMT,file.driver=3Dblkdebug,file.inject-error.event
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'read =
-P 42 0x38000 512'
>> =C2=A0 =C2=A0 echo
>> +echo "=3D=3D=3D Testing blkdebug latency through filename =3D=3D=3D"
>> +echo
>> +
>> +$QEMU_IO -c "open -o
>> file.driver=3Dblkdebug,file.delay.event=3Dwrite_aio,file.delay.latency=
=3D10000
>> $TEST_IMG" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_write -P 42 =
0x28000 512' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_read -P 42 0=
x38000 512' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_qemu_io
>> +
>> +echo
>> +echo "=3D=3D=3D Testing blkdebug latency through file blockref =3D=3D=
=3D"
>> +echo
>> +
>> +$QEMU_IO -c "open -o
>> driver=3D$IMGFMT,file.driver=3Dblkdebug,file.delay.event=3Dwrite_aio,f=
ile.delay.latency=3D10000,file.image.filename=3D$TEST_IMG"
>> \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_write -P 42 =
0x28000 512' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_read -P 42 0=
x38000 512' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_qemu_io
>> +
>> +# Using QMP is synchronous by default, so even though we would
>> +# expect reordering due to using the aio_* commands, they are
>> +# not. The purpose of this test is to verify that the driver
>> +# can be setup via QMP, and IO can complete. See the qemu-io
>> +# test above to prove delay functionality
>> +echo
>> +echo "=3D=3D=3D Testing blkdebug on existing block device =3D=3D=3D"
>> +echo
>> +
>> +run_qemu <<EOF
>> +{ "execute": "qmp_capabilities" }
>> +{ "execute": "blockdev-add",
>> +=C2=A0=C2=A0=C2=A0 "arguments": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node-name": "drive0",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "driver": "file",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": "$TEST_IMG"
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +{ "execute": "blockdev-add",
>> +=C2=A0=C2=A0=C2=A0 "arguments": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "driver": "$IMGFMT",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node-name": "drive0-debug=
",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "file": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "d=
river": "blkdebug",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i=
mage": "drive0",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "d=
elay": [{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "event": "write_aio",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "latency": 10000
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +{ "execute": "human-monitor-command",
>> +=C2=A0=C2=A0=C2=A0 "arguments": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "command-line": 'qemu-io d=
rive0-debug "aio_write 0 512"'
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +{ "execute": "human-monitor-command",
>> +=C2=A0=C2=A0=C2=A0 "arguments": {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "command-line": 'qemu-io d=
rive0-debug "aio_read 0 512"'
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +{ "execute": "quit" }
>> +EOF
>> +
>> +echo
>> =C2=A0 echo "=3D=3D=3D Testing blkdebug on existing block device =3D=3D=
=3D"
>> =C2=A0 echo
>> =C2=A0 diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/07=
1.out
>> index 1d5e28d..1952990 100644
>> --- a/tests/qemu-iotests/071.out
>> +++ b/tests/qemu-iotests/071.out
>> @@ -36,6 +36,37 @@ read failed: Input/output error
>> =C2=A0 =C2=A0 read failed: Input/output error
>> =C2=A0 +=3D=3D=3D Testing blkdebug latency through filename =3D=3D=3D
>> +
>> +read 512/512 bytes at offset 229376
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset 163840
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +
>> +=3D=3D=3D Testing blkdebug latency through file blockref =3D=3D=3D
>> +
>> +read 512/512 bytes at offset 229376
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset 163840
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +
>> +=3D=3D=3D Testing blkdebug on existing block device =3D=3D=3D
>> +
>> +Testing:
>> +QMP_VERSION
>> +{"return": {}}
>> +{"return": {}}
>> +{"return": {}}
>> +wrote 512/512 bytes at offset 0
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +{"return": ""}
>> +read 512/512 bytes at offset 0
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +{"return": ""}
>> +{"return": {}}
>> +{"timestamp": {"seconds":=C2=A0 TIMESTAMP, "microseconds":=C2=A0 TIME=
STAMP},
>> "event": "SHUTDOWN", "data": {"guest": false}}
>> +
>> +
>> =C2=A0 =3D=3D=3D Testing blkdebug on existing block device =3D=3D=3D
>> =C2=A0 =C2=A0 Testing:
>=20
>=20

Thanks, this seems like a good addition to have.

--js
