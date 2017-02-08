Received: from eggs.gnu.org ([2001:4830:134:3::10]:50744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cbPlm-0001Md-86
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cbPlh-0001mf-LB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:46:38 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:61394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cbPlg-0001lh-P8
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 05:46:33 -0500
Message-ID: <589AF6EC.5050803@huawei.com>
Date: Wed, 8 Feb 2017 18:46:04 +0800
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
	<20170110133019.GJ27720@redhat.com>
In-Reply-To: <20170110133019.GJ27720@redhat.com>
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
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>

Hi Daniel,

I was writing AF_ALG-backed for QEMU crypto these days, I think there're more
than two ways to implements it.

The first one look likes below:
[ cipher.c ]
qcrypto_cipher_new(...)
{
	if (...) { /* use AF_ALG */
		cipher = afalg_cipher_new(...)
		if (cipher) {
			return cipher;
		}
	}
	
	/* disabled AF_ALG or AF_ALG failed, then back to
	 * using 'builtin'(gcrypt/nettle/...)
	 */
	cipher = __qcrypto_cipher_new(...)
}

[ cipher-afalg.c ]
afalg_cipher_new(...) {....}
afalg_cipher_encrypt(...) {...}
......

[ cipher-gcrypt.c ]
__qcrypto_cipher_new(...) {...}
__qcrypto_cipher_encrypt(...) {...}
......

[ cipher-nettle.c ]
__qcrypto_cipher_new(...) {...}
__qcrypto_cipher_encrypt(...) {...}
......

In this way, I think I need to rename most functions in
cipher-gcrypt.c/cipher-nettle.c with a prefixion(such as '__')


Alternative way is:
[ cipher-afalg.c ]
afalg_cipher_new(...) {....}
afalg_cipher_encrypt(...) {...}
......

[ cipher-gcrypt.c ]
qcrypto_cipher_new(...)
{
	if (...) { /* use AF_ALG */
		cipher = afalg_cipher_new(...)
		if (cipher) {
			return cipher;
		}
	}
	
	/* disabled AF_ALG or AF_ALG failed, then back to
	 * using 'builtin'
	 */
	.......( the existing code )
}
......

[ cipher-nettle.c ]
qcrypto_cipher_new(...)
{
	if (...) { /* use AF_ALG */
		cipher = afalg_cipher_new(...)
		if (cipher) {
			return cipher;
		}
	}
	
	/* disabled AF_ALG or AF_ALG failed, then back to
	 * using 'builtin'
	 */
	.......( the existing code )
}
......

In this way, we should add AF_ALG-backed code in most functions in
cipher-gcrypt.c/cipher-nettle.c, I'm afraid this would introduce lots of
duplicate code because the same AF_ALG-backed code must in both gcrypt-backed
impls and nettle-backed impls as above.


I'm confusing about which way you'd prefer, or do you have any better suggestion?

Thanks!

-- 
Regards,
Longpeng(Mike)


On 2017/1/10 21:30, Daniel P. Berrange wrote:

> On Tue, Jan 10, 2017 at 12:17:48PM +0000, Gonglei (Arei) wrote:
>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> On Mon, Jan 09, 2017 at 01:43:10PM +0000, Stefan Hajnoczi wrote:
>>>>>>>> On Mon, Jan 09, 2017 at 03:04:55PM +0800, Longpeng (Mike) wrote:
>>>>>>>>> I'm one of Gonglei's virtio-crypto project members, and we plan to
>>> add a
>>>>>>> AF_ALG
>>>>>>>>> backend for virtio-crypto(there's only builtin-backend currently).
>>>>>>>>>
>>>>>>>>> I found that Catalin, Paolo and Stefan had discussed about this in
>>> 2015
>>>>>>>>> (http://www.spinics.net/lists/kvm/msg115457.html), but it seems
>>> that
>>>>>>> Catalin
>>>>>>>>> didn't do it, so I'm confuse about wether it is need to add a AF_ALG
>>>>>>> backend.
>>>>>>>>>
>>>>>>>>> Do you have any suggestion? Thanks :)
>>>>>>>>
>>>>>>>> I have no objections to an AF_ALG backend in QEMU.
>>>>>>>
>>>>>>> Rather than do another backend for virtio-crypto, IMHO, we should have
>>>>>>> an AF_ALG impl of the crypto/ APIs. That way any potential performance
>>>>>>> benefits will enhance our LUKS encryption code too.
>>>>>>>
>>>>>> According to the currently schemas of crypto/ APIs, we can't choose the
>>>>>> specific backend dynamically. This is a limitation for virtio-crypto
>>>>>> device I think.
>>>>>
>>>>> Do we really need to be able to choose the backend explicitly. If the AF_ALG
>>>>> backend is faster, why would you simply not use that automatically if it is
>>>>> available.
>>>>
>>>> Can we realize the purpose based on the crypto/ APIs? IIUC the crypto
>>>> subsystem chooses a backend during the building according to the specific
>>> priority,
>>>> nettle > gcrypt > cipher-builtin.
>>>>
>>>> If we add an AF_ALG implementation for crypto subsystem, shall we set it
>>>> as the highest priority? If so, other backends won't be used since AF_ALG
>>>> is always available. If not, how can we use AF_ALG backend for crypto/ API?
>>>>
>>>> Please correct me if I'm missing something.
>>>
>>> While AF_ALG has been available for a while, not all features have. For
>>> example AEAD support was only added in kernel 4.1
>>>
>> OK.
>>
>>> So if we had AF_ALG in QEMU, we would have to have a stacked impl, where
>>> we try AF_ALG and then fallback to the current code when QEMU runs on a
>>> kernel lacking the feature needed.
>>>
>> It makes sense though the implementation will be more complicate
>> since the code should identify the different error codes are returned
>> by AF_ALG APIs.
>>
>>> We could potentially also have a global arg to switch backends e.g.
>>>
>>>  -crypto-backend [afalg|builtin]
>>>
>> So the backend here is not the cryptodev backend?
> 
> No, it would apply to the crypto/ APIs, so it affects all users of those
> APIs not just cryptodev
> 
> 
> Regards,
> Daniel


-- 
Regards,
Longpeng(Mike)
