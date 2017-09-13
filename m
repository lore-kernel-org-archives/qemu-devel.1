Received: from eggs.gnu.org ([2001:4830:134:3::10]:34333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsCBS-0005SI-OK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsCBN-00018v-LM
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:14:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49702
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dsCBN-00018M-Fu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:14:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DIEbjS038124
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:14:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cy7nyxdpq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:14:39 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 19:14:13 +0100
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 20:14:05 +0200
MIME-Version: 1.0
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2d8ae3d3-438b-da84-4959-cf63f4f4ce99@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC 0/8] virtio-crypto: add multiplexing mode
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: weidong.huang@huawei.com, mst@redhat.com, jasowang@redhat.com, john.griffin@intel.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, agraf@suse.de, arei.gonglei@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, Jani.Kokkonen@huawei.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, cohuck@redhat.com, mike.caraman@nxp.com



On 09/11/2017 03:10 AM, Longpeng(Mike) wrote:
> *NOTE*
> The code realization is based on the latest virtio crypto spec:
>  [PATCH v19 0/2] virtio-crypto: virtio crypto device specification
>    https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05217.html
> 
> In session mode, the process of create/close a session
> makes we have a least one full round-trip cost from guest to host to guest
> to be able to send any data for symmetric algorithms. It gets ourself into
> synchronization troubles in some scenarios like a web server handling lots
> of small requests whose algorithms and keys are different.
> 
> We can support one-blob request (no sessions) as well for symmetric
> algorithms, including HASH, MAC services. The benefit is obvious for
> HASH service because it's usually a one-blob operation.
> 

Hi!

I've just started looking at this. Patch #1 modifies linux/virtio_crypto.h
which if I compare with the (almost) latest linux master is different. Thus
I would expect a corresponding kernel patch set too, but I haven't received
one, nor did I find a reference in the cover letter.

I think if I want to test the new features I need the kernel counter-part
too, or?

Could you point me to the kernel counterpart?

Regards,
Halil


> Gonglei (3):
>   virtio-crypto: add stateless crypto request handler
>   cryptodev: extract one util function
>   virtio-crypto: add host feature bits support
> 
> Longpeng(Mike) (5):
>   virtio-crypto: add new definations for multiplexing mode
>   virtio-crypto: add session creation logic for mux mode
>   virtio-crypto: add dataq operation logic for mux mode
>   cryptodev: add stateless mode cipher support
>   cryptodev-builtin: add stateless cipher support
> 
>  backends/cryptodev-builtin.c                   | 189 ++++++++---
>  backends/cryptodev.c                           |  21 ++
>  hw/virtio/virtio-crypto.c                      | 433 +++++++++++++++++++++++--
>  include/hw/virtio/virtio-crypto.h              |   2 +
>  include/standard-headers/linux/virtio_crypto.h | 182 ++++++++++-
>  include/sysemu/cryptodev.h                     |  21 ++
>  6 files changed, 774 insertions(+), 74 deletions(-)
> 
