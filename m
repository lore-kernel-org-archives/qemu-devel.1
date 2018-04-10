Received: from eggs.gnu.org ([2001:4830:134:3::10]:60700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f5qrF-0001Jh-3p
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f5qrB-000419-SA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:50:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37640
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1f5qrB-000410-Ml
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:50:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3AAnsbL147141
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:50:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h8rac9t8x-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:50:32 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 10 Apr 2018 06:50:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Apr 2018 16:22:18 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
In-Reply-To: <20180410095233.GA11713@localhost.localdomain>
References: <20180331185536.4835-1-bala24@linux.vnet.ibm.com>
	<87sh8bz6is.fsf@secure.mitica>
	<20180410095233.GA11713@localhost.localdomain>
Message-Id: <13ace01d09a7c869572669db763de115@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Qemu-devel <qemu-devel-bounces+bala24=linux.vnet.ibm.com@nongnu.org>

On 2018-04-10 15:22, Balamuruhan S wrote:
> On Wed, Apr 04, 2018 at 11:04:59AM +0200, Juan Quintela wrote:
>> Balamuruhan S <bala24@linux.vnet.ibm.com> wrote:
>> > expected_downtime value is not accurate with dirty_pages_rate * page_size,
>> > using ram_bytes_remaining would yeild it correct.
>> >
>> > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> 
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> 
>> See my other mail on the thread, my understanding is that your change 
>> is
>> corret (TM).
> 
> Juan, Please help to merge it.

Sorry for asking it as during discussion going on, but the reason is 
currently
postcopy migration for HP backed P8 guest from P8 -> P9 is broken and to 
use
precopy with appropriate downtime value we need this patch to be 
backported
to distros that is to be released soon.

> 
> Regards,
> Bala
> 
>> 
>> Thanks, Juan.
>> 
>> > ---
>> >  migration/migration.c | 3 +--
>> >  1 file changed, 1 insertion(+), 2 deletions(-)
>> >
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 58bd382730..4e43dc4f92 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -2245,8 +2245,7 @@ static void migration_update_counters(MigrationState *s,
>> >       * recalculate. 10000 is a small enough number for our purposes
>> >       */
>> >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
>> > -        s->expected_downtime = ram_counters.dirty_pages_rate *
>> > -            qemu_target_page_size() / bandwidth;
>> > +        s->expected_downtime = ram_bytes_remaining() / bandwidth;
>> >      }
>> >
>> >      qemu_file_reset_rate_limit(s->to_dst_file);
>> 
