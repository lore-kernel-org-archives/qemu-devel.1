Received: from eggs.gnu.org ([2001:4830:134:3::10]:43842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCqNH-0004Dq-QF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCqNG-00038x-Db
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:12:19 -0500
Date: Thu, 9 Nov 2017 17:12:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109171210.GD25162@stefanha-x1.localdomain>
References: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <1508816031-82709-1-git-send-email-sochin.jiang@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] throttle: fix a qemu crash
 problem when calling blk_delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sochin jiang <sochin.jiang@huawei.com>
Cc: berto@igalia.com, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com, qemu-devel@nongnu.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2017 at 11:33:51AM +0800, sochin jiang wrote:
> commit 7ca7f0 moves the throttling related part of the BDS life cycle
> management to BlockBackend, adds call to
> throttle_timers_detach_aio_context in blk_remove_bs.  commit 1606e
> remove a block device from its throttle group in blk_delete by calling
> blk_io_limits_disable, this fix an easily reproducible qemu crash. But
> delete a BB without a BDS inserted could easily cause a qemu crash too
> by calling bdrv_drained_begin in blk_io_limits_disable. Say, a simply
> drive_add and then a drive_del command.
>=20
> This patch removes draining BDS by calling throttle_group_unregister_tgm
> directly instead of blk_io_limits_disable, leaves draining operation to
> blk_remove_bs in case that there is no BDS inserted. Futhermore, make sure
> throttle timers are initialized or attached before throttle_timers_destroy
> is called in throttle_group_unregister_tgm.
>=20
> Signed-off-by: sochin jiang <sochin.jiang@huawei.com>
> ---
>  block/block-backend.c   | 2 +-
>  block/throttle-groups.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 45d9101..39c7cca 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -341,7 +341,7 @@ static void blk_delete(BlockBackend *blk)
>      assert(!blk->name);
>      assert(!blk->dev);
>      if (blk->public.throttle_group_member.throttle_state) {
> -        blk_io_limits_disable(blk);
> +        throttle_group_unregister_tgm(&blk->public.throttle_group_member=
);

The following assertions fail without the drain when there are pending
requests:

  void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
  {
      ThrottleState *ts =3D tgm->throttle_state;
      ThrottleGroup *tg =3D container_of(ts, ThrottleGroup, ts);
      ThrottleGroupMember *token;
      int i;

      if (!ts) {
          /* Discard already unregistered tgm */
          return;
      }

      assert(tgm->pending_reqs[0] =3D=3D 0 && tgm->pending_reqs[1] =3D=3D 0=
);
      assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
      assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));

A safer approach is making blk_io_limits_disable(blk) skip the draining
when blk_bs(blk) =3D=3D NULL.  That is the only case where we are 100% sure
that there are no pending requests.

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBIxqAAoJEJykq7OBq3PIv38IALzM3PgEYSWFWzWWUU6Oc0jW
ZKKmQ4uhThmO7pT6bG3Pg7+L5AupCs0B7C/FhvlEVdbV5IKzp4iDNfAMe7hKvbVs
PX22G09wtsBmVA2zcjwDrFZH4XAwbOQw14cy7LPj5GJ9kgaEE7/ANTpe9GHd5SUG
NpOfZXL4aUZDYzNLyV620mlACEIfD7JU04FgoNuVo9i4C6TgXeZknQyFuOELrsz0
2AvIP7oDqCEIMxY6PWiPXb4zC1mhLbztkpl4sUAoc2874v/Pn+YhRO0Mc5TFEZCU
ZR/2pw+5l/EtPxXTZJbuXK00SDvzWdC4yqJzYpcQDXNnnKMej37J4ZnICsvmT+w=
=vM3p
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
