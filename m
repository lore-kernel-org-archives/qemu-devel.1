Received: from eggs.gnu.org ([2001:4830:134:3::10]:41680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQWC-0003nS-L3
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQW7-0003o1-5e
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:52:27 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-6-mreitz@redhat.com>
	<20181015200733.GC31060@habkost.net>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d72adf1e-dccb-1b2f-f8f3-e4dea45672c9@redhat.com>
Date: Fri, 19 Oct 2018 10:52:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181015200733.GC31060@habkost.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f3TrVqsXmazgWZJgWNVafifBYb06YHXFn"
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: Different iterator behavior
 in Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f3TrVqsXmazgWZJgWNVafifBYb06YHXFn
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <d72adf1e-dccb-1b2f-f8f3-e4dea45672c9@redhat.com>
Subject: Re: [PATCH 5/9] iotests: Different iterator behavior in Python 3
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-6-mreitz@redhat.com>
 <20181015200733.GC31060@habkost.net>
In-Reply-To: <20181015200733.GC31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.10.18 22:07, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 04:14:49PM +0200, Max Reitz wrote:
>> In Python 3, several functions now return iterators instead of lists.
>> This includes range(), items(), map(), and filter().  This means that =
if
>> we really want a list, we have to wrap those instances with list().  O=
n
>> the other hand, sometimes we do just want an iterator, in which case w=
e
>> have sometimes used xrange() and iteritems() which no longer exist in
>> Python 3.  Just change these calls to be range() and items(), which
>> costs a bit of performance in Python 2, but will do the right thing in=

>> Python 3 (which is what is important).
>>
>> In one instance, we only wanted the first instance of the result of a
>> filter() call.  Instead of using next(filter()) which would work only =
in
>> Python 3, or list(filter())[0] which would work everywhere but is a bi=
t
>> weird, this instance is changed to a single-line for with next() wrapp=
ed
>> around, which works both in 2.7 and 3.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> Minor comments below:

[...]

>> diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
>> index 72aa9707c7..a339bf6069 100755
>> --- a/tests/qemu-iotests/065
>> +++ b/tests/qemu-iotests/065
>> @@ -59,7 +59,7 @@ class TestQemuImgInfo(TestImageInfoSpecific):
>>                      :data.index('')]
>>          for field in data:
>>              self.assertTrue(re.match('^ {4}[^ ]', field) is not None)=

>> -        data =3D map(lambda line: line.strip(), data)
>> +        data =3D list(map(lambda line: line.strip(), data))
>=20
> I would find this more readable:
>=20
>         data =3D [line.strip() for line in data]
>=20
> Not a blocker, though.

Yes, I agree, that looks better.

>>          self.assertEqual(data, self.human_compare)
>> =20
>>  class TestQMP(TestImageInfoSpecific):
>> @@ -80,7 +80,7 @@ class TestQMP(TestImageInfoSpecific):
>> =20
>>      def test_qmp(self):
>>          result =3D self.vm.qmp('query-block')['return']
>> -        drive =3D filter(lambda drive: drive['device'] =3D=3D 'drive0=
', result)[0]
>> +        drive =3D next(drive for drive in result if drive['device'] =3D=
=3D 'drive0')
>=20
> I didn't understand what you meant by "single-line for" on the
> commit message, until I saw the generator expression here.  :)

Maybe I should at least put quotes around the "for", because the
combination of "for with" really makes it difficult to read...

> This will raise an exception if there's no drive0 in the list,
> but that was already true on the original code.
>=20
>=20
>>          data =3D drive['inserted']['image']['format-specific']
>>          self.assertEqual(data['type'], iotests.imgfmt)
>>          self.assertEqual(data['data'], self.compare)
>> diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
>> index 3ea4ac53f5..9f189e3b54 100755
>> --- a/tests/qemu-iotests/124
>> +++ b/tests/qemu-iotests/124
>> @@ -39,7 +39,7 @@ def try_remove(img):
>>  def transaction_action(action, **kwargs):
>>      return {
>>          'type': action,
>> -        'data': dict((k.replace('_', '-'), v) for k, v in kwargs.iter=
items())
>> +        'data': dict((k.replace('_', '-'), v) for k, v in kwargs.item=
s())
>>      }
>> =20
>> =20
>> @@ -134,7 +134,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCas=
e):
>>      def img_create(self, img, fmt=3Diotests.imgfmt, size=3D'64M',
>>                     parent=3DNone, parentFormat=3DNone, **kwargs):
>>          optargs =3D []
>> -        for k,v in kwargs.iteritems():
>> +        for k,v in kwargs.items():
>>              optargs =3D optargs + ['-o', '%s=3D%s' % (k,v)]
>>          args =3D ['create', '-f', fmt] + optargs + [img, size]
>>          if parent:
>> diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
>> index cc7fe337f3..e00f10b8c8 100755
>> --- a/tests/qemu-iotests/139
>> +++ b/tests/qemu-iotests/139
>> @@ -51,7 +51,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
>>      # Check whether a BlockDriverState exists
>>      def checkBlockDriverState(self, node, must_exist =3D True):
>>          result =3D self.vm.qmp('query-named-block-nodes')
>> -        nodes =3D filter(lambda x: x['node-name'] =3D=3D node, result=
['return'])
>> +        nodes =3D list(filter(lambda x: x['node-name'] =3D=3D node, r=
esult['return']))
>=20
> I'd prefer a list expression:
>=20
>         nodes =3D [x for x in result['return'] if x['node-name'] =3D=3D=
 node]
>=20
> Also not a blocker.

I don't mind either way, so why not.

Max


--f3TrVqsXmazgWZJgWNVafifBYb06YHXFn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJmz8ACgkQ9AfbAGHV
z0BOMwgAq2SR0nJdfdO+c4gTcKkZqS5CS3c1rpL+CLpSyxSpgtBg28pG1mc67RVq
3xM4LSqHoIQKSiBMQEQToC16Kb1ULlkVmkpBXpVIi3rh1JFwhS6/EzP+AFMHkNAf
E0l3S8TQjY089VdJUH2RRwhrKxX04/m3fxleRVxN4yj6Dh7WQUm3yHJR8hBDuuiv
8T3KGr4nzWOU26VgaVaKeRG8U5cb+fax87yeQNYBtuRCt/l735QztzSg+Vjn0Ctx
aumNgxOPACXmoDqgyqEouG+K1l+Azyob3yEtqYmpOMa5Q3EfK3DOAu6Jx/eLut57
BxJfzkWx1rxgMWzRJmH+0j5elIpqiQ==
=Jh7q
-----END PGP SIGNATURE-----

--f3TrVqsXmazgWZJgWNVafifBYb06YHXFn--
