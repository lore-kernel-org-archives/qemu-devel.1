Received: from eggs.gnu.org ([2001:4830:134:3::10]:42344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eHqna-000881-1H
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eHqnN-0001M5-Go
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:40:10 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:43175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eHqnN-0001LY-5S
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:39:57 -0500
Received: by mail-wm0-x242.google.com with SMTP id x63so16554559wmf.2
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 04:39:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6739de79-67e2-1fc7-3f6a-774e7d2bc08f@de.ibm.com>
References: <151129128964.22232.12085565834223304351@sif>
	<255b996e-cfe4-2499-c6aa-8122461eb1dc@de.ibm.com>
	<fe97da57-87c3-40a0-92b9-f1868ab09080@de.ibm.com>
	<151132098079.31225.2285990377569459449@sif>
	<6739de79-67e2-1fc7-3f6a-774e7d2bc08f@de.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Nov 2017 12:39:55 +0000
Message-ID: <CAJSP0QWBvUjko_xDLTRiSK-HE4RnSvw8C8E8XQR4CuX_QHOviQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc2 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Nov 22, 2017 at 8:09 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 11/22/2017 04:23 AM, Michael Roth wrote:
>> Quoting Christian Borntraeger (2017-11-21 15:38:32)
>>> forgot to cc qemu-devel....
>>>
>>> On 11/21/2017 10:37 PM, Christian Borntraeger wrote:
>>>> a quick heads up . Rc2 now triggers
>>>> +qemu-img: block/block-backend.c:2088: blk_root_drained_end: Assertion `blk->quiesce_counter' failed.
>>>> for several qemu iotests.
>>>>
>>>> I have not looked into any details.
>>
>> It looks to be due to:
>>
>> 4afeffc8572f40d8844b946a30c00b10da4442b1
>> blockjob: do not allow coroutine double entry or entry-after-completion
>
> Yes, I can confirm that reverting this patch gets rid of this assertion, but
> I see things like
>
> --- /home/cborntra/REPOS/qemu/tests/qemu-iotests/020.out        2017-11-21 20:19:34.785519323 +0100
> +++ /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/020.out.bad      2017-11-22 09:04:50.127612500 +0100
> @@ -537,7 +537,8 @@
>  wrote 65536/65536 bytes at offset 4295098368
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  No errors were found on the image.
> -Image committed.
> +qemu_aio_coroutine_enter: Co-routine was already scheduled in 'co_aio_sleep_ns'
> +./common.rc: line 61: 88002 Aborted                 (core dumped) ( exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )

Thanks for reporting this, Christian!

I ran qemu-iotests with -raw and -qcow2 to verify that commit
64807cd77938885f681a9a18b5736e923ad50b7c ("Merge remote-tracking
branch 'remotes/cody/tags/block-pull-request' into staging") cause
regressions.  The results were failures in at least 055 109 (-raw) and
020 039 (-qcow2).

I think we should revert commit 64807cd77938885f681a9a18b5736e923ad50b7c.

Stefan
