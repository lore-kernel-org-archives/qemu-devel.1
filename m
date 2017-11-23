Received: from eggs.gnu.org ([2001:4830:134:3::10]:57450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eHpUX-0006qJ-7F
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eHpUT-00082Q-50
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:16:25 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50315 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eHpUS-00081b-TW
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:16:21 -0500
Date: Thu, 23 Nov 2017 14:16:18 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <1236eb3c-7612-4b96-3925-a0375e0c9888@linaro.org>
Message-ID: <alpine.DEB.2.20.1711231355360.7159@bulbul.intra.ispras.ru>
References: <20171109144155.17076-1-batuzovk@ispras.ru>
	<20171109144155.17076-3-batuzovk@ispras.ru>
	<1236eb3c-7612-4b96-3925-a0375e0c9888@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] tcg/optimize: do copy propagation
 for memory locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 22 Nov 2017, Richard Henderson wrote:

> On 11/09/2017 03:41 PM, Kirill Batuzov wrote:
> > +typedef struct TCGMemLocation {
> > +    /* Offset is relative to ENV. Only fields of CPUState are accounted.  */
> > +    tcg_target_ulong offset;
> > +    tcg_target_ulong size;
> > +    TCGType type;
> > +    /* Pointer to a temp containing a valid copy of this memory location.  */
> > +    TCGTemp *copy;
> > +    /* Pointer to the next memory location containing copy of the same
> > +       content.  */
> > +    struct TCGMemLocation *next_copy;
> 
> Did you ever find copies of memories that weren't also copies within temps?
> I.e. you could have found this through copy->next_copy?

Yes. This happens when a temp was stored to multiple memory locations.

> 
> > +    /* Double-linked list of all memory locations.  */
> > +    struct TCGMemLocation *next;
> > +    struct TCGMemLocation **prev_ptr;
> 
> Use QTAILQ_* for common double-linked-list manipulation.
> 
> > +struct TCGMemLocation *mem_locations;
> > +struct TCGMemLocation *free_mls;
> 
> These can't be globals anymore -- we're do multi-threaded code generation now.

Then they should be moved to TCGContext I assume?

> 
> > @@ -77,12 +125,27 @@ static void reset_ts(TCGTemp *ts)
> >      struct tcg_temp_info *pi = ts_info(ti->prev_copy);
> >      struct tcg_temp_info *ni = ts_info(ti->next_copy);
> >  
> > +    if (ti->mem_loc && ts_is_copy(ts) && 0) {
> > +        TCGMemLocation *ml, *nml;
> > +        for (ml = ti->mem_loc; ml; ml = nml) {
> > +            nml = ml->next_copy;
> > +            ml->copy = ti->next_copy;
> > +            ml->next_copy = ni->mem_loc;
> > +            ni->mem_loc = ml;
> > +        }
> > +    } else {
> > +        while (ti->mem_loc) {
> > +            reset_ml(ti->mem_loc);
> > +        }
> 
> Why would a single temp be associated with more than one memory?
>

Because it was stored to multiple memory locations. And when reading from
any of these locations we want to access the temp instead.

For example this happens when we translate ARM32 VDUP instruction. One
value is duplicated into all elements of the vector. When elements of the
vector are accessed later, we want to use this value instead of rereading
it from memory.

> > +static TCGOpcode ld_to_mov(TCGOpcode op)
> > +{
> > +#define LD_TO_EXT(sz, w)                                 \
> > +    case glue(glue(INDEX_op_ld, sz), glue(_i, w)):       \
> > +        return glue(glue(INDEX_op_ext, sz), glue(_i, w))
> > +
> > +    switch (op) {
> > +    LD_TO_EXT(8s, 32);
> > +    LD_TO_EXT(8u, 32);
> > +    LD_TO_EXT(16s, 32);
> > +    LD_TO_EXT(16u, 32);
> > +    LD_TO_EXT(8s, 64);
> > +    LD_TO_EXT(8u, 64);
> > +    LD_TO_EXT(16s, 64);
> > +    LD_TO_EXT(16u, 64);
> > +    LD_TO_EXT(32s, 64);
> > +    LD_TO_EXT(32u, 64);
> 
> How many extensions did you find?  Or is this Just In Case?
> 

One. It was in Aartch64 build of x264. So this is more Just in Case. But
it may become useful if we try to emulate some 8- or 16-bit architectures.

-- 
Kirill
