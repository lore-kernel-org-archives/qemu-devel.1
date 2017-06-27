Received: from eggs.gnu.org ([2001:4830:134:3::10]:59531)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPqXE-0000PD-4r
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPqXA-0007Mz-5u
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:28:04 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:39364 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPqX9-0007Lq-Sl
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:28:00 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-2-git-send-email-pl@kamp.de>
	<20170627132040.GH13634@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <845d7b29-8e55-f824-1dfa-af86aad23b93@kamp.de>
Date: Tue, 27 Jun 2017 15:27:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170627132040.GH13634@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, lersek@redhat.com

Am 27.06.2017 um 15:20 schrieb Daniel P. Berrange:
> On Tue, Jun 27, 2017 at 02:34:07PM +0200, Peter Lieven wrote:
>> this patch adds a new compression_algorithm option when creating qcow2 images.
>> The current default for the compresison algorithm is zlib and zlib will be
>> used when this option is omitted (like before).
>>
>> If the option is specified e.g. with:
>>
>>   qemu-img create -f qcow2 -o compression_algorithm=zlib image.qcow2 1G
> IMHO we should introduce a nested struct "compress" struct to hold the format
> name, and any other format specific arguments, in a way that maps nicely to
> any future QAPI representmatch of create options. eg
>
> { 'enum': 'BlockdevQcow2CompressFormat',
>    'data': [ 'zlib', 'lzo' ] }
>
> { 'union': 'BlockdevQcow2Compress',
>    'base': { 'format': 'BlockdevQcow2CompressFormat' },
>    'discriminator': 'format',
>    'data': { 'zlib': 'BlockdevQcow2CompressZLib',
>              'lzo': 'BlockdevQcow2CompressLZO'} }
>
> so it would map to
>
>   qemu-img create -f qcow2 -o compress.format=zlib image.qcow2 1G
>
> and let us have other compress.XXXX options specific to each format

Or would it be possible to start with just a compress.level (int) parameter.
In fact that would be sufficient for almost all formats (or better use algorithms?).
The windowBits can be default to -15 in the future. It seems the old choice of -12
was just not optimal. We just have to use it for backwards compatiblity if the compress
options are not specified.

Peter
