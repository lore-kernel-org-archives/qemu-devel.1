Received: from eggs.gnu.org ([2001:4830:134:3::10]:44638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drJKI-00049r-O6
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drJKF-00019u-L2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:40:14 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:43898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drJKF-00017I-E9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:40:11 -0400
Received: by mail-wm0-f43.google.com with SMTP id a137so6313859wma.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 00:40:09 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-4-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <984ae4a4-3045-e880-b39e-da846b1e2821@redhat.com>
Date: Mon, 11 Sep 2017 09:40:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170907092010.3605-4-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/4] memory: Share flat views and
 dispatch trees between address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 07/09/2017 11:20, Alexey Kardashevskiy wrote:
>  
>      /* Accessed via RCU.  */
>      struct FlatView *current_map;
>  
>      int ioeventfd_nb;
>      struct MemoryRegionIoeventfd *ioeventfds;
> -    struct AddressSpaceDispatch *dispatch;
> -    struct AddressSpaceDispatch *next_dispatch;
> +

The rough idea of the patch matches my suggestion indeed.  However, I am
not sure why all of the changes in patch 2 are needed.

Once you have built the FlatView and the dispatch within it, you can
still cache its dispatch tree in as->dispatch, and free it with RCU from
flatview_destroy.  This removes the need to use call_rcu from
flatview_unref.

In addition, you could change the computation of FlatView's root to
resolve 2^64-sized aliases; also set it to NULL if the AddressSpace's
root is disabled or the alias it resolves to is disabled (and so on
recursively until a non-alias is found).  This should remove the need
for address_space_root() and the change to pci_init_bus_master.

Paolo
