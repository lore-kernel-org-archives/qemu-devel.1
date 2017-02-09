Received: from eggs.gnu.org ([2001:4830:134:3::10]:48206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cbexO-0005wS-44
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cbexJ-0000ad-7h
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:59:38 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:25786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cbexH-0000W6-UG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:59:33 -0500
Message-ID: <589BDAEF.8000703@huawei.com>
Date: Thu, 9 Feb 2017 10:58:55 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <58733617.3050503@huawei.com>
	<20170109134310.GE30228@stefanha-x1.localdomain>
	<20170109162504.GH29989@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182982@DGGEMA505-MBX.china.huawei.com>
	<20170110100355.GD27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182ADA@DGGEMA505-MBX.china.huawei.com>
	<20170110120354.GH27720@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA182B4A@DGGEMA505-MBX.china.huawei.com>
	<20170110133019.GJ27720@redhat.com> <589AF6EC.5050803@huawei.com>
	<20170208105336.GH3129@redhat.com>
In-Reply-To: <20170208105336.GH3129@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, QEMU-DEV <qemu-devel@nongnu.org>

Hi Daniel,

On 2017/2/8 18:53, Daniel P. Berrange wrote:

> On Wed, Feb 08, 2017 at 06:46:04PM +0800, Longpeng (Mike) wrote:
>> Hi Daniel,
>>
>> I was writing AF_ALG-backed for QEMU crypto these days, I think there're more
>> than two ways to implements it.
>>
>> The first one look likes below:
>> [ cipher.c ]
>> qcrypto_cipher_new(...)
>> {
>> 	if (...) { /* use AF_ALG */
>> 		cipher = afalg_cipher_new(...)
>> 		if (cipher) {
>> 			return cipher;
>> 		}
>> 	}
>> 	
>> 	/* disabled AF_ALG or AF_ALG failed, then back to
>> 	 * using 'builtin'(gcrypt/nettle/...)
>> 	 */
>> 	cipher = __qcrypto_cipher_new(...)
>> }
>>
>> [ cipher-afalg.c ]
>> afalg_cipher_new(...) {....}
>> afalg_cipher_encrypt(...) {...}
>> ......
>>
>> [ cipher-gcrypt.c ]
>> __qcrypto_cipher_new(...) {...}
>> __qcrypto_cipher_encrypt(...) {...}
>> ......
>>
>> [ cipher-nettle.c ]
>> __qcrypto_cipher_new(...) {...}
>> __qcrypto_cipher_encrypt(...) {...}
>> ......
>>
>> In this way, I think I need to rename most functions in
>> cipher-gcrypt.c/cipher-nettle.c with a prefixion(such as '__')
>>


>> I'm confusing about which way you'd prefer, or do you have any better
>> suggestion?
> 
> Yeah, both approaches have some reasonably significant downsides. Approach
> 1 is sort of like providing a virtual driver table, except it is hardcoded
> to switch between 2 impls only.
> 
> A variant on approach 1 is to actually setup a proper driver-table dispatch
> layer. eg define a struct that contains callbacks for each public api
> operation. The qcrypto_cipher_new() method will then either setup callbacks
> for AF_ALG, or for the library impl.
> 
> This is the design we took in crypto/{ivgen.c,ivgenpriv.h}
> 


So...you prefer approach 1 with a driver-table dispatch layer, right?
And this implies that we must either rename some public methods in
cipher-gcrypt.c/cipher-nettle.c, or change them to 'static'.


I also have some other ideas:

1) *using bitmap to improve performance*

As you suggested before:
"if we had AF_ALG in QEMU, we would have to have a stacked impl, where
we try AF_ALG and then fallback to the current code when QEMU runs on a
kernel lacking the feature needed."

I think it would impact the performance if we "try AF_ALG and then fallback to
library" each time, so we can use a bitmap to indicate whether the @alg is
supported by AF_ALG.


2) *maybe we need a heuristic policy*

I added some speed test in test-crypto-cipher/hash and found that for big
packets AF_ALG is much faster than library-impl while library-impl is better
when the packets is small:

packet(bytes)	AF_ALG(MB/sec, intel QAT)	Library-impl(MB/sec)
512		53.68				127.82
1024		98.39				133.21
2048		167.56				134.62
4096		276.21				135.10
8192		410.80				135.82
16384		545.08				136.01
32768		654.49				136.30
65536		723.00				136.29

If a @alg is both supported by AF_ALG and library-impl, I think we should decide
to use which one dynamically.

> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
