Received: from eggs.gnu.org ([2001:4830:134:3::10]:33926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNQe-0007u5-Dv
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNQb-0006W2-D8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:58:16 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNQb-0006VR-5y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:58:13 -0500
Received: by mail-wr0-f174.google.com with SMTP id s5so532305wra.0
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 02:58:12 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-12-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10ea956e-3a47-9da4-2005-af5b1c636518@redhat.com>
Date: Wed, 7 Feb 2018 11:58:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-12-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> +
> +    HvSintMsgCb msg_cb;
> +    void *msg_cb_data;
> +    struct hyperv_message *msg;
> +    /*
> +     * the state of the message staged in .msg:
> +     * 0        - the staging area is not in use (after init or message
> +     *            successfully delivered to guest)
> +     * -EBUSY   - the staging area is being used in vcpu thread
> +     * -EAGAIN  - delivery attempt failed due to slot being busy, retry
> +     * -EXXXX   - error
> +     */
> +    int msg_status;
> +

Access to these fields needs to be protected by a mutex (the refcount is
okay because it is only released in the bottom half).  Please also add
comments regarding which fields are read-only, which are accessed under
BQL, etc.

Also, msg_status's handling of EBUSY/EAGAIN is a bit strange, like:

+    if (ret == -EBUSY) {
+        return -EAGAIN;
+    }
+    if (ret) {
+        return ret;
+    }

I wonder if it would be better to change -EBUSY to 1, or to split
msg_status into two fields, such as msg_status (filled by the vCPU
thread) and msg_state which can be HYPERV_MSG_STATE_{FREE,BUSY,POSTED}.
msg_status is only valid if the state is POSTED, and sint_msg_bh then
moves the state back to FREE.

Thanks,

Paolo
