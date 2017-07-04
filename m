Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSRAl-0000f2-3z
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSRAg-0004FB-Am
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:59:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dSRAg-0004Cv-5D
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 12:59:30 -0400
Date: Tue, 4 Jul 2017 18:59:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170704185924.3eb7171d@dhcp-192-215.str.redhat.com>
In-Reply-To: <87aeaca3-5261-91c9-506b-eded3dededb4@linux.vnet.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-4-git-send-email-borntraeger@de.ibm.com>
	<20170704163103.4d6670a9@dhcp-192-215.str.redhat.com>
	<3200e2c0-8ffe-2f6d-b7a8-049352851c96@linux.vnet.ibm.com>
	<87aeaca3-5261-91c9-506b-eded3dededb4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] s390x: fix error propagation in
 kvm-flic's realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On Tue, 4 Jul 2017 17:08:52 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >>>      cd.type = KVM_DEV_TYPE_FLIC;
> >>>      ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
> >>>      if (ret < 0) {
> >>> -        trace_flic_create_device(errno);
> >>> -        return;
> >>> +        error_setg_errno(&errp_local, errno, "Creating the KVM device failed");
> >>> +        trace_flic_no_device_api(errno);  
> >>
> >> Err... this should still be trace_flic_create_device(), no?  
> > 
> > I'm afraid you are right! Probably a copy paste error :/
> >   
> 
> Do you think the traces are still appropriate once we have
> proper error propagation?

They add less value, but I'd just keep them.

> 
> I did not feel comfortable removing them but thinking again,
> than might be the thing to do.
> 
> @Christian:
> I think we should really fix this the one way or the other.
> Can you tell me what is the proper procedure?

I'd vote for just fixing the trace event. Smaller change, and we can
revisit this later.
