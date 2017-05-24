Received: from eggs.gnu.org ([2001:4830:134:3::10]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDXOD-0005fc-7l
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDXO9-0007Q2-4w
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:35:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dDXO8-0007PR-Uj
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5D5AC04B943
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 14:35:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6c8b845f-fca7-5208-7097-8c4408dea004@redhat.com> (Laurent
	Vivier's message of "Wed, 24 May 2017 15:32:57 +0200")
References: <20170524085519.22856-1-quintela@redhat.com>
	<20170524085519.22856-2-quintela@redhat.com>
	<6c8b845f-fca7-5208-7097-8c4408dea004@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 24 May 2017 16:35:43 +0200
Message-ID: <87o9ui5nls.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Use savevm_handlers instead
 of loadvm copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com

Laurent Vivier <lvivier@redhat.com> wrote:
> On 24/05/2017 10:55, Juan Quintela wrote:
>> From: Juan Quintela <quintela@trasno.org>
>> 
>> There is no reason for having the loadvm_handlers at all.  There is
>> only one use, and we can use the savevm handlers.
>> 
>> We will remove the loadvm handlers on a following patch.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>


>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (se->section_id == section_id) {
>>              break;
>>          }
>>      }
>> -    if (le == NULL) {
>> +    if (se == NULL) {
>>          error_report("Unknown savevm section %d", section_id);
>>          return -EINVAL;
>>      }
>>  
>> -    ret = vmstate_load(f, le->se, le->version_id);
>> +    ret = vmstate_load(f, se, se->version_id);
> Are you sure you can replace le->version_id by se->version?
>
> Because according to code in qemu_loadvm_section_start_full(),
> we can have le->version_id <= se->version_id.

You are right.  We don't use basically anymore version_id, but we used
to use it.

I will arrive to a different solution.  Thanks a lot.

Later, Juan.
