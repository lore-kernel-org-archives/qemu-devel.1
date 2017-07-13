Received: from eggs.gnu.org ([2001:4830:134:3::10]:39644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVflr-0001mK-Qk
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVfln-0003rp-M6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:11:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVfln-0003rM-DD
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:11:11 -0400
Date: Thu, 13 Jul 2017 16:11:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170713151104.GE2121@work-vm>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
	<20170713142721.3a40e083@gondolin>
	<1798a9f2-63f0-ab03-11ad-5513d9a90da9@linux.vnet.ibm.com>
	<20170713144941.GD2121@work-vm>
	<99be1408-f8e4-7ecb-f47e-9de94a20ff18@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99be1408-f8e4-7ecb-f47e-9de94a20ff18@de.ibm.com>
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
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Juan Quintela <quintela@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> On 07/13/2017 04:49 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>
> >>
> >> On 07/13/2017 02:27 PM, Cornelia Huck wrote:
> >>>> +static void kvm_flic_ais_pre_save(void *opaque)
> >>>> +{
> >>>> +    KVMS390FLICStateMigTmp *tmp = opaque;
> >>>> +    KVMS390FLICState *flic = tmp->parent;
> >>>> +    struct kvm_s390_ais_all ais;
> >>>> +    struct kvm_device_attr attr = {
> >>>> +        .group = KVM_DEV_FLIC_AISM_ALL,
> >>>> +        .addr = (uint64_t)&ais,
> >>>> +        .attr = sizeof(ais),
> >>>> +    };
> >>>> +
> >>>> +    if (ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr)) {
> >>>> +        error_report("Failed to retrieve kvm flic ais states");
> >>> There's not much else we can do in that case, is there?
> >>>
> >>
> >> I think this is a very good question! The ioctl should not fail
> >> under any circumstances, but if it does we have a problem.
> >>
> >> Carrying on happily (what we do now) means effectively discarding
> >> ais state. In general just discarding state ain't a good idea.
> >>
> >> In particular it might be OK, but the patch should explain that!
> >>
> >> Regarding what could/should we do in such a case (instead
> >> of discarding state and carrying on happily) I don't know, so
> >> I tend to agree with you regarding 'not much else we can do'.
> >>
> >> Adding Dave and Juan. Maybe they can tell.
> > 
> > I keep meaning to make the pre_save give a return value for failure,
> > but it hasn't currently got one.
> 
> Would you accept patches for that?

Sure.

> > 
> > You could try something like:
> > 
> >   qemu_file_set_error(migrate_get_current()->to_dst_file, -EINVAL);
> > 
> >   I *think* the migration code should spot that before it finishes
> > but it might carry on for a little while before it does.
> 
> I will keep this patch as is, since this is one of the "should not happen"
> cases.

And you've got a log message, so when the impossible happens at least
we should be able to debug it.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
