Received: from eggs.gnu.org ([2001:4830:134:3::10]:37818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QXS-0003Ev-Jn
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QXR-0006hh-QI
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:32:58 -0400
Date: Fri, 20 Apr 2018 15:32:47 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420073247.GG15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-10-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/19] test-bdrv-drain: Add
 test for node deletion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 06:39:30PM +0200, Kevin Wolf wrote:
> +static void do_test_delete_by_drain(bool detach_instead_of_delete)
> +{
> +    BlockBackend *blk;
> +    BlockDriverState *bs, *child_bs, *null_bs;
> +    BDRVTestTopState *tts;
> +    TestCoDeleteByDrainData dbdd;
> +    Coroutine *co;
> +
> +    bs = bdrv_new_open_driver(&bdrv_test_top_driver, "top", BDRV_O_RDWR,
> +                              &error_abort);
> +    bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
> +    tts = bs->opaque;
> +
> +    null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
> +                        &error_abort);
> +    bdrv_attach_child(bs, null_bs, "null-child", &child_file, &error_abort);
> +
> +    /* This child will be the one to pass to requests through to, and
> +     * it will stall until a drain occurs */
> +    child_bs = bdrv_new_open_driver(&bdrv_test, "child", BDRV_O_RDWR,
> +                                    &error_abort);
> +    child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
> +    /* Takes our reference to child_bs */
> +    tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child", &child_file,
> +                                        &error_abort);
> +
> +    /* This child is just there to be deleted
> +     * (for detach_instead_of_delete == true) */
> +    null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
> +                        &error_abort);
> +    bdrv_attach_child(bs, null_bs, "null-child", &child_file, &error_abort);

Why is null_bs created twice (with the exact same "null-child" name)?
I'm surprised that bdrv_attach_child() succeeds with a duplicate name.
Anyway, I find the duplicate null_bs confusing and I'm not sure if it's
a copy-paste mistake.

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZefAAoJEJykq7OBq3PIWloH/Rihof/41nVwcvck3889jRnd
IroL2HfkEGQOYVsWpfT9dPygZRE0LWV/pS95bfmIElk11LmMwtQat9x906pQuoUb
HdLnwHSZDE7qqdtyd7pVatJqNgF9A39MqMs+C4GB9S3B5+RJ1bAq/MHkdSG78wiX
ZvZYCN22qLAxpEj/HmDlUfww3YmMushKuyMAiUfGKdrWdAqiXr5bc43KfF6OaBKc
SC1C3TIT950NwZWLaDy1gbdf0sf3m8+xBVrNEmOFm1gMzh6eJFwkpgZawhZr2iQ2
ckANU3HF99WaXlxjI7nkf1cNxAb35EkIAzXOpa35tNneTSp5vXfrU5S1vtBgF44=
=ra4I
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
