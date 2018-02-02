Received: from eggs.gnu.org ([208.118.235.92]:49549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ehdHd-0007Uc-Bh
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ehdGZ-0007R9-5Z
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:6882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ehdGY-0007Pe-K0
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:28:38 -0500
Message-ID: <5A7462DC.1020904@intel.com>
Date: Fri, 02 Feb 2018 21:08:44 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
	<5A70606F.3030307@intel.com>
	<20180201190712-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180201190712-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com

On 02/02/2018 01:08 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 30, 2018 at 08:09:19PM +0800, Wei Wang wrote:
>> Issues:
>> Suppose we have both the vhost and virtio-net set up, and vhost pmd <->
>> virtio-net pmd communication works well. Now, vhost pmd exits (virtio-net
>> pmd is still there). Some time later, we re-run vhost pmd, the vhost pmd
>> doesn't know the virtqueue addresses of the virtio-net pmd, unless the
>> virtio-net pmd reloads to start the 2nd phase of the vhost-user protocol. So
>> the second run of the vhost pmd won't work.
>>
>> Any thoughts?
>>
>> Best,
>> Wei
> So vhost in qemu must resend all configuration on reconnect.
> Does this address the issues?
>

Yes, but the issues are
1) there is no reconnecting when a pmd exits (the socket connection 
seems still on at the device layer);
2) If we find a way to break the QEMU layer socket connection when pmd 
exits and get it reconnect, virtio-net device still won't send all the 
configure when reconnecting, because socket connecting only triggers 
phase 1 of vhost-user negotiation (i.e. vhost_user_init). Phase 2 is 
triggered after the driver loads (i.e. vhost_net_start). If the 
virtio-net pmd doesn't reload, there are no phase 2 messages (like 
virtqueue addresses which are allocated by the pmd). I think we need to 
think more about this before moving forward.

Best,
Wei
