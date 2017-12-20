Received: from eggs.gnu.org ([2001:4830:134:3::10]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRbfy-0002D9-Qw
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eRbft-0001rE-81
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:32:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:53952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eRbfs-0001oo-Ux
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:32:33 -0500
Message-ID: <5A3A3CBC.4030202@intel.com>
Date: Wed, 20 Dec 2017 18:34:36 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
In-Reply-To: <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 0/7] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 12/19/2017 10:05 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> ChangeLog:
>> v19->v20:
>> 1) patch 1: xbitmap
>> 	- add __rcu to "void **slot";
>> 	- remove the exceptional path.
>> 2) patch 3: xbitmap
>> 	- DeveloperNotes: add an item to comment that the current bit range
>> 	  related APIs operating on extremely large ranges (e.g.
>>            [0, ULONG_MAX)) will take too long time. This can be optimized in
>> 	  the future.
>> 	- remove the exceptional path;
>> 	- remove xb_preload_and_set();
>> 	- reimplement xb_clear_bit_range to make its usage close to
>> 	  bitmap_clear;
>> 	- rename xb_find_next_set_bit to xb_find_set, and re-implement it
>> 	  in a style close to find_next_bit;
>> 	- rename xb_find_next_zero_bit to xb_find_clear, and re-implement
>> 	  it in a stytle close to find_next_zero_bit;
>> 	- separate the implementation of xb_find_set and xb_find_clear for
>> 	  the convenience of future updates.
> Removing exceptional path made this patch easier to read.
> But what I meant is
>
>    Can you eliminate exception path and fold all xbitmap patches into one, and
>    post only one xbitmap patch without virtio-balloon changes?
>
> .
>
> I still think we don't need xb_preload()/xb_preload_end().

Why would you think preload is not needed?

The bitmap is allocated via preload "bitmap = 
this_cpu_cmpxchg(ida_bitmap, NULL, bitmap);", this allocated bitmap 
would be used in xb_set_bit().


> I think xb_find_set() has a bug in !node path.

I think we can probably remove the "!node" path for now. It would be 
good to get the fundamental part in first, and leave optimization to 
come as separate patches with corresponding test cases in the future.

Best,
Wei
