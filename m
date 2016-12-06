Received: from eggs.gnu.org ([2001:4830:134:3::10]:47643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cEBXd-00038P-0A
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cEBXZ-0002KB-UN
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:56:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52457
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cEBXZ-0002Jc-Od
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:55:57 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB68rkjG146161
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 03:55:53 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2756tfnj2n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 03:55:53 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 14:25:50 +0530
Date: Tue, 6 Dec 2016 14:25:41 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-14-git-send-email-nikunj@linux.vnet.ibm.com>
	<20161206041122.GP32366@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206041122.GP32366@umbus.fritz.box>
Message-Id: <20161206085541.GD4211@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 13/13] target-ppc: Add xxperm and xxpermr
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org

On Tue, Dec 06, 2016 at 03:11:22PM +1100, David Gibson wrote:
> On Mon, Dec 05, 2016 at 04:55:30PM +0530, Nikunj A Dadhania wrote:
> > From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > 
> > xxperm:  VSX Vector Permute
> > xxpermr: VSX Vector Permute Right-indexed
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> > ---
> >  target-ppc/fpu_helper.c             | 50 +++++++++++++++++++++++++++++++++++++
> >  target-ppc/helper.h                 |  2 ++
> >  target-ppc/translate/vsx-impl.inc.c |  2 ++
> >  target-ppc/translate/vsx-ops.inc.c  |  2 ++
> >  4 files changed, 56 insertions(+)
> > 
> > diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
> > index 3b867cf..be552c7 100644
> > --- a/target-ppc/fpu_helper.c
> > +++ b/target-ppc/fpu_helper.c
> > @@ -2869,3 +2869,53 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
> >      float_check_status(env);
> >      return xt;
> >  }
> > +
> > +static void vsr_copy_256(ppc_vsr_t *xa, ppc_vsr_t *xt, int8_t *src)
> > +{
> > +#if defined(HOST_WORDS_BIGENDIAN)
> > +    memcpy(src, xa, sizeof(*xa));
> > +    memcpy(src + 16, xt, sizeof(*xt));
> > +#else
> > +    memcpy(src, xt, sizeof(*xt));
> > +    memcpy(src + 16, xa, sizeof(*xa));
> 
> Is this right?  I thought the order of the bytes within each word
> varied with the host endianness as well.

Since we are already working with 2 16 byte vectors xa and xb here, I thought
we don't have to worry about order of bytes within each vector, but instead can
construct the 32 byte vector as above based on host endianness.

> 
> > +#endif
> > +}
> > +
> > +static int8_t vsr_get_byte(int8_t *src, int bound, int idx)
> > +{
> > +    if (idx >= bound) {
> > +        return 0xFF;
> > +    }
> 
> AFAICT you don't need this check.  For both xxperm and xxpermr you're
> already masking the index to 5 bits, so it can't exceed 31.

Was thinking of making it a generic API and hence had that boundary
check but yes, no point for the check in the context of this instruction.

> 
> > +#if defined(HOST_WORDS_BIGENDIAN)
> > +    return src[idx];
> > +#else
> > +    return src[bound - 1 - idx];
> > +#endif
> > +}
> > +
> > +#define VSX_XXPERM(op, indexed)                                    \
> > +void helper_##op(CPUPPCState *env, uint32_t opcode)                \
> > +{                                                                  \
> > +    ppc_vsr_t xt, xa, pcv;                                         \
> > +    int i, idx;                                                    \
> > +    int8_t src[32];                                                \
> > +                                                                   \
> > +    getVSR(xA(opcode), &xa, env);                                  \
> > +    getVSR(xT(opcode), &xt, env);                                  \
> > +    getVSR(xB(opcode), &pcv, env);                                 \
> > +                                                                   \
> > +    vsr_copy_256(&xa, &xt, src);                                   \
> 
> You have a double copy here AFAICT - first from the actual env
> structure to xt and xa, then to the src array.  That seems like it
> would be good to avoid.
> 
> It seems like it would nice in any case to avoid even the one copy.
> You'd need a temporary for the output of course and to copy that, but
> you should be able to combine indexed with host endianness to
> translate each index to retrieve directly from the VSR values in env.

I am not sure it would be good to retrieve byte values directly from
env as getVSR nicely abstracts out from which fields
(env->[fpr, vsr, avr] the data is fetched based on the register specified
in the opcode.

I can reduce one copy though by not constructing a 32 byte vector (src)
but instead retrieving the bytes directly from xa and xt based on
the index.

Regards,
Bharata.
