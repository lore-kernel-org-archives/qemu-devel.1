Received: from eggs.gnu.org ([2001:4830:134:3::10]:52211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d2aAn-0005Vr-A8
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d2aAj-0005VI-BI
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:20:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d2aAj-0005V1-1P
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:20:41 -0400
Date: Mon, 24 Apr 2017 11:20:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170424112033.286fa261@nial.brq.redhat.com>
In-Reply-To: <20170424085248.GA16098@he>
References: <1492759935-23933-1-git-send-email-he.chen@linux.intel.com>
	<20170421115301.4475eff6@nial.brq.redhat.com>
	<20170424085248.GA16098@he>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>

On Mon, 24 Apr 2017 16:52:48 +0800
He Chen <he.chen@linux.intel.com> wrote:

> On Fri, Apr 21, 2017 at 11:53:01AM +0200, Igor Mammedov wrote:
> > On Fri, 21 Apr 2017 15:32:15 +0800
> > He Chen <he.chen@linux.intel.com> wrote:
> >   
> ...
> > > +static void validate_numa_distance(void)
> > > +{
> > > +    int src, dst;
> > > +    bool is_asymmetrical = false;
> > > +
> > > +    for (src = 0; src < nb_numa_nodes; src++) {
> > > +        for (dst = 0; dst < nb_numa_nodes; dst++) {  
> >                 ^^^ checks inside this loop are symmetric,
> >                 is there any reason it wouldn't work wit previous variant 'dst = src'?
> >   
> I am sorry I don't have a clear understanding about what you suggested
> here. You mean we should check whether the table is symmetric in this
> loop?
> Regarding 'dst = src', it represents local distance, user would
> omit setting it and we will fix it in complete_init_numa_distance. Did I
> mistake something? Could you please explain in more detail? Thanks.
I was trying to say that
since all checks inside this loop are symmetric
you can scan only half of matrix, i.e.:
  ...
     for (dst = src; dst < nb_numa_nodes; dst++) {
  ...
but I won't insist on it if you prefer leave it as is.

> > > +            if (numa_info[src].present && numa_info[dst].present) {  
> > we don't support sparse nodes, so this condition is always true
> > and not needed as earlier code assures that all nodes upto nb_numa_nodes
> > are present, greep for "numa: Node ID missing: %d"
> > so you can remove this check in this func and in complete_init_numa_distance()
> >   
> > > +                if (numa_info[src].distance[dst] == 0 &&
> > > +                    numa_info[dst].distance[src] == 0) {
> > > +                    if (src != dst) {
> > > +                        error_report("The distance between node %d and %d is missing, "
> > > +                                     "please provide all unique node pair distances.",
> > > +                                     src, dst);  
> > s/all unique node .../ at least one distance value between each nodes should be provided/
> > 
> > or something like this
> >   
> > > +                        exit(EXIT_FAILURE);
> > > +                    }
> > > +                }
> > > +
> > > +                if (((numa_info[src].distance[dst] != 0) &&
> > > +                    (numa_info[dst].distance[src] != 0)) &&
> > > +                    (numa_info[src].distance[dst] !=
> > > +                    numa_info[dst].distance[src])) {
> > > +                    is_asymmetrical = true;
> > > +                }
> > > +            }
> > > +        }
> > > +    }
> > > +
[...]
