Received: from eggs.gnu.org ([209.51.188.92]:56396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBo6b-0003jf-Jm
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 18:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBo6Z-0003Xd-GO
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 18:11:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:32395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hBo6V-0001B1-Br
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 18:11:33 -0400
Date: Thu, 4 Apr 2019 06:10:03 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190403221003.GA18809@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190402132650.23095-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402132650.23095-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] vl: Clean up after previous commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On Tue, Apr 02, 2019 at 03:26:49PM +0200, Markus Armbruster wrote:
>Since the previous commit, find_machine() and find_default_machine()
>don't have to deallocate on return.  This permits further
>simplifications.
>
>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>---
> vl.c | 25 +++++++------------------
> 1 file changed, 7 insertions(+), 18 deletions(-)
>
>diff --git a/vl.c b/vl.c
>index 126081f595..6a31e5bfac 100644
>--- a/vl.c
>+++ b/vl.c
>@@ -1467,40 +1467,29 @@ MachineState *current_machine;
> static MachineClass *find_machine(const char *name, GSList *machines)
> {
>     GSList *el;
>-    MachineClass *mc = NULL;
> 
>     for (el = machines; el; el = el->next) {
>-        MachineClass *temp = el->data;
>+        MachineClass *mc = el->data;
> 
>-        if (!strcmp(temp->name, name)) {
>-            mc = temp;
>-            break;
>-        }
>-        if (temp->alias &&
>-            !strcmp(temp->alias, name)) {
>-            mc = temp;
>-            break;
>+        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
>+            return mc;
>         }
>     }
> 
>-    return mc;
>+    return NULL;
> }
> 
> static MachineClass *find_default_machine(GSList *machines)
> {
>     GSList *el;
>-    MachineClass *mc = NULL;
> 
>     for (el = machines; el; el = el->next) {
>-        MachineClass *temp = el->data;
>-
>-        if (temp->is_default) {
>-            mc = temp;
>-            break;
>+        if (((MachineClass *)el->data)->is_default) {
>+            return el->data;
>         }
>     }

Generally it looks good to me.

One tiny suggestion here is to define 

        MachineClass *mc = el->data;

just as it does in find_machin() and return mc instead of raw el->data.

If you agree with that I will modify this at my place.

> 
>-    return mc;
>+    return NULL;
> }
> 
> MachineInfoList *qmp_query_machines(Error **errp)
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
