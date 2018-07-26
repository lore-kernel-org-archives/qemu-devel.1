Received: from eggs.gnu.org ([2001:4830:134:3::10]:55481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fiWPA-0003tq-8g
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 22:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fiWP7-0000so-Aa
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 22:53:28 -0400
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:52472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fiWP7-0000mi-6V
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 22:53:25 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w6Q2rC03064634
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 22:53:19 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 4329882
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 22:53:19 -0400 (EDT)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 8370388
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 22:53:14 -0400 (EDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
	[209.85.208.70])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w6Q2rD5w006098
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 22:53:14 -0400
Received: by mail-ed1-f70.google.com with SMTP id l1-v6so212790edi.11
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 19:53:14 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
	[209.85.221.53]) by smtp.gmail.com with ESMTPSA id
	i3-v6sm180885edt.42.2018.07.25.19.53.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 25 Jul 2018 19:53:12 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id h9-v6so160419wro.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 19:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyh4xjUmwHr7b=92y7YUwKGSW0o+FUMwJLSehdzuFc3R6eLTg@mail.gmail.com>
	<20180724055501.GA2479@xz-mi>
In-Reply-To: <20180724055501.GA2479@xz-mi>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Wed, 25 Jul 2018 22:53:00 -0400
Message-ID: <CAHyh4xhOWbhs50jsT1_SzKqaGoiaZH3oLto_x7QE8UNfW+9M7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Virtual IOMMU + Virtio-net devices in a Windows VM
 doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, "\\ Michael S . Tsirkin \\" <mst@redhat.com>

Hi Peter,

On Tue, Jul 24, 2018 at 1:55 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jul 23, 2018 at 04:13:18PM -0400, Jintack Lim wrote:
> > Hi,
> >
> > I'm running a Windows VM on top of KVM on x86, and one of virtio-net
> > device in the Windows VM doesn't seem to work. I provided virtual
> > IOMMU and two virtio-net devices to the VM: one bypassing the virtual
> > IOMMU and the other one behind the virtual IOMMU[1]. It turned out
> > that the virtio-net device behind virtual IOMMU didn't work while the
> > one bypassing the virtual IOMMU worked well. In a linux VM with the
> > same configuration, both of virtio-net device worked well.
> >
> > I found that there is a subtle difference between virtio-net devices
> > bypassing and behind virtual IOMMU in a Linux VM. The lscpu command in
> > the Linux VM shows different device names for them; the first line is
> > for the bypassing one, and the second line is for the one behind the
> > virtual IOMMU
> >
> > 00:03.0 Ethernet controller: Red Hat, Inc Virtio network device
> > 01:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
> >
> > I wonder if this difference somehow caused the problem in the Windows
> > VM. I've installed the latest virtio drivers (0.1.149) from the fedora
> > project [2]
> >
> > Any thoughts?
> >
> > I'm using v4.15 Linux kernel as a host, and QEMU 2.11.0.
>
> Have you tried the latest QEMU?
>

I just tried the latest QEMU, but observed the same symptom.

> Also CC Jason and Michael.

Thanks!

>
> >
> > Thanks,
> > Jintack
> >
> > [1] https://wiki.qemu.org/Features/VT-d
> > [2] https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtual-machines-using-virtio-drivers.html
> >
> >
>
> Regards,
>
> --
> Peter Xu
>
