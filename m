Received: from eggs.gnu.org ([2001:4830:134:3::10]:43984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUD0-0004Af-Ve
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUCw-0001t9-7r
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cwUCv-0001sa-RG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:45:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3250201FB
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:45:44 +0000 (UTC)
References: <20170406210917.6896-1-eblake@redhat.com>
	<20170407093508.GD26896@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2e681c9-5e17-5423-5f8f-e04cd80ef97a@redhat.com>
Date: Fri, 7 Apr 2017 08:45:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170407093508.GD26896@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G7GmXEJWPQOJibAu9VhwDb06JoorI8Bb6"
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G7GmXEJWPQOJibAu9VhwDb06JoorI8Bb6
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <d2e681c9-5e17-5423-5f8f-e04cd80ef97a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
References: <20170406210917.6896-1-eblake@redhat.com>
 <20170407093508.GD26896@redhat.com>
In-Reply-To: <20170407093508.GD26896@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 04:35 AM, Daniel P. Berrange wrote:
> On Thu, Apr 06, 2017 at 04:09:17PM -0500, Eric Blake wrote:
>> qemu_kill_report() is already able to tell whether a shutdown
>> was triggered by guest action (no output) or by a host signal
>> (a message about termination is printed via error_report); but
>> this information is then lost.  Libvirt would like to be able
>> to distinguish between a SHUTDOWN event triggered solely by
>> guest request and one triggered by a SIGTERM on the host.
>>
>> Enhance the SHUTDOWN event to pass the value of shutdown_signal
>> through to the monitor client, suitably remapped into a
>> platform-neutral string.  Note that mingw lacks decent signal
>> support, and will never report a signal because it never calls
>> qemu_system_killed().
>=20
> Is it conceivable that we find a non-signal based way to distinguish
> guest initiated shutdown, from host OS initiated kill when on Win32 ?
>=20
> If so, rather than including a 'signal' field in the event, it might
> be better to just have a 'source': 'host|guest' field. ie we would
> indicate /who/ initiated the shutdown, rather than /how/ it was
> initiated.
>=20
> Or perhaps we should include both the who & the how ?

It's always something that can be extended later (possibly by even
adding an 'unknown' to the how, if there is no real signal name for
mingw).  The 'who' is kind of implied by the presence or absence of the
optional 'how', and even though mingw doesn't have SIGHUP, it DOES have
SIGINT (C requires that), so it is still probably that someone
interested enough could wire up Ctrl-C on mingw host to trigger 'int' as
the 'how', rather than the current situation of Ctrl-C presumably doing
nothing and 'how' never being reported.  (I haven't ever actually tried
to run a guest with mingw as the host, to know if Ctrl-C even works...)

>> @@ -1852,8 +1867,8 @@ static bool main_loop_should_exit(void)
>>          qemu_system_suspend();
>>      }
>>      if (qemu_shutdown_requested()) {
>> -        qemu_kill_report();
>> -        qapi_event_send_shutdown(&error_abort);
>> +        ShutdownSignal ss =3D qemu_kill_report();
>> +        qapi_event_send_shutdown(ss < SHUTDOWN_SIGNAL__MAX, ss, &erro=
r_abort);
>>          if (no_shutdown) {
>>              vm_stop(RUN_STATE_SHUTDOWN);
>>          } else {
>=20
> If any to the above question means we keep '*signal', then consider thi=
s
>=20
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>=20

I still think for Unix-y hosts that '*signal' is useful (some people DO
care whether it was SIGTERM vs. SIGHUP that caused qemu to shutdown,
especially if the two signals are sent by two different agents and can
therefore let the management distinguish which agent asked for the guest
to be killed).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--G7GmXEJWPQOJibAu9VhwDb06JoorI8Bb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY55gBAAoJEKeha0olJ0NqxkoH/ArD6DcmvxlcgHlPT2NLQ6dZ
achFtt8MCEWoaosMsGyn0AQkiMOFBQHVcXMJrfnlgzWG2g41++MYx05zpVeZnj3B
vGNE0629fbNXCu8bhlRjBdss7dC+BFgwVKyQkZw/m+GtjCUOPRJRhAU+r0CexQzj
DkNykNp+7T3HyToC6trhb9XlmsAM1XChe1Q/Tsmp249fNHWDwGaFpc7LxqHGfWHi
gKpmc4y83fRfdh1HC5gtZEFsGz73wY8DoMQ2C47WfN0eHcIkhtsZ7EHX6k2LBzV5
CfhMSjFJ8C70Q2Gba76XP2AzMkQLQPqL9DYuGbKXCCskpRu6XiBEsjXWAA++JjU=
=LdJp
-----END PGP SIGNATURE-----

--G7GmXEJWPQOJibAu9VhwDb06JoorI8Bb6--
