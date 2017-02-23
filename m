Received: from eggs.gnu.org ([2001:4830:134:3::10]:47444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgwcM-0004Wp-7J
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgwcI-0001nO-CB
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:51:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgwcI-0001md-2j
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:51:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EA0D3A7696
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 16:51:41 +0000 (UTC)
References: <20170223144034.b2bhgsvwfyyymxwk@eukaryote>
	<87ino1gcx2.fsf@dusky.pond.sub.org>
	<20170223163315.w2nekel42grwtbkc@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36a8c750-8490-1c5d-ca12-cc2b8c594334@redhat.com>
Date: Thu, 23 Feb 2017 10:51:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170223163315.w2nekel42grwtbkc@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NAbQhOKfdCuuwl2AjxpgXMokd2SrOEN5D"
Subject: Re: [Qemu-devel] Adding an overlay with 'blockdev-add' fails with:
 "Parameter 'driver' is missing"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NAbQhOKfdCuuwl2AjxpgXMokd2SrOEN5D
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <36a8c750-8490-1c5d-ca12-cc2b8c594334@redhat.com>
Subject: Re: [Qemu-devel] Adding an overlay with 'blockdev-add' fails with:
 "Parameter 'driver' is missing"
References: <20170223144034.b2bhgsvwfyyymxwk@eukaryote>
 <87ino1gcx2.fsf@dusky.pond.sub.org>
 <20170223163315.w2nekel42grwtbkc@eukaryote>
In-Reply-To: <20170223163315.w2nekel42grwtbkc@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 10:33 AM, Kashyap Chamarthy wrote:
> On Thu, Feb 23, 2017 at 04:11:21PM +0100, Markus Armbruster wrote:
>> Kashyap Chamarthy <kchamart@redhat.com> writes:
>>
>>> TL;DR: Using `blockdev-add` to create an overlay file succeeds with Q=
EMU
>>>        2.7.0, however the *same* test fails with QEMU from Git (plus =
a
>>>        couple of patch series from mailing list).  Details below.
>>
>> commit 0153d2f50bc2ad3f41810d838fcf66acbf10f07a
>> Author: Kevin Wolf <kwolf@redhat.com>
>> Date:   Fri Oct 7 17:05:04 2016 +0200
>>
>>     block: Remove "options" indirection from blockdev-add
>=20
> [...]
>=20
>> Sorry for the confusion!  Early adopters always have the most fun ;)
>=20
> Ah, I see, thanks for the pointer.
>=20
> I tried to come up with the below JSON, after looking at the QAPI schem=
a
> documentation (from qemu/qapi/block-core.json), still I seem to be
> tripping up somewhere.  Now it doesn't recognize the 'backing' option:
>=20
> $ socat UNIX:./qmp-sock READLINE,history=3D$HOME/.qmp_history,prompt=3D=
'QMP> '
> [...]
> QMP> {
> QMP>   "execute":"blockdev-add",
> QMP>   "arguments":{
> QMP>     "driver":"qcow2",
> QMP>     "node-name":"node1"
> QMP>   },

Oops, you ended your arguments too soon.

> QMP>   "file":{
> QMP>     "driver":"file",
> QMP>     "filename":"/export/target.qcow2"
> QMP>   },
> QMP>   "backing":{

Here, you passed "file" and "backing" as siblings of "execute", but they
should be children of "arguments".

> QMP>     "driver":"qcow2",
> QMP>     "file":{
> QMP>       "driver":"file",
> QMP>       "filename":"/export/base.qcow2"
> QMP>     }
> QMP>   }
> QMP> }
> {"error": {"class": "GenericError", "desc": "QMP input object member 'b=
acking' is unexpected"}}
> QMP>=20

Try (untested on my end) this rewrite of your original post (just
removing the '"options":{' and corresponding '}' from that listing):

{
    "execute": "blockdev-add",
    "arguments": {
            "backing": "virtio0",
            "driver": "qcow2",
            "id": "virtio1",
            "file": {
                "driver": "file",
                "filename": "/export/target.qcow2"
            }
    }
}

or this attempt at your current post:

{   "execute":"blockdev-add",
    "arguments":{
     "driver":"qcow2",
     "node-name":"node1"
     "file":{
      "driver":"file",
      "filename":"/export/target.qcow2"
     },
     "backing":{
      "driver":"qcow2",
      "file":{
        "driver":"file",
        "filename":"/export/base.qcow2"
      }
     }
    }
}

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NAbQhOKfdCuuwl2AjxpgXMokd2SrOEN5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrxMaAAoJEKeha0olJ0NqwFAH/jx0+9uXcv6UwljyJbgQ8pPv
8BTXKbvAiF0OVVM77Yrt9NFq68Vi8cYs5AzuIXosT2mvdMM6KEPMrXLn1xFcZNGo
kucmhJP7Nq552IWn7ZwDB0VkkoQv6U+lykBOgeVwQaurgvRiVxFZcmYDYk7yyCMl
t/AAMHvKwICbCOyMB9NOlsEshQdtzM+LUMqDz3WFlAvXw8aRvLE495rfEY8hL/QF
dvTVajnXF5hnn1BBEUpHwqXvbkfD14COoB/KzRwxhRG6Yt2ogajPt5XvG+A6pQjm
+GdqqlRxiNCMJvM5B5SjECYYp1o2FZoCtFynsV6soKGXmTrW5rJtDlhieo1UmZM=
=aMz/
-----END PGP SIGNATURE-----

--NAbQhOKfdCuuwl2AjxpgXMokd2SrOEN5D--
