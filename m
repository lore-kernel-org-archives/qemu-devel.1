Received: from eggs.gnu.org ([2001:4830:134:3::10]:39461)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ddLLF-0000QO-K4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ddLLC-0005T8-Ac
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:59:29 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44434 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ddLLC-0005R1-1l
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:59:26 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-11-git-send-email-pl@kamp.de>
	<546c49d1-57c3-7ba7-c0cf-558da609e7a7@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <74b439ad-8466-2780-2517-095d877e6557@kamp.de>
Date: Thu, 3 Aug 2017 20:59:20 +0200
MIME-Version: 1.0
In-Reply-To: <546c49d1-57c3-7ba7-c0cf-558da609e7a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V5 10/10] block/qcow2: add compress info to
 image specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

Am 25.07.2017 um 23:55 schrieb Eric Blake:
> On 07/25/2017 09:41 AM, Peter Lieven wrote:
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  block/qcow2.c        | 7 +++++++
>>  qapi/block-core.json | 6 +++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> +++ b/qapi/block-core.json
>> @@ -68,6 +68,9 @@
>>  # @encrypt: details about encryption parameters; only set if image
>>  #           is encrypted (since 2.10)
>>  #
>> +# @compress: details about parameters for compressed clusters; only set if
>> +#            the compress format header extension is present (since 2.11)
> Thinking aloud:
>
> I still think this is better as "only set if the image uses compressed
> headers" (similar to encrypt).  That is, I would like this output to be
> present even when opening legacy deflate/0/12 images.
>
> But thinking more, what I am REALLY asking for is "if any cluster is
> compressed, then this information is present; if nothing is compressed,
> the choice of compression header doesn't matter".  But we don't have a
> quick-and-dirty way to tell if an image has any compressed clusters,
> short of examining every L2 map (including maps inside internal snapshots).
>
> Hmm - we already have 'Dirty bit' and 'Corrupt bit' as
> incompatible_features that can quickly identify certain image
> properties; do we want another bit set to 1 for images known to use
> compressed clusters?  Or even make it an auto-clear bit (or even a pair
> of auto-clear bits: one to designate that this image was written by a
> new-enough qemu that promises to mark the image if any compressed
> clusters exist, and the other is set only if such clusters do exist;
> that way, if both bits are clear, we know we have to walk L2 tables to
> look for compressed clusters, but if the first bit is set, then the
> second bit is reliable)?
>
> So maybe this means we are still debating spec ideas.  Kevin, do you
> want to chime in?
>
Hi all,


I would really like to move this forward and get at least the spec for

the QCOW2 Extension Header fixed. I internally need this feature and would

like not to produce incompatible images.

Maybe we can even decide later if we add further bits for tracking if

there are compressed cluster and keep this indepented of this series.


Thanks,
Peter
