Received: from eggs.gnu.org ([2001:4830:134:3::10]:33934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdXc-0000aa-Mf
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdXb-0001Nt-H8
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:15:52 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-7-kwolf@redhat.com>
	<2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
	<20180529121212.GD4756@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <824367e2-4e89-7c9c-24ff-df797a730411@redhat.com>
Date: Tue, 29 May 2018 14:15:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180529121212.GD4756@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N1pdbs9aiSIgYEPzmmob3zKrqSnUb57g0"
Subject: Re: [Qemu-devel] [PATCH 06/14] qemu-iotests: Add VM.qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N1pdbs9aiSIgYEPzmmob3zKrqSnUb57g0
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <824367e2-4e89-7c9c-24ff-df797a730411@redhat.com>
Subject: Re: [PATCH 06/14] qemu-iotests: Add VM.qmp_log()
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-7-kwolf@redhat.com>
 <2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
 <20180529121212.GD4756@localhost.localdomain>
In-Reply-To: <20180529121212.GD4756@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 14:12, Kevin Wolf wrote:
> Am 29.05.2018 um 13:48 hat Max Reitz geschrieben:
>> On 2018-05-25 18:33, Kevin Wolf wrote:
>>> This adds a helper function that logs both the QMP request and the
>>> received response before returning it.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/iotests.py | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
>>> index 17aa7c88dc..319d898172 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -206,6 +206,10 @@ def filter_qmp_event(event):
>>>          event['timestamp']['microseconds'] =3D 'USECS'
>>>      return event
>>> =20
>>> +def filter_testfiles(msg):
>>> +    prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
>>> +    return msg.replace(prefix, 'TEST_DIR/')
>>
>> I'd prefer 'TEST_DIR/PID-' (just because).
>>
>> But if you really like just 'TEST_DIR/'...  Then OK.
>=20
> I preferred that because it leaves the output unchanged from the old
> bash tests, which made reviewing the results easier. Maybe that's a too=

> temporary advantage to be of any use in the future, though, so we could=

> change it afterwards...

It doesn't really make reviewing the patches easier, though, because the
hardest part of course is the change of the test itself and not the
change of the result. :-)

(And some file name changes really are on the easy side.)

>>> +
>>>  def log(msg, filters=3D[]):
>>>      for flt in filters:
>>>          msg =3D flt(msg)
>>> @@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
>>>              result.append(filter_qmp_event(ev))
>>>          return result
>>> =20
>>> +    def qmp_log(self, cmd, **kwargs):
>>> +        logmsg =3D "{'execute': '%s', 'arguments': %s}" % (cmd, kwar=
gs)
>>> +        log(filter_testfiles(logmsg))
>>> +        result =3D self.qmp(cmd, **kwargs)
>>> +        log(result)
>>
>> I think we should apply the testfiles filter here, too (error messages=

>> may contain file names, after all).
>=20
> Didn't happen in the test outputs of this series, and filter_testfiles(=
)
> processes strings whereas result is a dict, so it would be more
> complicated than just adding a function call.

You mean it would be "log(filter_testfiles('%s' % result)))"?

Max


--N1pdbs9aiSIgYEPzmmob3zKrqSnUb57g0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNRGsACgkQ9AfbAGHV
z0DAcQgAo8LcUruK/PgKZzB40A34cC9brChuetv0Vtu8m4M8UeBOcXWC2xGjhMgJ
bSzuQv7aCDfYE1REBeASEpU/h9OZeR+beLBiuaU6v6z+IT/VIbixDP0q+IHOuZ2g
gT/fdOY8xs/mpBiKxES5rtq8s0oko9UrMLVhaf5GNYM6Wk6cLB+ivOYWbms6Du9B
MVCFEjvtfzKhZ3OTGXMNmxGfLRUoNAf6BxbglyuDa4q1J+5Kw+bQz4buSVo5XpcG
NMhBsJQSu9Yw8v5wIW9H6/ujYEBACdmH/c+FnLGIStp2BrqL07cM/onhEfMHsB9Q
5lpVpwoAdPmL4WHriPRE4eEwlyscxw==
=EiWO
-----END PGP SIGNATURE-----

--N1pdbs9aiSIgYEPzmmob3zKrqSnUb57g0--
