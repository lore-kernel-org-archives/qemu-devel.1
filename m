Received: from eggs.gnu.org ([2001:4830:134:3::10]:50233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJwd-0000RW-IK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdJwa-0005RL-Gk
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:57:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdJwa-0005RA-BB
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:57:40 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68AD33D94F
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 16:57:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170203113611.GG3208@work-vm> (David Alan Gilbert's message of
	"Fri, 3 Feb 2017 11:36:12 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-16-git-send-email-quintela@redhat.com>
	<20170203113611.GG3208@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 17:57:31 +0100
Message-ID: <87k28u3u6c.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 15/17] migration: Test new fd infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We just send the address through the alternate channels and test that it
>> is ok.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 4e530ea..95af694 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -432,8 +432,22 @@ static void *multifd_send_thread(void *opaque)
>>      qemu_mutex_lock(&params->mutex);
>>      while (!params->quit){
>>          if (params->pages.num) {
>> +            int i;
>> +            int num;
>> +
>> +            num = params->pages.num;
>>              params->pages.num = 0;
>>              qemu_mutex_unlock(&params->mutex);
>> +
>> +            for(i=0; i < num; i++) {
>> +                if (qio_channel_write(params->c,
>> +                                      (const char *)&params->pages.address[i],
>> +                                      sizeof(uint8_t *), &error_abort)
>> +                    != sizeof(uint8_t*)) {
>> +                    /* Shuoudn't ever happen */
>> +                    exit(-1);
>> +                }
>
> Nope, need to find a way to cleanly find the migration; that
> might actually be tricky from one of these threads?

It is tricky, but the error handling is wrong in the callers of this
already.  Will try to improve it on next series, but the problem is
already there.
