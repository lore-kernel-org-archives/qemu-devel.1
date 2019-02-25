Received: from eggs.gnu.org ([209.51.188.92]:32981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyJJc-0007Bj-94
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyJJb-0002ze-FJ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:41:16 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-8-david@redhat.com>
	<17cce95e-8e0d-5f49-920a-1e35c9ce8968@linaro.org>
	<6ac53abd-d461-e1f3-8e34-06f8584e85fc@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bf5458a8-dcc1-d079-7436-54cd0a3eb24c@twiddle.net>
Date: Mon, 25 Feb 2019 08:40:58 -0800
MIME-Version: 1.0
In-Reply-To: <6ac53abd-d461-e1f3-8e34-06f8584e85fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 7/7] s390x/tcg: Implement LOAD COUNT TO
 BLOCK BOUNDARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 2/25/19 8:17 AM, David Hildenbrand wrote:
> On 25.02.19 17:14, Richard Henderson wrote:
>> I don't understand all of this "blocksize" business, when they are all powers
>> of two, and the maximum value returned is 16.
>>
>> As far as I can see, the result is obtained by -(addr | -16) regardless of the
>> value of m3.
> 
> Let's assume we have addr = 63;
> 
> Assume block size is 64:
> -> to_load = 1
> 
> Assume block size is 128:
> -> to_load = 16
> 
> Or am i missing something?

No, just me.

You can still do the computation inline, with

    tcg_gen_ori_i64(tmp, addr, -blocksize);
    tcg_gen_neg_i64(tmp, tmp);
    sixteen = tcg_const_i64(16);
    tcg_gen_umin_i64(tmp, sixteen);


r~
