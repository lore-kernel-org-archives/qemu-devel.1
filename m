Received: from eggs.gnu.org ([2001:4830:134:3::10]:43581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNa4e-0003ni-MD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNa4Y-0003Ap-Pb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNa4Y-00039n-Jk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C7CF145FBE
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:29:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170621033346.GE3662@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 21 Jun 2017 11:33:46 +0800")
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-13-git-send-email-peterx@redhat.com>
	<87o9tk9djm.fsf@secure.mitica>
	<20170621033346.GE3662@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 09:28:58 +0200
Message-ID: <87o9thn6it.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 12/13] migration: move
 skip_configuration out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> On Mon, Jun 19, 2017 at 05:56:29PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > It was in SaveState but now moved to MigrationState altogether, reverted
>> > its meaning, then renamed to "send_configuration". Again, using
>> > HW_COMPAT_2_3 for old PC/SPAPR machines, and accel_register_prop() for
>> > xen_init().
>> >
>> > Removing savevm_skip_configuration().
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>

>> It is a different problem, but this patch makes enforce_config_section
>> optional, no?  We can get the same behaviour with this new option,
>> right?
>> 
>> Looking at the code, it is not clear to me if it is easier to put
>> enforce_config_option on top of this patch, or let things as they are.
>> 
>> Opinions?
>
> There can be a very tiny difference. Consider this cmdline:
>
>   qemu -M enforce-config-section=true -global migration.send-configuration=false
>
> For current patch, enforce-config-section=true will make sure this
> cmdline will send the config section no matter what we provided in
> -global section.
>
> If we remove the enforce_config_section() above and also use
> MigrationState.send_configuration, the enforce-config-section=true
> will be replaced by the latter send-configuration=false, then config
> section will not be sent.
>
> However, I'll vote for your suggestion since after all this cmdline is
> not really making much sense (considering it's providing two conflict
> confugrations). And anyone who starts to use "-global migration.*"
> then he/she should know the possible side effect.

Agreed.

Thanks for taking this, Juan.
