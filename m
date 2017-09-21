Received: from eggs.gnu.org ([2001:4830:134:3::10]:40896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duowX-0002Ev-Rd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duowT-0000VB-0G
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:02:13 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duowS-0000Tn-QV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:02:08 -0400
Received: by mail-pf0-x241.google.com with SMTP id g65so1790929pfe.1
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 17:02:08 -0700 (PDT)
References: <20170920114637.42004-1-aik@ozlabs.ru>
	<20170920114637.42004-19-aik@ozlabs.ru>
	<b957a600-b220-7e2c-a831-3b86b06c5d98@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b6ec083e-8e43-7625-2b96-ec56619255ff@ozlabs.ru>
Date: Thu, 21 Sep 2017 10:02:02 +1000
MIME-Version: 1.0
In-Reply-To: <b957a600-b220-7e2c-a831-3b86b06c5d98@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 18/18] memory: Give
 memory_region_transaction_commit a hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 03:14, Paolo Bonzini wrote:
> On 20/09/2017 13:46, Alexey Kardashevskiy wrote:
>> This extends memory_region_transaction_commit() to receive a MR as
>> if it is a root MR or its topmost parent is, then we can only rebuild
>> its FlatView and update it for address spaces sharing it.
>>
>> The optimization gets disabled though if there is full update about to
>> commit.
>>
>> memory_region_set_enabled() is a special case here, it does not use
>> a hint when MR is being disabled.
>>
>> On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this brings
>> down the boot time from 20s to 12s, the total memory footprint
>> goes down (17G -> 8G).
> 
> I think this is incorrect if MR has an alias (no matter if enabling or
> disabling)?

Hmmm. Right. I can add a aliases_nr counter to an MR (it does not even have
to go down as aliases are not creared/destroyed often) and take the slow
path if it is not zero, does it make sense?


-- 
Alexey
