Received: from eggs.gnu.org ([2001:4830:134:3::10]:56505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fflh4-0000bH-Qm
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fflh1-0007fl-Ng
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:36:34 -0400
Date: Wed, 18 Jul 2018 14:36:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180718143626.20826707.cohuck@redhat.com>
In-Reply-To: <20180718092330.19465-1-david@redhat.com>
References: <20180718092330.19465-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpumodel: fix segmentation fault
 when baselining models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>

On Wed, 18 Jul 2018 11:23:30 +0200
David Hildenbrand <david@redhat.com> wrote:

> Usually, when baselining two CPU models, whereby one of them has base
> CPU features disabled (e.g. z14-base,msa=off), we fallback to an older
> model that did not have these features in the base model. We always try to
> create a "sane" CPU model (as far as possible), and one part of it is that
> removing base features is no good and to be avoided.
> 
> Now, if we disable base features that were part of a z900, we're out of
> luck. We won't find a CPU model and QEMU will segfault. This is a
> scenario that should never happen in real life, but it can be used to
> crash QEMU.
> 
> So let's properly report an error if we baseline e.g.:
> 
> { "execute": "query-cpu-model-baseline",
>   "arguments" : { "modela": { "name": "z14-base", "props": {"esan3" : false}},
>                   "modelb": { "name": "z14"}} }
> 
> Instead of segfaulting.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks, queued to s390-fixes.
