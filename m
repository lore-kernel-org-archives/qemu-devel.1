Received: from eggs.gnu.org ([2001:4830:134:3::10]:57507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d348a-0003m3-Dl
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d348V-0004hl-VH
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:20:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d348V-0004hE-Mf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:20:23 -0400
Date: Tue, 25 Apr 2017 18:20:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170425172017.GB17122@work-vm>
References: <EC9759BC1E3E98429B5DE9A03DF86D8B59D1084B@DGGEML503-MBX.china.huawei.com>
	<20170424092320.GC2362@work-vm> <20170424095235.GH20809@redhat.com>
	<20170424102716.GE2362@work-vm> <20170424103428.GI20809@redhat.com>
	<EC9759BC1E3E98429B5DE9A03DF86D8B59D10917@DGGEML503-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EC9759BC1E3E98429B5DE9A03DF86D8B59D10917@DGGEML503-MBX.china.huawei.com>
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
To: Zhuangyanying <ann.zhuangyanying@huawei.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>, ehabkost@redhat.com

* Zhuangyanying (ann.zhuangyanying@huawei.com) wrote:
>=20
>=20
> > -----Original Message-----
> > From: Daniel P. Berrange [mailto:berrange@redhat.com]
> > Sent: Monday, April 24, 2017 6:34 PM
> > To: Dr. David Alan Gilbert
> > Cc: Zhuangyanying; Zhanghailiang; wangxin (U); qemu-devel@nongnu.org;
> > Gonglei (Arei); Huangzhichao; pbonzini@redhat.com
> > Subject: Re: [Qemu-devel] [BUG] Migrate failes between boards with di=
fferent
> > PMC counts
> >=20
> > On Mon, Apr 24, 2017 at 11:27:16AM +0100, Dr. David Alan Gilbert wrot=
e:
> > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > On Mon, Apr 24, 2017 at 10:23:21AM +0100, Dr. David Alan Gilbert =
wrote:
> > > > > * Zhuangyanying (ann.zhuangyanying@huawei.com) wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > Recently, I found migration failed when enable vPMU.
> > > > > >
> > > > > > migrate vPMU state was introduced in linux-3.10 + qemu-1.7.
> > > > > >
> > > > > > As long as enable vPMU, qemu will save / load the
> > > > > > vmstate_msr_architectural_pmu(msr_global_ctrl) register durin=
g the
> > migration.
> > > > > > But global_ctrl generated based on cpuid(0xA), the number of
> > > > > > general-purpose performance monitoring counters(PMC) can vary
> > > > > > according to Intel SDN. The number of PMC presented to vm, do=
es
> > > > > > not support configuration currently, it depend on host cpuid,=
 and enable
> > all pmc defaultly at KVM. It cause migration to fail between boards w=
ith
> > different PMC counts.
> > > > > >
> > > > > > The return value of cpuid (0xA) is different dur to cpu, acco=
rding to Intel
> > SDN=EF=BC=8C18-10 Vol. 3B:
> > > > > >
> > > > > > Note: The number of general-purpose performance monitoring
> > > > > > counters (i.e. N in Figure 18-9) can vary across processor
> > > > > > generations within a processor family, across processor
> > > > > > families, or could be different depending on the configuratio=
n
> > > > > > chosen at boot time in the BIOS regarding Intel Hyper Threadi=
ng
> > > > > > Technology, (e.g. N=3D2 for 45 nm Intel Atom processors; N =3D=
4 for
> > processors based on the Nehalem microarchitecture; for processors bas=
ed on
> > the Sandy Bridge microarchitecture, N =3D 4 if Intel Hyper Threading =
Technology
> > is active and N=3D8 if not active).
> > > > > >
> > > > > > Also I found, N=3D8 if HT is not active based on the broadwel=
l=EF=BC=8C,
> > > > > > such as CPU E7-8890 v4 @ 2.20GHz
> > > > > >
> > > > > > # ./x86_64-softmmu/qemu-system-x86_64 --enable-kvm -smp 4 -m
> > > > > > 4096 -hda
> > > > > > /data/zyy/test_qemu.img.sles12sp1 -vnc :99 -cpu kvm64,pmu=3Dt=
rue
> > > > > > -incoming tcp::8888 Completed 100 %
> > > > > > qemu-system-x86_64: error: failed to set MSR 0x38f to
> > > > > > 0x7000000ff
> > > > > > qemu-system-x86_64: /data/zyy/git/test/qemu/target/i386/kvm.c=
:1833:
> > kvm_put_msrs:
> > > > > > Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
> > > > > > Aborted
> > > > > >
> > > > > > So make number of pmc configurable to vm ? Any better idea ?
> > > > >
> > > > > Coincidentally we hit a similar problem a few days ago with -cp=
u
> > > > > host  - it took me quite a while to spot the difference between
> > > > > the machines was the source had hyperthreading disabled.
> > > > >
> > > > > An option to set the number of counters makes sense to me; but =
I
> > > > > wonder how many other options we need as well.  Also, I'm not s=
ure
> > > > > there's any easy way for libvirt etc to figure out how many
> > > > > counters a host supports - it's not in /proc/cpuinfo.
> > > >
> > > > We actually try to avoid /proc/cpuinfo whereever possible. We do
> > > > direct CPUID asm instructions to identify features, and prefer to
> > > > use /sys/devices/system/cpu if that has suitable data
> > > >
> > > > Where do the PMC counts come from originally ? CPUID or something
> > else ?
> > >
> > > Yes, they're bits 8..15 of CPUID leaf 0xa
> >=20
> > Ok, that's easy enough for libvirt to detect then. More a question of=
 what libvirt
> > should then do this with the info....
> >=20
>=20
> Do you mean to do a validation at the begining of migration? in qemuMig=
rationBakeCookie() & qemuMigrationEatCookie(), if the PMC numbers are not=
 equal, just quit migration?
> It maybe a good enough first edition.
> But for a further better edition, maybe it's better to support Heteroge=
neous migration I think, so we might need to make PMC number configrable,=
 then we need to modify KVM/qemu as well.

Yes agreed; the only thing I wanted to check was that libvirt would have =
enough
information to be able to use any feature we added to QEMU.

Dave

> Regards,
> -Zhuang Yanying
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
