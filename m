Received: from eggs.gnu.org ([2001:4830:134:3::10]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dQEIr-0006Ry-9F
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dQEIm-0002Yu-E9
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:50:49 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-2-git-send-email-pl@kamp.de>
	<20170627132040.GH13634@redhat.com>
	<845d7b29-8e55-f824-1dfa-af86aad23b93@kamp.de>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e1816401-2e7e-c8b7-ad65-51caf3eb9449@openvz.org>
Date: Wed, 28 Jun 2017 17:50:21 +0300
MIME-Version: 1.0
In-Reply-To: <845d7b29-8e55-f824-1dfa-af86aad23b93@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] block/qcow2: add compression_algorithm
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, lersek@redhat.com

On 06/27/2017 04:27 PM, Peter Lieven wrote:
> Am 27.06.2017 um 15:20 schrieb Daniel P. Berrange:
>> On Tue, Jun 27, 2017 at 02:34:07PM +0200, Peter Lieven wrote:
>>> this patch adds a new compression_algorithm option when creating
>>> qcow2 images.
>>> The current default for the compresison algorithm is zlib and zlib
>>> will be
>>> used when this option is omitted (like before).
>>>
>>> If the option is specified e.g. with:
>>>
>>>   qemu-img create -f qcow2 -o compression_algorithm=zlib image.qcow2 1G
>> IMHO we should introduce a nested struct "compress" struct to hold
>> the format
>> name, and any other format specific arguments, in a way that maps
>> nicely to
>> any future QAPI representmatch of create options. eg
>>
>> { 'enum': 'BlockdevQcow2CompressFormat',
>>    'data': [ 'zlib', 'lzo' ] }
>>
>> { 'union': 'BlockdevQcow2Compress',
>>    'base': { 'format': 'BlockdevQcow2CompressFormat' },
>>    'discriminator': 'format',
>>    'data': { 'zlib': 'BlockdevQcow2CompressZLib',
>>              'lzo': 'BlockdevQcow2CompressLZO'} }
>>
>> so it would map to
>>
>>   qemu-img create -f qcow2 -o compress.format=zlib image.qcow2 1G
>>
>> and let us have other compress.XXXX options specific to each format
>
> Or would it be possible to start with just a compress.level (int)
> parameter.
> In fact that would be sufficient for almost all formats (or better use
> algorithms?).
> The windowBits can be default to -15 in the future. It seems the old
> choice of -12
> was just not optimal. We just have to use it for backwards
> compatiblity if the compress
> options are not specified.
>
> Peter
>
We can put generic parameters on top (in generic header) but
put algorithm-dependent container inside. This could be
viable for the future to avoid incompatible format changes.

Den
