Received: from eggs.gnu.org ([2001:4830:134:3::10]:44722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejV3E-0007KC-5F
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejV3B-0003Jn-0C
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:06:36 -0500
Received: from mail-db5eur03hn0213.outbound.protection.outlook.com
	([104.47.10.213]:7825
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejV3A-0003Iy-F7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:06:32 -0500
Date: Wed, 7 Feb 2018 22:06:15 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207190615.GC18247@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-12-rkagan@virtuozzo.com>
	<10ea956e-3a47-9da4-2005-af5b1c636518@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ea956e-3a47-9da4-2005-af5b1c636518@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 11/34] hyperv: add synic message
 delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On Wed, Feb 07, 2018 at 11:58:08AM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > +
> > +    HvSintMsgCb msg_cb;
> > +    void *msg_cb_data;
> > +    struct hyperv_message *msg;
> > +    /*
> > +     * the state of the message staged in .msg:
> > +     * 0        - the staging area is not in use (after init or message
> > +     *            successfully delivered to guest)
> > +     * -EBUSY   - the staging area is being used in vcpu thread
> > +     * -EAGAIN  - delivery attempt failed due to slot being busy, retry
> > +     * -EXXXX   - error
> > +     */
> > +    int msg_status;
> > +
> 
> Access to these fields needs to be protected by a mutex (the refcount is
> okay because it is only released in the bottom half).

Hmm, I'll double-check, but the original idea was that this stuff is
only used/ref-d/unref-d in the main thread so no mutex was necessary.

> Please also add
> comments regarding which fields are read-only, which are accessed under
> BQL, etc.
> 
> Also, msg_status's handling of EBUSY/EAGAIN is a bit strange, like:
> 
> +    if (ret == -EBUSY) {
> +        return -EAGAIN;
> +    }
> +    if (ret) {
> +        return ret;
> +    }
> 
> I wonder if it would be better to change -EBUSY to 1, or to split
> msg_status into two fields, such as msg_status (filled by the vCPU
> thread) and msg_state which can be HYPERV_MSG_STATE_{FREE,BUSY,POSTED}.
> msg_status is only valid if the state is POSTED, and sint_msg_bh then
> moves the state back to FREE.

Fair enough, that code isn't easy to follow.  I'll give this your
suggestion a try.

Thanks,
Roman.
