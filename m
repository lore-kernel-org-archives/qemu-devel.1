Received: from eggs.gnu.org ([2001:4830:134:3::10]:48616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cTJyZ-0007aL-C0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cTJyV-0005yP-GY
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:58:23 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cTJyU-0005pb-UY
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:58:19 -0500
Message-ID: <587D8832.7050900@huawei.com>
Date: Tue, 17 Jan 2017 10:57:54 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1484387976-167704-1-git-send-email-longpeng2@huawei.com>
	<20170116141307.GG14681@stefanha-x1.localdomain>
In-Reply-To: <20170116141307.GG14681@stefanha-x1.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qtest: virtio: zeroed last VRingDesc after
 allocate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@redhat.com, lvivier@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, groug@kaod.org, arei.gonglei@huawei.com, qemu-devel@nongnu.org

Hi Stefan,

On 2017/1/16 22:13, Stefan Hajnoczi wrote:

> On Sat, Jan 14, 2017 at 05:59:36PM +0800, Longpeng(Mike) wrote:
......
>> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
>> index ec30cb9..b29c69e 100644
>> --- a/tests/libqos/virtio.c
>> +++ b/tests/libqos/virtio.c
>> @@ -171,12 +171,20 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
>>      for (i = 0; i < elem - 1; ++i) {
>>          /* indirect->desc[i].addr */
>>          writeq(indirect->desc + (16 * i), 0);
>> +        /* indirect->desc[i].len */
>> +        writeq(indirect->desc + (16 * i) + 8, 0);
> 
> The len field is 32 bits long.  Please use writel().
> 
>>          /* indirect->desc[i].flags */
>>          writew(indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
>>          /* indirect->desc[i].next */
>>          writew(indirect->desc + (16 * i) + 14, i + 1);
>>      }
>>  
>> +    /* zeroed last element */
>> +    writeq(indirect->desc + (16 * i), 0); /* addr */
>> +    writeq(indirect->desc + (16 * i) + 8, 0); /*len*/
> 
> Same here.


OK. I will fix it in V2.

-- 
Regards,
Longpeng(Mike)
