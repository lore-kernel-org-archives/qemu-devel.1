Received: from eggs.gnu.org ([2001:4830:134:3::10]:45055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYBZ-0004ww-5A
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYBU-0005yc-J0
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpYBU-0005y6-Ck
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1A8E356C9
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:07:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170811034725.GD26015@pxdev.xzpeter.org> (Peter Xu's message of
	"Fri, 11 Aug 2017 11:47:25 +0800")
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-2-quintela@redhat.com>
	<20170811034725.GD26015@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 06 Sep 2017 13:07:47 +0200
Message-ID: <878thsccfw.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 01/19] migration: Create
 migration_ioc_process_incoming()
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
> On Tue, Aug 08, 2017 at 06:26:11PM +0200, Juan Quintela wrote:
>
> [...]
>
>>  void migration_fd_process_incoming(QEMUFile *f)
>>  {
>> -    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
>> -
>> +    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +    
>> +    if (!mis->from_src_file) {
>> +        mis->from_src_file = f;
>
> [1]
>
>> +    }
>>      qemu_file_set_blocking(f, false);
>>      qemu_coroutine_enter(co);
>>  }
>>  
>> +void migration_ioc_process_incoming(QIOChannel *ioc)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +
>> +    if (!mis->from_src_file) {
>> +        QEMUFile *f = qemu_fopen_channel_input(ioc);
>> +        mis->from_src_file = f;
>
> Remove this line? Since migration_fd_process_incoming() will set it up
> as well below at [1].
>
> Then we can make sure there will be only one place to setup
> from_src_file.

This can be end being called from rdma code.

Yes, I know it is a mess.

Later, Juan.
