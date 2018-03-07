Received: from eggs.gnu.org ([2001:4830:134:3::10]:51090)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1etfnr-0007Y7-IA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1etfnm-0000L0-Pv
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:36:47 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34315 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1etfnm-0000KZ-I3
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:36:42 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Wed, 7 Mar 2018 21:36:37 +0100
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
	<20180306115124.GG31045@stefanha-x1.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <dfd15486-e90b-50cd-0271-37a55c3cfc74@kamp.de>
Date: Wed, 7 Mar 2018 21:36:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180306115124.GG31045@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 06.03.2018 um 12:51 schrieb Stefan Hajnoczi:
> On Tue, Feb 20, 2018 at 06:04:02PM +0100, Peter Lieven wrote:
>> I remember we discussed a long time ago to limit the stack usage of all functions that are executed in a coroutine
>> context to a very low value to be able to safely limit the coroutine stack size as well.
>>
>> I checked through all functions in block/, migration/ and nbd/ and there are only very few larger or unbound stack
>> allocations that can easily be fixed.
>>
>> Now my question: Is there an easy way to add a cflag like -Wstack-usage=2048 to all objects in a given directory only?
>> I tried to add a llimit to the whole project, but fixing this will be a larger task.
> 2KB is fine for QEMU code but actual coroutine stack sizes will have to
> be at least 8KB, I guess, in order for third-party libraries to work
> (e.g. curl, rbd).  PATH_MAX is 4KB on Linux.
>
> Nested event loops in QEMU code can also result in deep call stacks.
> This happens when aio_poll() invokes an fd handler or BH that also
> invokes aio_poll().

The plan was to limit the stack usage only as a compiler option. I would leave the coroutine stack size at 1MB
for now until we have a way to identify the worst case usage.

Peter
