Received: from eggs.gnu.org ([2001:4830:134:3::10]:43645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d85yV-0003Wx-Ck
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d85yU-0003yj-6C
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:18:51 -0400
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-6-eblake@redhat.com>
	<87a86mp71i.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e86df300-088c-d1f6-4e5a-c201672820e3@redhat.com>
Date: Tue, 9 May 2017 09:18:41 -0500
MIME-Version: 1.0
In-Reply-To: <87a86mp71i.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SsQsFGeABCoWArnSDupQrocOQLa8fDuXO"
Subject: Re: [Qemu-devel] [PATCH v7 5/5] shutdown: Expose bool cause in
 SHUTDOWN and RESET events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SsQsFGeABCoWArnSDupQrocOQLa8fDuXO
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 alistair.francis@xilinx.com
Message-ID: <e86df300-088c-d1f6-4e5a-c201672820e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 5/5] shutdown: Expose bool cause in
 SHUTDOWN and RESET events
References: <20170508211953.28017-1-eblake@redhat.com>
 <20170508211953.28017-6-eblake@redhat.com>
 <87a86mp71i.fsf@dusky.pond.sub.org>
In-Reply-To: <87a86mp71i.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 07:07 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Libvirt would like to be able to distinguish between a SHUTDOWN
>> event triggered solely by guest request and one triggered by a
>> SIGTERM or other action on the host.  While qemu_kill_report() was
>> already able to give different output to stderr based on whether a
>> shutdown was triggered by a host signal (but NOT by a host UI event,
>> such as clicking the X on the window), that information was then
>> lost to management.  The previous patches improved things to use an
>> enum throughout all callsites, so now we have something ready to
>> expose through QMP.
>>
>> Here is output from 'virsh qemu-monitor-event --loop' with the
>> patch installed:
>>
>> event SHUTDOWN at 1492639680.731251 for domain fedora_13: {"guest":tru=
e}
>> event STOP at 1492639680.732116 for domain fedora_13: <null>
>> event SHUTDOWN at 1492639680.732830 for domain fedora_13: {"guest":fal=
se}
>>
>> Note that libvirt runs qemu with -no-quit: the first SHUTDOWN event
>=20
> Do you mean -no-shutdown?

Oh, right. (Too many synonyms to choose from).

>=20
>> was triggered by an action I took directly in the guest (shutdown -h),=

>> at which point qemu stops the vcpus and waits for libvirt to do any
>> final cleanups; the second SHUTDOWN event is the result of libvirt
>> sending SIGTERM now that it has completed cleanup.
>=20
> The double shutdown is a bit weird.  To avoid it, we'd have to
> distinguish between guest shutdown and QEMU termination.  shutdown -h i=
n
> the guest triggers termination only when QEMU is configured that way.
> SIGTERM triggers shutdown only when the guest is running.  The result
> would be neater, but I'm not sure it's worth the extra effort.

And libvirt is already handling the double event emission - it only
exposes the first event to the end-user (which is the one that will have
the correct guest-vs-host flag); the second event (which will always be
host) is elided because libvirt already knows it passed on the first
event.  So changing it is outside the scope of this series.


>> +++ b/vl.c
>> @@ -1705,8 +1705,8 @@ void qemu_system_reset(ShutdownCause reason)
>>          qemu_devices_reset();
>>      }
>>      if (reason) {
>> -        /* FIXME update event based on reason */
>> -        qapi_event_send_reset(&error_abort);
>> +        qapi_event_send_reset(reason >=3D SHUTDOWN_CAUSE_GUEST_SHUTDO=
WN,
>> +                              &error_abort);
>=20
> Exploits enum ordering.  A comment in the enum definition warning not t=
o
> reorder its members would be in order.  Defining a suitable predicate
> right next to it would do, too.

As in, adding this to sysemu.h?

static inline bool shutdown_caused_by_guest(ShutdownCause cause) {
    return cause >=3D SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
}

I can do that, if you like it.

>=20
> With at least the -no-quit in the commit message fixed (assuming it
> needs fixing):

Yes, it does need fixing.

>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SsQsFGeABCoWArnSDupQrocOQLa8fDuXO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEc/BAAoJEKeha0olJ0NqIcAH/Rei6+pckrPb/99hIlOVhae7
SoEgfVKiMUFsp/r8LO4Zxy5aXs4yDRswOMpVryCicZtt4WAig3kQ4HStFAQNVPSN
D+IoXjWNW6tfjwNT75MAkiaIMoDsSAQXtYRJjTEXjC4GgSsUnCC2sqC8SsKTOt2n
tjssWN7DE/8sxjAJh60M4vvFvlRXQqxP/jPDmREZ2mpI6XR5YspQ0WYfCPz29Gxb
DRHAWJEwH38kxLGePmtW6U53MdmnAq4MyrSZAybtZvQYt+FpTLw+qxW5r9dpix81
AsW7YwHpW5d3qqJ2GOyVbyHvh894F5Ixs2tvY6FsiGMg66S5YsiIfllEQJQdj2c=
=Z+sZ
-----END PGP SIGNATURE-----

--SsQsFGeABCoWArnSDupQrocOQLa8fDuXO--
