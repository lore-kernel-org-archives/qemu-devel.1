Received: from eggs.gnu.org ([2001:4830:134:3::10]:39400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD385-0007cZ-Fj
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD382-0000QC-B4
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:21:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD382-0000Mw-0W
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:21:42 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
	<ab60c407-12c7-8872-1d7c-d4f933f12979@redhat.com>
	<20180428022407.GG13269@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54cee857-2492-95c8-e1c4-d6a6e2f6b552@redhat.com>
Date: Mon, 30 Apr 2018 09:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180428022407.GG13269@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, David Gibson <david@gibson.dropbear.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On 28/04/2018 04:24, Peter Xu wrote:
>>>> 2) Can we just reuse qemu BQL here?
>>> I would prefer not.  As I mentioned, at least I have spent too much
>>> time on fighting BQL already.  I really hope we can start to use
>>> isolated locks when capable.  BQL is always the worst choice to me.
>> Just a thought, using BQL may greatly simplify the code actually (consider
>> we don't plan to remove BQL now).
> Frankly speaking I don't understand why using BQL may greatly simplify
> the code... :( IMHO the lock here is really not a complicated one.
> 
> Note that IMO BQL is mostly helpful when we really want something to
> be run sequentially with some other things _already_ protected by BQL.
> In this case, all the stuff is inside VT-d code itself (or other
> IOMMUs), why bother taking the BQL to make our life harder?
> 
> So, even if we want to provide a general lock for the translation
> procedure, I would prefer we add a per AddressSpace lock but not BQL.
> However still that will need some extra flag showing that whether we
> need the protection of not.  For example, we may need to expliclitly
> turn that off for Power and s390.  Would that really worth it?
> 
> So my final preference is still current patch - we solve thread-safety
> problems in VT-d and IOMMU code.  Again, we really should make sure
> all IOMMUs work with multithreads.
> 

I agree.  In particular, using BQL is _worse_ because it has very strict
lock ordering requirements.  Using fine-grained locks is greatly
preferred as long as:

1) they are leaves in the lock ordering

2) they are not kept across calls to external callbacks (or there are no
external callbacks involved)

Paolo
