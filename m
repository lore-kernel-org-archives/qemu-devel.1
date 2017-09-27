Received: from eggs.gnu.org ([2001:4830:134:3::10]:43583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxGS1-0003Qy-Pt
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxGRw-0003v3-BB
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:48:49 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:43607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxGRw-0003uV-5F
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:48:44 -0400
Received: by mail-pf0-x229.google.com with SMTP id y29so7618973pff.0
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 10:48:43 -0700 (PDT)
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <30b6f3a1-bfeb-6172-5233-2f7d444399fc@linaro.org>
Date: Wed, 27 Sep 2017 10:48:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170927170027.8539-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/3] accel/tcg: allow to invalidate a
 write TLB entry immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>

On 09/27/2017 10:00 AM, David Hildenbrand wrote:
> Background: s390x implements Low-Address Protection (LAP). If LAP is
> enabled, writing to effective addresses (before any transaltion)
> 0-511 and 4096-4607 triggers a protection exception.
> 
> So we have subpage protection on the first two pages of every address
> space (where the lowcore - the CPU private data resides).
> 
> By immediately invalidating the write entry but allowing the caller to
> continue, we force every write access onto these first two pages into
> the slow path. we will get a tlb fault with the specific accessed
> addresses and can then evaluate if protection applies or not.
> 
> We have to make sure to ignore the invalid bit if tlb_fill() succeeds.

This is similar to a scheme I proposed to PMM wrt handling ARM v8M translation.
 Reusing TLB_INVALID_MASK would appear to work, but I wonder if it wouldn't be
clearer to use another bit.  I believe I had proposed a TLB_FORCE_SLOW_MASK.

Thoughts, Peter?


r~
