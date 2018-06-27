Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fY7VJ-0003An-BI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fY7VE-0007Nx-78
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:16:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fY7VE-0007NS-2S
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:16:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6329BF563
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:16:43 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-6-pbonzini@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <99e4c61b-38a2-37c8-091b-06a9f79955cc@redhat.com>
Date: Wed, 27 Jun 2018 12:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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

On 06/26/2018 05:40 PM, Paolo Bonzini wrote:
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

Also, can we emit this earlier? For instance at the two places where we
unset pr_mgr->ioc:

diff --git i/scsi/pr-manager-helper.c w/scsi/pr-manager-helper.c
index 6643caf4cf..4ca15dff3f 100644
--- i/scsi/pr-manager-helper.c
+++ w/scsi/pr-manager-helper.c
@@ -48,6 +48,8 @@ static int pr_manager_helper_read(PRManagerHelper *pr_mgr,
 
     if (r < 0) {
         object_unref(OBJECT(pr_mgr->ioc));
+        qapi_event_send_pr_manager_status_changed(pr_mgr->qom_path, false,
+                                                  &error_abort);
         pr_mgr->ioc = NULL;
         return -EINVAL;
     }
@@ -74,6 +76,8 @@ static int pr_manager_helper_write(PRManagerHelper *pr_mgr,
             assert(n_written != QIO_CHANNEL_ERR_BLOCK);
             object_unref(OBJECT(pr_mgr->ioc));
             pr_mgr->ioc = NULL;
+            qapi_event_send_pr_manager_status_changed(pr_mgr->qom_path, false,
+                                                      &error_abort);
             return n_written < 0 ? -EINVAL : 0;
         }
 
@@ -150,7 +154,6 @@ static int pr_manager_helper_run(PRManager *p,
     int ret;
     int expected_dir;
     int attempts;
-    bool was_connected = pr_mgr->ioc != NULL;
     uint8_t cdb[PR_HELPER_CDB_SIZE] = { 0 };
 
     if (!io_hdr->cmd_len || io_hdr->cmd_len > PR_HELPER_CDB_SIZE) {
@@ -232,11 +235,6 @@ static int pr_manager_helper_run(PRManager *p,
     return ret;
 
 out:
-    if (was_connected) {
-        qapi_event_send_pr_manager_status_changed(pr_mgr->qom_path, false,
-                                                  &error_abort);
-    }
-
     sense_len = scsi_build_sense(io_hdr->sbp, SENSE_CODE(LUN_COMM_FAILURE));
     io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
     io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, sense_len);
@@ -261,7 +259,7 @@ static void pr_manager_helper_complete(UserCreatable *uc, Error **errp)
 {
     PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(uc);
 
-    pr_mgr->qom_path = object_get_canonical_path(OBJECT(pr_mgr));
+    pr_mgr->qom_path = object_get_canonical_path_component(OBJECT(pr_mgr));
 
     qemu_mutex_lock(&pr_mgr->lock);
     pr_manager_helper_initialize(pr_mgr, errp);


With your approach the event is emitted only after the 5 reconnect 
attempts (which makes little sense IMO). With my approach the event is 
emitted a bit sooner so that reconnect has at least chance of 
succeeding.

I've written some patches for libvirt and with these changes it works 
well.

Michal
