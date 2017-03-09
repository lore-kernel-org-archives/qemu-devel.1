Received: from eggs.gnu.org ([2001:4830:134:3::10]:35213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikofeng@connect.hku.hk>) id 1cm158-0003Gb-4B
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikofeng@connect.hku.hk>) id 1cm156-0007Fn-8c
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:38:26 -0500
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nikofeng@connect.hku.hk>)
	id 1cm156-0007Fa-0r
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:38:24 -0500
Received: by mail-qk0-x22a.google.com with SMTP id p64so127789870qke.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 08:38:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170309151923.GG2480@work-vm>
References: <CAGd9JPiCvSpZ6wGT-Fci+f7odP4t9SHUwSw3vqOMDVWdyJeR3w@mail.gmail.com>
	<20170309151923.GG2480@work-vm>
From: "FENG, Jiasheng" <nikofeng@connect.hku.hk>
Date: Fri, 10 Mar 2017 00:37:42 +0800
Message-ID: <CAGd9JPgb1oAprD7MN+dUBJDPeLB_=9u6_2pfq5tOi-yA1SOvqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Wang Cheng <wangch.will@gmail.com>, "YE, Chen" <u3534845@connect.hku.hk>, "CHEN,
	XUSHENG" <chenxus@connect.hku.hk>, Heming Cui <heming@cs.hku.hk>

Dear David,

Really appreciate your feedback.

I have proceeded the experiments in both conditions, and no matter the
vCPUs are in idle or busy situation, there is no difference that smp_wmb()
will consume a lot of time to proceed its work.

In your opinion, may I know that what is the alternative way to minimize
the time consumption of smp_wmb() or any other system setting could speed
up smp_wmb()?

Thanks in advance for your assistance and hope to receive your feedback soo=
n

Thanks and best regards,
Niko Jiasheng Feng



On Thu, Mar 9, 2017 at 11:19 PM, Dr. David Alan Gilbert <dgilbert@redhat.co=
m
> wrote:

> * FENG, Jiasheng (nikofeng@connect.hku.hk) wrote:
> > Dear QEMU Development Team,
> >
> >
> > It is my honor to contact with you.
> >
> >
> >
> > I am a postgraduate student from University of Hong Kong. Currently I a=
m
> > working on a project related to QEMU MicroCheckpointing and I have
> > encountered a performance issue during checkpoint pause & resume.
>
> The microcheckpointing code hasn't been maintained for a long time;
> most of the current checkpointing work is based on the COLO work which is
> still under development.
>
> > Please kindly refer to migration/checkpoint.c file, in function
> > capture_checkpoint, I proceeded a test to see the time consumption
> between
> > vm_stop_force_state and vm_start. I found out that even if the system i=
s
> > idle, there are still 12-20ms latency recorded ( mem=3D2G, vCPU=3D4 ).
> > Moreover, latency will be increased while more cpus equipped by my
> virtual
> > machine. I have done some research on that and I realized that it is
> > related to the Memory Barrier in KVM kernel. Each cpu will proceed a
> > smp_wmb() request during pause & resume and it takes about  3-5ms to
> finish
> > the request ( mem=3D2G, vCPU=3D4 ).
> >
> >
> >
> > Therefore, I would like to ask 3 questions regarding on the above issue=
:
> >
> >
> > 1. What is your consideration with calling smp_wmb() in checkpoint
> period;
> >
> > 2. Is it any other solution to minimize the latency to improve the
> > performance in checkpoint period;
> >
> > 3. Is smp_wmb() able to be safely disabled during the checkpoint period
>
> Well you'd have to understand where it's used; but for example, when taki=
ng
> a checkpoint you'd want to be sure that the checkpoint data contained
> a consistent copy of the last write data from all of the vCPUs; so I thin=
k
> a wmb would be needed to make sure it's consistent.
>
> I'm surprised that the smp_wmb is such a big chunk of your total checkpoi=
nt
> time, and that it's quite so long.
> Are the vCPUs idle or are they busy - does it make difference?
>
> Dave
>
> > Really appreciate your help with my problems and hope to receive your
> > feedback soon.
> >
> >
> > Thanks again for your contribution to QEMU and it is such a masterpiece=
.
>
> Dave
>
> >
> >
> >
> > Thanks and best regards,
> >
> > Niko Jiasheng Feng
> >
> > University of Hong Kong
> >
> > --
> > *Niko Jiasheng *
> > *Feng **Computer Science(General Stream), Faculty of Engineering, The
> > University of Hong Kong*
> > Contact:  =EF=BC=88852=EF=BC=8997908620
> > Address: Pokfulam Road, The University of Hong Kong
> > Email:      nikofeng@hku.hk / niko_jiasheng@163.com
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>



--=20
*Niko Jiasheng *
*Feng **Computer Science(General Stream), Faculty of Engineering, The
University of Hong Kong*
Contact:  =EF=BC=88852=EF=BC=8997908620
Address: Pokfulam Road, The University of Hong Kong
Email:      nikofeng@hku.hk / niko_jiasheng@163.com
