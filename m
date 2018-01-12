Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eZt27-0008J3-IY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eZt24-00081S-H0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:41:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:31857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eZt24-0007z4-7q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:41:40 -0500
Message-ID: <5A585930.1030009@intel.com>
Date: Fri, 12 Jan 2018 14:44:00 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<5A5704B4.5090502@intel.com>
	<CAJSP0QWyaE8qUGMgcpzB460Y=kpX4VDfqFWm-CWmmX4X3nmRMQ@mail.gmail.com>
In-Reply-To: <CAJSP0QWyaE8qUGMgcpzB460Y=kpX4VDfqFWm-CWmmX4X3nmRMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 01/11/2018 05:56 PM, Stefan Hajnoczi wrote:
> On Thu, Jan 11, 2018 at 6:31 AM, Wei Wang <wei.w.wang@intel.com> wrote:
>> On 01/11/2018 12:14 AM, Stefan Hajnoczi wrote:
>>
>> 2) requires the driver to join the vhost-user negotiation.
> The driver must participate in vhost-user negotiation.  The vhost-pci
> patches try to avoid this by taking features bits on the QEMU
> command-line and hardcoding the number of supported virtqueues.  That
> doesn't work in production environments because:
> 1. What if the driver inside the VM has been updated and now supports
> different features?
> 2. What if the user isn't allowed to modify the VM configuration?
> 3. What if the management software doesn't expose the feature bits
> command-line parameter?
> 4. What if the number of virtqueues must be different from QEMU's
> default value to limit resource consumption?
>
> Users will find it incovenient to manually enter feature bits for the
> driver they are using.  The driver needs to be part of negotiation so
> it can indicate which features are supported, how many virtqueues,
> etc.
>

OK, the advantages of letting the guest join the vhost-user negotiation 
sounds convincing to me. Thanks.



>> Without above two, the solution already works well, so I'm not sure why would we need the above two from functionality point of view.
> The "[PATCH v3 0/7] Vhost-pci for inter-VM communication" series is
> incomplete.  It is a subset of vhost-user-net and it works only for
> poll-mode drivers.  It's the requirements that haven't been covered by
> the vhost-pci patch series yet that make me prefer the
> virtio-vhost-user approach.
>
> The virtio device design needs to be capable of supporting the rest of
> vhost-user functionality in the future.  Once the code is merged in
> QEMU and DPDK it will be very difficult to make changes to the virtio
> device.

This is how virtio works. A new feature with a new feature bit. Now, we 
let the guest driver join the vhost-user negotiation (including feature 
negotiation), the default device/driver feature negotiation is free to use.
I'm thinking if it is worthwhile to do some kind of mediated 
passthrough, which passes the selected messages only. Because many 
messages are not necessary to be passed down (e.g. VHOST_USER_SEND_RARP 
is not needed for simple VM-to-VM communication), though might be safe 
to do. I plan to see your full passthrough code first, and see if 
changing to mediated passthrough would be simpler.

Best,
Wei
