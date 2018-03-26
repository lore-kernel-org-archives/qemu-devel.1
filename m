Received: from eggs.gnu.org ([2001:4830:134:3::10]:46859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0YJ5-0004nX-JO
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0YJ0-0007vc-1q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:01:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0YIz-0007vN-Kb
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8B55406F890
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 20:01:17 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-4-peterx@redhat.com>
	<CAMxuvawX2yzMpMYNsB6b-8NP6iXm-ugjE5TUgj5KkgiEEUApFA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5264932f-c86d-4b32-2f75-40c81263c5fd@redhat.com>
Date: Mon, 26 Mar 2018 15:01:12 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvawX2yzMpMYNsB6b-8NP6iXm-ugjE5TUgj5KkgiEEUApFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/8] monitor: new parameter "x-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 04:10 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Mar 26, 2018 at 8:38 AM, Peter Xu <peterx@redhat.com> wrote:
>> Add new parameter to optionally enable Out-Of-Band for a QMP server.
>>
>> An example command line:
>>
>>    ./qemu-system-x86_64 -chardev stdio,id=3Dchar0 \
>>                         -mon chardev=3Dchar0,mode=3Dcontrol,x-oob=3Don
>>
>> By default, Out-Of-Band is off.
>>
>> It is not allowed if either MUX or non-QMP is detected, since
>> Out-Of-Band is currently only for QMP, and non-MUX chardev backends.

Worth documenting in the commit message at least that even when OOB is=20
enabled, the client must STILL opt-in to using it by replying correctly=20
to qmp_capabilities, as well as mention that in the future, we may=20
remove x-oob and rely on JUST qmp_capabilities for enabling OOB.


>> @@ -4568,12 +4569,26 @@ static void monitor_qmp_setup_handlers_bh(void=
 *opaque)
>>   void monitor_init(Chardev *chr, int flags)
>>   {
>>       Monitor *mon =3D g_malloc(sizeof(*mon));
>> +    bool use_readline =3D flags & MONITOR_USE_READLINE;
>> +    bool use_oob =3D flags & MONITOR_USE_OOB;
>> +
>> +    if (use_oob) {
>> +        if (CHARDEV_IS_MUX(chr)) {
>> +            error_report("Monitor Out-Of-Band is not supported with "
>> +                         "MUX typed chardev backend");
>> +            exit(1);
>> +        }
>> +        if (use_readline) {
>> +            error_report("Monitor Out-Of-band is only supported by QM=
P");
>> +            exit(1);

Should these two checks be swapped?  Otherwise, if you use a MUX-typed=20
chardev for HMP, the message implies that switching chardev backend=20
might make it work, even though if you actually do that you'd then get=20
the failure for not being QMP.

>> +        }
>> +    }
>=20
> I would rather see the error reporting / exit in vl.c:mon_init_func()
> function, to have a single place for exit()

To do that, monitor_init() should change signatures to take Error=20
**errp.  Probably worth doing if you spin a v2 of this series (adding=20
the parameter can be done as a separate patch, although there are only 5=20
callers in the tree so adjusting the callers at the same time is=20
probably not that hard to review).

>=20
> Other than that, it looks fine.
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Okay, I'll see how my review goes on the rest of the series before=20
deciding whether to request a v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
