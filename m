Received: from eggs.gnu.org ([2001:4830:134:3::10]:35479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cr7Ba-0004Z3-BC
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cr7BV-0005y1-7O
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:10:10 -0400
Received: from mail-db5eur01on0097.outbound.protection.outlook.com
	([104.47.2.97]:44960
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cr7BU-0005xg-H3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:10:05 -0400
References: <1490275739-14940-1-git-send-email-den@openvz.org>
	<377732f8-b41f-5ca8-d418-26d524ba4ea9@redhat.com>
	<20170323150456.GA5344@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <ce38d665-547c-a9e6-a698-ba586cba9ec1@openvz.org>
Date: Thu, 23 Mar 2017 18:35:59 +0300
MIME-Version: 1.0
In-Reply-To: <20170323150456.GA5344@noname.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/1] qcow2: add ZSTD compression feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/23/2017 06:04 PM, Kevin Wolf wrote:
> Am 23.03.2017 um 15:17 hat Eric Blake geschrieben:
>> On 03/23/2017 08:28 AM, Denis V. Lunev wrote:
>>> ZSDT compression algorithm consumes 3-5 times less CPU power with a
>> s/ZSDT/ZSTD/
>>
>>> comparable comression ratio with zlib. It would be wise to use it for=

>> s/comression/compression/
>>
>>> data compression f.e. for backups.
> Note that we don't really care that much about fast compression because=

> that's an one time offline operation. Maybe a better compression ratio
> while maintaining decent decompression performance would be the more
> important feature?
>
> Or are you planning to extend the qcow2 driver so that compressed
> clusters are used even for writes after the initial conversion? I think=

> it would be doable, and then I can see that better compression speed
> becomes important, too.
we should care about backups :) they can be done using compression
event right now and this is done in real time when VM is online.
Thus any additional CPU overhead counts, even if compressed data is
written only once.


>>> The patch adds incompatible ZSDT feature into QCOW2 header that indic=
ates
>>> that compressed clusters must be decoded using ZSTD.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: Fam Zheng <famz@redhat.com>
>>> ---
>>> Actually this is very straightforward. May be we should implement 2 s=
tage
>>> scheme, i.e. add bit that indicates presence of the "compression
>>> extension", which will actually define the compression algorithm. Tho=
ugh
>>> at my opinion we will not have too many compression algorithms and pr=
oposed
>>> one tier scheme is good enough.
>> I wouldn't bet on NEVER changing compression algorithms again, and whi=
le
>> I suspect that we won't necessarily run out of bits, it's safer to not=

>> require burning another bit every time we change our minds.  Having a
>> two-level scheme means we only have to burn 1 bit for the use of a
>> compression extension header, where we can then flip algorithms in the=

>> extension header without having to burn a top-level incompatible featu=
re
>> bit every time.
> Header extensions make sense for compatible features or for variable
> size data. In this specific case I would simply increase the header siz=
e
> if we want another field to store the compression algorithm. And I thin=
k
> having such a field is a good idea.
>
>>>  docs/specs/qcow2.txt | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
>>> index 80cdfd0..eb5c41b 100644
>>> --- a/docs/specs/qcow2.txt
>>> +++ b/docs/specs/qcow2.txt
>>> @@ -85,7 +85,10 @@ in the description of a field.
>>>                                  be written to (unless for regaining
>>>                                  consistency).
>>> =20
>>> -                    Bits 2-63:  Reserved (set to 0)
>>> +                    Bits 2:     ZSDT compression bit. ZSDT algorithm=
 is used
>> s/ZSDT/ZSTD/
>>
>> Another reason I think you should add a compression extension header:
>> compression algorithms are probably best treated as mutually-exclusive=

>> (the entire image should be compressed with exactly one compressor).
>> Even if we only ever add one more type (say 'xz') in addition to the
>> existing gzip and your proposed zstd, then we do NOT want someone
>> specifying both xz and zstd at the same time.  Having a single
>> incompatible feature bit that states that a compression header must be=

>> present and honored to understand the image, where the compression
>> header then chooses exactly one compression algorithm, seems safer tha=
n
>> having two separate incompatible feature bits for two opposing algorit=
hms
> Actually, if we used compression after the initial convert, having
> mixed-format images would make a lot of sense because after an update
> you could then start using a new compression format on an image that
> already has some compressed clusters.
>
> But we have neither L2 table bits left for this nor do we use
> compression for later writes, so I agree that we'll have to make them
> mututally exclusive in this reality.
>
> Kevin
There are compression magics, which could be put into data at the cost
of some additional bytes. In this case compression header must report
all supported compression algorithms and this indeed are incompatible
header bits. The image can not be opened if some used compression
algorithms are not available.

Den
