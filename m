Received: from eggs.gnu.org ([209.51.188.92]:47147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJlj-0006S9-Hq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJli-0007PF-3b
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:44:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gmJlh-0007CL-DH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:44:42 -0500
References: <20190123120759.7162-1-jusual@mail.ru>
	<20190123120759.7162-2-jusual@mail.ru> <87zhrrzc8l.fsf@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f1c4cff-c186-9fc3-10ee-7f628882ef82@redhat.com>
Date: Wed, 23 Jan 2019 08:44:12 -0600
MIME-Version: 1.0
In-Reply-To: <87zhrrzc8l.fsf@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x90p2ZbZ4woS7EQDh0s7OJcygA2K6dY6l"
Subject: Re: [Qemu-devel] [PATCH v5 1/3] tests/libqtest: Introduce
 qtest_init_with_serial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Julia Suvorova <jusual@mail.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x90p2ZbZ4woS7EQDh0s7OJcygA2K6dY6l
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Julia Suvorova <jusual@mail.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jim Mussared <jim@groklearning.com>
Message-ID: <8f1c4cff-c186-9fc3-10ee-7f628882ef82@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/3] tests/libqtest: Introduce
 qtest_init_with_serial()
References: <20190123120759.7162-1-jusual@mail.ru>
 <20190123120759.7162-2-jusual@mail.ru> <87zhrrzc8l.fsf@linaro.org>
In-Reply-To: <87zhrrzc8l.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 8:20 AM, Alex Benn=C3=A9e wrote:
>=20
> Julia Suvorova <jusual@mail.ru> writes:
>=20
>> Run qtest with a socket that connects QEMU chardev and test code.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20

>> +QTestState *qtest_init_with_serial(const char *extra_args, int *sock_=
fd)
>> +{
>> +    int sock_fd_init;
>> +    char *sock_path, sock_dir[] =3D "/tmp/qtest-serial-XXXXXX";
>> +    QTestState *qts;
>> +
>> +    g_assert_true(mkdtemp(sock_dir) !=3D NULL);
>> +    sock_path =3D g_strdup_printf("%s/sock", sock_dir);
>> +
>> +    sock_fd_init =3D init_socket(sock_path);
>> +
>> +    qts =3D qtest_initf("-chardev socket,id=3Ds0,path=3D%s -serial ch=
ardev:s0 %s",
>> +                      sock_path, extra_args);

EWWWW.  Please, let's not bake in this interface.  Relying on shell
splitting is nasty.


>>
>> +/**
>> + * qtest_init_with_serial:
>> + * @extra_args: other arguments to pass to QEMU.  CAUTION: these
>> + * arguments are subject to word splitting and shell evaluation.
>> + * @sock_fd: pointer to store the socket file descriptor for
>> + * connection with serial.
>> + *
>> + * Returns: #QTestState instance.
>> + */
>> +QTestState *qtest_init_with_serial(const char *extra_args, int *sock_=
fd);

I would MUCH rather see an interface that used varargs to pass extra
arguments as a list/array of actual arguments, no shell splitting require=
d.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--x90p2ZbZ4woS7EQDh0s7OJcygA2K6dY6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIfbwACgkQp6FrSiUn
Q2qQIAgAg3FtUsy7v28EBsQV+n9j2bt58Rp857lYPLuup3vibTYkQLLptS9SBKvt
ccX5mCn59gcFn2DKAURwuOlSJVwUPd3ReSDITN1NA47PZF6OpjclA4iUvm9vahvh
hexkVzw5jDWpOg30X+urhEULnULT1YuwNf000POBFlbo9w/LknMkHWNkYEtzpvqm
o5hVUkZ9CrNIeEOLlNk1X5HVe+AfBmBn6bCN8L9M/TMVH0mL6n8oLEQNYiQZebi9
ZNd9TbAhQSMsYBFMFnVAUnuGQcX9JEgtE+NhQGuDAm2o/jn2mf/yxn4ukF1JALJL
wq/8cL72tMu3+8VcQ10++0lREFaLfg==
=MhDZ
-----END PGP SIGNATURE-----

--x90p2ZbZ4woS7EQDh0s7OJcygA2K6dY6l--
