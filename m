Received: from eggs.gnu.org ([2001:4830:134:3::10]:53209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d1Bjv-0004Ti-Ow
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d1Bjp-0004q8-JI
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d1Bjp-0004ph-BD
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:03:09 -0400
Date: Thu, 20 Apr 2017 15:03:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170420150302.486f849e@nial.brq.redhat.com>
In-Reply-To: <20170420092545.GA13391@he>
References: <1491900566-32222-1-git-send-email-he.chen@linux.intel.com>
	<20170419161440.02c33ec5@nial.brq.redhat.com>
	<20170420092545.GA13391@he>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] Allow setting NUMA distance for
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
Cc: Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 20 Apr 2017 17:25:45 +0800
He Chen <he.chen@linux.intel.com> wrote:

> On Wed, Apr 19, 2017 at 04:14:40PM +0200, Igor Mammedov wrote:
> > On Tue, 11 Apr 2017 16:49:26 +0800
> > He Chen <he.chen@linux.intel.com> wrote:
...
> > > +        error_setg(errp, "Source/Destination NUMA node is missing. "
> > > +                   "Please use '-numa node' option to declare it first.");
> > > +        return;
> > > +    }
> > > +
> > > +    if (src >= MAX_NODES || dst >= MAX_NODES) {
> > > +        error_setg(errp, "Max number of NUMA nodes reached: %"
> > > +                   PRIu16 "", MAX_NODES);  
> > message implies that max number of nodes has been allocated,
> > which is not what check verifies.
> > how about:
> >  "Invalid node %" PRIu16 ", max possible could be %d" 
> >   
> As we should tell user which nodeid (src or dst) is invalid, what do you
> think of divide this if into 2 ifs like:
> 
> ```
>     if (src >= MAX_NODES) {
or shorter, keep original if and ...

>         error_setg(errp,
>                    "Invalid node %" PRIu16
>                    ", max possible could be %" PRIu16,
>                    src, MAX_NODES);
s/src/MAX(src, dst)/

>         return;
>     }


> 
>     if (dst >= MAX_NODES) {
>         error_setg(errp,
>                    "Invalid node %" PRIu16
>                    ", max possible could be %" PRIu16,
>                    dst, MAX_NODES);
>         return;
>     }
> ```
> > > +        return;
> > > +    }
> > > +
> > > +    if (val < NUMA_DISTANCE_MIN) {
> > > +        error_setg(errp, "NUMA distance (%" PRIu8 ") is invalid, "
> > > +                   "it should be larger than %d.",
> > > +                   val, NUMA_DISTANCE_MIN);
> > > +        return;
> > > +    }
> > > +
> > > +    if (src == dst && val != NUMA_DISTANCE_MIN) {
> > > +        error_setg(errp, "Local distance of node %d should be %d.",
> > > +                   src, NUMA_DISTANCE_MIN);
> > > +        return;
> > > +    }
> > > +
> > > +    numa_info[src].distance[dst] = val;
> > > +    have_numa_distance = true;
> > > +}
> > > +
> > >  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> > >  {
> > >      NumaOptions *object = NULL;
> > > @@ -235,6 +271,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> > >          }
> > >          nb_numa_nodes++;
> > >          break;
> > > +    case NUMA_OPTIONS_TYPE_DIST:
> > > +        numa_distance_parse(&object->u.dist, opts, &err);  
> > looks like 'opts' argument isn't used inside numa_distance_parse(),
> > why it's here?
> >   
> > > +        if (err) {
> > > +            goto end;
> > > +        }
> > > +        break;
> > >      default:
> > >          abort();
> > >      }
> > > @@ -294,6 +336,63 @@ static void validate_numa_cpus(void)
> > >      g_free(seen_cpus);
> > >  }
> > >  
> > > +static void validate_numa_distance(void)  
> > name of function doesn't match what it's doing,
> > it not only validates but also sets/fixups distance values,
> > 
> > it would be cleaner to split verification and
> > setting default/implied/mirrored values in to separate functions.
> >   
> I agree that split these operations to sepaprate functions (e.g.
> `validate_numa_distance` and `fixup_numa_distance`) would be a good
> idea.
> 
> But if so, two functions would repeat some operations e.g. check whether
> the numa distance table is asymmetrical.
> 
> I prefer to keep validation and fixup in one function, of course, if we
> come up with a good function name and we can make the function code
> clear enough. Please correct me if I am wrong.
It's not a big deal to have a little extra lines if it helps to
make code cleaner. So I suggest to go with 2 separate functions
validate + complete_initialization.


