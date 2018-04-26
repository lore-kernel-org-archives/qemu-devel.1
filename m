Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBlIn-0003GY-42
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBlIi-0004T6-Qs
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:07:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBlIi-0004T1-Ji
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:07:24 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
	<60a2650a-ff36-1641-51b1-5c5b1a36f18a@redhat.com>
	<23266.4013.789190.625834@mariner.uk.xensource.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d570f1f7-0db7-cbfb-6a13-eae66263555c@redhat.com>
Date: Thu, 26 Apr 2018 13:07:16 -0500
MIME-Version: 1.0
In-Reply-To: <23266.4013.789190.625834@mariner.uk.xensource.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kg7WsmI0STDx7KYYjPB0UIUdds9ClIJVz"
Subject: Re: [Qemu-devel] [RFC PATCH 3/7] error reporting: Use
 error_report_errno in obvious places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@citrix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "=?UTF-8?Q?Daniel_P.Berrang=c3=a9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kg7WsmI0STDx7KYYjPB0UIUdds9ClIJVz
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@citrix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, =?UTF-8?Q?Daniel_P.Berrang=c3=a9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <d570f1f7-0db7-cbfb-6a13-eae66263555c@redhat.com>
Subject: Re: [RFC PATCH 3/7] error reporting: Use error_report_errno in
 obvious places
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-4-git-send-email-ian.jackson@eu.citrix.com>
 <60a2650a-ff36-1641-51b1-5c5b1a36f18a@redhat.com>
 <23266.4013.789190.625834@mariner.uk.xensource.com>
In-Reply-To: <23266.4013.789190.625834@mariner.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 12:43 PM, Ian Jackson wrote:
> Eric Blake writes ("Re: [RFC PATCH 3/7] error reporting: Use error_repo=
rt_errno in obvious places"):
>> Misses a lot of two-line instances, such as:
>> $ git grep -A1 error_report | grep -C1 strerror.errno
>> ...
> ...
>> If we're going to clean up these instances, we might as well look hard=
er
>> for them.  Can Coccinelle be coaxed into helping us (at least for
>> identifying callsites, even if I can't figure out how to make it
>> slice-and-dice format strings)?
>=20
> I have never used Coccinelle, so I don't know.

It was quite easy to detect spots that would benefit from this pattern;
I'm less certain about getting Coccinelle to rewrite them, but at least
knowing where they are makes it easier to ensure you aren't missing
obvious candidates:

$ cat error_report.cocci
@@
expression E;
@@
* error_report(..., strerror(E))

$ spatch --sp-file error_report.cocci \
  --macro-file scripts/cocci-macro-file.h --dir . 2>/dev/null \
  grep -c error_report
149

Between patch 2 and 5, I thus see 149 instances of a call to strerror()
embedded as the last parameter to error_report(), which is more than you
found.

As an example, the tail of the Coccinelle output shows the one in
block/file-posix.c that I demonstrated that you missed, plus the one in
util/osdep.c that your simpler perl script caught:

=2E..
--- ./block/file-posix.c
+++ /tmp/nothing/block/file-posix.c
@@ -1762,8 +1762,6 @@ static int raw_regular_truncate(int fd,
 out:
     if (result < 0) {
         if (ftruncate(fd, current_length) < 0) {
-            error_report("Failed to restore old file length: %s",
-                         strerror(errno));
         }
     }

diff -u -p ./util/osdep.c /tmp/nothing/util/osdep.c
--- ./util/osdep.c
+++ /tmp/nothing/util/osdep.c
@@ -89,7 +89,6 @@ static int qemu_mprotect__osdep(void *ad
     return 0;
 #else
     if (mprotect(addr, size, prot)) {
-        error_report("%s: mprotect failed: %s", __func__, strerror(errno=
));
         return -1;
     }
     return 0;


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kg7WsmI0STDx7KYYjPB0UIUdds9ClIJVz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriFVQACgkQp6FrSiUn
Q2qaiAf/diknlTSgyQDkSFdPh+JCOOgwUWFRUcNwNeLuxBb9L8PiBRMd08tn5mvp
7H7Zu4uGMDBlsYKnemwxdyhzrPgZW5HgMZxPsiiAQ5MeCjzx2icS3wKGbFmUs5Zd
QkgyTC2/Ra+vWdpRxySJKRW/x1Xa/D3GlTNUd09wkRE0v/T4ZJyMxXGM4wboUwcQ
xAei0mNKciT1I0x1r5R3yLZpi98SpMAPEEilkEENzLM+g1HCW5sxcmESSnv1xL+p
6P0ZR3uHQEaI4cSLoBxcU6CGbYonKVxMBOYxJzSz4+yOG+x31/l7bFOjh6QYZHIj
dfctzAxbUX6hiKQTgPcCQY2BF5XxPw==
=wJ14
-----END PGP SIGNATURE-----

--kg7WsmI0STDx7KYYjPB0UIUdds9ClIJVz--
