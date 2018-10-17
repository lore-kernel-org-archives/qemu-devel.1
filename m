Received: from eggs.gnu.org ([2001:4830:134:3::10]:48187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiQf-0004ek-1W
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCiQZ-0001gQ-IC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:47:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gCiQZ-0001ct-5t
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:47:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 193-v6so1437250wme.3
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:47:43 -0700 (PDT)
Date: Wed, 17 Oct 2018 10:47:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017094740.GJ22755@stefanha-x1.localdomain>
References: <20181016152712.qpvjter6w47azcri@SPB-NB-133.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
In-Reply-To: <20181016152712.qpvjter6w47azcri@SPB-NB-133.local>
Subject: Re: [Qemu-devel] modern virtio on HVF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: qemu-devel@nongnu.org


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 06:27:12PM +0300, Roman Bolshakov wrote:
> Hello dear subscribers,
>=20
> I'm running Linux in QEMU on macOS with hvf accel enabled and having an
> issue that is very similar to the KVM bug in nested KVM environments,
> where KVM is run under another hypervisor:
> https://bugs.launchpad.net/qemu/+bug/1636217
>=20
>=20
> The symptomps are the same as in the bug above. udev hangs unless:
> * -machine type=3Dpc-i440fx-X, where X <=3D2.6 is used
> * -accel tcg is used
> * -global virtio-pci.disable-modern=3Don is specified
>=20
> The issue was briefly noted on packer mailing list:
> https://groups.google.com/forum/#!topic/packer-tool/je2D0LRhWj0
>=20
> If I send Magic SysRQ-t to the VM, I can notice virtio_pci hangs
> indefinetly in vp_reset:
> [   48.604482] systemd-udevd   D    0   121    106 0x00000100
> [   48.608093] Call Trace:
> [   48.609701]  ? __schedule+0x292/0x880
> [   48.612076]  schedule+0x32/0x80
> [   48.614189]  schedule_timeout+0x15e/0x300
> [   48.616840]  ? call_timer_fn+0x140/0x140
> [   48.619375]  msleep+0x2a/0x40
> [   48.621284]  vp_reset+0x27/0x50 [virtio_pci]
> [   48.624185]  register_virtio_device+0x71/0x100 [virtio]
> [   48.627689]  virtio_pci_probe+0xad/0x120 [virtio_pci]
> [   48.630825]  local_pci_probe+0x44/0xa0
> [   48.633357]  pci_device_probe+0x127/0x140
> [   48.636085]  driver_probe_device+0x297/0x450
> [   48.638876]  __driver_attach+0xd9/0xe0
> [   48.641484]  ? driver_probe_device+0x450/0x450
> [   48.644393]  bus_for_each_dev+0x5a/0x90
> [   48.646879]  bus_add_driver+0x41/0x260
> [   48.649279]  driver_register+0x5b/0xd0
> [   48.651703]  ? 0xffffffffc00ac000
> [   48.653994]  do_one_initcall+0x50/0x1b0
> [   48.656496]  do_init_module+0x5a/0x1fa
> [   48.659001]  load_module+0x1557/0x1ed0
> [   48.661507]  ? m_show+0x1b0/0x1b0
> [   48.663725]  ? security_capable+0x47/0x60
> [   48.666435]  SYSC_finit_module+0x80/0xb0
> [   48.669021]  do_syscall_64+0x74/0x150
> [   48.671222]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [   48.674565] RIP: 0033:0x7f71dac73139
> [   48.677050] RSP: 002b:00007ffdcfd35058 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
> [   48.681997] RAX: ffffffffffffffda RBX: 000055d25bd01500 RCX: 00007f71d=
ac73139
> [   48.686608] RDX: 0000000000000000 RSI: 00007f71db5af83d RDI: 000000000=
000000f
> [   48.691191] RBP: 00007f71db5af83d R08: 0000000000000000 R09: 000000000=
0000000
> [   48.695750] R10: 000000000000000f R11: 0000000000000246 R12: 000000000=
0020000
> [   48.700568] R13: 000055d25bd039b0 R14: 0000000000000000 R15: 000000000=
3938700
>=20
> It looks like virtio backend doesn't return 0 device status after
> vp_iowrite8 and vp_reset blocks udev:
>         while (vp_ioread8(&vp_dev->common->device_status))
>                         msleep(1)
>=20
> What could be the cause of the issue?
> Any advices how to triage it are appreciated.

I wonder what happened in virtio_pci_probe() ->
virtio_pci_modern_probe().  For example, were the BARs properly set up?

For starters you can debug the QEMU process to check if
virtio_pci_common_read/write() get called for this device (disable all
other virtio devices to make life easy).  If these functions aren't
being called then the guest either got the address wrong or dispatch
isn't working for some other reason (hvf?).

Stefan

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwU8AAoJEJykq7OBq3PIL2kH/2vXMZTicGZLtOgcVFbC1f0G
FCalsd3IfiKn9ty+JxAfYlQ4rCQ8DSQqG5g/mZPrkNP+pJyW0u4f/2pzOiQ2o9k3
x3gygBRtb6Ar7e+Hulqqx9PsCwhIH2tMncDZmAM7JX/6ntFgG4bYIJhS8hY97hW9
Lk9S20Z0KFm+x75kxhtRfsHaDpO5kFzMcN/gpiAS8WrOii7D8SPbrLbVflJ71azR
nrDLpJ1QBuKkw1jikNNmMfLQvxPyBLD/5KVNmCB8Bqx7/PO8ov8Pn3engw+AE30K
+A0bNTPLthi6mKxCRHSMVTImod9g4Vb7Tjhhtt8b08JqFltiKqgInjPiTLPlJAM=
=v3dK
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
