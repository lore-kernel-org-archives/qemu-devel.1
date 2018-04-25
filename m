Received: from eggs.gnu.org ([2001:4830:134:3::10]:43020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo.btrfs@gmx.com>) id 1fBKYw-0007iB-Jm
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo.btrfs@gmx.com>) id 1fBKYt-0007eK-HG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:34:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:58103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quwenruo.btrfs@gmx.com>)
	id 1fBKYt-0007ct-6q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:34:19 -0400
References: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
	<20180425131833.GK30024@redhat.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <42c2c567-8bca-69db-c27d-6e0af4f0e20d@gmx.com>
Date: Wed, 25 Apr 2018 21:33:48 +0800
MIME-Version: 1.0
In-Reply-To: <20180425131833.GK30024@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gjgsKjFBZvA1TDamYscwhlyMtaLtDVG2m"
Subject: Re: [Qemu-devel] ridiculously slow VM memory performance on Ryzen
 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gjgsKjFBZvA1TDamYscwhlyMtaLtDVG2m
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <42c2c567-8bca-69db-c27d-6e0af4f0e20d@gmx.com>
Subject: Re: [Qemu-devel] ridiculously slow VM memory performance on Ryzen CPU
References: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
 <20180425131833.GK30024@redhat.com>
In-Reply-To: <20180425131833.GK30024@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 21:18, Daniel P. Berrang=C3=A9 wro=
te:
> On Wed, Apr 25, 2018 at 05:48:42PM +0800, Qu Wenruo wrote:
>> Hi,
>>
>> When testing IO heavy work on my VM backed by Ryzen 1700 CPU, I turned=

>> to brd modules, but surprisingly, the speed is even slower than some H=
DD:
>>
>> ---
>> $ sudo modprobe brd rd_nr=3D1 rd_size=3D1048576
>> $ dd if=3D/dev/zero of=3D/dev/ram0 bs=3D1M count=3D1024
>> 1024+0 records in
>> 1024+0 records out
>> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 9.9928 s, 107 MB/s
>> ---
>> 107MB is pretty lame...
>> Even some HDD could be faster than this.
>=20
> You are sure that QEMU is actually using KVM, and not TCG emulation
> mode, as that could account for such terrible numbers. The QEMU
> argv would confirm this or can query it live with
>=20
>    virsh qemu-monitor-command --hmp $GUESTNAME "info kvm"
>=20
>> On host, it's much better:
>> ---
>> $ if=3D/dev/zero of=3D/dev/ram0 bs=3D1M count=3D1024
>> 1024+0 records in
>> 1024+0 records out
>> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.754641 s, 1.4 GB/s
>> ---
>>
>> For host hardware:
>> CPU: Ryzen 1700 All cores @ 3.8G
>> Mem: DDR4 2400 dual channel (8G x 2)
>>
>> For host software:
>> Kernel:       4.16.3-1-ARCH
>> Qemu:         2.11.1-2
>> Distribution: Archlinux
>>
>> VM setup is mostly default setup done by libvirt.
>=20
> Ideally please share the guest XML description from 'virsh dumpxml $GUE=
STNAME'
> and the corresponding QEMU argv from /var/log/libvirt/qemu/$GUESTNAME.l=
og

It turns out that my debugging config (KASAN + lockdep, maybe something
else) is causing the problem.

With lockdep only, the guest degrades to about 50% of host memory
performance.
With lockde + KASAN, only 10% of host.

So, in short, I'm just an idiot.
Sorry for the trouble.

Thanks,
Qu

>=20
> Regards,
> Daniel
>=20


--gjgsKjFBZvA1TDamYscwhlyMtaLtDVG2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlrgg7wACgkQwj2R86El
/qgetgf+OoA+94iQjMcawMoLFUVc9a3gHUPNYKpyyLPQd9FEISLNASXAC7sPSpQH
SlERayUuTxlDTdqUOGNCMjDHL7qC6Uf4rJ3Xi+/k2LizN14UBPYuhG4Gj9r1gvZU
HMiI1JzNp3/Aw1mGzx5Dr+gpgQjwAMLb/Sw0WOF5lPqKfH0IeMeoOHJl7kqh2XUG
MvU1i/NZ3XbTbjs8cGL6lq1vg1/9x76Gsc1xsy1RLdN20Vh4kdyLMmRHf98agNe5
wnv+3ycozMd/GlSz0oy8rDo/epaTVM/n6XrnMh+ZbpZYiFUlz05/Vcm28uEvw1Y6
qC+xfh3iNcYjVrSWEWepZuIwQbCWDg==
=RW8W
-----END PGP SIGNATURE-----

--gjgsKjFBZvA1TDamYscwhlyMtaLtDVG2m--
