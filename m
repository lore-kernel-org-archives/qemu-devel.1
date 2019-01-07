Received: from eggs.gnu.org ([209.51.188.92]:60521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ggLoE-0004W4-1x
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ggLoD-0007Fu-4l
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:42:38 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:44376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1ggLoD-0007BJ-0U
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:42:37 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	x073gEQG054672
	for <qemu-devel@nongnu.org>; Sun, 6 Jan 2019 22:42:30 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id C49367E
	for <qemu-devel@nongnu.org>; Sun,  6 Jan 2019 22:42:30 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id A531980
	for <qemu-devel@nongnu.org>; Sun,  6 Jan 2019 22:42:30 -0500 (EST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
	[209.85.208.71])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	x073gT3h064898
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 6 Jan 2019 22:42:30 -0500
Received: by mail-ed1-f71.google.com with SMTP id o21so37345088edq.4
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 19:42:30 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com.
	[209.85.128.49]) by smtp.gmail.com with ESMTPSA id
	k20sm30497658eda.71.2019.01.06.19.42.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 06 Jan 2019 19:42:28 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id y139so5820486wmc.5
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 19:42:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHyh4xhv5ZDfZv842U=adQN7hQFr=16BKEgZcEUZOLjFo3P+Jw@mail.gmail.com>
	<CAFEAcA_GCPp7ga7OGkZQopOSY_u+mwJ=vve5a9a4uU217butcA@mail.gmail.com>
In-Reply-To: <CAFEAcA_GCPp7ga7OGkZQopOSY_u+mwJ=vve5a9a4uU217butcA@mail.gmail.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Sun, 6 Jan 2019 22:42:16 -0500
Message-ID: <CAHyh4xgs0vYN8=CbmedMTbnK4cp4GR1Kmj=Z9QUwqHq3F0o+Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why one virtio-pci device has two different
 DeviceState?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On Sat, Jan 5, 2019 at 10:42 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 4 Jan 2019 at 20:23, Jintack Lim <jintack@cs.columbia.edu> wrote:
> > I was wondering why one virtio-pci device has two different
> > DeviceState? - one directly from VirtIOPCIProxy and the other from
> > VirtIO<dev type> such as VirtIONet. As an example, they are denoted as
> > qdev and vdev respectively in virtio_net_pci_realize().
>
> It's been a while since I looked at this, but there are two
> basic issues underlying the weird way virtio devices are
> set up:
>  (1) PCI is not the only "transport" -- the VirtIONet etc
>      are shared with other transports like MMIO or the S390 ones
>  (2) retaining back-compatibility matters a lot here: we need
>      command lines to still work, and also the migration data
>      stream needs to stay compatible
> Some of the way the devices are reflects the way we started
> with a design where there was only a single device (eg the
> pci virtio-net device) and then refactored it to support
> multiple transports while retaining back compatibility.

Thanks for the insight, Peter. That make sense!!

Thanks,
Jintack

>
> > I thought that just one DeviceState is enough for any device in QEMU.
> > Maybe I'm missing something fundamental here.
>
> This isn't generally true, it's just that a lot of
> our devices are of the simple straightforward kind
> where that's true. It's also possible for an
> implementation of a device to be as a combination
> of other devices, which is what we have here.
> virtio-pci-net is-a PCIDevice (which in turn is-a Device),
> but it has-a VirtIONet device (which is-a Device) as
> part of its implementation.
> (It's also possible to manually create the pci
> transport and the virtio-net backend separately
> and connect them together without the virtio-pci-net
> device at all. That's more often used with non-pci
> transports but it works for pci too.)
>
> You can also see a similar thing with a lot of the
> "container" SoC objects like TYPE_ASPEED_SOC, which
> is a subclass of DeviceState, but is implemented
> using a dozen different objects all of which are
> themselves DeviceState subclasses.
>
> thanks
> -- PMM
>
