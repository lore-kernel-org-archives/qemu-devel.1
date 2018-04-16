Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f88Q6-0006Kh-7A
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f88Q2-000899-QW
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f88Q2-000881-IR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:59:58 -0400
Date: Mon, 16 Apr 2018 14:59:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180416175955.GO29865@localhost.localdomain>
References: <0c14166c-28c4-a1ad-093b-ba63e373e790@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c14166c-28c4-a1ad-093b-ba63e373e790@redhat.com>
Subject: Re: [Qemu-devel] Purpose of memory-backend-file.discard-data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zack Cornelius <zack.cornelius@kove.net>

(CCing Zack Cornelius)

On Fri, Apr 13, 2018 at 08:21:26AM +0200, Michal Privoznik wrote:
> Eduardo et al,
> 
> I'm looking at 11ae6ed8affdd131e and I wanted to implement libvirt
> support for that. But more I look at it less I understand it. My
> understanding it is an optimization (although not very effective one
> since madvise() is/should be immediately followed by munmap()). So any
> application that is trying to keep track of guest memory  can stop doing
> so as soon as it sees munmap(). Or does the optimization lies in fact
> that madvise() is called sooner and thus the app can stop caring
> slightly sooner?

munmap() or close() are not enough: it would still make the host
kernel unnecessarily write data to backing storage.  The point of
the madvise() call is to tell the kernel that data can be
destroyed instead of being written back.

The original use case is described by Zack here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg473538.html


> 
> Also, I don't quite understand why is this configurable. What's the harm
> in turning it on by default? Yesterday I've posted some patches to
> libvirt list [1] (although I have to admit I am still not fully
> convinced about the design) and they implement just this - whenever qemu
> supports the feature libvirt turns it on.S

The option can destroy the data on the backing file, so QEMU can't enable it by
default.  libvirt can enable it as long as it knows it can destroy the data on
the backing file.

> 
> Michal
> 
> 1: https://www.redhat.com/archives/libvir-list/2018-April/msg01066.html

-- 
Eduardo
