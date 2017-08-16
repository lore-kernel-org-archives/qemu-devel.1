Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhwXm-0004j7-SH
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dhwXj-00005C-Lh
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dhwXj-0008Vb-Bv
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:31:23 -0400
References: <1502782095-3912-1-git-send-email-wang.yong155@zte.com.cn>
	<20170816095238.GE3180@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ba3aee4-4aa4-2fc8-f04e-264ed6f8d51b@redhat.com>
Date: Wed, 16 Aug 2017 13:30:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170816095238.GE3180@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kmkJ5hfpfo9viwpRAXaNEb8vSnkBxJnDJ"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-iothread: IOThread supports the
 GMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Wang yong <wang.yong155@zte.com.cn>
Cc: stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, wang.guang55@zte.com.cn, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kmkJ5hfpfo9viwpRAXaNEb8vSnkBxJnDJ
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Wang yong <wang.yong155@zte.com.cn>
Cc: stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com,
 zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com,
 wang.guang55@zte.com.cn, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com
Message-ID: <0ba3aee4-4aa4-2fc8-f04e-264ed6f8d51b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-iothread: IOThread supports the
 GMainContext event loop
References: <1502782095-3912-1-git-send-email-wang.yong155@zte.com.cn>
 <20170816095238.GE3180@stefanha-x1.localdomain>
In-Reply-To: <20170816095238.GE3180@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 16/08/2017 11:52, Stefan Hajnoczi wrote:
>=20
>     while (!atomic_read(&iothread->stopping)) {
> 	if (atomic_read(&iothread->use_glib_event_loop)) {
> 	    iothread_glib_event_loop();
> 	    break;
>         }
>=20
>         aio_poll(iothread->ctx, true);
>     }

Alternatively:

    while (!atomic_read(&iothread->stopping)) {
        aio_poll(iothread->ctx, true);
    }

    if (atomic_read(&iothread->worker_context)) {
	iothread_glib_event_loop();
    }

and you can use this to enter the glib event loop:

    iothread->stopping =3D true;
    aio_notify(iothread->ctx);

(similar to iothread_stop).

Thanks,

Paolo


--kmkJ5hfpfo9viwpRAXaNEb8vSnkBxJnDJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmULPUACgkQv/vSX3jH
roOkyQgAiC5Onjov//vBFvuesOVQm5+CfVstUF3iT+PbsiERJho+VAKKRUwLV80u
P6Bdxy/W8PemkqjVkAH2bCr+eXL019aHlyyZBgi5075sAIBjV6sRvrTDKEJfoIoi
6I9I5EqwhZF+jK4EXYT9mG1SPHVJ7wJd6ZNSCiRkrSgsJQC+1GhNZclLqgzQCWG1
9vGFk5OqbQ1ZnNpVWzkKroC2ESwO5bwyJRrZ/ZLOOFcVi4bSNrZLQHRDN48GMOoz
6boKdOty0TZqrTH+fouItFPMzB1Zrr1FJZbRUa673RAeSVB4old7Sm48qawViOs0
lfpv4D9DV8JRPUzLE1CSvRqnQJbA6g==
=6dIA
-----END PGP SIGNATURE-----

--kmkJ5hfpfo9viwpRAXaNEb8vSnkBxJnDJ--
