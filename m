Received: from eggs.gnu.org ([2001:4830:134:3::10]:44649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZBJ-0005hg-F6
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZBF-0006pT-CU
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:26:33 -0400
Date: Fri, 3 Nov 2017 10:26:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103102626.GH5078@stefanha-x1.localdomain>
References: <68B56AECEFB25A418ADB9417F6178A531091A91B@dggemi507-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <68B56AECEFB25A418ADB9417F6178A531091A91B@dggemi507-mbs.china.huawei.com>
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BQemu-block=5D_question=EF=BC=9A_I_foun?=
 =?utf-8?q?d_a_qemu_crash_when_attach_virtio-scsi_disk?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lizhengui <lizhengui@huawei.com>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Fangyi (C)" <eric.fangyi@huawei.com>


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2017 at 06:42:33AM +0000, lizhengui wrote:
> Hi, when I attach virtio-scsi disk to VM, the qemu crash happened at very=
 low probability.=20
>=20
> The qemu crash bt is below:
>=20
> #0  0x00007f2be3ada1d7 in raise () from /usr/lib64/libc.so.6
> #1  0x00007f2be3adb8c8 in abort () from /usr/lib64/libc.so.6
> #2  0x000000000084fe49 in PAT_abort ()
> #3  0x000000000084ce8d in patchIllInsHandler ()
> #4  <signal handler called>
> #5  0x00000000008228bb in qemu_strnlen ()
> #6  0x0000000000822934 in strpadcpy ()
> #7  0x0000000000684a88 in scsi_disk_emulate_inquiry ()
> #8  0x000000000068744b in scsi_disk_emulate_command ()
> #9  0x000000000068c481 in scsi_req_enqueue ()
> #10 0x00000000004b1f00 in virtio_scsi_handle_cmd_req_submit ()
> #11 0x00000000004b2e9e in virtio_scsi_handle_cmd_vq ()
> #12 0x000000000076dba7 in aio_dispatch ()
> #13 0x000000000076dd96 in aio_poll ()
> #14 0x00000000007a8673 in blk_prw ()
> #15 0x00000000007a922c in blk_pread ()
> #16 0x00000000007a9cd0 in blk_pread_unthrottled ()
> #17 0x00000000005cb404 in guess_disk_lchs ()
> #18 0x00000000005cb5b4 in hd_geometry_guess ()
> #19 0x00000000005cad56 in blkconf_geometry ()
> #20 0x0000000000685956 in scsi_realize ()
> #21 0x000000000068d3e3 in scsi_qdev_realize ()
> #22 0x00000000005e3938 in device_set_realized ()
> #23 0x000000000075bced in property_set_bool ()
> #24 0x0000000000760205 in object_property_set_qobject ()
> #25 0x000000000075df64 in object_property_set_bool ()
> #26 0x00000000005580ad in qdev_device_add ()
> #27 0x000000000055850b in qmp_device_add ()
> #28 0x0000000000818b37 in do_qmp_dispatch.constprop.1 ()
> #29 0x0000000000818d8b in qmp_dispatch ()
> #30 0x000000000045d212 in handle_qmp_command ()
> #31 0x000000000081f819 in json_message_process_token ()
> #32 0x00000000008434d0 in json_lexer_feed_char ()
> #33 0x00000000008435e6 in json_lexer_feed ()
> #34 0x000000000045bd72 in monitor_qmp_read ()
> #35 0x000000000055ecf3 in tcp_chr_read ()
> #36 0x00007f2be4cf899a in g_main_context_dispatch () from /usr/lib64/libg=
lib-2.0.so.0
> #37 0x000000000076b86b in os_host_main_loop_wait ()
> #38 0x000000000076b995 in main_loop_wait ()
> #39 0x0000000000569c51 in main_loop ()
> #40 0x0000000000420665 in main ()
>=20
> From the qemu crash bt, we can see that the scsi_realize has not complete=
d yet. Some fields sush as vendor, version in SCSIDiskState is=20
> Null at this moment. If qemu handles scsi request from this scsi disk at =
this moment, the qemu will access some null pointers and cause crash.
> How can I solve this problem? Should we add a check that whether the scsi=
 disk has realized or not in scsi_disk_emulate_command before
> Handling scsi requests?=20

Please try this patch:

diff --git a/hw/block/block.c b/hw/block/block.c
index 27878d0087..df99ddb899 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -120,9 +120,16 @@ void blkconf_geometry(BlockConf *conf, int *ptrans,
         }
     }
     if (!conf->cyls && !conf->heads && !conf->secs) {
+        AioContext *ctx =3D blk_get_aio_context(conf->blk);
+
+        /* Callers may not expect this function to dispatch aio handlers, =
so
+         * disable external aio such as guest device emulation.
+         */
+        aio_disable_external(ctx);
         hd_geometry_guess(conf->blk,
                           &conf->cyls, &conf->heads, &conf->secs,
                           ptrans);
+        aio_enable_external(ctx);
     } else if (ptrans && *ptrans =3D=3D BIOS_ATA_TRANSLATION_AUTO) {
         *ptrans =3D hd_bios_chs_auto_trans(conf->cyls, conf->heads, conf->=
secs);
     }

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/ERRAAoJEJykq7OBq3PIvKcIAJOlaTv6Y0VafbQ/DZe0Q0mV
VgtHAJZTTVZjdo786D7yZCdPl2MwZYXYDwaoiCrXoSMCF7UTdqyDOfWwxRTKVBs0
nkq21PlcmR6WccMEJkGL51JWIbDZyMw7PqNuGxPVi1HeTKr5monNgV8YqEIBGirJ
8lNicKHY0AmfD0C04CycdM9OWzew8MWFEcxd7tjK70zN2JWgozbeMg173ZtRGNOE
opwsTviB2qt7LZZmjTBYqMyUW+X9TBg1OxSbfTmnWbnZYfUT+tG9A7JRzGjI+CZB
7YgznPsz8AuvZB4y65pJRbDX1oondwZ+dqYprf7gDj+WEJpEcf5yal6UaGG0FO0=
=IRRz
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
