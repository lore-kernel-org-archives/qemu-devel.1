Received: from eggs.gnu.org ([2001:4830:134:3::10]:49433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9xxu-0007uP-DE
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9xxp-0000cC-Gq
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:42:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55670
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9xxp-0000bO-Aj
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:42:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA1IepBd136176
	for <qemu-devel@nongnu.org>; Wed, 1 Nov 2017 14:42:06 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dyj2swnn5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 14:42:06 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 1 Nov 2017 14:42:06 -0400
References: <20171101175356.11771-1-danielhb@linux.vnet.ibm.com>
	<CAFEAcA9HjqAss=j+unytx=FJKqMo6neNah4yvWtx2aXCvYw29Q@mail.gmail.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 16:42:01 -0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HjqAss=j+unytx=FJKqMo6neNah4yvWtx2aXCvYw29Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <b031ce5b-99d6-7570-a2c9-d27a34ee69b0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] configure: adding ppc64le to supported
 host CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>



On 11/01/2017 04:23 PM, Peter Maydell wrote:
> On 1 November 2017 at 17:53, Daniel Henrique Barboza
> <danielhb@linux.vnet.ibm.com> wrote:
>> When executing 'configure' in a fresh QEMU clone, in a fresh
>> OS install running in a ppc64le host, this is the error
>> shown:
>>
>> -----
>>
>> ../configure --enable-trace-backend=simple --enable-debug
>>      --target-list=ppc64-softmmu
>>
>> ERROR: Unsupported CPU = ppc64le, try --enable-tcg-interpreter
>>
>> -----
>>
>> This isn't true, ppc64le host CPU is supported.
>>
>> This patch adds 'ppc64le' to the list of supported host CPUs. After
>> this patch, the next error when executing configure in the
>> scenario mentioned is:
>>
>> -----
>>
>> ../configure --enable-trace-backend=simple --enable-debug
>>      --target-list=ppc64-softmmu
>>
>> ERROR: "cc" either does not exist or does not work
>>
>> -----
>>
>> Indicating that now we need a valid compiler to proceed.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
> I think this is either unnecessary or it should be a lot more
> changes than this. The problem here is that how we determine
> the host CPU type is by using the C compiler. So if you don't
> have a C compiler then we're going to fail to autodetect,
> and the (kind of bogus) fallback is via "uname -a". What
> we ought to do is (a) detect "no C compiler" before we
> try to use it and (b) not have that uname -a fallback.

Now that you've said, if I install GCC before running configure for the
first time I don't see this error happening. Perhaps alternative
(a) is a good approach and avoid a lot of changes just for the
sake of getting rid of that error message.


Daniel

> I suggest you install a C compiler and then try again with
> an unmodified configure to see how that does.
>
> (I think that the correct value of the "cpu" variable for
> ppc64le is "ppc64", same as for bigendian, which we'll
> autodetect if we have a compiler to do it with. If that's
> right, then you could argue for having our "normalise
> CPU host name" code map ppc64le to ppc64. Certainly a
> lot of places in configure assume "ppc64" is the only
> kind...)
>
> thanks
> -- PMM
>
