Received: from eggs.gnu.org ([2001:4830:134:3::10]:49052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLCD4-00077H-9g
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLCCz-0005ZV-DC
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:40:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fLCCz-0005Z2-3q
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:40:29 -0400
References: <20180521084249.10640-1-peterx@redhat.com>
	<8ef2c984-7817-a54f-ebae-a1f14e453b6a@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <810f70e6-4ce7-2ad9-2f20-19fc6df57452@redhat.com>
Date: Tue, 22 May 2018 14:40:26 -0400
MIME-Version: 1.0
In-Reply-To: <8ef2c984-7817-a54f-ebae-a1f14e453b6a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] monitor: turn on Out-Of-Band by default again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>



On 05/21/2018 10:13 AM, Eric Blake wrote:
> On 05/21/2018 03:42 AM, Peter Xu wrote:
>> We turned Out-Of-Band feature of monitors off for 2.12 release.=C2=A0 =
Now we
>> try to turn that on again.
>=20
> "try to turn" sounds weak, like you aren't sure of this patch.=C2=A0 If=
 you
> aren't sure, then why should we feel safe in applying it?=C2=A0 This te=
xt is
> going in the permanent git history, so sound bold, rather than hesitant=
!
>=20
> "We have resolved the issues from last time (commit 3fd2457d reverted b=
y
> commit a4f90923):
> - issue 1 ...
> - issue 2 ...
> So now we are ready to enable advertisement of the feature by default"
>=20
> with better descriptions of the issues that you fixed (I can think of a=
t
> least the fixes adding thread-safety to the current monitor, and fixing
> early use of the monitor before qmp_capabilities completes; there may
> also be other issues that you want to call out).
>=20
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> --=20
>> Now OOB should be okay with all known tests (except iotest qcow2, sinc=
e
>> it is still broken on master),
>=20
> Which tests are still failing for you?=C2=A0 Ideally, you can still
> demonstrate that the tests not failing without this patch continue to
> pass with this patch, even if you call out the tests that have known
> issues to still be resolved.
>=20

Probably 91 and 169. If any others fail that's news to me.

>> and AFAIK now we should also be okay with
>> ARM+Libvirt (not testsed, but Eric Auger helped to verify that before
>> the release).=C2=A0 So I think it's now safe to turn OOB on again.=C2=A0=
 Please
>> feel free to test this against any of existing testsuites to see wheth=
er
>> it'll still break any stuff.=C2=A0 Thanks,
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>> =C2=A0 monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++---=
-------
>> =C2=A0 tests/qmp-test.c |=C2=A0 2 +-
>> =C2=A0 vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 9 ++++-----
>> =C2=A0 3 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 46814af533..ce5cc5e34e 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4560,16 +4560,9 @@ void monitor_init(Chardev *chr, int flags)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool use_readline =3D flags & MONITOR_U=
SE_READLINE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool use_oob =3D flags & MONITOR_USE_OO=
B;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (use_oob) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CHARDEV_IS_MUX(chr)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report("Monitor Out-Of-Band is not supported with "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "MUX typed chardev backend");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ex=
it(1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (use_readline) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report("Monitor Out-Of-band is only supported by
>> QMP");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ex=
it(1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (CHARDEV_IS_MUX(chr)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MUX is still not suppor=
ted for Out-Of-Band */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_oob =3D false;
>=20
> This isn't a mere reinstatement of 3fd2457d, but is now advertising OOB
> when using readline (which presumably is a synonym for using HMP).=C2=A0=
 Is
> that intentional?=C2=A0 If so, the commit message should mention it.
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_data_init(mon, false, us=
e_oob);
>> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
>> index 88f867f8c0..c85a3964d9 100644
>> --- a/tests/qmp-test.c
>> +++ b/tests/qmp-test.c
>> @@ -89,7 +89,7 @@ static void test_qmp_protocol(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(q);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_version(qdict_get(q, "version"));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capabilities =3D qdict_get_qlist(q, "ca=
pabilities");
>> -=C2=A0=C2=A0=C2=A0 g_assert(capabilities && qlist_empty(capabilities)=
);
>> +=C2=A0=C2=A0=C2=A0 g_assert(capabilities);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_unref(resp);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Test valid command before han=
dshake */
>> diff --git a/vl.c b/vl.c
>> index 3b39bbd7a8..b71fb8eb25 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2394,6 +2394,10 @@ static int mon_init_func(void *opaque, QemuOpts
>> *opts, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D MONIT=
OR_USE_READLINE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (strcmp(mode, "control") =3D=3D=
 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D MONIT=
OR_USE_CONTROL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Out-Of-Band is on by de=
fault */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_opt_get_bool(opts=
, "x-oob", 1)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fl=
ags |=3D MONITOR_USE_OOB;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Do we really still need the x-oob property, vs. outright deletion of
> this bandaid?=C2=A0 Then again, I guess keeping it for one more release=
 makes
> it easier to forcefully turn things off for temporary testing when
> isolating whether OOB is a culprit in something breaking.
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("u=
nknown monitor mode \"%s\"", mode);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> @@ -2402,11 +2406,6 @@ static int mon_init_func(void *opaque, QemuOpts
>> *opts, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_opt_get_bool(opts, "pretty", 0=
))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D MONI=
TOR_USE_PRETTY;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* OOB is off by default */
>> -=C2=A0=C2=A0=C2=A0 if (qemu_opt_get_bool(opts, "x-oob", 0)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D MONITOR_USE_OOB=
;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chardev =3D qemu_opt_get(opts, "chardev=
");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chr =3D qemu_chr_find(chardev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chr =3D=3D NULL) {
>>
>=20
