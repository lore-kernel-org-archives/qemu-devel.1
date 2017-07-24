Received: from eggs.gnu.org ([2001:4830:134:3::10]:39782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcEm-0004HO-QW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcEj-0005xw-Le
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dZcEj-0005wl-C3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:13:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16A02883D7
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:13:18 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-6-ldoktor@redhat.com>
	<20170720182753.GV2757@localhost.localdomain>
	<6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
	<20170721184227.GB2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <1ec2f684-ddbc-de62-e13b-58f54d92e27d@redhat.com>
Date: Mon, 24 Jul 2017 14:13:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170721184227.GB2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rt9WsXn01Rdqj9CHrICie9c6vdAfjkc2f"
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu.py: Use custom exceptions
 rather than Exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rt9WsXn01Rdqj9CHrICie9c6vdAfjkc2f
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <1ec2f684-ddbc-de62-e13b-58f54d92e27d@redhat.com>
Subject: Re: [PATCH 05/11] qemu.py: Use custom exceptions rather than
 Exception
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-6-ldoktor@redhat.com>
 <20170720182753.GV2757@localhost.localdomain>
 <6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
 <20170721184227.GB2757@localhost.localdomain>
In-Reply-To: <20170721184227.GB2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 21.7.2017 v 20:42 Eduardo Habkost napsal(a):
> On Fri, Jul 21, 2017 at 08:37:34AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> Dne 20.7.2017 v 20:27 Eduardo Habkost napsal(a):
>>> On Thu, Jul 20, 2017 at 06:28:09PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
>>>> The naked Exception should not be widely used. It makes sense to be =
a
>>>> bit more specific and use better-suited custom exceptions. As a bene=
fit
>>>> we can store the full reply in the exception in case someone needs i=
t
>>>> when catching the exception.
>>>>
>>>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>>> ---
>>>>  scripts/qemu.py | 17 +++++++++++++++--
>>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>> index 5948e19..2bd522f 100644
>>>> --- a/scripts/qemu.py
>>>> +++ b/scripts/qemu.py
>>>> @@ -19,6 +19,19 @@ import subprocess
>>>>  import qmp.qmp
>>>> =20
>>>> =20
>>>> +class MonitorResponseError(qmp.qmp.QMPError):
>>>> +    '''
>>>> +    Represents erroneous QMP monitor reply
>>>> +    '''
>>>> +    def __init__(self, reply):
>>>> +        try:
>>>> +            desc =3D reply["error"]["desc"]
>>>> +        except KeyError:
>>>> +            desc =3D reply
>>>> +        super(MonitorResponseError, self).__init__(desc)
>>>> +        self.reply =3D reply
>>>
>>> This would require every user of self.reply to first check if
>>> it's a string or dictionary.  All because of the "Monitor is
>>> closed" case below:
>>>
>> I haven't used it for the `Monitor is closed` exception, so
>> it's just to be able to store really broken reply safely.
>> Anyway people can check whether the reply is a dict, or I can
>> add `is_valid_reply` property which would check for
>> `[error][desc]` presence (which is a bit more precise than just
>> plain dict type checking).
>=20
>=20
> Oops, I wasn't paying enough attention, sorry.  self.reply is
> actually always set to the response from the monitor.
>=20
> If you are just trying a safe fallback for 'desc' if the response
> broken, what about using repr(reply) or json.dumps(reply) if
> reply['error']['desc'] isn't set?
>=20
I could use repr, but I'd prefer keeping it the way it is as you could us=
e `isinstance` to see whether it's dict and interact with it (if needed, =
eg. on negative testing, which is my motivation for storing the full resp=
onse).

Luk=C3=A1=C5=A1

>>
>>>> +
>>>> +
>>>>  class QEMUMachine(object):
>>>>      '''A QEMU VM'''
>>>> =20
>>>> @@ -197,9 +210,9 @@ class QEMUMachine(object):
>>>>          '''
>>>>          reply =3D self.qmp(cmd, conv_keys, **args)
>>>>          if reply is None:
>>>> -            raise Exception("Monitor is closed")
>>>> +            raise qmp.qmp.QMPError("Monitor is closed")
>>>
>>> Should we really use the same exception type for this, if it's
>>> not really a QMP monitor error reply, and won't even have a real
>>> QMP reply in self.reply?
>>>
>> I wasn't sure but the same exception can be caused by other
>> failures when obtaining replies so I think in case the monitor
>> is closed we might expect the same exception. Would importing
>> it in the top level of this module to become `qemu.QMPError`
>> work for you better, or would you prefer IOError, RuntimeError
>> or another custom exception?
>=20
> I was not paying enough attention.  QMPError sounds good to me.
>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
>>
>> Luk=C3=A1=C5=A1
>>
>>>
>>>>          if "error" in reply:
>>>> -            raise Exception(reply["error"]["desc"])
>>>> +            raise MonitorResponseError(reply)
>>>>          return reply["return"]
>>>> =20
>>>>      def get_qmp_event(self, wait=3DFalse):
>>>> --=20
>>>> 2.9.4
>>>>
>>>
>>
>>
>=20
>=20
>=20
>=20



--Rt9WsXn01Rdqj9CHrICie9c6vdAfjkc2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZdeRVExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsER
qAf9FlZvyyPyeer/kIziVXdBbdEr/6G6M2wXy8Kbm9+a3DeZor6RQ96oLWcC1Rkn
1y2Vieaqsp4VoZViU0+J9P/lVCwzagg5v48zslRYpdYcDnJC5z4+oyQ61h0gwIvG
Df6JYfPLFJvHIMRSJj9g8sxnWAqcx/OgT3OnIX6jsuS13zjV8oujqnsEjL1Kz9E9
3MmZiSoZVNWa57KnljGGbo0HUDMTuTNwXjxfdLCB7ZX4E8+gDsQGYPDhrn85IuCS
8PjVThJ20lDE68PdCzhKj9PTzX1jPHJESeF1ECAk1ek3ureEPmqp5tJ1565WrjJ2
b49X6kWgNGXq+3OnE9NuZeuZ/Q==
=vTio
-----END PGP SIGNATURE-----

--Rt9WsXn01Rdqj9CHrICie9c6vdAfjkc2f--
