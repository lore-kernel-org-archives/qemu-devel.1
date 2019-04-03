Received: from eggs.gnu.org ([209.51.188.92]:44112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBoRs-0000rN-Kx
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 18:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBoRq-0003b0-F3
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 18:33:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hBoRj-0003B7-0q
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 18:33:28 -0400
Date: Thu, 4 Apr 2019 06:32:55 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190403223255.GB18809@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190402132650.23095-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402132650.23095-2-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] vl: Simplify machine_parse()
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

On Tue, Apr 02, 2019 at 03:26:50PM +0200, Markus Armbruster wrote:
>Exploit that argument @name is nerver null.  Check is_help_option()
>first, because that's what we do elsewhere.
>
>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>---
> vl.c | 24 +++++++++++-------------
> 1 file changed, 11 insertions(+), 13 deletions(-)
>
>diff --git a/vl.c b/vl.c
>index 6a31e5bfac..da1af3e10d 100644
>--- a/vl.c
>+++ b/vl.c
>@@ -2573,19 +2573,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
> 
> static MachineClass *machine_parse(const char *name, GSList *machines)
> {
>-    MachineClass *mc = NULL;
>+    MachineClass *mc;
>     GSList *el;
> 
>-    if (name) {
>-        mc = find_machine(name, machines);
>-    }
>-    if (mc) {
>-        return mc;
>-    }
>-    if (name && !is_help_option(name)) {
>-        error_report("unsupported machine type");
>-        error_printf("Use -machine help to list supported machines\n");
>-    } else {
>+    if (is_help_option(name)) {
>         printf("Supported machines are:\n");
>         machines = g_slist_sort(machines, machine_class_cmp);
>         for (el = machines; el; el = el->next) {
>@@ -2597,9 +2588,16 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
>                    mc->is_default ? " (default)" : "",
>                    mc->deprecation_reason ? " (deprecated)" : "");
>         }
>+        exit(0);
>     }
>-
>-    exit(!name || !is_help_option(name));
>+        
>+    mc = find_machine(name, machines);
>+    if (!mc) {
>+        error_report("unsupported machine type");
>+        error_printf("Use -machine help to list supported machines\n");
>+        exit(1);
>+    }
>+    return mc;

This change looks changed the original behavior.

In original logic, if mc is not NULL, there is no message printed. While now
it rely on is_help_option(). And no it exit when !is_help_option(), while
before this change it exit when is_help_option().

I don't understand the reason behind this. My suggestion is you may split this
patch into two:

  1. remove check on name
  2. refine the logic with explanations.

> }
> 
> void qemu_add_exit_notifier(Notifier *notify)
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
