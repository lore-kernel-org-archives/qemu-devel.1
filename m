Received: from eggs.gnu.org ([2001:4830:134:3::10]:44460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwwGm-000409-RT
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwwGm-00044U-0a
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:15:52 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-9-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8df45cd3-8ea0-8455-2c1b-7d49c91aad97@redhat.com>
Date: Tue, 26 Sep 2017 16:15:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/23] block: Switch
 bdrv_co_get_block_status() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> function (no semantic change); and as with its public counterpart,
> rename to bdrv_co_block_status() to make the compiler enforce that
> we catch all uses.  For now, we assert that callers still pass
> aligned data, but ultimately, this will be the function where we
> hand off to a byte-based driver callback, and will eventually need
> to add logic to ensure we round calls according to the driver's
> request_alignment then touch up the result handed back to the
> caller, to start permitting a caller to pass unaligned offsets.
> 
> Note that we are now prepared to accepts 'bytes' larger than INT_MAX;
> this is okay as long as we clamp things internally before violating
> any 32-bit limits, and makes no difference to how a client will
> use the information (clients looping over the entire file must
> already be prepared for consecutive calls to return the same status,
> as drivers are already free to return shorter-than-maximal status
> due to any other convenient split points, such as when the L2 table
> crosses cluster boundaries in qcow2).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: John Snow <jsnow@redhat.com>
