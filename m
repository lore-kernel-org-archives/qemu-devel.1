Received: from eggs.gnu.org ([2001:4830:134:3::10]:38725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2CjP-0004el-A7
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2CjK-00018Y-KU
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:51:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2CjK-000185-Dy
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:51:06 -0400
Date: Wed, 11 Oct 2017 10:50:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171011105059.498a02d1.cohuck@redhat.com>
In-Reply-To: <ab1c14fe-95c3-0954-ec16-3ff43c2037f5@linaro.org>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-27-david@redhat.com>
	<ab1c14fe-95c3-0954-ec16-3ff43c2037f5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 26/30] s390x/tcg: switch to new SIGP
 handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On Fri, 6 Oct 2017 10:02:43 -0400
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 09/28/2017 04:37 PM, David Hildenbrand wrote:
> >  static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
> >  {
> >      TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> > +    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
> >      check_privileged(s);
> > -    potential_page_fault(s);
> > -    gen_helper_sigp(cc_op, cpu_env, o->in2, r1, o->in1);
> > +    gen_helper_sigp(cc_op, cpu_env, o->in2, r1, r3);
> >      set_cc_static(s);
> >      tcg_temp_free_i32(r1);
> > +    tcg_temp_free_i32(r3);
> >      return NO_EXIT;
> >  }  
> 
> You want to change insn-data.def as well.
> 
> -    C(0xae00, SIGP,    RS_a,  Z,   r3_o, a2, 0, 0, sigp, 0)
> +    C(0xae00, SIGP,    RS_a,  Z,   0, a2, 0, 0, sigp, 0)

I'll do that while applying. Let's avoid another patchbomb :)

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
