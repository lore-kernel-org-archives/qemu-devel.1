Received: from eggs.gnu.org ([2001:4830:134:3::10]:44305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLqxZ-00074p-PO
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLqxY-0004cs-Db
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:06:45 -0400
References: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
	<76e5666c-ecbf-5c7d-5dbb-e1fa845d2150@redhat.com>
	<d9eea04a-9ea7-34b4-121e-f635786cac58@huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d75de7fa-e356-9324-253c-d6bb4675d9f9@redhat.com>
Date: Fri, 16 Jun 2017 15:06:28 +0200
MIME-Version: 1.0
In-Reply-To: <d9eea04a-9ea7-34b4-121e-f635786cac58@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1ujXWAbASDBmDdQ3l4lH449DsbOtRpMl7"
Subject: Re: [Qemu-devel] [PATCH] fix: avoid infinite loop when blockjob
 encountering failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1ujXWAbASDBmDdQ3l4lH449DsbOtRpMl7
From: Max Reitz <mreitz@redhat.com>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com,
 subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com,
 zhangshuai13@huawei.com, lizhengui@huawei.com
Message-ID: <d75de7fa-e356-9324-253c-d6bb4675d9f9@redhat.com>
Subject: Re: [PATCH] fix: avoid infinite loop when blockjob encountering
 failure
References: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
 <76e5666c-ecbf-5c7d-5dbb-e1fa845d2150@redhat.com>
 <d9eea04a-9ea7-34b4-121e-f635786cac58@huawei.com>
In-Reply-To: <d9eea04a-9ea7-34b4-121e-f635786cac58@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-15 04:38, sochin.jiang wrote:
> Thanks for your kindly reply.
>=20
> I do have made a mistake that ignoring the AIOContext lock.
>=20
> About the patch, firstly, if job->ret comes to be non-zero(also means j=
ob->completed to be true) , blockjob 'callback'(common_block_job_cb) will=
 be called, blockjob error will be put into errp. It won't report success=
=2E

Oh, right, good.

> Secondly, blockjob fails with 'ret < 0' and without calling block_job_c=
omplete_sync(), we won't have segfault because bdrv_reopen won't be calle=
d.
commit_active_start() invokes bdrv_reopen(), and that segfaults for me
if the backing file is a bit unusual. See:

$ qemu-img create -f qcow2 \
    -b "json:{'driver':'raw','file':{
            'driver':'blkdebug','inject-error':[{
                'event':'write_aio','once':true
            }],
            'image':{'driver':'null-co'}}}" \
    overlay.qcow2
$ qemu-img commit overlay.qcow2
[1]    11080 segmentation fault (core dumped)  qemu-img commit overlay.qc=
ow2

Same if you actually write something to the overlay to trigger the write
error (which would fail the block job).

Yes, not directly related to your patch, which is why I've fixed it mysel=
f:
http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00424.html

> Also, with the use-after-free problems.

No, but I see you noticed that. :-)

Max


--1ujXWAbASDBmDdQ3l4lH449DsbOtRpMl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZQ9fVEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGPq
B/9ucbGjFAf5WsiVEGHps/9qvjtC6TTC+RtL9yXYoP3bJtdApNDNNgAz1AghL5kk
Hei+pVF5pRHDFyZ44JmYmZ0m2vtJqThbPv1+pmpwlJ96ezeptkEFv2QH4dvuDXGD
sUgLf51NUqBRCpVuLUVM0S4oWYPUbofV9q1s44diI4AmqhR2+Xrm7qG4hVkN5r03
o8IxiGOwxN6MAVO23fsSr5upkj+XxC+Jv9ytF2syoPa+fCwCS9pV7On2PhH2r3w7
YfbTyTsKekfXmHPAiTeVLT/HLPudOUqJRzOUhwivx5JDLwaQYf8Q9ZTzNKj+G0Oa
vDb5/3DiVtJckcS7MImZMuid
=XdNz
-----END PGP SIGNATURE-----

--1ujXWAbASDBmDdQ3l4lH449DsbOtRpMl7--
