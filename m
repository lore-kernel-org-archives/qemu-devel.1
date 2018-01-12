Received: from eggs.gnu.org ([2001:4830:134:3::10]:57036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eZwx3-0004Tj-Ux
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eZwx0-0002dd-1F
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:52:46 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:56403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eZwwz-0002cw-Qq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:52:41 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1E14090F57
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 11:52:40 +0100 (CET)
Date: Fri, 12 Jan 2018 11:48:19 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180112114819.19513e45@bahia.lan>
In-Reply-To: <e23601f9-0562-92f1-2db8-cbb9305da9e0@huawei.com>
References: <b74a4929-26ed-711a-6d90-c6c06b492fd8@huawei.com>
	<20180108111039.2ec3cefd@bahia.lan>
	<e23601f9-0562-92f1-2db8-cbb9305da9e0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] virtio-9p: hot-plug/unplug about virtio-9p device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>
Cc: "Fangyi (C)" <eric.fangyi@huawei.com>, joinpub@163.com, Jiangyiwen <jiangyiwen@huawei.com>, qemu-devel@nongnu.org

On Thu, 11 Jan 2018 10:23:32 +0800
sochin.jiang <sochin.jiang@huawei.com> wrote:

> On 2018/1/8 18:10, Greg Kurz wrote:
> > On Tue, 19 Dec 2017 13:41:12 +0800
> > sochin.jiang <sochin.jiang@huawei.com> wrote:
> >  
> >>      Hi, guys.
> >>
> >>     I'm looking for the hot-plug/unplug features of virtio-9p device recently, and found there's a lack of support.
> >>
> >>     I am wondering why ? Is there a reason. Actually, I write a qmp command to support fsdev_add, then a device_add qmp will    
> >>
> >>     successfully add a virtio-9p device(just like virtio-blk).
> >>
> >>    Whether there is some concerns that we haven't support this ? hope for a reply, thanks.
> >>
> >>
> >> sochin.
> >>  
> > Hi Sochin,
> >
> > I've just discovered this mail by chance. Please note I'm the only active
> > maintainer for virtio-9p. You really should check the content of MAINTAINERS
> > and Cc the appropriate people. :)
> >
> > Now, back to your question. Yes, there's only some partial support for
> > hot-plug/unplug. Mostly because nobody cared to work on it I guess.
> >
> > So, indeed, we don't have fsdev_add/fsdev_del, ie, we can only rely on
> > shared directories specified on the QEMU command line.
> >
> > On the virtio-9p device side, hotplug is supported, ie, device_add virtio-9p
> > works as expected.
> >
> > Hot-unplug is different as it requires some coordination with the guest. The
> > current status is that it requires the 9p shared directory to be unmounted
> > in the guest: if you do device_del while the directory is mounted in a linux
> > guest, you'll get these messages in the guest syslog:
> >
> > kernel:9pnet_virtio virtio2: p9_virtio_remove: waiting for device in use.
> >
> > If the 9p directory is unmounted at some point, then the hot unplug
> > sequence will eventually succeed.
> >
> > But this shouldn't be done like this: the guest should cancel inflight
> > requests and cause any new I/O requests in the guest to fail right away.
> > I have a tentative patch for the linux driver I can share if you want.
> >
> > Cheers,
> >
> > --
> > Greg
> >
> > .
> >  
> 
> 
> Thanks, Greg.
> 
> Indeed, I got those error messages while trying to do device_del with
> shared directory mounted in the guest. I really would like to see you patch for linux driver.
> 

I'll try to send it soon.

> About virtio-9p, we are actually considering to use it for hypervisor-based container, 

Something like Intel's Clear Containers ?

> a support of hotplug/unplug will be better, also I believe there will be more people to work on it.

That's good news !

Cheers,

--
Greg

> 
> 
> Sochin.
> 
> 
> 
