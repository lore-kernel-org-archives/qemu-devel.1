Received: from eggs.gnu.org ([2001:4830:134:3::10]:58292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0tI-0004CX-Vg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0tE-0004LW-OJ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:07:48 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180306160017.GM31045@stefanha-x1.localdomain>
	<20180306174918.GA22807@flamenco>
	<482599db-65b7-ba5d-6784-72acf3486786@virtuozzo.com>
	<20180308185638.GA25161@flamenco>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <876a1999-fdc7-196e-e94b-a71e82ad13f9@virtuozzo.com>
Date: Thu, 8 Mar 2018 22:07:35 +0300
MIME-Version: 1.0
In-Reply-To: <20180308185638.GA25161@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

08.03.2018 21:56, Emilio G. Cota wrote:
> On Thu, Mar 08, 2018 at 14:42:29 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi Emilio!
>>
>> Looked through qdist, if I understand correctly, it saves each added (with
>> different value) element. It is not effective for disk io timing - we'll
>> have too much elements. In my approach, histogram don't grow, it initially
>> have several ranges and counts hits to each range.
> I thought about this use case, i.e. having a gazillion elements.
> You should just do some pre-binning before inserting samples
> into qdist, as pointed out in this comment in qdist.h:
>
> /*
>   * Samples with the same 'x value' end up in the same qdist_entry,
>   * e.g. inc(0.1) and inc(0.1) end up as {x=0.1, count=2}.
>   *
>   * Binning happens only at print time, so that we retain the flexibility to
>   * choose the binning. This might not be ideal for workloads that do not care
>   * much about precision and insert many samples all with different x values;
>   * in that case, pre-binning (e.g. entering both 0.115 and 0.097 as 0.1)
>   * should be considered.
>   */
> struct qdist_entry {
>      double x;
>      unsigned long count;
> };
>
> Let me know if you need help with that.
>
> Thanks,
>
> 		Emilio

In this case, I'll have to do same bin search (and store same interval 
settings) as I already do, on my part, to calculate a parameter for 
qdist interface. And I'll have store almost all same data on my part. 
So, it doesn't really help. And I need nothing of qdist benefits: I 
don't need (and don't want) dynamic allocation of bins on adding an 
element or any type of visualization.

-- 
Best regards,
Vladimir
