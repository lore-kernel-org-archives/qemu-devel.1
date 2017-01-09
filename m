Received: from eggs.gnu.org ([2001:4830:134:3::10]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQhhL-0002Zg-Be
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQhhH-0002HD-F6
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:41:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQhhH-0002H7-6T
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:41:43 -0500
Date: Mon, 9 Jan 2017 23:41:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170109234006-mutt-send-email-mst@kernel.org>
References: <1478856187-284644-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA16E01B@DGGEMA505-MBX.china.huawei.com>
	<20170103150003.GD14707@stefanha-x1.localdomain>
	<33183CC9F5247A488A2544077AF19020DA174682@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA174682@DGGEMA505-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v14 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Shiqing Fan <Shiqing.Fan@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>

On Wed, Jan 04, 2017 at 01:03:21AM +0000, Gonglei (Arei) wrote:
> Hi Stefan,
> 
> >
> > Subject: Re: [Qemu-devel] [PATCH v14 0/2] virtio-crypto: virtio crypto device
> > specification
> > 
> > On Mon, Dec 26, 2016 at 02:38:29AM +0000, Gonglei (Arei) wrote:
> > > Both Alex and Stefan mentioned that the process of create/close a session
> > > makes we have a least one full round-trip cost from guest to host to guest
> > > to be able to send any data for symmetric algorithms. It gets ourself into
> > > synchronization troubles in some scenarios like a web server handling lots
> > > of small requests whose algorithms and keys are different.
> > >
> > > Because the virtio crypto specification has not been voted yet and v15 is on
> > the way.
> > > I'd like to make some changes in order to support those scenarios better.
> > That means
> > > we will support one-blob request (no sessions) as well for symmetric
> > > algorithms, including HASH, MAC services. The benefit is obvious for
> > > HASH service because it's usually a one-blob operation.
> > >
> > > The main changes will be:
> > >  1) using the flag property of struct virtio_crypto_op_header to identify the
> > >     type of crypto request. Aka Is it a session-based or non-session
> > request?
> > >     The flag is not used currently, so we can make use of it.
> > >
> > >  2) extending virtio_crypto_*_para structures, for example, add the content
> > of
> > >     struct virtio_crypto_cipher_session_para into struct
> > virtio_crypto_cipher_para.
> > >     It's true that will increase the size of each crypto request after this
> > change.
> > >
> > > Does it make sense? Thanks!
> > 
> > That sounds good.  Hopefully many crypto API users only use a single
> > operation and can therefore benefit from this optimization.
> > 
> Thanks for your feedback. I'll start this work.
> 
> Regards,
> -Gonglei

I worry what's going to happen with the virtio driver
I merged upstream though. Do you plan to make changes
compatible with it?


-- 
MST
