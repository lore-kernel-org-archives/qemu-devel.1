Received: from eggs.gnu.org ([2001:4830:134:3::10]:47008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evNBR-0003hC-Rt
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evNBQ-00063C-TM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:08:09 -0400
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-4-kwolf@redhat.com>
	<20180312114009.GI3493@redhat.com>
	<20180312114721.GB31537@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6fe64b8a-fa57-5345-89c5-683d1556e921@redhat.com>
Date: Mon, 12 Mar 2018 08:07:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180312114721.GB31537@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] luks: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On 03/12/2018 06:47 AM, Kevin Wolf wrote:

>>> +##
>>> +{ 'struct': 'BlockdevCreateOptionsLUKS',
>>> +  'data': { 'file':             'BlockdevRef',
>>> +            'qcrypto':          'QCryptoBlockCreateOptionsLUKS',
>>> +            'size':             'size' } }
>>
>> s/qcrypto/crypto/ in this field.
>>
>> I do wonder about whether instead of embedding QCryptoBlockCreateOptionsLUKS
>> as a field, we could instead use QCryptoBlockCreateOptionsLUKS as the
>> base struct and just inherit from it to add file/size.
>>
>> I'm not really fussed, but I wonder if you/Eric have any thoughts on the pros
>> or cons of inheritance vs embedding in this case.
> 
> I don't think QAPI has a way to embed it in JSON, but still provide a
> QCryptoBlockCreateOptionsLUKS C object. Originally I wanted to use
> inheritance, but instead of having the struct type reused, you get all
> field definitions copied. I guess you could then manually cast to the
> base type and it would still work, but it didn't really feel clean.

The QAPI generators generate a function (qapi_NAME_base()) which will 
convert any derived type back to the parent class, which is cleaner than 
manually casting; if that makes the decision to use inheritance any easier.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
