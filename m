Received: from eggs.gnu.org ([2001:4830:134:3::10]:40619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQLfr-0003ME-TZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 18:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQLfo-0007Ek-TK
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 18:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQLfo-0007ET-Mn
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 18:43:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 733EDC0587F1
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 22:42:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170628190616.GN12152@localhost.localdomain> (Eduardo Habkost's
	message of "Wed, 28 Jun 2017 16:06:16 -0300")
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-10-git-send-email-peterx@redhat.com>
	<20170628190616.GN12152@localhost.localdomain>
Reply-To: quintela@redhat.com
Date: Thu, 29 Jun 2017 00:42:56 +0200
Message-ID: <878tkb68en.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 09/10] migration: merge
 enforce_config_section somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> wrote:

>
> So, this is a case where a user-provided config option (-machine
> enforce-config-section) should trigger a different default in another
> class (migration.send-configuration).
>
> Also, the new default triggered by -machine has a very specific
> priority:
>
> * AccelClass::global_props must not override "-machine enforce-config-section=on"
> * MachineClass::compat_props must not override
>   "-machine enforce-config-section=on"
>
> We must also decide in advance what should be result of:
> * "-machine enforce-config-section=on -global migration.send-configuration=off"
> * "-machine enforce-config-section=off -global migration.send-configuration=on"
> * "-global migration.send-configuration=off -machine enforce-config-section=off"
> * "-global migration.send-configuration=on -machine enforce-config-section=on"

BOOM!!!!!

We use old configuration or new one.


>
> I'm not sure what we should decide about these 4 cases above, but I
> believe it would be safer to encode that decision at the same place we
> handle the priority between accel/machine/user globals:
> register_global_properties() at vl.c.
>
>
> Or maybe this extra complexity is a sign that we shouldn't try to add
> extra magic to make -machine affect the "migration" object properties,
> and keep the existing machine->enforce_config_section check in the
> migration code?  I'm not sure.

Not sure there either.  I preffer doing it in a single place, but I am
not the expert here.

Later, Juan.
