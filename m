Received: from eggs.gnu.org ([2001:4830:134:3::10]:42479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dNZyS-0001yo-1y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dNZyQ-0000he-PD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:22:48 -0400
MIME-Version: 1.0
In-Reply-To: <CALkUq2gp+x-nkALLTLqrSGmw8nfo5FzNeDpr1Gm3qh8N9mDn0Q@mail.gmail.com>
References: <CAOE=1Z1Bbgb494m6mYRnX1-80eT0tSnF0F6zNM7efEie4rd7DA@mail.gmail.com>
	<CAOE=1Z1LJr9rpaEQ9+b7D5vM3N=Wy0oGunRnzoQ79x3dWA3oaw@mail.gmail.com>
	<CALkUq2gp+x-nkALLTLqrSGmw8nfo5FzNeDpr1Gm3qh8N9mDn0Q@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Wed, 21 Jun 2017 15:22:45 +0800
Message-ID: <CAOE=1Z0h+Dd=T8QKyVnTHwFjeYwm-qz_Da7HWEDk=pcrMbp9ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Pavel Shirshov <pavel.shirshov@gmail.com>
Cc: dev@dpdk.org, users@dpdk.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Thank you~

1. We have a compare test on qemu-kvm enviroment with huge page and without
huge page. Qemu start process is much longer in huge page enviromwnt. And I
write an email titled with '[DPDK-memory] how qemu waste such long time
under dpdk huge page envriment?'. I could resend it later.

2. Then I have another test on qemu-kvm enviroment with huge page and
without huge page, which I didn't start ovs-dpdk and vhostuser port in qemu
start process. And I found Qemu start process is also much longer in huge
page enviroment.

So I think huge page enviroment, which grub2.cfg file is specified in
=E2=80=98[DPDK-memory]
how qemu waste such long time under dpdk huge page envriment?=E2=80=99, wil=
l really
have negative effect on qemu start up process.

That's why we don't like to use ovs-dpdk. Althrough ovs-dpdk is faster, but
the start up process of qemu is much longer then normal ovs, and the reason
is nothing with ovs but huge page. For customers, vm start up time is
important then network speed.

BTW, ovs-dpdk start up process is also longer then normal ovs. But I know
the reason, it's dpdk EAL init process with forking big continous memory
and zero this memory. For qemu, I don't know why, as there is no log to
report this.

2017-06-21 14:15 GMT+08:00 Pavel Shirshov <pavel.shirshov@gmail.com>:

> Hi Sam,
>
> Below I'm saying about KVM. I don't have experience with vbox and others.
> 1. I'd suggest don't use dpdk inside of VM if you want to see best
> perfomance on the box.
> 2. huge pages enabled globally will not have any bad effect to guest
> OS. Except you have to enable huge pages inside of VM and provide real
> huge page for VM's huge pages from the host system. Otherwise dpdk
> will use "hugepages" inside of VM, but this "huge pages" will not real
> ones. They will be constructed from normal pages outside. Also when
> you enable huge pages OS will reserve them from start and your OS will
> not able use them for other things. Also you can't swap out huge
> pages, KSM will not work for them and so on.
> 3. You can enable huge pages just for one numa node. It's impossible
> to enable them just for one core. Usually you reserve some memory for
> hugepages when the system starts and you can't use this memory in
> normal applications unless normal application knows how to use them.
>
> Also why it didn't work inside of the docker?
>
>
> On Tue, Jun 20, 2017 at 8:35 PM, Sam <batmanustc@gmail.com> wrote:
> > BTW, we also think about use ovs-dpdk in docker enviroment, but test
> result
> > said it's not good idea, we don't know why.
> >
> > 2017-06-21 11:32 GMT+08:00 Sam <batmanustc@gmail.com>:
> >
> >> Hi all,
> >>
> >> We plan to use DPDK on HP host machine with several core and big memor=
y.
> >> We plan to use qemu-kvm enviroment. The host will carry 4 or more gues=
t
> vm
> >> and 1 ovs.
> >>
> >> Ovs-dpdk is much faster then normal ovs, but to use ovs-dpdk, we have =
to
> >> enable huge page globally.
> >>
> >> My question is, will huge page enabled globally have negative effect o=
n
> >> guest vm's memory orperate or something? If it is, how to prevent this=
,
> or
> >> could I enable huge page on some core or enable huge page for a part o=
f
> >> memory?
> >>
> >> Thank you~
> >>
>
