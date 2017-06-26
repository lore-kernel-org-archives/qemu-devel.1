Received: from eggs.gnu.org ([2001:4830:134:3::10]:39173)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPRAp-00019k-J8
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPRAm-0006qF-BK
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:15 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:55480 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPRAm-0006oT-1S
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:23:12 -0400
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
	<0e6586f9-85eb-efcd-4825-20066a7c869a@kamp.de>
	<20170626100407.GE495@redhat.com>
	<436300f3-0a0b-49db-5b85-b4a1b11fc778@openvz.org>
From: Peter Lieven <pl@kamp.de>
Message-ID: <920b056a-28d7-45fa-48ea-964da98cbc1f@kamp.de>
Date: Mon, 26 Jun 2017 12:23:09 +0200
MIME-Version: 1.0
In-Reply-To: <436300f3-0a0b-49db-5b85-b4a1b11fc778@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QCOW2 support for LZO compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Am 26.06.2017 um 12:15 schrieb Denis V. Lunev:
> On 06/26/2017 01:04 PM, Daniel P. Berrange wrote:
>> On Mon, Jun 26, 2017 at 11:20:33AM +0200, Peter Lieven wrote:
>>> Am 26.06.2017 um 10:28 schrieb Kevin Wolf:
>>>> [ Cc: qemu-devel; don't post to qemu-block only! ]
>>>>
>>>> Am 26.06.2017 um 09:57 hat Peter Lieven geschrieben:
>>>>> Hi,
>>>>>
>>>>> I am currently working on optimizing speed for compressed QCOW2
>>>>> images. We use them for templates and would also like to use them for
>>>>> backups, but the latter is almost infeasible because using gzip for
>>>>> compression is horribly slow. I tried to experiment with different
>>>>> options to deflate, but in the end I think its better to use a
>>>>> different compression algorithm for cases where speed matters. As we
>>>>> already have probing for it in configure and as it is widely used I
>>>>> would like to use LZO for that purpose. I think it would be best to
>>>>> have a flag to indicate that compressed blocks use LZO compression,
>>>>> but I would need a little explaination which of the feature fields I
>>>>> have to use to prevent an older (incompatible) Qemu opening LZO
>>>>> compressed QCOW2 images.
>>>>>
>>>>> I also have already some numbers. I converted a fresh Debian 9 Install
>>>>> which has an uncomressed QCOW2 size of 1158 MB with qemu-img to a
>>>>> compressed QCOW2.  With GZIP compression the result is 356MB whereas
>>>>> the LZO version is 452MB. However, the current GZIP variant uses 35
>>>>> seconds for this operation where LZO only needs 4 seconds. I think is
>>>>> is a good trade in especially when its optional so the user can
>>>>> choose.
>>>>>
>>>>> What are your thoughts?
>>>> We had a related RFC patch by Den earlier this year, which never
>>>> received many comment and never got out of RFC:
>>>>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04682.html
>>> I was not aware of that one. Thanks for pointing out.
>>>
>>>> So he chose a different algorithm (zstd). When I asked, he posted a
>>>> comparison of algorithms (however a generic one and not measured in the
>>>> context of qemu) that suggests that LZO would be slightly faster, but
>>>> have a considerable worse compression ratio with the settings that were
>>>> benchmarked.
>>> My idea to choose LZO was that it is widely available and available in
>>> any distro you can think of. We already have probing for it in configure.
>>> My concern with ZSTD would be that it seems there are no packages
>>> available for most distros and that it seems to be multi-threaded. I don't
>>> know if this will cause any trouble?
>> As a distro maintainer I'd always prefer option to use a library that is
>> already widely available. While ZSTD could certainly be added to distros,
>> it means the QEMU maintainer will end up having to package it & become
>> the defacto long term maintainer of it long term, which is an extra burden.
>>
>> WRT to making compression algorithms configurable, I think it is important
>> to ensure we don't add lots of optional algorithms. An important factor is
>> portability of images - we don't want to end up with each distro's build
>> of QEMU enabling a different sub-set of compression algorithms, as that is
>> going to harm interoperability for distributed images. This again makes me
>> prefer a compression format whose library is widely available, as that makes
>> it highly likely that the distro will choose to enable it during build.
>>
>> Regards,
>> Daniel
> Speaking about image compression - ZSDT could be questioned
> for different things. Though speaking about online migration -
> ZSTD IMHO is the best choice. I have started the investigation
> keeping that in mind.

For migration things a different. In this case you likely control both ends
of the process and use the same distro there.

Peter
