Received: from eggs.gnu.org ([2001:4830:134:3::10]:56242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gregkh@linuxfoundation.org>) id 1chCfU-00017X-W9
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gregkh@linuxfoundation.org>) id 1chCfR-000732-S2
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:00:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gregkh@linuxfoundation.org>)
	id 1chCfR-0006y8-NO
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:00:01 -0500
Date: Fri, 24 Feb 2017 10:59:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20170224095951.GA11626@kroah.com>
References: <589D83CE.1090803@huawei.com> <589DDC05.9010807@windriver.com>
	<58AA51D6.6020508@huawei.com> <1487565495.3740.27.camel@intel.com>
	<58AD0094.90304@windriver.com>
	<4dd92012-626a-2d80-9adb-0be398f73eb1@redhat.com>
	<58AD92AE.6040502@windriver.com>
	<6c5567f4-192d-aefd-90e4-89f53479c24e@redhat.com>
	<58AF9921.6060201@huawei.com> <58AFFE55.20306@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58AFFE55.20306@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] kvm bug in __rmap_clear_dirty during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chris Friesen <chris.friesen@windriver.com>, "Han, Huaitong" <huaitong.han@intel.com>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, stable@vger.kernel.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "fangying1@huawei.com" <fangying1@huawei.com>, "xudong.hao@linux.intel.com" <xudong.hao@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com" <wangxinxin.wang@huawei.com>, "kai.huang@linux.intel.com" <kai.huang@linux.intel.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "guangrong.xiao@linux.intel.com" <guangrong.xiao@linux.intel.com>, linux-kernel@vger.kernel.org

On Fri, Feb 24, 2017 at 05:35:17PM +0800, Herongguang (Stephen) wrote:
>=20
>=20
> On 2017/2/24 10:23, Herongguang (Stephen) wrote:
> >=20
> >=20
> > On 2017/2/22 22:43, Paolo Bonzini wrote:
> > >=20
> > >=20
> > > On 22/02/2017 14:31, Chris Friesen wrote:
> > > > > >=20
> > > > >=20
> > > > > Can you reproduce it with kernel 4.8+?  I'm suspecting commmit
> > > > > 4e59516a12a6 ("kvm: vmx: ensure VMCS is current while enabling =
PML",
> > > > > 2016-07-14) to be the fix.
> > > >=20
> > > > I can't easily try with a newer kernel, the software package we'r=
e using
> > > > has kernel patches that would have to be ported.
> > > >=20
> > > > I'm at a conference, don't really have time to set up a pair of t=
est
> > > > machines from scratch with a custom kernel.
> > >=20
> > > Hopefully Gaohuai and Rongguang can help with this too.
> > >=20
> > > Paolo
> > >=20
> > > .
> > >=20
> > Yes, we are looking into and testing this.
> >=20
> > I think this can result in any memory corruption, if VM1 writes its
> > PML buffer into VM2=E2=80=99s VMCS (since sched_in/sched_out notifier=
 of VM1
> > is not registered yet), then VM1 is destroyed (hence its PML buffer
> > is freed back to kernel), after that, VM2 starts migration, so CPU
> > logs VM2=E2=80=99s dirty GFNS into a freed memory, results in any mem=
ory corruption.
> >=20
> > As its severity, this commit (http://git.kernel.org/cgit/linux/kernel=
/git/torvalds/linux.git/commit/?id=3D4e59516a12a6ef6dcb660cb3a3f70c64bd60=
cfec)
> > is eligible to back port to kernel stable.
>=20
> Hi, Greg, can you cherry pick commit 4e59516a12a6ef6dcb660cb3a3f70c64bd=
60cfec to 4.4-y?

If the KVM maintainers say it is ok to do so, yes, I will.

thanks,

greg k-h
