Received: from eggs.gnu.org ([2001:4830:134:3::10]:57543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFkyq-0005hD-Ad
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFkyj-0008Jp-VJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dFkyj-0008HX-PB
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:30:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72673C05972F
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 17:30:44 +0000 (UTC)
Date: Tue, 30 May 2017 18:30:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170530173038.GM2120@work-vm>
References: <20170530083705.15141-1-quintela@redhat.com>
	<20170530083705.15141-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530083705.15141-2-quintela@redhat.com>
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
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> There is no reason for having the loadvm_handlers at all.  There is
> only one use, and we can use the savevm handlers.
> 
> We will remove the loadvm handlers on a following patch.

<snip>

>      trace_qemu_loadvm_state_section_partend(section_id);
> -    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
> -        if (le->section_id == section_id) {
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        if (se->section_id == section_id) {

Isn't this the problem?  What guarantees that the se->section_id
is the same as the source's section_id - I don't think anything.
It's just dynamically allocated in register_savevm_live so the
initialisation order on source/dest could be different and you'd
get different ID.  You can't update se->section_id
unless you guaranteed to updated all of them.

Dave

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
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
