Received: from eggs.gnu.org ([2001:4830:134:3::10]:39055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eyB3C-0003aN-TZ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 02:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eyB39-0007tF-JL
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 02:47:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eyB39-0007s7-E1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 02:47:11 -0400
Date: Tue, 20 Mar 2018 07:46:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180320074658.19fe0668@redhat.com>
In-Reply-To: <7a8ee5e0-d450-5d60-f388-278eb0b3083f@ozlabs.ru>
References: <28028831-7306-3356-6018-c7dcf72dc349@ozlabs.ru>
	<7a8ee5e0-d450-5d60-f388-278eb0b3083f@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Partial NUMA config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 19 Mar 2018 15:28:50 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 13/3/18 1:26 pm, Alexey Kardashevskiy wrote:
> > Hi Igor,
> > 
> > ec78f8114bc4c1 "numa: use possible_cpus for not mapped CPUs check" added a
> > warning about "All CPU(s) up to maxcpus should be described in NUMA config,
> > ability to start up with partial NUMA mappings is obsoleted and will be
> > removed in future" and this is printed when I add a numa node without
> > attached CPU like this:
> > 
> > -numa node,nodeid=0,cpus=0,mem=4G
> > -numa node,nodeid=1,mem=131072M
Warning you see is about CPU(s) not assigned to any node
and it has noting to do with cpu-less node.

What's the full CLI you are using?


> > And the reason for this command line is that I am trying to pass some dodgy
> > host RAM (actually belongs to a GPU but directly accessible via a fast
> > NVLink, not PCI fabric) which let's say is equally far from all CPUs, at
> > least in the host's NUMA config this memory is also not bound to any CPU:
-numa node,nodeid=1,mem=131072M - will assign some chunk of initial RAM to
cpu-less node. It might serve purpose of cpu-less node simulation and nothing else.
You won't be able to pass it GPU memory this way though.

It might be possible using -numa node,nodeid=1,memdev=foo
but knowing nothing about NVLink, I'm not sure how it's shared with
GPU (PCI) and per node memory controllers.


> > [aik@aik ~]$ ssh yc02goos numactl -H
> > available: 8 nodes (0,8,250-255)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> > 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
> > 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> > node 0 size: 261735 MB
> > node 0 free: 258932 MB
> > node 8 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84
> > 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106
> > 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125
> > 126 127
> > node 8 size: 261739 MB
> > node 8 free: 261414 MB
> > node 250 cpus:
> > node 250 size: 15360 MB
> > node 250 free: 15359 MB
> > node 251 cpus:
> > node 251 size: 0 MB
> > node 251 free: 0 MB
> > node 252 cpus:
> > node 252 size: 15360 MB
> > node 252 free: 15359 MB
> > node 253 cpus:
> > node 253 size: 15360 MB
> > node 253 free: 15359 MB
> > node 254 cpus:
> > node 254 size: 15360 MB
> > node 254 free: 15359 MB
> > node 255 cpus:
> > node 255 size: 15360 MB
> > node 255 free: 15359 MB
> > node distances:
> > node   0   8  250  251  252  253  254  255
> >   0:  10  40  80  80  80  80  80  80
> >   8:  40  10  80  80  80  80  80  80
> >  250:  80  80  10  80  80  80  80  80
> >  251:  80  80  80  10  80  80  80  80
> >  252:  80  80  80  80  10  80  80  80
> >  253:  80  80  80  80  80  10  80  80
> >  254:  80  80  80  80  80  80  10  80
> >  255:  80  80  80  80  80  80  80  10
> > 
> > 
> > I am not sure I'll progress far enough to get this working with VFIO but if
> > I do, I'd like to keep an ability to have such a partial config in the
> > future. What was the reason for this warning in the first place?
a CPU(including possible ones) shouldn't hung in nowhere,
it should be assigned to some node to describe its relation to memory on nodes.

> 
> Ping?
> 
> 
> 
