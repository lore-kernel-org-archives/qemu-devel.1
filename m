Received: from eggs.gnu.org ([2001:4830:134:3::10]:47733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctaoj-0003vw-Ge
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctaof-0002TW-BQ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1ctaof-0002Rz-4x
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:12:45 -0400
References: <1490880938-90331-1-git-send-email-agraf@suse.de>
	<1490882437.28523.21.camel@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <153f81fa-ca56-d63d-cb56-33712bed8824@suse.de>
Date: Thu, 30 Mar 2017 16:12:43 +0200
MIME-Version: 1.0
In-Reply-To: <1490882437.28523.21.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] input: Add trace events for polled
 keyboard input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 03/30/2017 04:00 PM, Gerd Hoffmann wrote:
> On Do, 2017-03-30 at 15:35 +0200, Alexander Graf wrote:
>> When driving QEMU from the outside, we have basically no chance to
>> determine how quickly the guest OS picks up key events, so we usually
>> have to limit ourselves to very slow keyboard presses to make sure
>> the guest always has enough chance to pick them up.
>>
>> This patch adds trace events for when the guest polls for HID keyboard
>> events. That way we can be reasonably safely assume that the guest
>> handled that one key event and can type the next.
> Hmm, I'm wondering why you are tracing the event details?  Input layer
> has tracepoints for this already, so why duplicate this here?
> Especially as you have to do quite some effort to store the data for
> tracing?

Because we need to know when the events are off the queue, not pushed 
onto the queue.

> For queue management (in automated testing I assume?) a simple "queue
> empty" trace point should do the trick, no?  Or maybe a "queue has $i of
> $n slots filled atm" trace points, if you wanna know how much you can
> pass in without loosing events due to the queue being full.

That's a very good point. In fact, that would make things much much 
easier for the other side. If we just know "queue is drained", we know 
we can send new events.


Alex
