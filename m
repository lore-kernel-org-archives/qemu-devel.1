Received: from eggs.gnu.org ([209.51.188.92]:47633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzQKI-00040V-7i
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzQKG-000561-TP
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:22:34 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzQKG-00053l-LK
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:22:32 -0500
Received: by mail-pg1-x544.google.com with SMTP id m2so10111342pgl.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:22:31 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-34-david@redhat.com>
	<9c8913f5-76b6-1175-5574-19f19d1e8eef@linaro.org>
	<c37a7e69-934c-ab2e-08a1-c67cb3e156c5@redhat.com>
	<f4e08332-be07-e2f1-be20-fe4406215427@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <12668b8f-18c8-c656-d28f-9cc36b3171c7@linaro.org>
Date: Thu, 28 Feb 2019 10:22:27 -0800
MIME-Version: 1.0
In-Reply-To: <f4e08332-be07-e2f1-be20-fe4406215427@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 33/33] s390x/tcg: Implement VECTOR
 UNPACK *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2/28/19 2:54 AM, David Hildenbrand wrote:
> Hmm, as v2 and v3 are handled concatenated it is not that easy. I am not
> sure if we can handle this without a temporary vector.
> 
> I thought about packing them first interleaved
> 
> v2 = [v2e0, v2e1]
> v3 = [v3e0, ve31]
> v1 = [v2e0_packed, v3e0_packed, v2e1_packed, v3e1_packed]
> 
> And then restoring the right order
> 
> v1 = [v2e0_packed, v2e1_packed, v3e0_packed, v3e1_packed]
> 
> But than the second operation seems to be the problem. That shuffling
> would have to be hard coded as far as I can see. (shuffling with MO_8 is
> nasty -> 14 element shave to be exchanged, in my opinion needing
> eventually 14 temporary variables)

I suppose you could do it in registers.

  load_element_i64(t1, v2, 0);
  for (i = 1; i < N; i++) {
    load_element_i64(t3, v2, i, es);
    tcg_gen_deposit_i64(t1, t1, t3, i << es, 1 << es);
  }
  // repeat for v3 into t2
  // store t1,t2 into v1.

Now you have only 3 temporaries, which is manageable.

The only question, when it comes to MO_8, is whether the code expansion of this
is reasonable (16 byte loads, 15 deposits, 2 stores -- minimum 33 insns,
probably 48 for x86_64 host), or whether a helper function would be better in
the end.  But then the same is true for all of the other merge & unpack
operations wrt MO_8.


r~
