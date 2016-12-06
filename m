Received: from eggs.gnu.org ([2001:4830:134:3::10]:42851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHuH-0001os-EU
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHuG-0003k0-C0
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:43:49 -0500
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
	<20161206100457.GI12630@stefanha-x1.localdomain>
	<f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f10d665-2fc4-8804-a620-f9433b9e524a@redhat.com>
Date: Tue, 6 Dec 2016 09:43:34 -0600
MIME-Version: 1.0
In-Reply-To: <f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KtxeJxN5i4kOpabEjAnWUxdiLBPPo5eul"
Subject: Re: [Qemu-devel] [Qemu-block] [PULL for-2.8 0/3] Block patches for
 -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KtxeJxN5i4kOpabEjAnWUxdiLBPPo5eul
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <9f10d665-2fc4-8804-a620-f9433b9e524a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL for-2.8 0/3] Block patches for
 -rc3
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
 <20161206100457.GI12630@stefanha-x1.localdomain>
 <f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
In-Reply-To: <f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 09:11 AM, Eric Blake wrote:

>> BlockdevOptionsGluster.debug(-level) does not have "Added in 2.8" so I=

>> had to dig through git-blame(1) to verify that it was indeed added in
>> the current release cycle.
>=20
> Then that implies we should add yet one more patch that adds the
> appropriate versioning information to all the gluster fields added for
> 2.8.  My reviewed-by was given on the assumption that debug was in 2.7
> and that this was a break from 2.7 behavior, but that we already KNOW
> we're breaking blockdev-add between 2.7 and 2.8; while your argument is=

> that there is no backwards incompatibility because it was not in 2.7 to=

> begin with.  I think both reasons are indeed acceptable, but it also
> means that my reason was flawed because of the incomplete documentation=
=2E

I checked again.  'git diff v2.7.0..origin qapi/*.json' shows:

 ##
-# @BlockdevOptionsGluster
+# @BlockdevOptionsGluster:
 #
 # Driver specific block device options for Gluster
 #
@@ -2140,7 +2195,9 @@
 #
 # @server:      gluster servers description
 #
-# @debug-level: #optional libgfapi log level (default '4' which is Error=
)
+# @debug:       #optional libgfapi log level (default '4' which is Error=
)
+#
+# @logfile:     #optional libgfapi log file (default /dev/stderr)
(Since 2.8)
 #
 # Since: 2.7
 ##
@@ -2148,25 +2205,163 @@
   'data': { 'volume': 'str',
             'path': 'str',
             'server': ['GlusterServer'],
-            '*debug-level': 'int' } }
+            '*debug': 'int',
+            '*logfile': 'str' } }

So I was right after all - this IS a backwards-incompatible change (and
NOT something that was introduced only in 2.8) - but I still argue that
the change is appropriate NOW (but not later) because blockdev-add is
the only client of this type in QMP, and that command changed
backwards-incompatibly at the same time.

>=20
>>
>> In the future please make sure all QAPI changes are marked by version.=

>=20
> Indeed, and I try to flag it in my reviews as often as I notice it.
>=20
>> If there tricky changes you can include a statement showing you are
>> aware of QAPI backwards compatibility ("These new options were added i=
n
>> the 2.8 release cycle and can therefore still be changed without
>> breaking backward compatibility").  This will make me confident that
>> you've checked the QAPI changes.
>>
>> Thanks, applied to my staging tree:
>> https://github.com/stefanha/qemu/commits/staging

In my audit of all differences between 2.7 and current state of qapi
=2Ejson files, I only found one addition that was lacking versioning
information:

event DEVICE_TRAY_MOVED gained 'id' parameter

I'll submit a patch for that shortly.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KtxeJxN5i4kOpabEjAnWUxdiLBPPo5eul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRtymAAoJEKeha0olJ0NqVWsH/39hJ6cSvVp71QHVmh8WmskF
hONjshq8tEXoqJi1WZVvOZcKcjAxB8FTf91xyn0cAghGpUw8BeSfj1FfzsZDwNWw
VjvFv59zZRKoY1QFJlOznLSLP1MVyNSmqzcZioFedZp2cTBtqTkBTeKlJZNkEibM
nkvGnpJQDsl+d6FVaYehvd7qmaaDyMjCfu/6oxfL3JhOvkRKVce6lqRtbejVXZaC
lDQ1rWwWRNb8ymP36VX8cIcIPYvjefIqrwIVH9u8cyDzLC+j1klhxwJuXzl8s38w
eFGzVQ8/oG1KSpi8mKKnDrx5hX175rEnIXJ4f8ZYLTRwqk268xIELhdzkT4zDB8=
=3/Y2
-----END PGP SIGNATURE-----

--KtxeJxN5i4kOpabEjAnWUxdiLBPPo5eul--
