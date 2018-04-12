Received: from eggs.gnu.org ([2001:4830:134:3::10]:35532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6j5V-0006LR-7F
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6j5U-0006KH-HX
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:44:57 -0400
References: <20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
	<20180412115316.GC5004@localhost.localdomain>
	<306e73f3-9e72-e60f-123c-47a8a72915e2@redhat.com>
	<20180412132735.GD5004@localhost.localdomain>
	<dc693c45-e1dc-5a3d-3c95-adcb946c65d6@redhat.com>
	<20180412142519.GE5004@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <302b4aea-7e42-a321-f8db-4d0f69794bbf@redhat.com>
Date: Thu, 12 Apr 2018 22:44:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180412142519.GE5004@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on
 drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 12/04/2018 16:25, Kevin Wolf wrote:
> This is already the order we have there. What is probably different from
> what you envision is that after the parents have concluded, we still
> check that they are still quiescent in every iteration.

Yes, and that's the quadratic part.

> What we could do easily is introducing a bool bs->quiesce_concluded or
> something that bdrv_drain_poll() sets to true the first time that it
> returns false. It also gets a shortcut so that it returns false
> immediately if bs->quiesce_concluded is true. The field is reset in
> bdrv_do_drained_end() when bs->quiesce_counter reaches 0.

Or bs->quiescent, for the sake of bikeshedding.

> That would be a rather simple optimisation that could be done as the
> final patch in this series, and would ensure that we don't recurse back
> to parents that are already quiescent.
> 
> Would you be happy with this change?

Yes, I'll leave the organization of the series to you of course.

Paolo
