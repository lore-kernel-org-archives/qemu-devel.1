Received: from eggs.gnu.org ([2001:4830:134:3::10]:51581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVdtX-0001Xy-AK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVdtU-0007VT-21
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVdtT-0007VF-S1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:10:59 -0400
Date: Thu, 13 Jul 2017 15:10:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713151054.28eb7909@gondolin>
In-Reply-To: <606fdb06-cb0e-00b3-ffa3-18a024f14309@de.ibm.com>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
	<20170713142721.3a40e083@gondolin>
	<606fdb06-cb0e-00b3-ffa3-18a024f14309@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/s390-next 3/3] s390x/flic: migrate ais
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On Thu, 13 Jul 2017 15:02:08 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/13/2017 02:27 PM, Cornelia Huck wrote:
> > On Thu, 13 Jul 2017 12:40:29 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >>
> >> During migration we should transfer ais states to the target guest.
> >> This patch introduces a subsection to kvm_s390_flic_vmstate and new
> >> vmsd for qemu_flic. The ais states need to be migrated only when
> >> ais is supported.
> >>
> >> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  hw/intc/s390_flic.c          | 20 ++++++++++++
> >>  hw/intc/s390_flic_kvm.c      | 75 ++++++++++++++++++++++++++++++++++++++++++++
> >>  include/hw/s390x/s390_flic.h |  1 +
> >>  3 files changed, 96 insertions(+)

> >> +static int kvm_flic_ais_post_load(void *opaque, int version_id)
> >> +{
> >> +    KVMS390FLICStateMigTmp *tmp = opaque;
> >> +    KVMS390FLICState *flic = tmp->parent;
> >> +    struct kvm_s390_ais_all ais = {
> >> +        .simm = tmp->simm,
> >> +        .nimm = tmp->nimm,
> >> +    };
> >> +    struct kvm_device_attr attr = {
> >> +        .group = KVM_DEV_FLIC_AISM_ALL,
> >> +        .addr = (uint64_t)&ais,
> >> +    };
> >> +
> >> +    if (!ais_needed(flic)) {
> >> +        return -ENOSYS;
> >> +    }  
> > 
> > I do not understand this... does that mean that
> > - we should never get here or 
> > - we should not try to change the fields or
> > - I need coffee?  
> 
> My understanding is that this should not happen with a normal setup, 
> but it can happen if the user does something "wrong". For example
> use qemu without libvirt and with -cpu host (which is not migration safe)
> and do a migration from a host that has AIS to a host that has no AIS.
> In that case the target system will reject the migration (late, but hopefully
> not too late).

A comment would be helpful here.
