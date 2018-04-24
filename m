Received: from eggs.gnu.org ([2001:4830:134:3::10]:53648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB066-0005CK-VW
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB063-0000bi-TA
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fB063-0000bW-Lp
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:11 -0400
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
	<b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
	<23263.17660.17771.980752@mariner.uk.xensource.com>
	<20180424151830.GI20310@redhat.com>
	<baa5df1e-3e65-4213-045a-ca064fb69c3f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e72b98a-5553-5990-2327-c86c75952e87@redhat.com>
Date: Tue, 24 Apr 2018 10:43:09 -0500
MIME-Version: 1.0
In-Reply-To: <baa5df1e-3e65-4213-045a-ca064fb69c3f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UH1yxr9BkEMy5b5h2w3SUW9Q97q4eyV5x"
Subject: Re: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror
 with error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Ian Jackson <ian.jackson@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UH1yxr9BkEMy5b5h2w3SUW9Q97q4eyV5x
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Ian Jackson <ian.jackson@citrix.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Ross Lagerwall <ross.lagerwall@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <1e72b98a-5553-5990-2327-c86c75952e87@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror with
 error_report
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
 <b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
 <23263.17660.17771.980752@mariner.uk.xensource.com>
 <20180424151830.GI20310@redhat.com>
 <baa5df1e-3e65-4213-045a-ca064fb69c3f@redhat.com>
In-Reply-To: <baa5df1e-3e65-4213-045a-ca064fb69c3f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:40 AM, Eric Blake wrote:
> On 04/24/2018 10:18 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
>>>  - static void vreport(report_type type, const char *fmt, va_list ap)=

>>>  + static void vreport(report_type type, int errnoval, const char *fm=
t, va_list ap)
>>> ...
>>>  +     if (errnoval >=3D 0) {
>>>  +         error_printf(": %s", strerror(errnoval);
>>>  +     }
>>>
>>> and then add both
>>>   error_report_errno
>>>   error_vreport_errno
>>> with the obvious semantics.
>>
>> That would be nice, because then we can make these two functions actua=
lly
>> use strerror_r() instead of strerror(), for thread safety on all platf=
orms.
>=20
> Except that strerror_r() is a bear to use portably, given that glibc's
> default declaration differs from the POSIX requirement (you can force
> glibc to give you the POSIX version, but doing so causes you to lose
> access to many other useful extensions).  It's rather telling that 'git=

> grep strerror_r' currently comes up empty.

That said, glib's g_strerror() may be suitable for this purpose,
although we are currently using it only in tests/ivshmem-test.c.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UH1yxr9BkEMy5b5h2w3SUW9Q97q4eyV5x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfUI0ACgkQp6FrSiUn
Q2rdBgf+LpmtzP5RgSpkhUpOM/gnsLjiItbCM87i3yHK2pISN7BQZDguL75ckv+G
mDKusBsKMsmodVymoNGwWICy6VnE7U33/yb/vFgDQug2VFVp5wQXCJFiPlFSYa2D
0knliVdIEIcAxsa3ldOFfSSsp8JKBxSfVl9AKp8f1C1hWb+SGg7MACmGi/+YKmOw
DAbpT0WCtT5GF5uWM8yX1LlpY3Iu0dtjQ5YZyx3oIPMLT2gk4C4pH0ANpnsQyQxO
6OI0L5GZoULp+ET9XS3SF14mkpPZkGic5S1xozUtrtAj87yw0U0Mz+eCzIhyeELb
0Uo5MQ1k6Bowk3UFne/yyiIYAHzhNg==
=czfD
-----END PGP SIGNATURE-----

--UH1yxr9BkEMy5b5h2w3SUW9Q97q4eyV5x--
