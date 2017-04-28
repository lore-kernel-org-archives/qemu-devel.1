Received: from eggs.gnu.org ([2001:4830:134:3::10]:55490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4ETJ-0004Zy-Tt
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4ETF-0007B5-7P
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:34:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d4ETE-0007Ae-Tk
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 18:34:37 -0400
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
	<87wpa4bnlo.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a45fe48a-5136-35e9-221d-a23939a31202@redhat.com>
Date: Fri, 28 Apr 2017 17:34:28 -0500
MIME-Version: 1.0
In-Reply-To: <87wpa4bnlo.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6wnIIrEKkA61DtIhPSeHcNiKsJfmhLK12"
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, alistair.francis@xilinx.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wnIIrEKkA61DtIhPSeHcNiKsJfmhLK12
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 alistair.francis@xilinx.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <a45fe48a-5136-35e9-221d-a23939a31202@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an enum
 in reset/shutdown_request
References: <20170428021317.24711-1-eblake@redhat.com>
 <20170428021317.24711-3-eblake@redhat.com>
 <87wpa4bnlo.fsf@dusky.pond.sub.org>
In-Reply-To: <87wpa4bnlo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 09:42 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> We want to track why a guest was shutdown; in particular, being able
>> to tell the difference between a guest request (such as ACPI request)
>> and host request (such as SIGINT) will prove useful to libvirt.
>> Since all requests eventually end up changing shutdown_requested in
>> vl.c, the logical change is to make that value track the reason,
>> rather than its current 0/1 contents.
>>
>> Since command-line options control whether a reset request is turned
>> into a shutdown request instead, the same treatment is given to
>> reset_requested.
>>
>> This patch adds a QAPI enum ShutdownCause that describes reasons
>> that a shutdown can be requested, and changes qemu_system_reset() to
>> pass the reason through, although for now it is not reported.  The
>> next patch will actually wire things up to modify events to report
>> data based on the reason, and to pass the correct enum value in from
>> various call-sites that can trigger a reset/shutdown.  Since QAPI
>> generates enums starting at 0, it's easier if we use a different
>> number as our sentinel that no request has happened yet.  Most of
>> the changes are in vl.c, but xen was using things externally.
>>

>> -static int reset_requested;
>> -static int shutdown_requested, shutdown_signal;
>> +static int reset_requested =3D -1;
>> +static int shutdown_requested =3D -1, shutdown_signal;
>=20
> Peeking ahead, I see that shutdown_requested and reset_requested take
> ShutdownCause values and -1.  The latter means "no shutdown requested".=

> What about adding 'none' to ShutdownCause, with value 0, und use that
> instead of literal -1?  Would avoid the unusual "negative means false,
> non-negative means true".

Works nicely if the enum is internal-use only.  Gets a bit more awkward
if the enum is exposed to the end-user.

The fact that I let QAPI generate the enum in patch 3 is evidence that
I'm leaning towards exposing it to the end user (patch 4); if we want to
keep it internal-only, a better place for the enum might be in sysemu.h
(where we also have the weird '#define VMRESET_SILENT false' '#define
VMRESET_REPORT true' to name a boolean parameter).

>=20
> PATCH 4 exposes ShutdownCause in event SHUTDOWN, and 'none' must not
> occur there.  However, if we ever add a query-shutdown to go with this
> event, we will need 'none' there.

So, query-shutdown would basically be: what is the last-reported
shutdown event (normally none, when the guest is still running; but if,
like libvirt, you start qemu -no-shutdown, it can then be the cause of
why we are in a shutdown/stopped state while waiting for final cleanup)?

How important/likely is such an event?  (Hmm, from libvirt's
perspective, events are usually reliable, but can be lost; if we can
restart libvirtd and reconnect to a qemu process that is hanging on to
life only because no one has cleaned it up yet, query-shutdown does seem
like a useful thing for libvirt to have at the time it reconnects to
that qemu process).

We could always include 'none' in the QAPI enum, then document in
'SHUTDOWN' and 'RESET' events that the cause will never be 'none'.  Doc
hacks like that feel a little unclean, but not so horrible as to be
unforgivable.

>=20
> I'd be tempted to reshuffle declarations here, because shutdown_signal'=
s
> int is a different one than reset_requested's and shutdown_requested,
> and the latter two's "negative means false, non-negative means true" is=

> unusual enough to justify a comment.
=2E..
>=20
> Hmm.  In case we stick to literal -1: consider splitting this patch int=
o
> a part that changes @shutdown_requested from zero/non-zero to
> negative/non-negative, and a part that uses ShutdownCause for the
> non-negative values.


You're definitely right that if the enum doesn't have a nice none=3D0
state, then reshuffling to the magic -1 as no request is awkward enough
to be done alone.

But part of the answer is also dependent on whether we want PATCH 4 or
not (or, as you brought up, the possibility of a query-shutdown command
with even more persistent storage of the last-reported event).


>> @@ -1650,11 +1650,11 @@ static void qemu_kill_report(void)
>>  static int qemu_reset_requested(void)
>>  {
>>      int r =3D reset_requested;
>> -    if (r && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
>> -        reset_requested =3D 0;
>> +    if (r >=3D 0 && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
>> +        reset_requested =3D -1;
>>          return r;
>>      }
>> -    return false;
>> +    return -1;
>=20
> "return false" in a function returning int smells, good riddance.
>=20

In one of my earlier drafts of the patch, I even tried to change the
return type from int to bool, but decided that keeping it as int worked
best (if I have to use the -1/cause dichotomy).  But you're also right
that with a 'none' value in the enum, I could directly return ShutdownCau=
se.

>>  }
>>
>>  static int qemu_suspend_requested(void)
>> @@ -1686,7 +1686,12 @@ static int qemu_debug_requested(void)
>>      return r;
>>  }
>>
>> -void qemu_system_reset(bool report)
>> +/*
>> + * Reset the VM. If @report is VMRESET_REPORT, issue an event, using
>> + * the @reason interpreted as ShutdownType for details.  Otherwise,
>> + * @report is VMRESET_SILENT and @reason is ignored.
>> + */
>> +void qemu_system_reset(bool report, int reason)
>=20
> Why int reason and not ShutdownCause?  Hmm, peeking ahead, I see you
> pass -1 with VMRESET_SILENT.  Yet another place where you use int for
> type ShutdownCause + { -1 }.  Adding 'none' to ShutdownCause looks
> even more attractive to me now.

Yeah, it's getting to be that way to me to, even if it just means that I
may have volunteered myself into writing a query-shutdown QMP command.

>> @@ -1738,9 +1744,10 @@ void qemu_system_guest_panicked(GuestPanicInfor=
mation *info)
>>  void qemu_system_reset_request(void)
>>  {
>>      if (no_reboot) {
>> -        shutdown_requested =3D 1;
>> +        /* FIXME - add a parameter to allow callers to specify reason=
 */
>=20
> FIXME addressed in the next patch.  Mention in this one's commit
> message?

Sure. Something like "Mark a couple of places as FIXME where we have to
guess a value to use; a later patch will fix things to supply a correct
value".

>=20
>> +        shutdown_requested =3D SHUTDOWN_CAUSE_GUEST_RESET;

I've also debated about splitting patch 3 into two parts: the event
member additions (affecting .json and vl.c) and the parameter additions
(affecting all other call-sites).  If I add the event parameter first,
then supplying a bogus value to the event means extra churn to qemu
iotests output files unless I change THIS line of code to guess
SHUTDOWN_CAUSE_HOST_QMP; the other option is to wire up parameter
passing first and event reporting last.

I'll wait for more inputs before respinning this series (I already did a
poor enough job slamming mailboxes by sending 3 iterations of the series
in one day).  As you mention, I'd still like to hear ideas for the
replay side of things, and I wouldn't mind if Dan has any ideas from the
libvirt/upper-layer stack usage side of things on the fate of patch 4.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6wnIIrEKkA61DtIhPSeHcNiKsJfmhLK12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA8N0AAoJEKeha0olJ0NqHScIAKtt6O/N4SCVpGjJf1XS7OM+
+XoQWx019t65y/GCNbYLcPlFbR2cIMt8i5BF4oMhjxnY9dWIGPSrcj9p1XMeMkjr
/2mvUBmzpqa5CX2BgHAE4ZR1OTMKz/6HjV2iHrU+nt90+Jxd3iOt5Pbsh0oxQ5DD
mHrxRRoGoC8TXKnmu2qVuGaMK3YCk6YPnbTR2WEB66IA4C9l4NwMLwCSTeHH1on2
1tCPmJdQNxcGh7t+/+G+VG6p6GHpyHl/l3eDCqaWK6Ml6WzcyaLzycr2L1HAyUsj
JsFHIlHqDfm7TXDQlKiQB6hntRG7JqZis5U3rbgkrldyMTf/aNa6yGQZNLxagDw=
=Vk9F
-----END PGP SIGNATURE-----

--6wnIIrEKkA61DtIhPSeHcNiKsJfmhLK12--
