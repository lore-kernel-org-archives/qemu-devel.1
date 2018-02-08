Received: from eggs.gnu.org ([2001:4830:134:3::10]:60291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ejmrt-0000Z1-3a
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ejmrs-0006Xl-5M
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:08:05 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ejmrr-0006XE-Uq
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:08:04 -0500
Received: by mail-wm0-x231.google.com with SMTP id 141so10127042wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:08:03 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 8 Feb 2018 14:08:02 +0000
Message-ID: <CAJSP0QX8zOCKK9HTf4=VddZcYqWmuuC+L5PWiEwVtsnxPd8V2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] libiscsi task cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.de>

SAM-5, 5.6 Aborting commands says:

  A command is aborted when a SCSI device condition (see 6.3), command,
  or task management function causes termination of the command prior to
  its completion by the device server. After a command is aborted and
  TASK ABORTED status, if any, is returned, the SCSI target device shall
  send no further requests or responses for that command.

Then "Table 48 =E2=80=94 Task management functions that abort commands (par=
t 1
of 2)" goes on to say that no TASK ABORTED status is returned for
aborted commands "if the ABORT TASK scope is I_T_L nexus".

My interpretation is that the target doesn't have to send a response
for the aborted command.  It just needs to complete the ABORT TASK
TMF.  Afterwards the initiator knows the task is gone and will receive
no more responses.

Is my understanding correct?

Now on to libiscsi:

The iscsi_task_mgmt_async() API documentation says:

  * abort_task will also cancel the scsi task. The callback for the
scsi task will be invoked with
  *            SCSI_STATUS_CANCELLED

I see that the ABORT TASK TMF response invokes the user's
iscsi_task_mgmt_async() callback but not the command callback.  I'm
not sure how the command callback is invoked with
SCSI_STATUS_CANCELLED unless libiscsi is relying on the target to send
that response.

Is libiscsi honoring its iscsi_task_mgmt_async() contract?

Thanks,
Stefan
