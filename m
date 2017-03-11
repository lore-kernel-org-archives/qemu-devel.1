Received: from eggs.gnu.org ([2001:4830:134:3::10]:53254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmkPC-0001jN-UA
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmkP9-0006on-Qq
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:02:10 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:51404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmkP9-0006nI-Hp
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 12:02:07 -0500
Date: Sat, 11 Mar 2017 12:02:03 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <236110410.1797136.1489251723081.JavaMail.zimbra@redhat.com>
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A0FC31@ORSMSX112.amr.corp.intel.com>
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<867e2a13-b48e-cb85-1eb9-38694e28c172@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F66A@ORSMSX112.amr.corp.intel.com>
	<a5f6ed2f-2580-beaa-a5d2-42857588844c@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0FC31@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org, Chao P Peng <chao.p.peng@intel.com>



----- Original Message -----
> From: "Anthony Xu" <anthony.xu@intel.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, "Yang Zhong" <yang.zhong@intel.com>, qemu-devel@nongnu.org
> Cc: "Chao P Peng" <chao.p.peng@intel.com>
> Sent: Friday, March 10, 2017 8:30:06 PM
> Subject: RE: [PATCH v1 1/2] reduce qemu's heap Rss size from 12252kB to 2752KB
> 
> > > Ideally, freeing QOM object should not require a global lock.
> > > If you see any other QOM requiring a global lock, please let us know, we
> > are willing to fix it.
> > 
> > All of them.  When unplugging a device, the device object will be freed
> > from an RCU callback.
> > 
> 
> Thanks for your reply,
> Some objects may not need lock at all to be freed,
> Some objects may just need a small lock to be freed,
> 
> Should we let RCU callbacks to decide which lock they need instead of
> enforcing the global lock in RCU thread?

Splitting the global lock and deciding which object requires which lock
is very, very hard.

The problem is that everything calling object_unref potentially needs the
global lock, and that includes the following call chain: object_unref
-> memory_region_unref -> flatview_destroy -> flatview_unref ->
address_space_update_topology -> memory_region_transaction_commit.

Paolo

> As for the device object, can we get the global lock inside the object
> free/destroy function for now?
> 
> If we can remove the global lock inside RCU thread, we can save 9MB heap
> memory, that's a lot!
> 
> Please share with us if you have other idea to do this.
> 
> Thanks
> Anthony
> 
> 
> 
> 
