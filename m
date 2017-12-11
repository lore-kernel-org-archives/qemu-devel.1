Received: from eggs.gnu.org ([2001:4830:134:3::10]:53118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eOKZP-0002qi-PQ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eOKZM-0006dZ-Jl
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:40:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eOKZM-0006Za-Cs
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:40:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACF6BC049D5F
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:40:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171017152746.GE2326@work-vm> (David Alan Gilbert's message of
	"Tue, 17 Oct 2017 16:27:47 +0100")
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-13-quintela@redhat.com>
	<20171017152746.GE2326@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 11 Dec 2017 10:40:07 +0100
Message-ID: <877ettr4aw.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 12/12] migration: Add multifd test
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
>> We set the x-multifd-page-count and x-multifd-channels.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> <snip>
> We *must* find a way to share all the boiler plate I've snipped
> out;  even this test_migrate function is almost identical to
> your other test series with just those few extra parameter sets.

See my migration-test series, I changed this a lot.  I think that
without using function pointers, it is not easy to share more code that
what I did there (and I am not sure that using function pointers makes
things easier to understand).


>> +    /* 200ms downtime */
>> +    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
>> +              "'arguments': { 'downtime-limit': 300 } }");
>
> Note 200 vs 300 !


Fixed when I merged with the previous cod.

>> +    /* Destination still running, wait for a byte to change */
>> +    do {
>> +        qtest_memread(to, start_address, &dest_byte_b, 1);
>> +        usleep(10 * 1000);
>> +    } while (dest_byte_a == dest_byte_b);
>
> Are there any multifd stats we can check?  I guess the migration
> wont start until all channels are connected, so we know they're all
> in use in theory, so there's nothing specific.

We can check that all threads have been created, for instance.

Later, Juan.
