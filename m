Received: from eggs.gnu.org ([2001:4830:134:3::10]:35023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv01F-00059n-MB
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv01A-0001zb-QU
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:51:49 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv01A-0001zC-JQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:51:44 -0400
Received: by mail-wm0-f44.google.com with SMTP id b195so1028019wmb.5
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 04:51:44 -0700 (PDT)
References: <20170921085110.25598-1-aik@ozlabs.ru>
	<20170921085110.25598-5-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5b9c3ac-56fe-c29c-ed19-3eb5a5f159c2@redhat.com>
Date: Thu, 21 Sep 2017 13:51:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170921085110.25598-5-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5 04/18] memory: Move
 AddressSpaceDispatch from AddressSpace to FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 21/09/2017 10:50, Alexey Kardashevskiy wrote:
> * since FlatView::rcu is used now to dispose FV, call_rcu() in
> address_space_update_topology() is replaced with direct call to
> flatview_unref()

Hmm, this is not correct, as you could have


   thread 1             thread 2             RCU thread
  -------------------------------------------------------------
   rcu_read_lock
   read as->current_map
                        set as->current_map
                        flatview_unref
                           '--> call_rcu
   flatview_ref
   rcu_read_unlock
                                             flatview_destroy

I need to think a bit more about this (and possibly ask Paul...).

Paolo
