Received: from eggs.gnu.org ([2001:4830:134:3::10]:45072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDBE-0003wI-34
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDB9-0006iC-Uu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duDB9-0006hx-P5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:42:47 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
	<2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
	<a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bdd220a9-7773-74c5-f924-112a6134d13b@redhat.com>
Date: Tue, 19 Sep 2017 09:42:42 +0200
MIME-Version: 1.0
In-Reply-To: <a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 01/13] memory: Postpone flatview
 and dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 19/09/2017 08:57, Alexey Kardashevskiy wrote:
>>> 2) also, after patch 2 you know that the address space has no listeners
>>> here, so the begin/commit isn't really needed.  Instead you can use the
>>> open-coded loop to directly generate the FlatView.  This avoids touching
>>> _all_ address spaces, which is already an improvement from O(n^2) to
>>> O(n) rebuilds on device startup.
> 03/13 does this already, no?
> 

No, there's still

    as->dispatch = NULL;
    memory_region_update_pending |= root->enabled;
    memory_region_transaction_commit();

when creating the address space, which touches all address spaces.

Paolo
