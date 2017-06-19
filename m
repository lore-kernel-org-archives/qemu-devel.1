Received: from eggs.gnu.org ([2001:4830:134:3::10]:39429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMz2j-0004hj-KE
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMz2g-0003jY-Fl
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dMz2g-0003jO-95
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:56:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2A6019CBF3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:56:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497876588-947-13-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 19 Jun 2017 20:49:47 +0800")
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-13-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 19 Jun 2017 17:56:29 +0200
Message-ID: <87o9tk9djm.fsf@secure.mitica>
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
> It was in SaveState but now moved to MigrationState altogether, reverted
> its meaning, then renamed to "send_configuration". Again, using
> HW_COMPAT_2_3 for old PC/SPAPR machines, and accel_register_prop() for
> xen_init().
>
> Removing savevm_skip_configuration().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> -    if (!savevm_state.skip_configuration || enforce_config_section()) {
> +    if (migrate_get_current()->send_configuration ||
> +        enforce_config_section()) {
>          qemu_put_byte(f, QEMU_VM_CONFIGURATION);
>          vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
>      }

It is a different problem, but this patch makes enforce_config_section
optional, no?  We can get the same behaviour with this new option,
right?

Looking at the code, it is not clear to me if it is easier to put
enforce_config_option on top of this patch, or let things as they are.

Opinions?

Thanks, Juan.
