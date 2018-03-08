Received: from eggs.gnu.org ([2001:4830:134:3::10]:34031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ety0Y-0006I6-NW
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ety0T-00006C-Vv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:03:06 -0500
Date: Thu, 8 Mar 2018 16:02:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180308160258.GE2769@stefanha-x1.localdomain>
References: <20180307114459.26636-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20180307114459.26636-1-slp@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] virtio-blk: dataplane: Don't
 batch notifications if EVENT_IDX is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, sochin.jiang@huawei.com, w90p710@gmail.com


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 12:44:59PM +0100, Sergio Lopez wrote:
> Commit 5b2ffbe4d99843fd8305c573a100047a8c962327 ("virtio-blk: dataplane:
> notify guest as a batch") deferred guest notification to a BH in order
> batch notifications, with purpose of avoiding flooding the guest with
> interruptions.
>=20
> This optimization came with a cost. The average latency perceived in the
> guest is increased by a few microseconds, but also when multiple IO
> operations finish at the same time, the guest won't be notified until
> all completions from each operation has been run. On the contrary,
> virtio-scsi issues the notification at the end of each completion.
>=20
> On the other hand, nowadays we have the EVENT_IDX feature that allows a
> better coordination between QEMU and the Guest OS to avoid sending
> unnecessary interruptions.
>=20
> With this change, virtio-blk/dataplane only batches notifications if the
> EVENT_IDX feature is not present.
>=20
> Some numbers obtained with fio (ioengine=3Dsync, iodepth=3D1, direct=3D1):
>  - Test specs:
>    * fio-3.4 (ioengine=3Dsync, iodepth=3D1, direct=3D1)
>    * qemu master
>    * virtio-blk with a dedicated iothread (default poll-max-ns)
>    * backend: null_blk nr_devices=3D1 irqmode=3D2 completion_nsec=3D280000
>    * 8 vCPUs pinned to isolated physical cores
>    * Emulator and iothread also pinned to separate isolated cores
>    * variance between runs < 1%
>=20
>  - Not patched
>    * numjobs=3D1:  lat_avg=3D327.32  irqs=3D29998
>    * numjobs=3D4:  lat_avg=3D337.89  irqs=3D29073
>    * numjobs=3D8:  lat_avg=3D342.98  irqs=3D28643
>=20
>  - Patched:
>    * numjobs=3D1:  lat_avg=3D323.92  irqs=3D30262
>    * numjobs=3D4:  lat_avg=3D332.65  irqs=3D29520
>    * numjobs=3D8:  lat_avg=3D335.54  irqs=3D29323
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Thanks, applied to my block tree!

I merged this quickly because I don't want to forget this patch for the
upcoming QEMU 2.12 release.  If anyone has questions or wants to
discuss, please go ahead and I can hold back the patch.

https://github.com/stefanha/qemu/commits/block

Stefan

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaoV6yAAoJEJykq7OBq3PI6J4H/036iT+wZNhB7YXcmssft7eJ
jim6KM1A+rN54cop2Gdenc2I1ZO2cHl749YPEwBF+aUpiA6yFhB7M+NE43hcMnWn
uMmDKzdTTmm5xmbjeJXTtobUnQrU6JGdIJPlPDKKcet4HfJYLu3/vH0xKrtvfzky
GYOTc+7WxnZ3I1XQbG0uRDeork2wDs3pQzrVP7WWg2s+tABGij7+tRY258qcQRcQ
o3FjoFpjShcSUTe0F8gYhMu5ZafinWnFa2ID90Qg0bVUq+ibPrJxRG892uuxidtx
7w3ZFdZgQH8Xf+OZbUTWZmbKSukJAQpx9Inpmz7h8WyRVKICEvCZwrRTN7gA+bs=
=ohY8
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
