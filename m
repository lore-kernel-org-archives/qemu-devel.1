Received: from eggs.gnu.org ([2001:4830:134:3::10]:54084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYWsN-0002dL-QI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYWsJ-0000y9-Lr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:22:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYWsJ-0000wB-I2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:22:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31DFB8151D6F
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:22:15 +0000 (UTC)
References: <20180607101019.14958-1-berrange@redhat.com>
	<20180628131722.GA13766@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8964dea3-042d-2eac-0198-d50c9c8947fc@redhat.com>
Date: Thu, 28 Jun 2018 08:22:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180628131722.GA13766@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] doc: switch to modern syntx for VNC TLS
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 06/28/2018 08:17 AM, Daniel P. Berrang=C3=A9 wrote:
> Ping, anyone have comments on this, besides the typo in $SUBJECT,
> also repeated in commit msg
>=20
> On Thu, Jun 07, 2018 at 11:10:19AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
>> The use of 'tls', 'x509' and 'x509verify' properties is the legacy
>> backcompat syntx, replaced by use of TLS creds objects.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>   qemu-doc.texi | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index f00706b999..d526870479 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -1097,7 +1097,9 @@ support provides a secure session, but no authen=
tication. This allows any
>>   client to connect, and provides an encrypted session.
>>  =20
>>   @example
>> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509=3D/etc/pki/qemu -mo=
nitor stdio
>> +qemu-system-i386 [...OPTIONS...] \
>> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dser=
ver,verify-peer=3Dno \

I'd use --object here (especially since -object cannot be used on=20
qemu-nbd, but --object tls-creds-x509 can).

>> +  -vnc :1,tls-creds=3Dtls0 -monitor stdio
>>   @end example
>>  =20
>>   In the above example @code{/etc/pki/qemu} should contain at least th=
ree files,
>> @@ -1112,10 +1114,14 @@ only be readable by the user owning it.
>>   Certificates can also provide a means to authenticate the client con=
necting.
>>   The server will request that the client provide a certificate, which=
 it will
>>   then validate against the CA certificate. This is a good choice if d=
eploying
>> -in an environment with a private internal certificate authority.
>> +in an environment with a private internal certificate authority. It u=
ses the
>> +same syntax as previously, but with @code{verify-peer} set to @code{y=
es}
>> +instead.
>>  =20
>>   @example
>> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509verify=3D/etc/pki/qe=
mu -monitor stdio
>> +qemu-system-i386 [...OPTIONS...] \
>> +  -object tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dser=
ver,verify-peer=3Dyes \

multiple times in this patch.

Otherwise looks good to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
