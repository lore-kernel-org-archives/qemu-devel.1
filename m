Received: from eggs.gnu.org ([209.51.188.92]:34765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopj2-0008CC-3b
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopj0-0000uO-7H
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:16:20 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-5-mreitz@redhat.com>
	<9cdec140-f130-6e4c-738b-0b2dd69ca714@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9e96eb3e-c35a-2a3f-2276-bf78bf9890a9@redhat.com>
Date: Wed, 30 Jan 2019 14:16:05 +0100
MIME-Version: 1.0
In-Reply-To: <9cdec140-f130-6e4c-738b-0b2dd69ca714@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3ar6HJzl8ZdPZ2snqREO6rHoZVfolFCuG"
Subject: Re: [Qemu-devel] [PATCH 4/9] iotests: Fix 207 to use QMP filters
 for qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ar6HJzl8ZdPZ2snqREO6rHoZVfolFCuG
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9e96eb3e-c35a-2a3f-2276-bf78bf9890a9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] iotests: Fix 207 to use QMP filters for
 qmp_log
References: <20190123144610.8842-1-mreitz@redhat.com>
 <20190123144610.8842-5-mreitz@redhat.com>
 <9cdec140-f130-6e4c-738b-0b2dd69ca714@redhat.com>
In-Reply-To: <9cdec140-f130-6e4c-738b-0b2dd69ca714@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.19 22:31, John Snow wrote:
>=20
>=20
> On 1/23/19 9:46 AM, Max Reitz wrote:
>> Fixes: 08fcd6111e1949f456e1b232ebeeb0cc17019a92
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Commit message is a bit barren, feel free to blame me for not realizing=

> that non-qcow2 tests used the feature I was rewriting. I may have chose=
n
> to rewrite it differently if I had seen all the other callers. :\

I felt like all I wanted to say fit into the title.

> Any opinions on how it shook out, now that you've had to fix things in
> its wake? It felt like a lot of work to do not much to be honest, but
> also it seemed like we were being too cavalier about the differences
> between rich/qmp filters and text ones.

Well...  I felt like it was good enough before.  These are tests, so
whatever works, works.

In theory it's nice that filters can now see the real objects, but in
practice filtering for a certain key wasn't impossible, as it was done
in this test before this patch; and in other cases, it turns out we
probably don't want to filter for a certain key at all (like when
filtering the filename).

So all in all I'd have to say to me it mostly makes things more
complicated than necessary.  But OTOH I wouldn't say it's
overcomplicated because I can see the theoretical purpose, at least.  It
makes sense to give objects to the filters -- but it doesn't seem too
useful in the end.

Also, when in doubt, it's probably better to really work on objects
instead of having just simple text filters.  After all, at least I write
Python tests to get away from those text filters we have in the bash test=
s.

Max

> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
>> ---
>>  tests/qemu-iotests/207     | 10 +++++++---
>>  tests/qemu-iotests/207.out |  4 ++--
>>  2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
>> index c617ee7453..dfd3c51bd1 100755
>> --- a/tests/qemu-iotests/207
>> +++ b/tests/qemu-iotests/207
>> @@ -27,12 +27,16 @@ import re
>>  iotests.verify_image_format(supported_fmts=3D['raw'])
>>  iotests.verify_protocol(supported=3D['ssh'])
>> =20
>> -def filter_hash(msg):
>> -    return re.sub('"hash": "[0-9a-f]+"', '"hash": HASH', msg)
>> +def filter_hash(qmsg):
>> +    def _filter(key, value):
>> +        if key =3D=3D 'hash' and re.match('[0-9a-f]+', value):
>> +            return 'HASH'
>> +        return value
>> +    return iotests.filter_qmp(qmsg, _filter)
>> =20
>>  def blockdev_create(vm, options):
>>      result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=
=3Doptions,
>> -                        filters=3D[iotests.filter_testfiles, filter_h=
ash])
>> +                        filters=3D[iotests.filter_qmp_testfiles, filt=
er_hash])
>> =20
>>      if 'return' in result:
>>          assert result['return'] =3D=3D {}
>> diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
>> index 45ac7c2a8f..88d2240f54 100644
>> --- a/tests/qemu-iotests/207.out
>> +++ b/tests/qemu-iotests/207.out
>> @@ -40,7 +40,7 @@ Job failed: remote host key does not match host_key_=
check 'wrong'
>>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>>  {"return": {}}
>> =20
>> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "optio=
ns": {"driver": "ssh", "location": {"host-key-check": {"hash": HASH, "mod=
e": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"hos=
t": "127.0.0.1", "port": "22"}}, "size": 8388608}}}
>> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "optio=
ns": {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "m=
ode": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"h=
ost": "127.0.0.1", "port": "22"}}, "size": 8388608}}}
>>  {"return": {}}
>>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>>  {"return": {}}
>> @@ -55,7 +55,7 @@ Job failed: remote host key does not match host_key_=
check 'wrong'
>>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>>  {"return": {}}
>> =20
>> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "optio=
ns": {"driver": "ssh", "location": {"host-key-check": {"hash": HASH, "mod=
e": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"ho=
st": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
>> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "optio=
ns": {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "m=
ode": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"=
host": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
>>  {"return": {}}
>>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>>  {"return": {}}
>>



--3ar6HJzl8ZdPZ2snqREO6rHoZVfolFCuG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxRo5UACgkQ9AfbAGHV
z0D+rwf+JtB98uvWpvfKuo8AN2XfV4tj58TvTYY/csHxB6F89f6BJPotCPLIaeDe
N/lBWad7HaWzobzKvSkf6EgzeXyI2Qg7tYvAy33sR/VS+hiZpVpe2QLxpnq1Bfoe
BXAq0r4Oupn6nTYpOCaAn++vIanrxqYNbC84S6lqEhINZtvH1FGzqUdDvKuZEAa6
rrU3AOHTvO+AJsQjPJPSZmp3cMq6BAPy/YTOXBemRueT8E1lhtT7xzZKKYljdOgG
Dlys1RsA2rqSddHuilbxWJdkBtPQO478Pqo0zLj1ebeICHS6athFM9EpkBiOZ0m2
RLXp/WbqOKTh+QRrya5sDC68Q1VmGQ==
=iAqu
-----END PGP SIGNATURE-----

--3ar6HJzl8ZdPZ2snqREO6rHoZVfolFCuG--
