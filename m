Received: from eggs.gnu.org ([2001:4830:134:3::10]:35020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIISQ-0004Hd-Vu
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIISN-00074b-2Y
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIISM-00074A-TJ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:39:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C206C4E02D
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 17:39:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170606081634.GE27621@pxdev.xzpeter.org> (Peter Xu's message of
	"Tue, 6 Jun 2017 16:16:34 +0800")
References: <20170601220813.30535-1-quintela@redhat.com>
	<20170601220813.30535-6-quintela@redhat.com>
	<20170606081634.GE27621@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Tue, 06 Jun 2017 19:39:41 +0200
Message-ID: <87efux582q.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/5] ram: Make RAMState dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jun 02, 2017 at 12:08:13AM +0200, Juan Quintela wrote:
>> We create the variable while we are at migration and we remove it
>> after migration.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> @@ -1818,6 +1825,8 @@ static int ram_state_init(RAMState *rs)
>>              error_report("Error allocating current_buf");
>>              g_free(XBZRLE.encoded_buf);
>>              XBZRLE.encoded_buf = NULL;
>> +            g_free(*rsp);
>> +            *rsp = NULL;
>
> Though may not be directly related to this patch, but... do we need to
> destroy the two mutexes as well?
>
>         (*rsp)->bitmap_mutex
>         (*rsp)->src_page_req_mutex
>

I guess so.  Will do on a next series.

> Also a nit: These several places I would slightly prefer a "goto
> xbzrle_fail", then:
>
> xbzrle_fail:
>     if (XBZRLE.encoded_buf) {
>         g_free(XBZRLE.encoded_buf);
>         XBZRLE.encoded_buf = NULL;
>     }
>     qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
>     qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
>     g_free(*rsp);
>     *rsp = NULL;
>     return -1;
>

My idea is to split the XBZRLE bits from being all overal the code.  But
that would be later O:-)

Later, Juan.
