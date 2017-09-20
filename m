Received: from eggs.gnu.org ([2001:4830:134:3::10]:50968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dufVs-0004QJ-S2
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dufVn-0006gH-Or
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dufVn-0006fu-JD
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:57:59 -0400
Date: Wed, 20 Sep 2017 15:57:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920155746.1192d2fa.cohuck@redhat.com>
In-Reply-To: <20170919180038.26056-2-dgilbert@redhat.com>
References: <20170919180038.26056-1-dgilbert@redhat.com>
	<20170919180038.26056-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] migration: pre_save return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org, rth@twiddle.net

On Tue, 19 Sep 2017 19:00:34 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Modify the pre_save method on VMStateDescription to return an int
> rather than void so that it potentially can fail.
> 
> Changed zillions of devices to make them return 0; the only
> case I've made it return non-0 is hw/intc/s390_flic_kvm.c that already
> had an error_report/return case.

Never thought that this device would be at the bleeding edge ;)

> 
> Note: If you add an error exit in your pre_save you must emit
> an error_report to say why.

Would it make sense to relay an error object? For example,
cpu_pre_save() in target/s390x/machine.c calls
kvm_s390_vcpu_interrupt_pre_save() which already does an error report.
If we relay that error instead, we would avoid saying "oops, this
didn't work" several times with decreasing amount of information.

On the other hand, that change would be more invasive.

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

>  hw/intc/s390_flic_kvm.c        |  6 ++++--

>  hw/s390x/css.c                 | 10 +++++++---
>  hw/s390x/virtio-ccw.c          |  4 +++-

>  target/s390x/machine.c         |  4 +++-

That said, the changes in s390-related code look fine.
