Received: from eggs.gnu.org ([2001:4830:134:3::10]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVv1R-0002yJ-8S
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVv1O-0002xU-5t
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVv1N-0002x5-VK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:28:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB41A7C83B
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:28:16 +0000 (UTC)
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
	<1499847223-8078-5-git-send-email-peterx@redhat.com>
	<0850f338-98a2-614a-c8bd-3407c9b5a485@redhat.com>
	<20170714043241.GK27284@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <14784c80-2b88-1994-9d50-7d39dc72a808@redhat.com>
Date: Fri, 14 Jul 2017 15:28:09 +0800
MIME-Version: 1.0
In-Reply-To: <20170714043241.GK27284@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] intel_iommu: implement mru list for
 iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>



On 2017=E5=B9=B407=E6=9C=8814=E6=97=A5 12:32, Peter Xu wrote:
> On Thu, Jul 13, 2017 at 04:48:42PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B407=E6=9C=8812=E6=97=A5 16:13, Peter Xu wrote:
>>> It is not wise to disgard all the IOTLB cache when cache size reaches
>>> max, but that's what we do now. A slightly better (but still simple) =
way
>>> to do this is, we just throw away the least recent used cache entry.
>>>
>>> This patch implemented MRU list algorithm for VT-d IOTLB. The main lo=
gic
>>> is to maintain a Most Recently Used list for the IOTLB entries. The h=
ash
>>> table is still used for lookup, though a new list field is added to e=
ach
>>> IOTLB entry for a iotlb MRU list. For each active IOTLB entry, it's b=
oth
>>> in the hash table in s->iotlb, and also linked into the MRU list of
>>> s->iotlb_head. The hash helps in fast lookup, and the MRU list helps =
in
>>> knowing whether the cache is still hot.
>>>
>>> After we have such a MRU list, replacing all the iterators of IOTLB
>>> entries by using list iterations rather than hash table iterations.
>> Any reason of doing this, I thought hashtable was even a little bit fa=
ster?
> Could I ask why?
>
> I thought they are merely the same (when iterating all the items)?
>

Ok, looks like I was wrong, but it they are merely the same, why bother?

Thanks
