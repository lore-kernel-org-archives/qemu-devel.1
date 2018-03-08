Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eu0id-0003BD-Ds
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eu0ic-0007i3-MK
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:56:47 -0500
Date: Thu, 8 Mar 2018 13:56:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180308185638.GA25161@flamenco>
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180306160017.GM31045@stefanha-x1.localdomain>
	<20180306174918.GA22807@flamenco>
	<482599db-65b7-ba5d-6784-72acf3486786@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482599db-65b7-ba5d-6784-72acf3486786@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

On Thu, Mar 08, 2018 at 14:42:29 +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi Emilio!
> 
> Looked through qdist, if I understand correctly, it saves each added (with
> different value) element. It is not effective for disk io timing - we'll
> have too much elements. In my approach, histogram don't grow, it initially
> have several ranges and counts hits to each range.

I thought about this use case, i.e. having a gazillion elements.
You should just do some pre-binning before inserting samples
into qdist, as pointed out in this comment in qdist.h:

/*
 * Samples with the same 'x value' end up in the same qdist_entry,
 * e.g. inc(0.1) and inc(0.1) end up as {x=0.1, count=2}.
 *
 * Binning happens only at print time, so that we retain the flexibility to
 * choose the binning. This might not be ideal for workloads that do not care
 * much about precision and insert many samples all with different x values;
 * in that case, pre-binning (e.g. entering both 0.115 and 0.097 as 0.1)
 * should be considered.
 */
struct qdist_entry {
    double x;
    unsigned long count;
};

Let me know if you need help with that.

Thanks,

		Emilio
