Received: from eggs.gnu.org ([209.51.188.92]:39026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7iH-0000qB-1u
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gw7iG-0008CU-1q
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:53:40 -0500
References: <cd28473f-b768-0c3e-82be-1e07e9c3e786@redhat.com>
	<20190219104445.GB7154@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ac61a17-6018-8d8f-fe8f-6137f8ec2fe4@redhat.com>
Date: Tue, 19 Feb 2019 09:53:23 -0600
MIME-Version: 1.0
In-Reply-To: <20190219104445.GB7154@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Failing qemu-iotest 233
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2/19/19 4:44 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 19, 2019 at 07:36:07AM +0100, Thomas Huth wrote:
>>
>>  Hi Eric, hi Daniel,
>>
>> QEMU iotest 233 is failing for me on RHEL7:
>>
>> 233                [07:29:30] [07:29:30] [failed, exit status 1] - out=
put mismatch (see 233.out.bad)
>> --- /home/thuth/devel/qemu/tests/qemu-iotests/233.out	2019-02-19 07:14=
:45.000000000 +0100
>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/233.out.bad	2019-02-=
19 07:29:30.000000000 +0100
>> @@ -13,45 +13,7 @@
>>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =20
>>  =3D=3D check TLS client to plain server fails =3D=3D
>> -qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,t=
ls-creds=3Dtls0': Denied by server for option 5 (starttls)
>> -server reported: TLS not configured
>> -qemu-nbd: Denied by server for option 5 (starttls)
>> -server reported: TLS not configured
>> +qemu-nbd: Unable to import client certificate /tmp/qemu-iotests-quick=
-28354/tls/client1/client-cert.pem: Base64 unexpected header error.
>=20
> This is fun, because it is actually non-determinstic, failing in a diff=
erent
> place in the test everytime it is run !
>=20
> Turns out that piping certtool to "head -1" is bad because it causes
> certtool to get a broken pipe making it quit before it has written
> the certificate to disk leaving a zero length file. This in turn
> causes the base64 error above.

Changing 'head -1' to 'sed -n 1p' should prevent certtool from seeing
SIGPIPE.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
