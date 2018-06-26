Received: from eggs.gnu.org ([2001:4830:134:3::10]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqkx-0004HS-97
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqku-0007Cl-0W
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:23:51 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:34403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqkt-0007Cb-RQ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:23:47 -0400
Received: by mail-qk0-x22a.google.com with SMTP id b66-v6so4344553qkj.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:23:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f527e00d-79e2-5d7f-f689-73831dfed759@amsat.org>
Date: Tue, 26 Jun 2018 13:23:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] pr-manager-helper: report event on
 connection/disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com

Hi Paolo,

On 06/26/2018 12:40 PM, Paolo Bonzini wrote:
> Let management know if there were any problems communicating with
> qemu-pr-helper.  The event is edge-triggered, and is sent every time
> the connection status of the pr-manager-helper object changes.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qapi/block.json          | 24 ++++++++++++++++++++++++
>  scsi/pr-manager-helper.c | 25 +++++++++++++++++++------
>  2 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/block.json b/qapi/block.json
> index dc3323c954..1882a8d107 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -334,6 +334,30 @@
>  { 'event': 'DEVICE_TRAY_MOVED',
>    'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
>  
> +##
> +# @PR_MANAGER_STATUS_CHANGED:
> +#
> +# Emitted whenever the connected status of a persistent reservation
> +# manager changes.
> +#
> +# @id: The QOM path of the PR manager object
> +#
> +# @connected: true if the PR manager is connected to a backend
> +#
> +# Since: 2.12

3.0?

> +#
> +# Example:
> +#
> +# <- { "event": "PR_MANAGER_STATUS_CHANGED",
> +#      "data": { "id": "/object/pr-helper0",
> +#                "connected": true
> +#      },
> +#      "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
> +#
> +##
> +{ 'event': 'PR_MANAGER_STATUS_CHANGED',
> +  'data': { 'id': 'str', 'connected': 'bool' } }
> +
>  ##
>  # @QuorumOpType:
>  #
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> index b11481be9e..6643caf4cf 100644
> --- a/scsi/pr-manager-helper.c
> +++ b/scsi/pr-manager-helper.c
> @@ -17,6 +17,7 @@
>  #include "io/channel.h"
>  #include "io/channel-socket.h"
>  #include "pr-helper.h"
> +#include "qapi/qapi-events-block.h"
>  
>  #include <scsi/sg.h>
>  
> @@ -33,6 +34,7 @@ typedef struct PRManagerHelper {
>      PRManager parent;
>  
>      char *path;
> +    char *qom_path;
>  
>      QemuMutex lock;
>      QIOChannel *ioc;
> @@ -127,6 +129,8 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
>          goto out_close;
>      }
>  
> +    qapi_event_send_pr_manager_status_changed(pr_mgr->qom_path, true,
> +                                              &error_abort);
>      return 0;
>  
>  out_close:
> @@ -142,9 +146,11 @@ static int pr_manager_helper_run(PRManager *p,
>  
>      uint32_t len;
>      PRHelperResponse resp;
> +    int sense_len;
>      int ret;
>      int expected_dir;
>      int attempts;
> +    bool was_connected = pr_mgr->ioc != NULL;
>      uint8_t cdb[PR_HELPER_CDB_SIZE] = { 0 };
>  
>      if (!io_hdr->cmd_len || io_hdr->cmd_len > PR_HELPER_CDB_SIZE) {
> @@ -222,15 +228,19 @@ static int pr_manager_helper_run(PRManager *p,
>          io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, PR_HELPER_SENSE_SIZE);
>          memcpy(io_hdr->sbp, resp.sense, io_hdr->sb_len_wr);
>      }
> +    qemu_mutex_unlock(&pr_mgr->lock);
> +    return ret;

Maybe this big function can be refactored in 2, the second being the
bottom code with the mutex locked.

>  
>  out:
> -    if (ret < 0) {
> -        int sense_len = scsi_build_sense(io_hdr->sbp,
> -                                         SENSE_CODE(LUN_COMM_FAILURE));
> -        io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
> -        io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, sense_len);
> -        io_hdr->status = CHECK_CONDITION;
> +    if (was_connected) {
> +        qapi_event_send_pr_manager_status_changed(pr_mgr->qom_path, false,
> +                                                  &error_abort);
>      }
> +
> +    sense_len = scsi_build_sense(io_hdr->sbp, SENSE_CODE(LUN_COMM_FAILURE));
> +    io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
> +    io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, sense_len);
> +    io_hdr->status = CHECK_CONDITION;
>      qemu_mutex_unlock(&pr_mgr->lock);
>      return ret;
>  }
> @@ -251,6 +261,8 @@ static void pr_manager_helper_complete(UserCreatable *uc, Error **errp)
>  {
>      PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(uc);
>  
> +    pr_mgr->qom_path = object_get_canonical_path(OBJECT(pr_mgr));
> +
>      qemu_mutex_lock(&pr_mgr->lock);
>      pr_manager_helper_initialize(pr_mgr, errp);
>      qemu_mutex_unlock(&pr_mgr->lock);
> @@ -276,6 +288,7 @@ static void pr_manager_helper_instance_finalize(Object *obj)
>      PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(obj);
>  
>      object_unref(OBJECT(pr_mgr->ioc));
> +    g_free(pr_mgr->qom_path);
>      qemu_mutex_destroy(&pr_mgr->lock);
>  }
>  
> 
