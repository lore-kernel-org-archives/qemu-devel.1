Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejmyV-0006Z6-SM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejmyV-0002qo-4X
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:14:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejmyU-0002qd-Vz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:14:55 -0500
References: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7d46cd7-aba7-ebae-e1a0-4d321586705f@redhat.com>
Date: Thu, 8 Feb 2018 15:14:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] libiscsi task cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.de>

On 08/02/2018 15:08, Stefan Hajnoczi wrote:
> Now on to libiscsi:
> 
> The iscsi_task_mgmt_async() API documentation says:
> 
>   * abort_task will also cancel the scsi task. The callback for the
> scsi task will be invoked with
>   *            SCSI_STATUS_CANCELLED
> 
> I see that the ABORT TASK TMF response invokes the user's
> iscsi_task_mgmt_async() callback but not the command callback.  I'm
> not sure how the command callback is invoked with
> SCSI_STATUS_CANCELLED unless libiscsi is relying on the target to send
> that response.
> 
> Is libiscsi honoring its iscsi_task_mgmt_async() contract?

No, and QEMU is assuming the "wrong" behavior:

static void
iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
                    void *private_data)
{
    IscsiAIOCB *acb = private_data;

    acb->status = -ECANCELED;
    iscsi_schedule_bh(acb);
}

Paolo
