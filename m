Received: from eggs.gnu.org ([2001:4830:134:3::10]:44869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBdtw-0001Ov-Um
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBdts-0000nK-05
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:41:04 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBdtr-0000mm-PA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:40:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id r196so12779499wmf.2
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 01:40:58 -0800 (PST)
References: <1b862cf2-2fee-3243-cb54-2780ace6f25b@profihost.ag>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <971cc10f-7930-9830-0528-27e8faac7282@redhat.com>
Date: Mon, 6 Nov 2017 10:40:56 +0100
MIME-Version: 1.0
In-Reply-To: <1b862cf2-2fee-3243-cb54-2780ace6f25b@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm: virtio-net: saved image requires TUN_F_UFO
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, qemu-devel <qemu-devel@nongnu.org>

On 06/11/2017 10:38, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> i've upgraded some servers from kernel 4.4 to 4.12 - both running Qemu
> 2.9.1.
> 
> If i migrate a VM from a host running kernel 4.4 to a host running 4.12
> i get:
> 
> kvm: virtio-net: saved image requires TUN_F_UFO support
> kvm: Failed to load virtio-net-device:tmp
> kvm: Failed to load virtio-net:virtio
> kvm: error while loading state for instance 0x0 of device
> '0000:00:12.0/virtio-net'
> kvm: load of migration failed: Invalid argument
> 
> 
> while migrating from 4.12 to 4.4 works fine.
> 
> Can anybody help? Is this expected?

Can you check why peer_has_ufo failed (in hw/net/virtio-net.c)?  Also,
did this ioctl fail when the tap device was set up on the 4.12 destination?

int tap_probe_has_ufo(int fd)
{
    unsigned offload;

    offload = TUN_F_CSUM | TUN_F_UFO;

    if (ioctl(fd, TUNSETOFFLOAD, offload) < 0)
        return 0;

    return 1;
}

Thanks,

Paolo
