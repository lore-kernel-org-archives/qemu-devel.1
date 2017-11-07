Received: from eggs.gnu.org ([2001:4830:134:3::10]:33354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBsSi-0004I7-0O
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 20:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBsSf-0004hN-BB
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 20:13:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBsSe-0004fa-Oi
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 20:13:53 -0500
Message-ID: <5A0108C0.702@huawei.com>
Date: Tue, 7 Nov 2017 09:13:36 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
	<20171106171844.GI4557@stefanha-x1.localdomain>
In-Reply-To: <20171106171844.GI4557@stefanha-x1.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] crypto: afalg: fix a NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: berrange@redhat.com, pbonzini@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org



On 2017/11/7 1:18, Stefan Hajnoczi wrote:

> On Mon, Nov 06, 2017 at 02:21:11PM +0800, Longpeng(Mike) wrote:
>> Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
>> errp=NULL, this will cause a NULL poniter deference if afalg_driver
>> doesn't support requested algos:
>>     ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
>>                                                 result, resultlen,
>>                                                 errp);
>>     if (ret == 0) {
>>         return ret;
>>     }
>>
>>     error_free(*errp);  // <--- here
>>
>> So we must check 'errp & *errp' before dereference.
> 
> Only errp needs to be checked.  It's okay to invoke error_free(NULL):
> 
>   void error_free(Error *err)
>   {
>       if (err) {


Ah yes, thanks for your note :)

I'll pick another approach to fix this bug.

-- 
Regards,
Longpeng(Mike)
