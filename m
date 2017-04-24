Received: from eggs.gnu.org ([2001:4830:134:3::10]:53353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2aDT-00071n-Os
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2aDP-0006St-QF
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2aDP-0006RS-IL
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:23:27 -0400
Date: Mon, 24 Apr 2017 10:23:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424092320.GC2362@work-vm>
References: <EC9759BC1E3E98429B5DE9A03DF86D8B59D1084B@DGGEML503-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EC9759BC1E3E98429B5DE9A03DF86D8B59D1084B@DGGEML503-MBX.china.huawei.com>
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Zhuangyanying (ann.zhuangyanying@huawei.com) wrote:
> Hi all,
>=20
> Recently, I found migration failed when enable vPMU.
>=20
> migrate vPMU state was introduced in linux-3.10 + qemu-1.7.
>=20
> As long as enable vPMU, qemu will save / load the
> vmstate_msr_architectural_pmu(msr_global_ctrl) register during the migr=
ation.
> But global_ctrl generated based on cpuid(0xA), the number of general-pu=
rpose performance
> monitoring counters(PMC) can vary according to Intel SDN. The number of=
 PMC presented
> to vm, does not support configuration currently, it depend on host cpui=
d, and enable all pmc
> defaultly at KVM. It cause migration to fail between boards with differ=
ent PMC counts.
>=20
> The return value of cpuid (0xA) is different dur to cpu, according to I=
ntel SDN=EF=BC=8C18-10 Vol. 3B:
>=20
> Note: The number of general-purpose performance monitoring counters (i.=
e. N in Figure 18-9)
> can vary across processor generations within a processor family, across=
 processor families, or
> could be different depending on the configuration chosen at boot time i=
n the BIOS regarding
> Intel Hyper Threading Technology, (e.g. N=3D2 for 45 nm Intel Atom proc=
essors; N =3D4 for processors
> based on the Nehalem microarchitecture; for processors based on the San=
dy Bridge
> microarchitecture, N =3D 4 if Intel Hyper Threading Technology is activ=
e and N=3D8 if not active).
>=20
> Also I found, N=3D8 if HT is not active based on the broadwell=EF=BC=8C=
,
> such as CPU E7-8890 v4 @ 2.20GHz  =20
>=20
> # ./x86_64-softmmu/qemu-system-x86_64 --enable-kvm -smp 4 -m 4096 -hda
> /data/zyy/test_qemu.img.sles12sp1 -vnc :99 -cpu kvm64,pmu=3Dtrue -incom=
ing tcp::8888
> Completed 100 %
> qemu-system-x86_64: error: failed to set MSR 0x38f to 0x7000000ff
> qemu-system-x86_64: /data/zyy/git/test/qemu/target/i386/kvm.c:1833: kvm=
_put_msrs:=20
> Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
> Aborted
>=20
> So make number of pmc configurable to vm ? Any better idea ?

Coincidentally we hit a similar problem a few days ago with -cpu host  - =
it took me
quite a while to spot the difference between the machines was the source
had hyperthreading disabled.

An option to set the number of counters makes sense to me; but I wonder
how many other options we need as well.  Also, I'm not sure there's any
easy way for libvirt etc to figure out how many counters a host supports =
- it's
not in /proc/cpuinfo.

Dave

>=20
> Regards,
> -Zhuang Yanying
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