> > > +{
> > > +    int src, dst, s, d;
> > > +    bool is_asymmetrical = false;
> > > +    bool opposite_missing = false;
> > > +
> > > +    if (!have_numa_distance) {
> > > +        return;
> > > +    }
> > > +
> > > +    for (src = 0; src < nb_numa_nodes; src++) {
> > > +        for (dst = src; dst < nb_numa_nodes; dst++) {
> > > +            s = src;
> > > +            d = dst;
> > > +
> > > +            if (numa_info[s].present && numa_info[d].present) {
> > > +                if (numa_info[s].distance[d] == 0 &&
> > > +                    numa_info[d].distance[s] == 0) {
> > > +                    if (s == d) {
> > > +                        numa_info[s].distance[d] = NUMA_DISTANCE_MIN;
> > > +                    } else {
> > > +                        error_report("The distance between node %d and %d is missing, "
> > > +                                     "please provide all unique node pair distances.",
> > > +                                     s, d);
> > > +                        exit(EXIT_FAILURE);
> > > +                    }
> > > +                }
> > > +
> > > +                if (numa_info[s].distance[d] == 0) {
> > > +                    s = dst;
> > > +                    d = src;  
> > this swapping makes the following up code rather confusing,
> > I'd prefer dst/src to be used as is in the capacity names imply and s, d dropped
> > 
> > PS:
> > adding small comments around blocks in this function
> > would help reviewers and whoever comes here later to
> > understand what's going on.
> >   
> Oh, there should be comments here.
> 
> May I explain why I choose to use var s/d here and do this swapping.
> 
> Let's see some input cases first:
>   +-----------+       +-----------+       +-----------+
>   |XX 21 31 41|       |XX 21 31 XX|       |XX 21 31 41|
>   |XX XX 21 31|       |XX XX 21 31|       |XX XX 21 31|
>   |XX XX XX 21|       |XX XX XX 21|       |XX XX 10 21|
>   |XX XX XX XX|       |41 XX XX XX|       |51 XX XX 10|
>   +-----------+       +-----------+       +-----------+
>        (1)                 (2)                 (3)
>   (XX means the value is not provided by users.)
> 
> According to previous discussion, we agreed that user at least should
> provide Table (1) as legal input because we can complete the whole with
> default mirror distance policy.
> Regarding Table (2), I think we also agreed that it is legal because if
> we move left bottom 41 to the opposite position we still get a upper
> triangular matrix and it is the same as Table (1).
> 
> I have to admit that s/d is confusing, what I mean is that `s`
> represents the entry in upper triangular matrix and `d` represents the
> entry in the lower triangular matrix that is symmetric with respect to
> the main diagonal.
> 
> `if (numa_info[s].distance[d] == 0)` means that we miss the distance
> value in the upper triangular matrix, we would encounter this in table
> (2). In this case, we want to deal with Table (2) in the same way as
> Table (1). So we do the swapping.
> 
> Table (1) and Table (2) would be regarded as symmetric matrices, they
> are the same essentially.
> Table (3) is illegal input since we find that one asymmetrical pair of
> distances is given, in this case, the whole table should be given.
> 
> > > +                }
> > > +
> > > +                if (numa_info[d].distance[s] == 0) {  
> > if above swapping happened than this condition would be checking
> > the same array entry as previous condition did, is that correct?
> >   
> I think yes although it does the same thing as previous condition from
> the code view. Here, we want to check if the opposite entry is not set.
> Let's see Table (2), when we process entry(1,4) i.e.
> `numa_info[0].distance[3]`, we find it is 0, then we swap `s` and `d`,
> now `numa_info[s].distance[d]` is `41`, and we will see this condition
> makes sense in this case.
> > > +                    opposite_missing = true;
> > > +                }
> > > +
> > > +                if ((numa_info[d].distance[s] != 0) &&
> > > +                    (numa_info[s].distance[d] != numa_info[d].distance[s])) {
> > > +                    is_asymmetrical = true;
> > > +                }
> > > +
> > > +                if (is_asymmetrical) {
> > > +                    if (opposite_missing) {
this check will start working only after is_asymmetrical detected,
but entries that were checked before are left unverified for missing opposite.
So function won't work as described.
To guarantee that all entries have opposite, you have to do 2 passes over matrix.

> > > +                        error_report("At least one asymmetrical pair of distances "
> > > +                                     "is given, please provide distances for both "
> > > +                                     "directions of all node pairs.");
> > > +                        exit(EXIT_FAILURE);
> > > +                    }
> > > +                } else {  
> > what if numa_info[d].distance[s] is 0 and numa_info[s].distance[d] is 0 as well?
> > wouldn't we end up with invalid distance entry in SLIT
> >   
> At the start of this function, we ensure that the symmetric value would
> not be both 0.
> 
> I know, the code in this function may be not clear enough. But when I
> treat the whole numa distance table as a matrix, it looks fine.
> Anyway, this is my point of view, if you have any sugguestion, I am very
> willing to know and cook a better patch in next version.
Suggestions stay the same:
 1. split validate in init into separate functions, it should make code simpler to follow.
 2. don't do swapping just use src/dst as is
 3. add comments and maybe a larger one before validate function
    to describe valid input so that reader won't have to check out qemu-options.hx

> 
> Thanks,
> -He
> 
