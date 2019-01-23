Received: from eggs.gnu.org ([209.51.188.92]:49882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmGK0-0004kl-Qc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmGJv-0007Xa-BP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:03:52 -0500
Date: Wed, 23 Jan 2019 12:03:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190123120337.72eb7637.cohuck@redhat.com>
In-Reply-To: <20190121134249.16615-2-david@redhat.com>
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] s390x/pci: Introduce unplug
 requests and split unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Mon, 21 Jan 2019 14:42:48 +0100
David Hildenbrand <david@redhat.com> wrote:

> PCI on s390x is really weird and how it was modeled in QEMU might not have
> been the right choice. Anyhow, right now it is the case that:
> - Hotplugging a PCI device will silently create a zPCI device
>   (if none is provided)
> - Hotunplugging a zPCI device will unplug the PCI device (if any)
> - Hotunplugging a PCI device will unplug also the zPCI device
> As far as I can see, we can no longer change this behavior. But we
> should fix it.
> 
> Both device types are handled via a single hotplug handler call. This
> is problematic for various reasons:
> 1. Unplugging via the zPCI device allows to unplug PCI bridges as
>    checks are not performed - bad.

Maybe I'm confused here, but how can a zPCI device couple with a bridge?
