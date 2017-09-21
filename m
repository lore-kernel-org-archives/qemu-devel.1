Received: from eggs.gnu.org ([2001:4830:134:3::10]:38418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duuyT-0003bG-7Q
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duuyP-0005nM-8F
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:28:37 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:51475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duuyO-0005nC-Vk
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:28:33 -0400
Received: by mail-it0-x22a.google.com with SMTP id o200so5347485itg.0
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 23:28:32 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-10-aik@ozlabs.ru>
	<611f7d09-7c5d-20c4-9b9b-1c1f58525fb1@redhat.com>
	<e9f654aa-ca37-b4fc-a4b9-e916d62a5847@ozlabs.ru>
	<97ce1385-01c9-1045-2791-494a14a86a78@ozlabs.ru>
Message-ID: <3f073ddb-a46a-523d-fb0b-037b3a193d78@ozlabs.ru>
Date: Thu, 21 Sep 2017 16:28:27 +1000
MIME-Version: 1.0
In-Reply-To: <97ce1385-01c9-1045-2791-494a14a86a78@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 09/18] memory: Store physical root
 MR in FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 15:22, Alexey Kardashevskiy wrote:
> On 21/09/17 10:02, Alexey Kardashevskiy wrote:
>> On 21/09/17 03:15, Paolo Bonzini wrote:
>>> On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
>>>> Address spaces get to keep a root MR (alias or not) but FlatView stores
>>>> the actual MR as this is going to be used later on to decide whether to
>>>> share a particular FlatView or not.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>> Changes:
>>>> v4:
>>>> * s/memory_region_unalias_entire/memory_region_get_flatview_root/
>>>
>>> Did you try the idea of checking for single-child regions too?
>>
>> No, I did not, I do not see how I can actually measure the difference - the
>> PCI and virtio root MRs or single child MRs are unique anyway, I can save
>> some time by just checking for 2 @enabled flags instead of rendering a
>> FlatView but rendering such cases itself is fast as well. I'll give a try
>> though.
> 
> I tried. memory_region_get_flatview_root() returns a last child which still
> covers the same space as the root; generate_memory_topology() checks for
> @enabled first and only if it is enabled - renders a new FV (this solves
> PCI busmater).
> 
> With 256 CPUs and 256 virtio devices this saves 0.1s (20.4s -> 20.3s) and
> 100MB of RAM (14.38G -> 14.28G) :) I'll push it out anyway.


Hm. Actually using that child as a root for FV in 09/18 increases memory
use from 18G to 20G. If I just check the nested MR if it is not enabled,
this does not change a thing - time and memory use is the same. Well, it is
beyond accuracy of my measurements :)


-- 
Alexey
