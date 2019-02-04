Received: from eggs.gnu.org ([209.51.188.92]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqiCD-0003Eg-VO
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqiCD-0004xp-0N
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:38:13 -0500
Date: Mon, 4 Feb 2019 18:37:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204183756.5bbf0782.cohuck@redhat.com>
In-Reply-To: <b477cf45-50d2-049d-0f80-befa70e74ffd@redhat.com>
References: <20190204154406.16122-1-david@redhat.com>
	<b477cf45-50d2-049d-0f80-befa70e74ffd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/tcg: Don't model FP registers as
 globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 4 Feb 2019 16:47:12 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.02.19 16:44, David Hildenbrand wrote:
> > As floating point registers overlay some vector registers and we want
> > to make use of the general tcg_gvec infrastructure that assumes vectors
> > are not stored in globals but in memory, don't model flaoting point  
> 
> s/flaoting/floating/
> 
> > registers as globals anymore. This is than similar to how arm handles

s/than/then/

:)

> > it.
> > 
> > Reading/writing a floating point register means reading/writing memory now.
> > 
> > Break up ugly in2_x2() handling that modifies both, in1 and in2 into
> > in1_x2l and in2_x2h. This makes things more readable. Also, in1_x1() is  
> 
> s/in1_x2l/in2_x2l/
> s/in1_x2h/in2_x2h/

Confused... it's already in2_x2h, I suppose that one should stay like
it is?

> 
> 
> Sorry Conny, I assume when you pick this up, you can fix this up :)

I would recommend a spell checker, only it would not help for the last
case :)

> 
> > ugly as it touches out/out2, get rid of that and use prep_x1() instead.
> > 
> > As we are no longer able to use the original global variables for
> > out/out2, we have to use new temporary variables and write from them to
> > the target registers using wout_ helpers.
> > 
> > E.g. an instruction that reads and writes x1 will use
> > - prep_x1 to get the values into out/out2
> > - wout_x1 to write the values from out/out2
> > This special handling is needed for x1 as it is often used along with
> > other inputs, so in1/in2 is already used.
> > 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> > 
> > v1 -> v2:
> > - renamed x2h -> x2l and x2l -> x2h to match the actual meaning
> >   ("high" on s390x is where the smaller bit numbers are ;) )
> > - did another quick sniff test
> > 
> >  target/s390x/insn-data.def | 150 ++++++++++++++++++-------------------
> >  target/s390x/translate.c   | 135 ++++++++++++++++++++-------------
> >  2 files changed, 160 insertions(+), 125 deletions(-)
