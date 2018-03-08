Received: from eggs.gnu.org ([2001:4830:134:3::10]:56803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etzNq-0002de-3f
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etzNp-0002wX-2L
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:31:14 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180207125037.13510-2-vsementsov@virtuozzo.com>
	<20180306153213.GK31045@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49f2f289-ce1c-6e24-8b54-bb5b5c1601bc@redhat.com>
Date: Thu, 8 Mar 2018 11:31:03 -0600
MIME-Version: 1.0
In-Reply-To: <20180306153213.GK31045@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block/accounting: introduce latency
 histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

On 03/06/2018 09:32 AM, Stefan Hajnoczi wrote:
> On Wed, Feb 07, 2018 at 03:50:36PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Introduce latency histogram statics for block devices.
>> For each accounted operation type latency region [0, +inf) is
>> divided into subregions by several points. Then, calculate
>> hits for each subregion.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---

> According to Wikipedia and Mathworld, "intervals" and "bins" are
> commonly used terms:
> https://en.wikipedia.org/wiki/Histogram
> http://mathworld.wolfram.com/Histogram.html
> 
> I suggest:
> 
>    typedef struct {
>        /* The following histogram is represented like this:
>         *
>         * 5|           *
>         * 4|           *
>         * 3| *         *
>         * 2| *         *    *
>         * 1| *    *    *    *
>         *  +------------------
>         *      10   50   100
>         *
>         * BlockLatencyHistogram histogram = {
>         *     .nbins = 4,
>         *     .intervals = {10, 50, 100},
>         *     .bins = {3, 1, 5, 2},
>         * };

The name 'intervals' is still slightly ambiguous: does it hold the 
boundary point (0-10 for 10 slots, 10-50 for 40 slots, 50-100, for 50 
slots, then 100-INF) or is it the interval size of each slot (first bin 
is 10 slots for 0-10, next bin is 50 slots wide so 10-60, next bin is 
100 slots wide so 60-160, everything else is 160-INF).  But the 
ascii-art diagram plus the text is sufficient to resolve the intent if 
you keep that name (I don't have a suggestion for a better name).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
