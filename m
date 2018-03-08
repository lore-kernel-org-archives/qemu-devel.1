Received: from eggs.gnu.org ([2001:4830:134:3::10]:49269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eu1nR-0000ws-Fm
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eu1nQ-0001OO-Ft
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:05:49 -0500
Date: Thu, 8 Mar 2018 15:05:40 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180308200540.GA31830@flamenco>
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180306160017.GM31045@stefanha-x1.localdomain>
	<20180306174918.GA22807@flamenco>
	<482599db-65b7-ba5d-6784-72acf3486786@virtuozzo.com>
	<20180308185638.GA25161@flamenco>
	<876a1999-fdc7-196e-e94b-a71e82ad13f9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876a1999-fdc7-196e-e94b-a71e82ad13f9@virtuozzo.com>
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

On Thu, Mar 08, 2018 at 22:07:35 +0300, Vladimir Sementsov-Ogievskiy wrote:
> 08.03.2018 21:56, Emilio G. Cota wrote:
> >  * Binning happens only at print time, so that we retain the flexibility to
> >  * choose the binning. This might not be ideal for workloads that do not care
> >  * much about precision and insert many samples all with different x values;
> >  * in that case, pre-binning (e.g. entering both 0.115 and 0.097 as 0.1)
> >  * should be considered.
(snip)
> In this case, I'll have to do same bin search (and store same interval
> settings) as I already do, on my part, to calculate a parameter for qdist
> interface. And I'll have store almost all same data on my part. So, it
> doesn't really help. And I need nothing of qdist benefits: I don't need (and
> don't want) dynamic allocation of bins on adding an element or any type of
> visualization.

I see. You require a couple of features that qdist doesn't yet support:

- Arbitrarily-sized, pre-defined bins.
- Support for querying the data programmatically instead of just
  printing it out.

We could circumvent the first missing feature with pre-binning,
but in that case we'd do a bsearch twice as you point out (BTW
your concern about memory allocation wouldn't apply though).

The second missing feature should be easy to add to qdist.

That said, given that you want this in for 2.12, I'd go with your
approach for now. In the future we should look into supporting
your use case in qdist, since it is likely that there will be
more users with a similar need.

Thanks,

		Emilio
