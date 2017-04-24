Received: from eggs.gnu.org ([2001:4830:134:3::10]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2bDJ-0003l7-PT
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2bDG-0003ah-K5
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:27:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2bDG-0003a6-BD
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:27:22 -0400
Date: Mon, 24 Apr 2017 11:27:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424102716.GE2362@work-vm>
References: <EC9759BC1E3E98429B5DE9A03DF86D8B59D1084B@DGGEML503-MBX.china.huawei.com>
	<20170424092320.GC2362@work-vm> <20170424095235.GH20809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170424095235.GH20809@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [BUG] Migrate failes between boards with different
 PMC counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Zhuangyanying <ann.zhuangyanying@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Mon, Apr 24, 2017 at 10:23:21AM +0100, Dr. David Alan Gilbert wrote:
> > * Zhuangyanying (ann.zhuangyanying@huawei.com) wrote:
> > > Hi all,
> > >=20
> > > Recently, I found migration failed when enable vPMU.
> > >=20
> > > migrate vPMU state was introduced in linux-3.10 + qemu-1.7.
> > >=20
> > > As long as enable vPMU, qemu will save / load the
> > > vmstate_msr_architectural_pmu(msr_global_ctrl) register during the =
migration.
> > > But global_ctrl generated based on cpuid(0xA), the number of genera=
l-purpose performance
> > > monitoring counters(PMC) can vary according to Intel SDN. The numbe=
r of PMC presented
> > > to vm, does not support configuration currently, it depend on host =
cpuid, and enable all pmc
> > > defaultly at KVM. It cause migration to fail between boards with di=
fferent PMC counts.
> > >=20
> > > The return value of cpuid (0xA) is different dur to cpu, according =
to Intel SDN=EF=BC=8C18-10 Vol. 3B:
> > >=20
> > > Note: The number of general-purpose performance monitoring counters=
 (i.e. N in Figure 18-9)
> > > can vary across processor generations within a processor family, ac=
ross processor families, or
> > > could be different depending on the configuration chosen at boot ti=
me in the BIOS regarding
> > > Intel Hyper Threading Technology, (e.g. N=3D2 for 45 nm Intel Atom =
processors; N =3D4 for processors
> > > based on the Nehalem microarchitecture; for processors based on the=
 Sandy Bridge
> > > microarchitecture, N =3D 4 if Intel Hyper Threading Technology is a=
ctive and N=3D8 if not active).
> > >=20
> > > Also I found, N=3D8 if HT is not active based on the broadwell=EF=BC=
=8C,
> > > such as CPU E7-8890 v4 @ 2.20GHz  =20
> > >=20
> > > # ./x86_64-softmmu/qemu-system-x86_64 --enable-kvm -smp 4 -m 4096 -=
hda
> > > /data/zyy/test_qemu.img.sles12sp1 -vnc :99 -cpu kvm64,pmu=3Dtrue -i=
ncoming tcp::8888
> > > Completed 100 %
> > > qemu-system-x86_64: error: failed to set MSR 0x38f to 0x7000000ff
> > > qemu-system-x86_64: /data/zyy/git/test/qemu/target/i386/kvm.c:1833:=
 kvm_put_msrs:=20
> > > Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
> > > Aborted
> > >=20
> > > So make number of pmc configurable to vm ? Any better idea ?
> >=20
> > Coincidentally we hit a similar problem a few days ago with -cpu host=
  - it took me
> > quite a while to spot the difference between the machines was the sou=
rce
> > had hyperthreading disabled.
> >=20
> > An option to set the number of counters makes sense to me; but I wond=
er
> > how many other options we need as well.  Also, I'm not sure there's a=
ny
> > easy way for libvirt etc to figure out how many counters a host suppo=
rts -
> > it's not in /proc/cpuinfo.
>=20
> We actually try to avoid /proc/cpuinfo whereever possible. We do direct
> CPUID asm instructions to identify features, and prefer to use
> /sys/devices/system/cpu if that has suitable data
>=20
> Where do the PMC counts come from originally ? CPUID or something else =
?

Yes, they're bits 8..15 of CPUID leaf 0xa

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
