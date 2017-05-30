Received: from eggs.gnu.org ([2001:4830:134:3::10]:37431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFdJI-0002sX-ML
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFdJH-0002G8-Ft
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dFdJH-0002FD-72
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:19:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E962B85545
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:19:24 +0000 (UTC)
References: <20170530083705.15141-1-quintela@redhat.com>
	<20170530083705.15141-2-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <abba2681-0e14-b225-c5cd-24d37ba561b5@redhat.com>
Date: Tue, 30 May 2017 11:19:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170530083705.15141-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] migration: Use savevm_handlers
 instead of loadvm copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 30/05/2017 10:37, Juan Quintela wrote:
> There is no reason for having the loadvm_handlers at all.  There is
> only one use, and we can use the savevm handlers.
> 
> We will remove the loadvm handlers on a following patch.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  migration/savevm.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d971e5e..d7c08c3 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -251,6 +251,8 @@ typedef struct SaveStateEntry {
>      int instance_id;
>      int alias_id;
>      int version_id;
> +    /* version id read from the stream */
> +    int load_version_id;
>      int section_id;
>      SaveVMHandlers *ops;
>      const VMStateDescription *vmsd;
> @@ -1792,7 +1794,7 @@ struct LoadStateEntry {
>   * Returns: true if the footer was good
>   *          false if there is a problem (and calls error_report to say why)
>   */
> -static bool check_section_footer(QEMUFile *f, LoadStateEntry *le)
> +static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
>  {
>      uint8_t read_mark;
>      uint32_t read_section_id;
> @@ -1805,15 +1807,15 @@ static bool check_section_footer(QEMUFile *f, LoadStateEntry *le)
>      read_mark = qemu_get_byte(f);
>  
>      if (read_mark != QEMU_VM_SECTION_FOOTER) {
> -        error_report("Missing section footer for %s", le->se->idstr);
> +        error_report("Missing section footer for %s", se->idstr);
>          return false;
>      }
>  
>      read_section_id = qemu_get_be32(f);
> -    if (read_section_id != le->section_id) {
> +    if (read_section_id != se->section_id) {
>          error_report("Mismatched section id in footer for %s -"
>                       " read 0x%x expected 0x%x",
> -                     le->se->idstr, read_section_id, le->section_id);
> +                     se->idstr, read_section_id, se->section_id);
>          return false;
>      }
>  
> @@ -1866,6 +1868,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>                       version_id, idstr, se->version_id);
>          return -EINVAL;
>      }
> +    se->load_version_id = version_id;
>  
>      /* Validate if it is a device's state */
>      if (xen_enabled() && se->is_ram) {
> @@ -1881,13 +1884,13 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
>      le->version_id = version_id;
>      QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
>  
> -    ret = vmstate_load(f, le->se, le->version_id);
> +    ret = vmstate_load(f, se, se->load_version_id);
>      if (ret < 0) {
>          error_report("error while loading state for instance 0x%x of"
>                       " device '%s'", instance_id, idstr);
>          return ret;
>      }
> -    if (!check_section_footer(f, le)) {
> +    if (!check_section_footer(f, se)) {
>          return -EINVAL;
>      }
>  
> @@ -1898,29 +1901,29 @@ static int
>  qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>  {
>      uint32_t section_id;
> -    LoadStateEntry *le;
> +    SaveStateEntry *se;
>      int ret;
>  
>      section_id = qemu_get_be32(f);
>  
>      trace_qemu_loadvm_state_section_partend(section_id);
> -    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
> -        if (le->section_id == section_id) {
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (se->section_id == section_id) {
>              break;
>          }
>      }
> -    if (le == NULL) {
> +    if (se == NULL) {
>          error_report("Unknown savevm section %d", section_id);
>          return -EINVAL;
>      }
>  
> -    ret = vmstate_load(f, le->se, le->version_id);
> +    ret = vmstate_load(f, se, se->load_version_id);
>      if (ret < 0) {
>          error_report("error while loading state section id %d(%s)",
> -                     section_id, le->se->idstr);
> +                     section_id, se->idstr);
>          return ret;
>      }
> -    if (!check_section_footer(f, le)) {
> +    if (!check_section_footer(f, se)) {
>          return -EINVAL;
>      }
>  
> 
