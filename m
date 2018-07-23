Received: from eggs.gnu.org ([2001:4830:134:3::10]:46769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhdj5-00047a-PL
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhdj4-0006ES-Tc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:30:23 -0400
Date: Mon, 23 Jul 2018 17:30:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180723163011.GH20596@stefanha-x1.localdomain>
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
	<a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 03:11:14PM -0400, Farhan Ali wrote:
> I am seeing another issue pop up, in a different test. Even though it's a
> different assertion, it might be related based on the call trace.

Which test case?

> Stack trace of thread 276199:
> #0  0x000003ff8473e274 raise (libc.so.6)
> #1  0x000003ff847239a8 abort (libc.so.6)
> #2  0x000003ff847362ce __assert_fail_base (libc.so.6)
> #3  0x000003ff8473634c __assert_fail (libc.so.6)
> #4  0x000002aa30aba0c4 iov_memset (qemu-system-s390x)
> #5  0x000002aa30aba9a6 qemu_iovec_memset (qemu-system-s390x)
> #6  0x000002aa30a23e88 qemu_laio_process_completion (qemu-system-s390x)

What are the values of laiocb->qiov->size and laiocb->ret?

> #7  0x000002aa30a23f68 qemu_laio_process_completions (qemu-system-s390x)
> #8  0x000002aa30a2418e qemu_laio_process_completions_and_submit
> (qemu-system-s390x)
> #9  0x000002aa30a24220 qemu_laio_poll_cb (qemu-system-s390x)
> #10 0x000002aa30ab22c4 run_poll_handlers_once (qemu-system-s390x)
> #11 0x000002aa30ab2e78 aio_poll (qemu-system-s390x)
> #12 0x000002aa30a29f4e bdrv_do_drained_begin (qemu-system-s390x)
> #13 0x000002aa30a2a276 bdrv_drain (qemu-system-s390x)
> #14 0x000002aa309d45aa bdrv_set_aio_context (qemu-system-s390x)
> #15 0x000002aa3085acfe virtio_blk_data_plane_stop (qemu-system-s390x)
> #16 0x000002aa3096994c virtio_bus_stop_ioeventfd.part.1 (qemu-system-s390=
x)
> #17 0x000002aa3087d1d6 virtio_vmstate_change (qemu-system-s390x)
> #18 0x000002aa308e8a12 vm_state_notify (qemu-system-s390x)
> #19 0x000002aa3080ed54 do_vm_stop (qemu-system-s390x)
> #20 0x000002aa307bea04 main (qemu-system-s390x)
> #21 0x000003ff84723dd2 __libc_start_main (libc.so.6)
> #22 0x000002aa307c0414 _start (qemu-system-s390x)
>=20
>=20
> The failing assertion is:
>=20
> qemu-kvm: util/iov.c:78: iov_memset: Assertion `offset =3D=3D 0' failed.

I wonder if the offset is beyond the end of the iovecs.

Thanks,
Stefan

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbVgKTAAoJEJykq7OBq3PITBcH/0aa3mFBCw+XH3W2p8yrSe9c
ICO9mCB8gaq06TIXXJVLLybdYc8nhfsUtRRUgjIEEk7RXzu2gCYKPs9+YCPHppdw
dBfJYsEFef5znOtnMOSeLZrwwRx96pBesroK74Yc8Zm5D9DagL4Nrkcw7V0Imufy
3WSe/P1DRVI9xw6pylXVtG+/RA/1l8YYrd4r6+ZEAD+TEL7q2pY76fBocxSvulBi
RaDbTK+meE5Gl7Jd47yB4sJGveta+TxcUD9kNKWmD9UZ6wl/D+PlREAVAA6EooOi
F7OeNtvyM7YIR5igbz4ZcvVyZctrNRYyE8XK6UMhtoIWeEH5hSY309g1fa1gQ+E=
=Plvu
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
