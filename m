Received: from eggs.gnu.org ([2001:4830:134:3::10]:55109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gCk5d-00086y-Ha
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gCk5Z-00047d-JA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:34:13 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:29544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gCk5X-0003z3-3h
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:34:07 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
	<d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <d5d914fc-daa1-4164-44ba-a02365a44ddb@proxmox.com>
Date: Wed, 17 Oct 2018 13:34:01 +0200
MIME-Version: 1.0
In-Reply-To: <d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: add info about reset to SHUTDOWN
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com

On 10/17/18 12:58 PM, Paolo Bonzini wrote:
> On 17/10/2018 09:17, Dominik Csapak wrote:
>> On 10/8/18 3:19 PM, Dominik Csapak wrote:
>>> when '-no-reboot' is set, it is interesting if the guest was original=
ly
>>> shutdown or reset, so save and return that info
>>
>>
>>  =C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (no_reboot && reason !=3D SHUTDOWN_=
CAUSE_SUBSYSTEM_RESET) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shutdown_was_reset =3D tru=
e;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shutdown_reque=
sted =3D reason;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset_requeste=
d =3D reason;
>> @@ -1807,7 +1809,8 @@ static bool main_loop_should_exit(void)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request =3D qemu_shutdown_requested();
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (request) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_kill_repo=
rt();
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_event_send_shutdown(s=
hutdown_caused_by_guest(request));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_event_send_shutdown(s=
hutdown_caused_by_guest(request),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shutdown_was_reset);
>=20
> So the problem with shutdown_caused_by_guest is that you get the same
> value for both guest reset and guest shutdown.  Could we instead just
> pass the ShutdownCause in the event (similar to what was proposed even
> when discussing commit 08fba7ac9b618516a5f1d096f78a7e2837fe0594)?
>=20
> You would get either guest-reset or host-qmp if it's a reset; the same
> host-qmp reason could account for both "quit" and "system_reset", but i=
n
> practice the caller will know if it has asked for a hard shutdown or a
> reset.

i would find it nicer to always be able to distinguish between
a reset and a normal exit, since it would be less work on the
management side (i.e. we would have to handle the qmp reset elsewhere
instead of in the same process that monitors the events)

also it would make the 'guest' parameter redundant or change the api and=20
i am not sure about how stable it has to be?
