Received: from eggs.gnu.org ([2001:4830:134:3::10]:47475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHZUB-0007Zi-Kn
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHZU8-00061W-Ti
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:10:59 -0500
Date: Wed, 22 Nov 2017 19:10:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122191040.3b82ae95.cohuck@redhat.com>
In-Reply-To: <20171108165422.46267-2-pasic@linux.vnet.ibm.com>
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed,  8 Nov 2017 17:54:20 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

Subject: s/ccs/css/

> Add a fake device meant for testing the correctness of our css emulation.
> 
> What we currently have is writing a Fibonacci sequence of uint32_t to the
> device via ccw write. The write is going to fail if it ain't a Fibonacci
> and indicate a device exception in scsw together with the proper residual
> count. With this we can do basic verification of data integrity.
> 
> Of course lot's of invalid inputs (besides basic data processing) can be
> tested with that as well.
> 
> We also have a no-op mode where the device just tells all-good! This
> could be useful for fuzzing.
> 
> Usage:
> 1) fire up a qemu with something like -device ccw-testdev,devno=fe.0.0001
>    on the command line
> 2) exercise the device from the guest
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> Introduction
> ------------
> 
> While discussing v1 we (more or less) decided a test device for ccw is a
> good idea. This is an RFC because there are some unresolved technical
> questions I would like to discuss.
> 
> Usage
> -----
> 
> Build like this:  make CONFIG_CCW_TESTDEV=y
> 
> Changelog
> ---------
> 
> v1 -> v2:
> - Renamed and moved to hw/misc/
> - Changed cu_type to 0xfffe.
> - Changed chpid_type to 0x25 (questionable).
> - Extensibility: addedd both in-band (ccw) and out-of-band set mode
>   mechanism. Currently we have two modes: fib and no-op. The purpose
>   of the mode mechanism is to facilitate different behaviors. One can
>   both specify and lock a mode on the command line.
> - Added read for fib mode.
> 
> Things I've figured out and things to figure out
> -----------------------------------------------
> 
> The zVM folks say they don't have a reserved cu_type reserved for test
> (or hypervisor use in general). So I've gone with cu_type  0xfffe because
> according to Christian  only numeric digit hex values are used, and Linux
> uses x0ffff as extremal value.

ack

> 
> The zVM folks say the don't have a chpid_type reserved for test (or
> hypervisor use in general. So I took 0x25 for now, which belongs to FC
> and should be safe in my opinion.

That's fine, I think.

> 
> AFAIR there was some discussion on using a dedicated diag function code.
> There are multiple such that could be re-purposed for out-of-band
> signaling reserved by zVM. For now I've decided to go with a new subcode
> for diag 0x500 as it appears to me that it requires less changes.

It means that we don't have to synchronize with anyone else, yes.

> 
> I've implemented both in-band and out-of-band signaling for influencing
> what the testdev does from the guest. We should probably get rid of one.
> I've just implemented both so we can discuss pros and cons with some
> code.
> 
> I've taken subcode 254, the last one supported at the moment. I'm not
> really happy with the way I 'took' it. Maybe all taken subcodes
> could go into hw/s390x/s390-virtio-hcall.h either via include or
> directly.

For virtio-ccw, we're going the way via the standard headers (as for
other virtio things). The last used subcode for the old virtio
transport is already in this file (in s390-next).

We currently have Documentation/virtual/kvm/s390-diag.txt in the
kernel. Not sure whether that would be a good place to document the
testdev subcode.

> 
> I'm not really happy with the side effects of moving it to hw/misc, which
> ain't s390x specific. I've pretty much bounced off the build system, so
> I would really appreciate some help here. Currently you have to say you
> want it when you do make or it won't get compiled into your qemu. IMHO
> this device only makes sense for testing and should not be rutinely
> shipped in production builds. That is why I did not touch
> default-configs/s390x-softmmu.mak.

The pci and isa testdevs seem to be included on all platforms that
support isa/pci (except for the pci testdev on s390x). They do have
their own config symbols, so they can be manually disabled should it be
desired. This seems like a good way to go for us as well.

> 
> I think, I have the most problematic places marked with a  TODO
> comment in the code.

I'll save looking at the code for another day.
