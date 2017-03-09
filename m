Received: from eggs.gnu.org ([2001:4830:134:3::10]:36562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clzqm-0006gO-92
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clzqj-0008JE-3o
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:19:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clzqi-0008J0-Rw
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:19:29 -0500
Date: Thu, 9 Mar 2017 15:19:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170309151923.GG2480@work-vm>
References: <CAGd9JPiCvSpZ6wGT-Fci+f7odP4t9SHUwSw3vqOMDVWdyJeR3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGd9JPiCvSpZ6wGT-Fci+f7odP4t9SHUwSw3vqOMDVWdyJeR3w@mail.gmail.com>
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
Cc: qemu-devel@nongnu.org, Wang Cheng <wangch.will@gmail.com>, "YE, Chen" <u3534845@connect.hku.hk>, "CHEN, XUSHENG" <chenxus@connect.hku.hk>, Heming Cui <heming@cs.hku.hk>

* FENG, Jiasheng (nikofeng@connect.hku.hk) wrote:
> Dear QEMU Development Team,
>=20
>=20
> It is my honor to contact with you.
>=20
>=20
>=20
> I am a postgraduate student from University of Hong Kong. Currently I a=
m
> working on a project related to QEMU MicroCheckpointing and I have
> encountered a performance issue during checkpoint pause & resume.

The microcheckpointing code hasn't been maintained for a long time;
most of the current checkpointing work is based on the COLO work which is
still under development.

> Please kindly refer to migration/checkpoint.c file, in function
> capture_checkpoint, I proceeded a test to see the time consumption betw=
een
> vm_stop_force_state and vm_start. I found out that even if the system i=
s
> idle, there are still 12-20ms latency recorded ( mem=3D2G, vCPU=3D4 ).
> Moreover, latency will be increased while more cpus equipped by my virt=
ual
> machine. I have done some research on that and I realized that it is
> related to the Memory Barrier in KVM kernel. Each cpu will proceed a
> smp_wmb() request during pause & resume and it takes about  3-5ms to fi=
nish
> the request ( mem=3D2G, vCPU=3D4 ).
>=20
>=20
>=20
> Therefore, I would like to ask 3 questions regarding on the above issue=
:
>=20
>=20
> 1. What is your consideration with calling smp_wmb() in checkpoint peri=
od;
>=20
> 2. Is it any other solution to minimize the latency to improve the
> performance in checkpoint period;
>=20
> 3. Is smp_wmb() able to be safely disabled during the checkpoint period

Well you'd have to understand where it's used; but for example, when taki=
ng
a checkpoint you'd want to be sure that the checkpoint data contained
a consistent copy of the last write data from all of the vCPUs; so I thin=
k
a wmb would be needed to make sure it's consistent.

I'm surprised that the smp_wmb is such a big chunk of your total checkpoi=
nt
time, and that it's quite so long. =20
Are the vCPUs idle or are they busy - does it make difference?

Dave

> Really appreciate your help with my problems and hope to receive your
> feedback soon.
>=20
>=20
> Thanks again for your contribution to QEMU and it is such a masterpiece=
.

Dave

>=20
>=20
>=20
> Thanks and best regards,
>=20
> Niko Jiasheng Feng
>=20
> University of Hong Kong
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
