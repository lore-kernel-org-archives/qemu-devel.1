Received: from eggs.gnu.org ([2001:4830:134:3::10]:56777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dkQ5u-0002RS-C8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dkQ5t-0003Vf-5S
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:28:54 -0400
Received: from mail-yw0-x236.google.com ([2607:f8b0:4002:c05::236]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1dkQ5s-0003VP-SC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:28:53 -0400
Received: by mail-yw0-x236.google.com with SMTP id h127so5104357ywf.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 00:28:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503471212-109371-1-git-send-email-borntraeger@de.ibm.com>
References: <1503471212-109371-1-git-send-email-borntraeger@de.ibm.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 23 Aug 2017 09:28:21 +0200
Message-ID: <CAATJJ0+OztkKpfD9RzK_FpGZKeUm_QbmEDr4CdajNYaiU9VnfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] configure: enable --s390-pgste linker
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Dan Horak <dhorak@redhat.com>

On Wed, Aug 23, 2017 at 8:53 AM, Christian Borntraeger <
borntraeger@de.ibm.com> wrote:

> KVM guests on s390 need a different page table layout than normal
> processes (2kb page table + 2kb page status extensions vs 2kb page table
> only). As of today this has to be enabled via the vm.allocate_pgste
> sysctl.
>
> Newer kernels (>= 4.12) on s390 check for an S390_PGSTE program header
> and enable the pgste page table extensions in that case. This makes the
> vm.allocate_pgste sysctl unnecessary. We enable this program header for
> the s390 system emulation (qemu-system-s390x) if we build on s390
> - for s390 system emulation
> - the linker supports --s390-pgste (binutils >= 2.29)
> - KVM is enabled
>
> This will allow distributions to disable the global vm.allocate_pgste
> sysctl, which will improve the page table allocation for non KVM
> processes as only 2kb chunks are necessary.
>

Hi Christian,
it is great to see context pgste come to life.
Currently vm.allocate_pgste defaults to 0 in the kernel but as you stated
mostly enabled for KVM support in Distros.
So when someone wants to disable it he has to drop the enabling
(e.g. /etc/sysctl.d/10-arch-specific.conf for us).

I want to be sure on the proper phasing of this - we can drop the
"enabling" of global pgste once for a release we:
- do not expect/support a kernel <4.12 to run there
- will have only qemu versions >= the one carrying this change (and have it
properly enabled)
- binutils >= 2.29 to get the linking right

But furthermore if we have a qemu with this enabled, there is no drawback
and we could still run it in:
- former releases with older kernels
- former releases with older build environments
That program header would just be ignored and we just would have to keep
the sysctl enabled there right?

Also for the time we want to check on the proper header, you surely have a
one liner you can share that you run against the binary to check if it was
generated correctly?
Maybe even one that you can run against a pid if the status is correct?
