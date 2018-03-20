Received: from eggs.gnu.org ([2001:4830:134:3::10]:44179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyJHH-0003Oo-6y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyJHC-000489-Gw
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:34:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyJHC-000472-B4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:34:14 -0400
References: <41b63d9b-c551-4e22-28f5-1144724dff2e@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b446d661-f0f1-2fcb-ada1-b08af58a9c27@redhat.com>
Date: Tue, 20 Mar 2018 16:34:01 +0100
MIME-Version: 1.0
In-Reply-To: <41b63d9b-c551-4e22-28f5-1144724dff2e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Some thoughts about per-queue iothreads in
 VirtIOBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, "Denis V. Lunev" <den@openvz.org>

On 20/03/2018 15:45, Edgar Kaziakhmedov wrote:
> Hi!
> 
> Recently, I have started working on the real multi-queue implementation
> for the VirtIOBlock device and came to conclusion
> that for the time being it may work only with RAW images. The reason is
> obviously lack of the true thread-safe multi-queue block
> layer, but recently I have seen the following message from Stefan
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04791.html
> 
> It appears like Paolo has already started implementing this feature, so
> I wonder whether the work is abandoned or not, and
> could anyone point me out to any of those patches

I have almost finished getting rid of the AioContext lock
(aio_context_acquire and aio_context_release), which is the final step
of thread-safety and a prerequisite for multiqueue.  Unfortunately it's
stalled a bit due to all the Meltdown and Spectre mess, which yes is
still going on after some months. :(

> As I understood from
> Stefan description, it is expected to change significantly
> the approach we use to interact with BlockDriverState.

I don't think the change is very large actually, at least for on-disk
devices.  I haven't yet considered network devices such as libiscsi or ceph.

Paolo
