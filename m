Received: from eggs.gnu.org ([2001:4830:134:3::10]:56675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dGO1H-0000sR-W7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dGO1D-0004mO-Ti
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:11:59 -0400
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
	<20170601091224.GB4987@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <8baa473d-d756-2a0b-3356-1cc00f31bd25@openvz.org>
Date: Thu, 1 Jun 2017 14:11:34 +0300
MIME-Version: 1.0
In-Reply-To: <20170601091224.GB4987@noname.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: armbru@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>

On 06/01/2017 12:12 PM, Kevin Wolf wrote:
> Am 31.05.2017 um 17:03 hat Eric Blake geschrieben:
>> On 05/31/2017 09:43 AM, Pavel Butsykin wrote:
>>> This patch adds the reduction of the image file for qcow2. As a result, this
>>> allows us to reduce the virtual image size and free up space on the disk without
>>> copying the image. Image can be fragmented and reduction is done by punching
>>> holes in the image file.
>>>
>>> # ./qemu-img create -f qcow2 -o size=4G image.qcow2
>>> Formatting 'image.qcow2', fmt=qcow2 size=4294967296 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
>>>
>>> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
>> So this is 1G of guest-visible data...
>>
>>> # ./qemu-img resize image.qcow2 128M
>>> Image resized.
>> ...and you are truncating the image by throwing away guest-visible
>> content, with no warning or double-checking (such as requiring a -f
>> force parameter or something) about the data loss.  Shrinking images is
>> something we should allow, but it feels like is a rare enough operation
>> that you don't want it to be casually easy to throw away data.
>>
>> Is it feasible to require that a shrink operation will not be performed
>> unless all clusters being eliminated have been previously discarded (or
>> maybe written to zero), as an assurance that the guest did not care
>> about the tail of the image?
> I think that ship has sailed long ago because raw images have always
> supported shrinking images without any special checks or options. We
> want consistency between raw and qcow2, and we also need to provide
> backwards compatibility.
>
> The only thing I can imagine we could do now is to introduce a --shrink
> option in qemu-img, print a deprecation warning for shrinking without
> this option, and then make it mandatory in a few years.
>
> If we want to distinguish based on the block driver, so that we can
> require --shrink for all drivers that didn't support shrinking until
> now, we'd have to check the .bdrv_truncate() implementations of all
> drivers to see whether it already allowed shrinking.
>
> Kevin
Will the solution proposed by Pavel in the answer to Max work:
- if there are no data blocks in the truncated space, truncate is allowed
  without additional options
- if there are data blocks in the truncated space, truncate is allowed
  with the flag --force or error is generated

Den
