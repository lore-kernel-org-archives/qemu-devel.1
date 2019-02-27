Received: from eggs.gnu.org ([209.51.188.92]:40266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz28B-0007ES-04
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz289-0001eS-Db
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:32:26 -0500
References: <20190227115152.1906-1-berrange@redhat.com>
	<20190227115152.1906-2-berrange@redhat.com>
	<61c14d41-362e-b6ba-be62-b360c215a98b@redhat.com>
	<20190227153331.GL31688@redhat.com> <20190227155828.GO31688@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f11fce5e-8119-5dfa-b9b8-cc9d9071d131@redhat.com>
Date: Wed, 27 Feb 2019 10:32:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190227155828.GO31688@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 2/27/19 9:58 AM, Daniel P. Berrang=C3=A9 wrote:

>>>>  echo "=3D=3D check TLS works =3D=3D"
>>>> -obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3D=
tls0
>>>> -$QEMU_IMG info --image-opts --object $obj \
>>>> +obj1=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=
=3Dtls0
>>>> +obj2=3Dtls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,id=
=3Dtls0
>>>> +$QEMU_IMG info --image-opts --object $obj1 \
>>>>      driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cred=
s=3Dtls0 \
>>>>      2>&1 | sed "s/$nbd_tcp_port/PORT/g"
>>>> -$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj \
>>>> +$QEMU_IMG info --image-opts --object $obj2 \
>>>> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cred=
s=3Dtls0 \
>>>> +    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
>>>> +$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj1 =
\
>>>>      --tls-creds=3Dtls0
>>>
>>> It looks like you have both a positive and negative test that a qemu-=
img
>>> client can only connect with the right auth, but only a positive test
>>> for a qemu-nbd --list client.  Should we also duplicate the
>>> QEMU_NBD_PROG line to use $obj2 for a negative test?
>>
>> I can look at that
>=20
> On reflection I don't think that's needed. This is a server side featur=
e we
> are validating. As such it is sufficient to validate with any client ap=
p
> supporting TLS. IOW, qemu-img is sufficient to prove the server side fe=
ature
> is working correctly.

There's two things being validated in this test: does the server
properly honor authorization (accepting/denying clients as appropriate),
and does the client properly expose a way to pass correct credentials.
You're right that once we've tested that the server can reject at least
one client lacking credentials, we don't need any more negative tests
(the server will reject any other client without credentials); and as
long as both clients that we care about (qemu-img, qemu-nbd --list) have
at least one positive test, then we've covered that each important
client has a way to provide the required credentials.

Okay, I can live with your claim that we have sufficient coverage, and
don't need anything more with --list (for this test, where the server is
accepting regardless of client certificate).

>>>> +echo "=3D=3D check TLS with authorization =3D=3D"
>>>> +
>>>> +nbd_server_stop
>>>> +
>>>> +nbd_server_start_tcp_socket \
>>>> +    --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dser=
ver,id=3Dtls0,verify-peer=3Dyes \
>>>> +    --object "authz-simple,identity=3DCN=3Dlocalhost,,O=3DCthulu Da=
rk Lord Enterprises client1,,L=3DR'lyeh,,C=3DSouth Pacific,id=3Dauthz0" \
>>>> +    --tls-authz authz0 \
>>>> +    --tls-creds tls0 \
>>>> +    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
>>>> +
>>>> +$QEMU_IMG info --image-opts \
>>>> +    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dcli=
ent,id=3Dtls0 \
>>>> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cred=
s=3Dtls0
>>>> +
>>>> +$QEMU_IMG info --image-opts \
>>>> +    --object tls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dcli=
ent,id=3Dtls0 \
>>>> +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cred=
s=3Dtls0
>>>
>>> Similarly, do we want --list testing here?
>>
>> I'll have a look.
>=20
> For same reason as above, we don't need to repeat with qemu-nbd --list

Here, it's a bit fuzzier - now that the server DOES require the client
to use a correct certificate (you're showing that the server accepts
client 1 but rejects client 2, because they used a different
certificate).  But, since client 1 is the same here as it was before,
and the earlier test showed how to let qemu-nbd --list as client give
the same credentials as before, I can also live with the notion that we
don't need a --list test here (the server being stricter about
certificates doesn't change that the client can still pass the correct
certificate).

Okay.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
