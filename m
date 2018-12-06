Received: from eggs.gnu.org ([2001:4830:134:3::10]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUsgY-00013y-HW
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUsdi-0006SH-Ss
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:20:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUsdi-0006RR-Lb
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:20:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B789BA403F
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 12:20:21 +0000 (UTC)
Date: Thu, 6 Dec 2018 12:20:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206122017.GI29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181206121743.20762-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206121743.20762-1-armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] json: Fix to reject duplicate object
 member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, eblake@redhat.com, dgilbert@redhat.com

On Thu, Dec 06, 2018 at 01:17:43PM +0100, Markus Armbruster wrote:
> The JSON parser happily accepts duplicate object member names.  The
> last value wins.  Reproducer #1:
>=20
>     $ qemu-system-x86_64 -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 93, "minor": 0, "major": 3},
>     "package": "v3.1.0-rc3-7-g87a45d86ed"}, "capabilities": []}}
>     {'execute':'qmp_capabilities'}
>     {"return": {}}
>     {'execute':'blockdev-add','arguments':{'driver':'null-co',
>      'node-name':'foo','node-name':'bar'}}
>     {"return": {}}
>     {'execute':'query-named-block-nodes'}
>     {"return": [{ [...] "node-name": "bar" [...] }]}
>=20
> Reproducer #2 is iotest 229.
>=20
> Fix the parser to reject duplicates, and fix iotest 229 not to use
> them.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qobject/json-parser.c  | 5 +++++
>  tests/qemu-iotests/229 | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
