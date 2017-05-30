Received: from eggs.gnu.org ([2001:4830:134:3::10]:43855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFlzk-0002nK-Vb
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFlzh-0002PX-QL
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFlzh-0002PP-Jo
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5480EC000727
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 18:35:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170530173038.GM2120@work-vm> (David Alan Gilbert's message of
	"Tue, 30 May 2017 18:30:39 +0100")
References: <20170530083705.15141-1-quintela@redhat.com>
	<20170530083705.15141-2-quintela@redhat.com>
	<20170530173038.GM2120@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 20:35:45 +0200
Message-ID: <87ziduchvi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> There is no reason for having the loadvm_handlers at all.  There is
>> only one use, and we can use the savevm handlers.
>> 
>> We will remove the loadvm handlers on a following patch.
>
> <snip>
>
>>      trace_qemu_loadvm_state_section_partend(section_id);
>> -    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
>> -        if (le->section_id == section_id) {
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (se->section_id == section_id) {
>
> Isn't this the problem?  What guarantees that the se->section_id
> is the same as the source's section_id - I don't think anything.
> It's just dynamically allocated in register_savevm_live so the
> initialisation order on source/dest could be different and you'd
> get different ID.  You can't update se->section_id
> unless you guaranteed to updated all of them.

Ok.  It worked for me because I was using the same command line in both
sides.

Changed to add load_section_id and adjust all around.

Thanks, Juan.
