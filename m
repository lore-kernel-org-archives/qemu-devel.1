Received: from eggs.gnu.org ([2001:4830:134:3::10]:33555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyMzT-0000jc-Ko
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 16:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyMzQ-0003ci-72
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 16:04:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fyMzQ-0003W5-1R
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 16:04:24 -0400
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
	<153634345465.24629.12107192195596244951.malone@gac.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e44e6746-8b94-c9e9-698f-514265208e68@redhat.com>
Date: Fri, 7 Sep 2018 15:04:22 -0500
MIME-Version: 1.0
In-Reply-To: <153634345465.24629.12107192195596244951.malone@gac.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX
 creates corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1776920 <1776920@bugs.launchpad.net>, qemu-devel@nongnu.org

On 09/07/2018 01:04 PM, Yan-Jie Wang wrote:
> I have done some experiments and find out that
> the behavior of lseek with whence set to SEEK_DATA is different from the behavior of Linux's lseek.
> 
> If the supplied offset is in the middle of a data region, it returns the
> start of the next data region.  There may be many data regions in a big
> file even though it has no hole.
> 
> return value of lseek with whence set to SEEK_DATA:
> 
> |--(offset)--Data----|(return value)----Data----|
> |--(offset)--Data----|----Hole----|(return value)----Data----|
> 
> 
> ** Patch added: "macOS-lseek.patch"
>     https://bugs.launchpad.net/qemu/+bug/1776920/+attachment/5186138/+files/macOS-lseek.patch

While a developer can chase a URL, our CI tools can't.  Can you please 
also send that patch directly to qemu-devel@nongnu.org, so that it gets 
the same level of review as other patches?

But I am very reluctant to take your patch. MacOS is flat-out buggy and 
in violation of the specification of lseek(SEEK_DATA), so making all 
applications work around their bug is not going to scale as well as 
having them fix their bug in the first place.

Here's the proposed POSIX specification for what lseek(SEEK_DATA) is 
supposed to do:
http://austingroupbugs.net/view.php?id=415#c862

That text has been present for 7 years now - so anyone implementing 
SEEK_DATA should really be paying attention to interoperability with 
that text.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
