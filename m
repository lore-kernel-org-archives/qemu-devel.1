Received: from eggs.gnu.org ([2001:4830:134:3::10]:44708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7ezu-000793-AS
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7ezr-0007bZ-4f
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7ezq-0007at-Sz
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:07:15 -0400
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
	<20180921082217.29481-6-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47ed971a-71c8-4a95-c1e0-697c68a7a82c@redhat.com>
Date: Wed, 3 Oct 2018 13:06:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180921082217.29481-6-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] hyperv: add synic message delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On 21/09/2018 10:22, Roman Kagan wrote:
> +typedef struct HvSintStagedMesage {
> +    /* message content staged by hyperv_post_msg */
> +    struct hyperv_message msg;
> +    /* callback + data (r/o) to complete the processing in a BH */
> +    HvSintMsgCb cb;
> +    void *cb_data;
> +    /* message posting status filled by cpu_post_msg */
> +    int status;
> +    /* passing the buck: */
> +    enum {
> +        /* initial state */
> +        HV_STAGED_MSG_FREE,
> +        /*
> +         * hyperv_post_msg (e.g. in main loop) grabs the staged area (FREE ->
> +         * BUSY), copies msg, and schedules cpu_post_msg on the assigned cpu
> +         */
> +        HV_STAGED_MSG_BUSY,
> +        /*
> +         * cpu_post_msg (vcpu thread) tries to copy staged msg to msg slot,
> +         * notify the guest, records the status, marks the posting done (BUSY
> +         * -> POSTED), and schedules sint_msg_bh BH
> +         */
> +        HV_STAGED_MSG_POSTED,
> +        /*
> +         * sint_msg_bh (BH) verifies that the posting is done, runs the
> +         * callback, and starts over (POSTED -> FREE)
> +         */
> +    } state;
> +} HvSintStagedMesage;

s/Mesage/Message/

> +    if (atomic_read(&staged_msg->state) != HV_STAGED_MSG_POSTED) {
> +        /* status nor ready yet (spurious ack from guest?), ignore */
> +        return;
> +    }
> +

Can this actually happen?  It seems scary...

Paolo
