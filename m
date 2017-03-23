Received: from eggs.gnu.org ([2001:4830:134:3::10]:49201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr4yk-0003hR-E4
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr4yh-0001tD-7p
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:48:46 -0400
References: <20170322144525.18964-1-eblake@redhat.com>
	<20170322144525.18964-3-eblake@redhat.com>
	<20170323153753.GF13825@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83bb29d8-0e43-8d1c-2ea8-020f14dda070@redhat.com>
Date: Thu, 23 Mar 2017 10:48:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170323153753.GF13825@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kxsDjc96ev95jDRDqeei1jVucHDqHvNww"
Subject: Re: [Qemu-devel] Possible regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kxsDjc96ev95jDRDqeei1jVucHDqHvNww
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, qemu-stable@nongnu.org
Message-ID: <83bb29d8-0e43-8d1c-2ea8-020f14dda070@redhat.com>
Subject: Re: Possible regression
References: <20170322144525.18964-1-eblake@redhat.com>
 <20170322144525.18964-3-eblake@redhat.com>
 <20170323153753.GF13825@redhat.com>
In-Reply-To: <20170323153753.GF13825@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 10:37 AM, Richard W.M. Jones wrote:
> On Wed, Mar 22, 2017 at 09:45:24AM -0500, Eric Blake wrote:
>> A regression in commit 15c2f669e caused us to silently ignore
>> excess input to the QemuOpts visitor.  Later, commit ea4641
>> accidentally abused that situation, by removing "qom-type" and
>> "id" from the corresponding QDict but leaving them defined in
>> the QemuOpts, when using the pair of containers to create a
>> user-defined object. Note that since we are already traversing
>> two separate items (a QDict and a QemuOpts), we are already
>> able to flag bogus arguments, as in:
>>
>> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdi=
o -object memory-backend-ram,id=3Dmem1,size=3D4k,bogus=3Dhuh
>> qemu-system-x86_64: -object memory-backend-ram,id=3Dmem1,size=3D4k,bog=
us=3Dhuh: Property '.bogus' not found
>>
>> So the only real concern is that when we re-enable strict checking
>> in the QemuOpts visitor, we do not want to start flagging the two
>> leftover keys as unvisited.  Rearrange the code to clean out the
>> QemuOpts listing in advance, rather than removing items from the
>> QDict.  Since "qom-type" is usually an automatic implicit default,
>> we don't have to restore it (this does mean that once instantiated,
>> QemuOpts is not necessarily an accurate representation of the
>> original command line - but this is not the first place to do that);

Well, my assumption that qom-type was not necessary to restore...

> This commit causes a problem for libguestfs:
>=20
>   [02192ms] /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
>   [...]
>       -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
>       -device virtio-rng-pci,rng=3Drng0 \
>   [...]
>   qemu-system-x86_64: -object rng-random,filename=3D/dev/urandom,id=3Dr=
ng0: Parameter 'qom-type' is missing

=2E..was just proven false :(

I should have been more conservative.  I'll post the obvious follow-up
patch that restores qom-type after the temporary removal from the
QemuOpts that is necessary for the duration of the user_creatable_add.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kxsDjc96ev95jDRDqeei1jVucHDqHvNww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0+5XAAoJEKeha0olJ0NqCkkH/jGwOlBsUZ0BKGRw0PZ4Mudu
Zc9DqOHV6/o0PInLeAcDCSgLE8CekqwF9lxHhI0OHsDtnOO515J3N0GBc6lhlySq
B5mNMVxOKIJ285kxTyKLysyhjcVcW17260xzN4AwOPeMftVR+Kzl8+Mox4m7eGun
Rh7PP5WOkqTlrJM8byQwMwaG24J7XQWM4lsf+MBxTaOSI+h6/xvmDR9mAekCwtP7
YLNToW679Ej/Az1evPu3nCdImuFrlwc8oiFEzfXOC91cwkiqRrnVuUtKpVKMwsrD
QLcfce0Wgwouviu5qXAhlrpn0AtzwiW4yHsvZQjCgP/vyfgThnsxez15iHA+6os=
=4UjU
-----END PGP SIGNATURE-----

--kxsDjc96ev95jDRDqeei1jVucHDqHvNww--
