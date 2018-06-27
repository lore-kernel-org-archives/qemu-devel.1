Received: from eggs.gnu.org ([2001:4830:134:3::10]:50377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY4oy-0004l7-R6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY4ou-0004k8-M8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:24:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fY4ou-0004iU-GK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:24:52 -0400
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
Date: Wed, 27 Jun 2018 09:24:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

On 27.06.2018 08:51, Gerd Hoffmann wrote:
>>> Signed-off-by: Martin Schrodt <martin@schrodt.org>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Message-id: 20180622111200.30561-2-kraxel@redhat.com
>>> Message-id: 20171015184033.2951-3-martin@schrodt.org
>>>
>>> [ kraxel: keep old code for compatibility with older qemu versions,
>>>           add property to switch code paths at runtime ]
>>> [ kraxel: new code is disabled by default, use-timer=on enables it ]
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  hw/audio/hda-codec.c | 263 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>>  hw/audio/intel-hda.c |   7 --
>>>  2 files changed, 237 insertions(+), 33 deletions(-)
>>
>> This patch breaks compilation on clang with -m32 for me, because I
>> apparently I don't have 64 bit atomics there.  Should there be
>> CONFIG_ATOMIC64 guards and handling for when that isn't defined?
> 
> Given the code runs under big qemu lock anyway the atomics are not
> needed, so we could drop just them.  I left them in nevertheless because
> 
>   (a) we might want try run the code in a thread instead of using a timer, and
>   (b) I was too lazy to rewrite the code to drop the atomics.
> 
> I'd prefer to keep option (a) ...
> 
> Using int32_t instead of int64_t for rpos and wpos would be another way.
> Also not that great because they will wrap then after playing sound for
> roughly 6 hours.
> 
> Using int32_t on 32bit hosts only (or depending on CONFIG_ATOMIC64) is
> bad too because rpos and wpos are in vmstate, so the live migration
> stream format changes.
> 
> Hmm.
> 
> Drop support for 32bit hosts in qemu?

I guess the only way to answer that question reliably is to send a patch
to mark 32-bit hosts as deprecated...

Anyway, you still have got to fix that problem with -m32 now somehow
since we certainly can not drop 32-bit immediately.

 Thomas
