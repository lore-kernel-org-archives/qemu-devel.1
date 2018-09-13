Received: from eggs.gnu.org ([2001:4830:134:3::10]:60158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TGO-0002jL-AH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TGN-00015d-Is
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:10:36 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-12-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <908e08a4-a58a-e4e1-5eb7-fe9d17adfbe3@redhat.com>
Date: Thu, 13 Sep 2018 17:10:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/17] block-backend: Decrease in_flight
 only after callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On 13/09/2018 14:52, Kevin Wolf wrote:
> + if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
> + /* If we are in the main thread, the callback is allowed to unref
> + * the BlockBackend, so we have to hold an additional reference */
> + blk_ref(acb->rwco.blk);
> + }
> acb->common.cb(acb->common.opaque, acb->rwco.ret);
> + blk_dec_in_flight(acb->rwco.blk);
> + if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
> + blk_unref(acb->rwco.blk);
> + }

Is this something that happens only for some specific callers?  That is,
which callers are sure that the callback is invoked from the main thread?

Thanks,

Paolo
