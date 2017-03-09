Received: from eggs.gnu.org ([2001:4830:134:3::10]:45719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm1W5-0003wH-7E
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm1W1-0001T7-6D
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:06:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cm1W0-0001Ri-Sr
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:06:13 -0500
Date: Thu, 9 Mar 2017 17:06:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170309170605.GL2480@work-vm>
References: <CAGd9JPiCvSpZ6wGT-Fci+f7odP4t9SHUwSw3vqOMDVWdyJeR3w@mail.gmail.com>
	<20170309151923.GG2480@work-vm>
	<CAGd9JPgb1oAprD7MN+dUBJDPeLB_=9u6_2pfq5tOi-yA1SOvqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGd9JPgb1oAprD7MN+dUBJDPeLB_=9u6_2pfq5tOi-yA1SOvqg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU MicroCheckpointing Pause & Resume Latency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "FENG, Jiasheng" <nikofeng@connect.hku.hk>
Cc: qemu-devel@nongnu.org, Wang Cheng <wangch.will@gmail.com>, "YE, Chen" <u3534845@connect.hku.hk>, "CHEN, XUSHENG" <chenxus@connect.hku.hk>, Heming Cui <heming@cs.hku.hk>, pbonzini@redhat.com

(cc'ing in Paolo since he knows our barrier code)

* FENG, Jiasheng (nikofeng@connect.hku.hk) wrote:
> Dear David,
>=20
> Really appreciate your feedback.
>=20
> I have proceeded the experiments in both conditions, and no matter the
> vCPUs are in idle or busy situation, there is no difference that smp_wm=
b()
> will consume a lot of time to proceed its work.
>=20
> In your opinion, may I know that what is the alternative way to minimiz=
e
> the time consumption of smp_wmb() or any other system setting could spe=
ed
> up smp_wmb()?
>=20
> Thanks in advance for your assistance and hope to receive your feedback=
 soon

Just checking, is this on a normal x86 PC?
Your numbers of 3-5ms just seem quite high to me but I've not tried timin=
g that
code.

Dave

>=20
> Thanks and best regards,
> Niko Jiasheng Feng
>=20
>=20
>=20
> On Thu, Mar 9, 2017 at 11:19 PM, Dr. David Alan Gilbert <dgilbert@redha=
t.com
> > wrote:
>=20
> > * FENG, Jiasheng (nikofeng@connect.hku.hk) wrote:
> > > Dear QEMU Development Team,
> > >
> > >
> > > It is my honor to contact with you.
> > >
> > >
> > >
> > > I am a postgraduate student from University of Hong Kong. Currently=
 I am
> > > working on a project related to QEMU MicroCheckpointing and I have
> > > encountered a performance issue during checkpoint pause & resume.
> >
> > The microcheckpointing code hasn't been maintained for a long time;
> > most of the current checkpointing work is based on the COLO work whic=
h is
> > still under development.
> >
> > > Please kindly refer to migration/checkpoint.c file, in function
> > > capture_checkpoint, I proceeded a test to see the time consumption
> > between
> > > vm_stop_force_state and vm_start. I found out that even if the syst=
em is
> > > idle, there are still 12-20ms latency recorded ( mem=3D2G, vCPU=3D4=
 ).
> > > Moreover, latency will be increased while more cpus equipped by my
> > virtual
> > > machine. I have done some research on that and I realized that it i=
s
> > > related to the Memory Barrier in KVM kernel. Each cpu will proceed =
a
> > > smp_wmb() request during pause & resume and it takes about  3-5ms t=
o
> > finish
> > > the request ( mem=3D2G, vCPU=3D4 ).
> > >
> > >
> > >
> > > Therefore, I would like to ask 3 questions regarding on the above i=
ssue:
> > >
> > >
> > > 1. What is your consideration with calling smp_wmb() in checkpoint
> > period;
> > >
> > > 2. Is it any other solution to minimize the latency to improve the
> > > performance in checkpoint period;
> > >
> > > 3. Is smp_wmb() able to be safely disabled during the checkpoint pe=
riod
> >
> > Well you'd have to understand where it's used; but for example, when =
taking
> > a checkpoint you'd want to be sure that the checkpoint data contained
> > a consistent copy of the last write data from all of the vCPUs; so I =
think
> > a wmb would be needed to make sure it's consistent.
> >
> > I'm surprised that the smp_wmb is such a big chunk of your total chec=
kpoint
> > time, and that it's quite so long.
> > Are the vCPUs idle or are they busy - does it make difference?
> >
> > Dave
> >
> > > Really appreciate your help with my problems and hope to receive yo=
ur
> > > feedback soon.
> > >
> > >
> > > Thanks again for your contribution to QEMU and it is such a masterp=
iece.
> >
> > Dave
> >
> > >
> > >
> > >
> > > Thanks and best regards,
> > >
> > > Niko Jiasheng Feng
> > >
> > > University of Hong Kong
> > >
> > > --
> > > *Niko Jiasheng *
> > > *Feng **Computer Science(General Stream), Faculty of Engineering, T=
he
> > > University of Hong Kong*
> > > Contact:  =EF=BC=88852=EF=BC=8997908620
> > > Address: Pokfulam Road, The University of Hong Kong
> > > Email:      nikofeng@hku.hk / niko_jiasheng@163.com
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>=20
>=20
>=20
> --=20
> *Niko Jiasheng *
> *Feng **Computer Science(General Stream), Faculty of Engineering, The
> University of Hong Kong*
> Contact:  =EF=BC=88852=EF=BC=8997908620
> Address: Pokfulam Road, The University of Hong Kong
> Email:      nikofeng@hku.hk / niko_jiasheng@163.com
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
