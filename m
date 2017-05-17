Received: from eggs.gnu.org ([2001:4830:134:3::10]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB0sT-000674-0P
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB0sP-00025j-QC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB0sP-00025Y-HY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:28:37 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
	<6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
	<57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
Date: Wed, 17 May 2017 10:28:33 -0500
MIME-Version: 1.0
In-Reply-To: <57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6WJqu9fT5IFrJcknxr3tKbGpd3DSdMUdq"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6WJqu9fT5IFrJcknxr3tKbGpd3DSdMUdq
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <2c0e99ce-f3cb-90e8-baed-8fad9d39455b@redhat.com>
Subject: Re: [PATCH v4 4/4] fsdev: QMP interface for throttling
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
 <6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
 <57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
In-Reply-To: <57a24e21-0864-16d3-1bce-ad801875ea9f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 09:53 AM, Pradeep Jagadeesh wrote:

>>> +#ifdef _WIN64
>>> +
>>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
>>> +{
>>> +  return;
>>> +}
>>> +
>>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
>>> +{
>>> +    abort();
>>> +}
>>> +
>>> +#endif
>>
>> I think you're missing an addition to monitor.c
>> qmp_unregister_commands_hack() if you intend for this command to be
>> available only on non-windows platforms (and is your #ifdef the correc=
t
>> name, or is this a Linux-only feature rather than a non-windows featur=
e).
> I had to add this one here because, I was getting some error when I
> cross compile for Windows. But I do not have any idea about, do I need
> to add in monitor.c or not.

First point: is fsdev a Linux-only feature, or can it be compiled on
BSD?  If it is Linux-only, then compiling a stub for Windows will still
leave BSD broken, and your #ifdef is wrong.  Fixing compilation on mingw
is nice, but not the only platform to worry about.

Second point: if fsdev is indeed a platform-specific feature, then we
don't want to advertise the QMP commands that are useless when running
on a platform that doesn't support it. Anywhere you have to add a stub
for compilation means you ALSO need to patch monitor.c to unregister the
command from being advertised as a valid QMP command.  (If you used
#ifdef __LINUX__ to guard the working version, and #ifndef __LINUX__ to
declare the stub, then the monitor.c needs an #ifndef section within
qmp_unregister_commands_hack() to tell QMP to not advertise the stubs.)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6WJqu9fT5IFrJcknxr3tKbGpd3DSdMUdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHGwiAAoJEKeha0olJ0Nq8XcIAJKRTncfbNzOdHSOxbiUYr37
4bDHS/LsNuvlzOfWOAED/oukpfsrui1br39eyOSwFPCcuQZ+0T6E5tIOjvlmIqvc
7cO6fGuzuSV1M0OtVheb++Ab6HwTjlEEboLEUNx6wCjDhCBOLW4KPmmP5/lyqW9b
bVIFmFiC1wC3SSsL6mCbWNn/ONgKBXuUx2GLvTNXqpKOAZGb6N1S61G5NgBE5g4y
djS7KObRyocAUgYgjusntw0Z5qvBcnp0rnSzfMaubPu5eMJCSw2ZFbqLr8bCxCBP
Z4vFo1bjWwAIEbFByCXs5bBdDLPO1XzGtrl/dW0dJt5tYEyJ6LT+/Qa3j3R+RsY=
=vZR3
-----END PGP SIGNATURE-----

--6WJqu9fT5IFrJcknxr3tKbGpd3DSdMUdq--
