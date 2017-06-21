Received: from eggs.gnu.org ([2001:4830:134:3::10]:47262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dNl6p-0002C1-7n
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dNl6l-000477-6F
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 15:16:11 -0400
Date: Wed, 21 Jun 2017 20:16:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170621191601.GB2425@work-vm>
References: <CAOE=1Z1Bbgb494m6mYRnX1-80eT0tSnF0F6zNM7efEie4rd7DA@mail.gmail.com>
	<CAOE=1Z1LJr9rpaEQ9+b7D5vM3N=Wy0oGunRnzoQ79x3dWA3oaw@mail.gmail.com>
	<CALkUq2gp+x-nkALLTLqrSGmw8nfo5FzNeDpr1Gm3qh8N9mDn0Q@mail.gmail.com>
	<CAOE=1Z0h+Dd=T8QKyVnTHwFjeYwm-qz_Da7HWEDk=pcrMbp9ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOE=1Z0h+Dd=T8QKyVnTHwFjeYwm-qz_Da7HWEDk=pcrMbp9ug@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [dpdk-dev] Will huge page have negative effect on
 guest vm in qemu enviroment?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: Pavel Shirshov <pavel.shirshov@gmail.com>, dev@dpdk.org, qemu-discuss@nongnu.org, users@dpdk.org, qemu-devel@nongnu.org

* Sam (batmanustc@gmail.com) wrote:
> Thank you~
>=20
> 1. We have a compare test on qemu-kvm enviroment with huge page and wit=
hout
> huge page. Qemu start process is much longer in huge page enviromwnt. A=
nd I
> write an email titled with '[DPDK-memory] how qemu waste such long time
> under dpdk huge page envriment?'. I could resend it later.

> 2. Then I have another test on qemu-kvm enviroment with huge page and
> without huge page, which I didn't start ovs-dpdk and vhostuser port in =
qemu
> start process. And I found Qemu start process is also much longer in hu=
ge
> page enviroment.
>=20
> So I think huge page enviroment, which grub2.cfg file is specified in
> =E2=80=98[DPDK-memory]
> how qemu waste such long time under dpdk huge page envriment?=E2=80=99,=
 will really
> have negative effect on qemu start up process.
>=20
> That's why we don't like to use ovs-dpdk. Althrough ovs-dpdk is faster,=
 but
> the start up process of qemu is much longer then normal ovs, and the re=
ason
> is nothing with ovs but huge page. For customers, vm start up time is
> important then network speed.

How are you setting up hugepages?  What values are you putting in the
various /proc or cmdline options and how are you specifying them on
QEMU's commandline.

I think one problem is that with hugepages qemu normally allocates them
all at the start;  I think there are cases where that means moving a lot
of memory about, especially if you lock it to particular NUMA nodes.

> BTW, ovs-dpdk start up process is also longer then normal ovs. But I kn=
ow
> the reason, it's dpdk EAL init process with forking big continous memor=
y
> and zero this memory. For qemu, I don't know why, as there is no log to
> report this.

I suspect it's the mmaping and madvising of those hugepages - you should
be able to see it with an strace of a qemu startup, or perhaps a
'perf top'  on the host as it's in that pause.

I'm told that hugepages are supposed to be especially useful with IOMMU
performance for cards passed through to the guest, so it might still
be worth doing.

Dave

> 2017-06-21 14:15 GMT+08:00 Pavel Shirshov <pavel.shirshov@gmail.com>:
>=20
> > Hi Sam,
> >
> > Below I'm saying about KVM. I don't have experience with vbox and oth=
ers.
> > 1. I'd suggest don't use dpdk inside of VM if you want to see best
> > perfomance on the box.
> > 2. huge pages enabled globally will not have any bad effect to guest
> > OS. Except you have to enable huge pages inside of VM and provide rea=
l
> > huge page for VM's huge pages from the host system. Otherwise dpdk
> > will use "hugepages" inside of VM, but this "huge pages" will not rea=
l
> > ones. They will be constructed from normal pages outside. Also when
> > you enable huge pages OS will reserve them from start and your OS wil=
l
> > not able use them for other things. Also you can't swap out huge
> > pages, KSM will not work for them and so on.
> > 3. You can enable huge pages just for one numa node. It's impossible
> > to enable them just for one core. Usually you reserve some memory for
> > hugepages when the system starts and you can't use this memory in
> > normal applications unless normal application knows how to use them.
> >
> > Also why it didn't work inside of the docker?
> >
> >
> > On Tue, Jun 20, 2017 at 8:35 PM, Sam <batmanustc@gmail.com> wrote:
> > > BTW, we also think about use ovs-dpdk in docker enviroment, but tes=
t
> > result
> > > said it's not good idea, we don't know why.
> > >
> > > 2017-06-21 11:32 GMT+08:00 Sam <batmanustc@gmail.com>:
> > >
> > >> Hi all,
> > >>
> > >> We plan to use DPDK on HP host machine with several core and big m=
emory.
> > >> We plan to use qemu-kvm enviroment. The host will carry 4 or more =
guest
> > vm
> > >> and 1 ovs.
> > >>
> > >> Ovs-dpdk is much faster then normal ovs, but to use ovs-dpdk, we h=
ave to
> > >> enable huge page globally.
> > >>
> > >> My question is, will huge page enabled globally have negative effe=
ct on
> > >> guest vm's memory orperate or something? If it is, how to prevent =
this,
> > or
> > >> could I enable huge page on some core or enable huge page for a pa=
rt of
> > >> memory?
> > >>
> > >> Thank you~
> > >>
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
