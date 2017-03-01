Received: from eggs.gnu.org ([2001:4830:134:3::10]:35801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjDnO-0002BI-1V
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjDnJ-0007zm-AP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:36:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cjDnJ-0007zL-3r
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:36:29 -0500
Date: Thu, 2 Mar 2017 01:36:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170302002303-mutt-send-email-mst@kernel.org>
References: <1d155a66-8806-8792-b82d-4bebabcd4971@linux.vnet.ibm.com>
	<20170301191459-mutt-send-email-mst@kernel.org>
	<4022b3c9-56c3-7cea-928c-9e0e7d070d90@linux.vnet.ibm.com>
	<20170301173823.GO10160@redhat.com>
	<20170301194704-mutt-send-email-mst@kernel.org>
	<20170301180602.GH2429@work-vm>
	<20170301200804-mutt-send-email-mst@kernel.org>
	<20170301181801.GI2429@work-vm>
	<20170301202044-mutt-send-email-mst@kernel.org>
	<302eb2e3-6fdf-9c66-91cf-f8bad469383b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302eb2e3-6fdf-9c66-91cf-f8bad469383b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 02:24:20PM -0500, Stefan Berger wrote:
> > > Anyway, having it in a separate process locked down by SELinux means that even
> > > if it does go horribly wrong it won't break qemu.
> > > 
> > > Dave
> > Since qemu does blocking ioctls on it and doesn't validate results
> > too much it sure can break QEMU - anything from DOS to random
> > code execution. That's why we want to keep it in tree and
> > start it ourselves - I don't want CVEs claiming not validating
> > some parameter we get from it is a remote code execution.
> > It should be just a library that yes, we can keep out of
> > process for extra security but no, we can't just out random
> > stuff in there and never care.
> 
> So then the question is whether the implementation is hopelessly broken or
> whether we can defend against buffer overflows so that remote code execution
> from a malicious TPM emulator can actually happen? I thought I was properly
> checking the alllocated buffer for size and that we won't receive more than
> the expected number of bytes, but maybe it needs an additional check for
> unreasonable input.
> 
> Example of such code is here:
> 
> https://github.com/stefanberger/qemu-tpm/commit/27d332dc3b2c6bfd0fcd38e69f5c899651f3a5d8#diff-c9d7e2e1d4b17b93ca5580ec2d0d204aR188
> 
> 
> FYI:
> TPM 1.2 in libtpms:
> 
> $ wc *.c *.h | grep total
>   86130  352307 3227530 total
> 
> 
> TPM 2 in TPM 2 preview branch of libtpms:
> 
> $ wc *.c *.h | grep total
>   65318  319043 2651231 total

libtpms seems to be packaged and used outside QEMU, I don't say we need
to have that in tree. I thought we were discussing swtpm cuse thing.

> 
