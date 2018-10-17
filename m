Received: from eggs.gnu.org ([2001:4830:134:3::10]:41363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCjX7-0007qn-7k
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCjX4-0004M0-1M
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCjX3-0004Kf-LE
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:58:29 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
Date: Wed, 17 Oct 2018 12:58:20 +0200
MIME-Version: 1.0
In-Reply-To: <1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
Content-Type: text/plain; charset=utf-8
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
To: Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com

On 17/10/2018 09:17, Dominik Csapak wrote:
> On 10/8/18 3:19 PM, Dominik Csapak wrote:
>> when '-no-reboot' is set, it is interesting if the guest was originall=
y
>> shutdown or reset, so save and return that info=20
>
>=20
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (no_reboot && reason !=3D SHUTDOWN_CA=
USE_SUBSYSTEM_RESET) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shutdown_was_reset =3D true=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shutdown_request=
ed =3D reason;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset_requested =
=3D reason;
> @@ -1807,7 +1809,8 @@ static bool main_loop_should_exit(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request =3D qemu_shutdown_requested();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (request) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_kill_report=
();
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_event_send_shutdown(sh=
utdown_caused_by_guest(request));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_event_send_shutdown(sh=
utdown_caused_by_guest(request),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shutdown_was_reset);

So the problem with shutdown_caused_by_guest is that you get the same
value for both guest reset and guest shutdown.  Could we instead just
pass the ShutdownCause in the event (similar to what was proposed even
when discussing commit 08fba7ac9b618516a5f1d096f78a7e2837fe0594)?

You would get either guest-reset or host-qmp if it's a reset; the same
host-qmp reason could account for both "quit" and "system_reset", but in
practice the caller will know if it has asked for a hard shutdown or a
reset.

Paolo
