Received: from eggs.gnu.org ([2001:4830:134:3::10]:38173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49mz-0003OP-Hu
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49mw-0007ye-22
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:06:57 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:55640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49mv-0007yF-Sx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:06:53 -0400
Received: by mail-pg0-x22b.google.com with SMTP id b11so7431997pgn.12
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 11:06:53 -0700 (PDT)
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-2-david@redhat.com>
	<30b6f3a1-bfeb-6172-5233-2f7d444399fc@linaro.org>
	<a1f27655-5a3b-0e1f-cca3-12c09b7cbe51@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1d995492-dbcf-7466-0ebc-9e507d50d099@linaro.org>
Date: Mon, 16 Oct 2017 11:06:49 -0700
MIME-Version: 1.0
In-Reply-To: <a1f27655-5a3b-0e1f-cca3-12c09b7cbe51@redhat.com>
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

On 10/16/2017 12:24 AM, David Hildenbrand wrote:
> On 27.09.2017 19:48, Richard Henderson wrote:
>> On 09/27/2017 10:00 AM, David Hildenbrand wrote:
>>> Background: s390x implements Low-Address Protection (LAP). If LAP is
>>> enabled, writing to effective addresses (before any transaltion)
>>> 0-511 and 4096-4607 triggers a protection exception.
>>>
>>> So we have subpage protection on the first two pages of every address
>>> space (where the lowcore - the CPU private data resides).
>>>
>>> By immediately invalidating the write entry but allowing the caller to
>>> continue, we force every write access onto these first two pages into
>>> the slow path. we will get a tlb fault with the specific accessed
>>> addresses and can then evaluate if protection applies or not.
>>>
>>> We have to make sure to ignore the invalid bit if tlb_fill() succeeds.
>>
>> This is similar to a scheme I proposed to PMM wrt handling ARM v8M translation.
>>  Reusing TLB_INVALID_MASK would appear to work, but I wonder if it wouldn't be
>> clearer to use another bit.  I believe I had proposed a TLB_FORCE_SLOW_MASK.
>>
>> Thoughts, Peter?
> 
> As two weeks have passed:
> 
> Any further opinions? Richard, how do you want me to continue with this?

Let's just go ahead with TLB_INVALID_MASK; we'll revisit if it gets to be
confusing.


r~
