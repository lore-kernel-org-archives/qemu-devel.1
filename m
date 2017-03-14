Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnlce-0002mm-Rb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnlca-0001S9-VI
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:32:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnlca-0001Qi-Mx
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:32:12 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B01C7C05AA63
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 12:32:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170314103428.GD2652@redhat.com> (Daniel P. Berrange's message
	of "Tue, 14 Mar 2017 10:34:28 +0000")
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-10-quintela@redhat.com>
	<20170313164134.GM4799@redhat.com> <87fuihuna9.fsf@secure.mitica>
	<20170314103428.GD2652@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 14 Mar 2017 13:32:10 +0100
Message-ID: <87k27st4xh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/16] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Mon, Mar 13, 2017 at 05:58:06PM +0100, Juan Quintela wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>> > On Mon, Mar 13, 2017 at 01:44:27PM +0100, Juan Quintela wrote:
>> >
>> > I still don't really like any of the changes in this file. We've now got
>> > two sets of methods which connect to a remote host and two sets of methods
>> > which accept incoming clients. I've got to think there's a better way to
>> > refactor the existing code, such that we don't need two sets of methods
>> > for the same actions
>> 
>> I am open to suggestions, basically we want to be able to:
>> - open one + n channels
>> - be sure that we got the same id on both sides of the connection.
>> 
>> You suggested on the previous iteration that I changed the FALSE in
>> *HERE* for TRUE, but I was not able to:
>> - make sure that we have opened n sockets before we continue with
>>   migration
>> - making sure that we got same id numbers in both sides, that is doable,
>>   just add a new id field
>> - right now I open a channel, and wait for the other side to open it
>>   before open the following one.  I can do things in parallel, but
>>   locking is going to be "interesting".
>> 
>> So, as said, I don't really care how we open the channels, I am totally
>> open to suggestions.  Looking at the current code, this is the best way
>> that I have been able to think of.
>
> I think the key problem in the current design is that you delay the opening
> of the extra socket channels. To be able to remove most of this duplication,
> I think you need to open all the channels at once right at the start.
>
>
> IOW, in qmp_migrate() instead of calling tcp_start_outgoing_migration()
> just once, use a loop to call it N times (where N == number of threads).
>
> Now this method is asynchronous, and eventually triggers a call to
> migration_channel_connect() when the connection actually succeeds.
> You will need to change migration_channel_connect() so that it can be
> called multiple times. migration_channel_connect() should count how
> many channels have been opened, and only start the migration once all
> of them are open.
>
> The incoming side is a little different - in qemu_start_incoming_migration()
> you only need call tcp_start_incoming_migration() once. In the
> socket_accept_incoming_migration() method though, you need to change the
> 'return FALSE' to 'return TRUE', so that it continues to accept multiple
> incoming clients. The socket_start_outgoing_migration()method needs to again
> count the number of channels that have been opened so far, and only start
> the actual migration once the right number are open.
>
>
> By doing all this opening of channels upfront, you'll also make it much
> easier to support the other migration protocols - in particular 'fd'
> protocol needs to be extended so that libvirt can pass in multiple FDs
> in the monitor command at once. The 'exec' protocol should also be
> able to trivially support this by simply launching the command multiple
> times.

Ok. Thanks.  Will look into this.

Later, Juan.
