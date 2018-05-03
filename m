Received: from eggs.gnu.org ([2001:4830:134:3::10]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEGPC-0007Ga-WD
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEGP9-0000yZ-S4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:44:27 -0400
Date: Thu, 3 May 2018 17:44:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180503174412.359494fb.cohuck@redhat.com>
In-Reply-To: <cbe7b21c-639c-aa64-4777-03d0aa793ac8@linux.ibm.com>
References: <20180502125221.4877-1-cohuck@redhat.com>
	<cbe7b21c-639c-aa64-4777-03d0aa793ac8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Thu, 3 May 2018 11:25:08 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 05/02/2018 08:52 AM, Cornelia Huck wrote:
> > We currently pass an integer as the subcode parameter. However,
> > the upper bits of the register containing the subcode need to
> > be 0, which is not guaranteed unless we explicitly specify the
> > subcode to be an unsigned long value.
> > 
> > Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
> > Cc:qemu-stable@nongnu.org
> > Signed-off-by: Cornelia Huck<cohuck@redhat.com>  
> 
> Sorry for my ignorance, but is there a C standard that says upper bits 
> of an int is not guaranteed to be 0?

The value (5 resp. 6) is small enough to fit into a regular integer,
and the compiler generated a lhi for the load, which did not change any
upper values that might have been in the register previously. Telling
the compiler to treat the value as an unsigned long makes it generate a
lghi.
