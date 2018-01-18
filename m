Received: from eggs.gnu.org ([2001:4830:134:3::10]:38705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec7l7-0001cV-0P
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec7l3-0006Fx-SL
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:49:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ec7l3-0006Ff-LY
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:49:21 -0500
Date: Thu, 18 Jan 2018 10:49:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118104916.GF19695@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXe6SJtWUFY8hN=dXzFCzztcsGkWbNx+1WZba05Rp3TqO_38w@mail.gmail.com>
Subject: Re: [Qemu-devel] Do I need update the microcode of virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On Thu, Jan 18, 2018 at 06:38:57PM +0800, Li Qiang wrote:
> Hi Paolo, all,
> 
> I have a question about the intel microcode update for spectre variant#2.
> From my understanding, there is no need to update the microcode of VMs
> because the kvm has expose the SPEC_CTL and PRED_CMD to the guest.
> Also, if we need to update the micorcode in guest, who is the vendor for
> this.
> From the hyper-v, I think I'm right.
> -->
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/CVE-2017-5715-and-hyper-v-vms
> 
> But upon I update the centos guest, the host kvm/qemu has been updated.
> The IBPB_ENABLED and IBRS_ENABLED are both zero if I don't update the
> microcode in the guest.
> If I update the guest micorcode, the are both 1.
>
> So I want to know, if I should update the microcode in guest.
> If the answer is Yes, then what about the Windows guest, how to update the
> microcode?

Microcode updates are only applicable to the physical CPUs seen by the
host. There is no concept of microcde for virtual CPUs in the guest. The
guest merely sees whatever CPU feature the hypervisor has permitted it to
see. IOW, as described in that microsoft link, you need to

 - Update microcode and/or firmware in host
 - Update host hypervisor software
 - Change hypervisor config for each guest to enable new CPU features
 - Update guest software (kernel)
 - Cold boot (ie fully shutoff, and then power on) the guest

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
