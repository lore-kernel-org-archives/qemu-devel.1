Received: from eggs.gnu.org ([2001:4830:134:3::10]:40422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdwo-00025q-4r
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdwn-00033x-18
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:41:54 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-7-kwolf@redhat.com>
	<2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
	<20180529121212.GD4756@localhost.localdomain>
	<824367e2-4e89-7c9c-24ff-df797a730411@redhat.com>
	<20180529123942.GE4756@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f3e96a5c-3944-a5d7-d04e-90e03e7e500b@redhat.com>
Date: Tue, 29 May 2018 14:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180529123942.GE4756@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dkFW7PmOqSTG29eiOd42ajfAG847EOCE5"
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
--dkFW7PmOqSTG29eiOd42ajfAG847EOCE5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jsnow@redhat.com, eblake@redhat.com,
 pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <f3e96a5c-3944-a5d7-d04e-90e03e7e500b@redhat.com>
Subject: Re: [PATCH 06/14] qemu-iotests: Add VM.qmp_log()
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-7-kwolf@redhat.com>
 <2b57e7d1-6980-298e-3cd4-9370595f58d7@redhat.com>
 <20180529121212.GD4756@localhost.localdomain>
 <824367e2-4e89-7c9c-24ff-df797a730411@redhat.com>
 <20180529123942.GE4756@localhost.localdomain>
In-Reply-To: <20180529123942.GE4756@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 14:39, Kevin Wolf wrote:
> Am 29.05.2018 um 14:15 hat Max Reitz geschrieben:
>> On 2018-05-29 14:12, Kevin Wolf wrote:
>>> Am 29.05.2018 um 13:48 hat Max Reitz geschrieben:
>>>> On 2018-05-25 18:33, Kevin Wolf wrote:
>>>>> This adds a helper function that logs both the QMP request and the
>>>>> received response before returning it.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>> ---
>>>>>  tests/qemu-iotests/iotests.py | 11 +++++++++++
>>>>>  1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iot=
ests.py
>>>>> index 17aa7c88dc..319d898172 100644
>>>>> --- a/tests/qemu-iotests/iotests.py
>>>>> +++ b/tests/qemu-iotests/iotests.py
>>>>> @@ -206,6 +206,10 @@ def filter_qmp_event(event):
>>>>>          event['timestamp']['microseconds'] =3D 'USECS'
>>>>>      return event
>>>>> =20
>>>>> +def filter_testfiles(msg):
>>>>> +    prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
>>>>> +    return msg.replace(prefix, 'TEST_DIR/')
>>>>
>>>> I'd prefer 'TEST_DIR/PID-' (just because).
>>>>
>>>> But if you really like just 'TEST_DIR/'...  Then OK.
>>>
>>> I preferred that because it leaves the output unchanged from the old
>>> bash tests, which made reviewing the results easier. Maybe that's a t=
oo
>>> temporary advantage to be of any use in the future, though, so we cou=
ld
>>> change it afterwards...
>>
>> It doesn't really make reviewing the patches easier, though, because t=
he
>> hardest part of course is the change of the test itself and not the
>> change of the result. :-)
>>
>> (And some file name changes really are on the easy side.)
>=20
> If you think so... For me the main reason to convert the test files was=

> to see whether the job actually does the same thing as the old
> synchronous command did.

Sure, but kompare is rather good at highlighting changes in a single
line, so I can quickly verify them as benign. :-)

>>>>> +
>>>>>  def log(msg, filters=3D[]):
>>>>>      for flt in filters:
>>>>>          msg =3D flt(msg)
>>>>> @@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
>>>>>              result.append(filter_qmp_event(ev))
>>>>>          return result
>>>>> =20
>>>>> +    def qmp_log(self, cmd, **kwargs):
>>>>> +        logmsg =3D "{'execute': '%s', 'arguments': %s}" % (cmd, kw=
args)
>>>>> +        log(filter_testfiles(logmsg))
>>>>> +        result =3D self.qmp(cmd, **kwargs)
>>>>> +        log(result)
>>>>
>>>> I think we should apply the testfiles filter here, too (error messag=
es
>>>> may contain file names, after all).
>>>
>>> Didn't happen in the test outputs of this series, and filter_testfile=
s()
>>> processes strings whereas result is a dict, so it would be more
>>> complicated than just adding a function call.
>>
>> You mean it would be "log(filter_testfiles('%s' % result)))"?
>=20
> Ah, you mean just for logging? Yes, we can do that. I thought you meant=

> returning a filtered result as well.

Oh, no.  At least I can't think of a reason why we'd want that.

Max


--dkFW7PmOqSTG29eiOd42ajfAG847EOCE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNSocACgkQ9AfbAGHV
z0DkkQf+NgqI3WynsDc2tktW1F/UUeBBtO4y0BCqV4rFVOURWBmq35wTtopAo7t7
3KAe969jDfwZoj6vtA54lXUhdihjWqd0JAVqam+f+iksOsQ4gP942uvqY5ZRp+u0
YcJQRy2xS3MW+yhI9wbWuK4yjXtyZULoJSgk3r+p99dJnKK8Jrb9IyrJQuksJClq
t77a67BwBWCc0OVmxlj+xMIYgTd4ACRiyfAsOxNDCvzVUapAp0SjT+K3eJN6xEIe
2YlgLow14mriA2vyX1VvqP37x2B91k/7Nd6XdB1fJNWRYB0pIzA2Dn5E6L9CfHEO
FNgmXm7tWPdRibYsZ1BGWGYhjGbQ4g==
=ePPw
-----END PGP SIGNATURE-----

--dkFW7PmOqSTG29eiOd42ajfAG847EOCE5--
