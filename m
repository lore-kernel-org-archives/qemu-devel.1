Received: from eggs.gnu.org ([2001:4830:134:3::10]:35768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp7r-00028s-DG
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp7p-0005g2-SW
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:16:43 -0400
References: <20170314154315.17869-1-famz@redhat.com>
	<bcb24567-c232-803d-a316-c9f285494583@redhat.com>
	<e2b629be-1d0f-5fda-54a9-b3bce4e21416@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d9cfbc1-ef11-7bbb-d7e5-dd0280076a28@redhat.com>
Date: Tue, 14 Mar 2017 11:16:34 -0500
MIME-Version: 1.0
In-Reply-To: <e2b629be-1d0f-5fda-54a9-b3bce4e21416@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7KtVgW658oVrBbX80WP7m0vtrLbNiXUmu"
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7KtVgW658oVrBbX80WP7m0vtrLbNiXUmu
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <0d9cfbc1-ef11-7bbb-d7e5-dd0280076a28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
References: <20170314154315.17869-1-famz@redhat.com>
 <bcb24567-c232-803d-a316-c9f285494583@redhat.com>
 <e2b629be-1d0f-5fda-54a9-b3bce4e21416@redhat.com>
In-Reply-To: <e2b629be-1d0f-5fda-54a9-b3bce4e21416@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 11:14 AM, Eric Blake wrote:
> On 03/14/2017 11:11 AM, Eric Blake wrote:
>> On 03/14/2017 10:43 AM, Fam Zheng wrote:
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> ---
>>>  block/file-posix.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index c4c0663..e6170f4 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -703,6 +703,7 @@ static int hdev_get_max_segments(const struct sta=
t *st)
>>
>> hdev_get_max_segments() is not part of master yet; should this just be=

>> treated as a fixup! to a pending patch?
>=20
> Scratch that - I forgot to 'git pull' on my end.
>=20
> Commit message could usefully be improved by mentioning commit 9103f1ce=

> as the spot the problem was introduced.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Question: does valgrind or any other tool complain about:

+    if (fd =3D=3D -1) {
+        ret =3D -errno;
+        goto out;
+    }
=2E..
+out:
+    close(fd);
+    g_free(sysfspath);
+    return ret;

this being a useless syscall to close(-1) ?  If so, you need to wrap in
an 'if (fd !=3D -1)'

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7KtVgW658oVrBbX80WP7m0vtrLbNiXUmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBdiAAoJEKeha0olJ0NqG50H/AzYVyavz5vlrh+riNox31mz
3B9Mp3+Q1Bg6/KZJ46fgmO+9Ie14qXXwQcUey5niw+PjBqXKp+9SK5Zh0SZo+gQW
ZhhCoB0oyGR8pHY+mlIXHexnOInRfe2Bl+IX+R+nbSpJEBQ9xM8hPVP8xQgWwYeh
76LHipngFvvWyqmHcm2VP9zjCFBDPXONMHzy1D9tihGrGvWkvgOmpXihI+RhXsR6
65dqraxzEWrtERRCB1sEfKm//BC7p4fdodDbO0xdzUep8sbBOwaRQp4fH80qrWHq
nhRe+IZc7lJuCIewAgu34Af2/0aWucsEbQOrYMaoqWOv+EiqG9gNOL67m+9aIqc=
=gsM2
-----END PGP SIGNATURE-----

--7KtVgW658oVrBbX80WP7m0vtrLbNiXUmu--
