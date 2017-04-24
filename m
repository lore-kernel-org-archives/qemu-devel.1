Received: from eggs.gnu.org ([2001:4830:134:3::10]:45575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d2ZjE-0002sM-Td
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d2ZjB-0005jQ-S2
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:52:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:31751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <he.chen@linux.intel.com>)
	id 1d2ZjB-0005fT-IO
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:52:13 -0400
Date: Mon, 24 Apr 2017 16:52:48 +0800
From: He Chen <he.chen@linux.intel.com>
Message-ID: <20170424085248.GA16098@he>
References: <1492759935-23933-1-git-send-email-he.chen@linux.intel.com>
	<20170421115301.4475eff6@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170421115301.4475eff6@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>

On Fri, Apr 21, 2017 at 11:53:01AM +0200, Igor Mammedov wrote:
> On Fri, 21 Apr 2017 15:32:15 +0800
> He Chen <he.chen@linux.intel.com> wrote:
> 
...
> > +static void validate_numa_distance(void)
> > +{
> > +    int src, dst;
> > +    bool is_asymmetrical = false;
> > +
> > +    for (src = 0; src < nb_numa_nodes; src++) {
> > +        for (dst = 0; dst < nb_numa_nodes; dst++) {
>                 ^^^ checks inside this loop are symmetric,
>                 is there any reason it wouldn't work wit previous variant 'dst = src'?
> 
I am sorry I don't have a clear understanding about what you suggested
here. You mean we should check whether the table is symmetric in this
loop?
Regarding 'dst = src', it represents local distance, user would
omit setting it and we will fix it in complete_init_numa_distance. Did I
mistake something? Could you please explain in more detail? Thanks.
> > +            if (numa_info[src].present && numa_info[dst].present) {
> we don't support sparse nodes, so this condition is always true
> and not needed as earlier code assures that all nodes upto nb_numa_nodes
> are present, greep for "numa: Node ID missing: %d"
> so you can remove this check in this func and in complete_init_numa_distance()
> 
> > +                if (numa_info[src].distance[dst] == 0 &&
> > +                    numa_info[dst].distance[src] == 0) {
> > +                    if (src != dst) {
> > +                        error_report("The distance between node %d and %d is missing, "
> > +                                     "please provide all unique node pair distances.",
> > +                                     src, dst);
> s/all unique node .../ at least one distance value between each nodes should be provided/
> 
> or something like this
> 
> > +                        exit(EXIT_FAILURE);
> > +                    }
> > +                }
> > +
> > +                if (((numa_info[src].distance[dst] != 0) &&
> > +                    (numa_info[dst].distance[src] != 0)) &&
> > +                    (numa_info[src].distance[dst] !=
> > +                    numa_info[dst].distance[src])) {
> > +                    is_asymmetrical = true;
> > +                }
> > +            }
> > +        }
> > +    }
> > +
> > +    if (is_asymmetrical) {
> > +        for (src = 0; src < nb_numa_nodes; src++) {
> > +            for (dst = 0; dst < nb_numa_nodes; dst++) {
> > +                if (numa_info[src].present && numa_info[dst].present) {
> > +                    if ((src != dst) && (numa_info[src].distance[dst] == 0)) {
> > +                        error_report("At least one asymmetrical pair of "
> > +                                "distances is given, please provide distances "
> > +                                "for both directions of all node pairs.");
> > +                        exit(EXIT_FAILURE);
> > +                    }
> > +                }
> > +            }
> > +        }
> > +    }
> > +}
> > +
> > +static void complete_init_numa_distance(void)
> > +{
> > +    int src, dst;
> > +
> > +    /* fixup NUMA distance by symmetric policy because if it is an
> > +     * asymmtric distance table, it should be a complete table and there
> > +     * would not be any missing distance except local node, which is
> > +     * verified by validate_numa_distance above.
> > +     */
> > +    for (src = 0; src < nb_numa_nodes; src++) {
> > +        for (dst = 0; dst < nb_numa_nodes; dst++) {
> > +            if (numa_info[src].present && numa_info[dst].present) {
> > +                if (numa_info[src].distance[dst] == 0) {
> > +                    if (src == dst) {
> > +                        numa_info[src].distance[dst] = NUMA_DISTANCE_MIN;
> > +                    } else {
> > +                        numa_info[src].distance[dst] = numa_info[dst].distance[src];
> > +                    }
> > +                }
> > +            }
> > +        }
> > +    }
> > +}
...
