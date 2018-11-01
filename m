Received: from eggs.gnu.org ([2001:4830:134:3::10]:57099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gIG6a-00084B-B5
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gIG6Z-0006Zn-Gf
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:46:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jmattson@google.com>) id 1gIG6Z-0006ZL-9f
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:45:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id e9so16834222oti.1
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 09:45:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181101155610.GD2726@work-vm>
References: <EFF8C049-EE78-4035-A38E-6A91EA219878@oracle.com>
	<80DAB33E-A982-4903-AEBA-F71AB2E8AFC3@oracle.com>
	<5F34DE35-D1EE-441A-87A1-379C7A04AFE7@oracle.com>
	<20181031181759.GR3902@habkost.net>
	<a5b6cdf7-6ff9-7bd8-d591-3e2669b4f802@redhat.com>
	<B34C4E8C-748D-4D78-807F-3F51C80EA5B2@oracle.com>
	<20181031185930.GC2403@work-vm>
	<5FA867F7-3520-4903-BC2F-B55227A04FED@oracle.com>
	<20181101131059.GB2726@work-vm>
	<F144DC98-45AA-4DD8-8A7E-25B867FE7863@oracle.com>
	<20181101155610.GD2726@work-vm>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 1 Nov 2018 09:45:56 -0700
Message-ID: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Thu, Nov 1, 2018 at 8:56 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

> So if I have matching host kernels it should always work?
> What happens if I upgrade the source kernel to increase it's maximum
> nested size, can I force it to keep things small for some VMs?

Any change to the format of the nested state should be gated by a
KVM_CAP set by userspace. (Unlike, say, how the
KVM_VCPUEVENT_VALID_SMM flag was added to the saved VCPU events state
in commit f077825a8758d.) KVM has traditionally been quite bad about
maintaining backwards compatibility, but I hope the community is more
cognizant of the issues now.

As a cloud provider, one would only enable the new capability from
userspace once all hosts in the pool have a kernel that supports it.
During the transition, the capability would not be enabled on the
hosts with a new kernel, and these hosts would continue to provide
nested state that could be consumed by hosts running the older kernel.
