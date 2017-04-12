Received: from eggs.gnu.org ([2001:4830:134:3::10]:50246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyI7A-0003wP-Fe
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyI75-0007sW-PJ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cyI75-0007sD-Hl
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:15:11 -0400
References: <20170406210917.6896-1-eblake@redhat.com>
	<877f2pnb2t.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
Date: Wed, 12 Apr 2017 08:15:07 -0500
MIME-Version: 1.0
In-Reply-To: <877f2pnb2t.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X77vaS37Le9I1DXN08WT56jsBN8jlmGpa"
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X77vaS37Le9I1DXN08WT56jsBN8jlmGpa
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Message-ID: <70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
References: <20170406210917.6896-1-eblake@redhat.com>
 <877f2pnb2t.fsf@dusky.pond.sub.org>
In-Reply-To: <877f2pnb2t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 06:02 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
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
>=20
> I understand the desire to distinguish between guest-initiated and
> host-initiated shutdown, but I'm not sure why libvirt (or anyone) would=

> care for the exact signal.  Can you explain?

If we don't care about the signal itself, a simple boolean (host vs.
guest) is just as easy to code up.  Or even code up a boolean now, and
then add signal information down the road if someone has a use case for
it (as Dan said, libvirt doesn't care, but someone on top of libvirt
might - but I haven't identified such a user at this point in time).

>=20
>>                           Note that mingw lacks decent signal
>> support, and will never report a signal because it never calls
>> qemu_system_killed().
>=20
> Awkward.
>=20

> In other words, these three signals are polite requests to terminate
> QEMU.
>=20
> Stefan, are there equivalent requests under Windows?  I guess there
> might be one at least for SIGINT, namely whatever happens when you hit
> ^C on the console.

Mingw has SIGINT (C99 requires it), and that's presumably what happens
for ^C,...

>=20
> Could we arrange to run qemu_system_killed() then?

=2E..but I don't know why it is not currently wired up to call
qemu_system_killed(), nor do I have enough Windows programming expertise
to try and write such a patch. But I think that is an orthogonal
improvement.  On the other hand, mingw has a definition for SIGTERM (but
I'm not sure how it gets triggered) and no definition at all for SIGHUP
(as evidenced by the #ifdef'fery in the patch to get it to compile under
docker targetting mingw).

>=20
> If not, could we at least distinguish between guest-initiated and
> host-initiated shutdown?
>=20
>> See also https://bugzilla.redhat.com/1384007
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  qapi/event.json | 20 +++++++++++++++++++-
>>  vl.c            | 21 ++++++++++++++++++---
>>  2 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/event.json b/qapi/event.json
>> index e80f3f4..6aad475 100644
>> --- a/qapi/event.json
>> +++ b/qapi/event.json
>> @@ -5,11 +5,29 @@
>>  ##
>>
>>  ##
>> +# @ShutdownSignal:
>> +#
>> +# The list of host signal types known to cause qemu to shut down a gu=
est.
>> +#
>> +# @int: SIGINT
>> +# @hup: SIGHUP
>> +# @term: SIGTERM
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'enum': 'ShutdownSignal', 'data': [ 'int', 'hup', 'term' ] }
>=20
> I'd call them sigint, sighup, sigterm, but it's a matter of taste.

And it goes away if we are okay with a simpler bool of host vs. guest.

>=20
>> +
>> +##
>>  # @SHUTDOWN:
>>  #
>>  # Emitted when the virtual machine has shut down, indicating that qem=
u is
>>  # about to exit.
>>  #
>> +# @signal: If present, the shutdown was (probably) triggered due to
>> +# the receipt of the given signal in the host, rather than by a guest=

>> +# action (note that there is an inherent race with a guest choosing t=
o
>> +# shut down near the same time the host sends a signal). (since 2.10)=

>> +#
>=20
> Is the "(probably)" due to just Windows, or are there other reasons for=

> uncertainty?

There are other reasons too: a guest can request shutdown immediately
before the host sends SIGINT. Based on when things are processed, you
could see either the guest or the host as the initiator.  And the race
is not entirely implausible - when trying to shut down a guest, libvirt
first tries to inform the guest to initiate things (whether by interrupt
or guest agent), but after a given amount of time, assumes the guest is
unresponsive and resorts to a signal to qemu. A heavily loaded guest
that takes its time in responding could easily overlap with the timeout
resorting to a host-side action.


>> -static void qemu_kill_report(void)
>> +static ShutdownSignal qemu_kill_report(void)
>>  {
>> +    ShutdownSignal ss =3D SHUTDOWN_SIGNAL__MAX;
>>      if (!qtest_driver() && shutdown_signal !=3D -1) {
>=20
> Outside this patch's scope: could just as well use 0 instead of -1, as =
0
> can't be a valid signal number (kill() uses it for "check if we could
> kill").

Indeed.

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
> Why not send the event within qemu_kill_report()?

Sure, I can do that in v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--X77vaS37Le9I1DXN08WT56jsBN8jlmGpa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7ihcAAoJEKeha0olJ0NqFrcIAJn9shew+3xNdLsttUvEZMJe
TCuRoq69auZLpFFqe9JqMh67ldgr8XiWv9Lj/ZnDeiW0c3H0L29Qg2bSgenK0Ciu
ZLN4ZEJZsPcgXP9r6mSsIESaC8Ege1V6/sDG2n9RIpqgC2jmjVbFcAbpGxfGdiIY
QRFl+B85AJvgiknthtMsZ//lhnH/K6QeOIN7jRzwdRpT35VRirQDafn9LHX81INT
NbAnypYAPu7cJYTEJ+3yErY78X9M87kuLN942KKCoMv6Yk4Yn58nCoR/Gc4oNRB8
rnm7tkiw2750tLQaVJujv1nfCFTcs6ph0MtM4MQjsgduquOekHK5udWMOW8Rtfw=
=cqwP
-----END PGP SIGNATURE-----

--X77vaS37Le9I1DXN08WT56jsBN8jlmGpa--
