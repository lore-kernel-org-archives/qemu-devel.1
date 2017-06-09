Received: from eggs.gnu.org ([2001:4830:134:3::10]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJNk9-0007xo-G0
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJNk5-00069Z-HK
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dJNk5-00069A-8c
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:30:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0928581222
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 17:30:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <877f0lgsxu.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 09 Jun 2017 16:02:37 +0200")
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<877f0lgsxu.fsf@dusky.pond.sub.org>
Reply-To: quintela@redhat.com
Date: Fri, 09 Jun 2017 19:30:32 +0200
Message-ID: <87lgp183wn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] migration: objectify MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Markus Armbruster <armbru@redhat.com> wrote:
> Test compile gripes:
>
>     hw/xen/xen-common.c: In function =E2=80=98xen_init=E2=80=99:
>     hw/xen/xen-common.c:147:5: warning: implicit declaration of function =
=E2=80=98register_compat_prop=E2=80=99 [-Wimplicit-function-declaration]
>          register_compat_prop("migration", "store-global-state", "off");
>          ^~~~~~~~~~~~~~~~~~~~
>     hw/xen/xen-common.c:147:5: warning: nested extern declaration of =E2=
=80=98register_compat_prop=E2=80=99 [-Wnested-externs]
>
> You might want to install Xen development packages to catch such issues
> earlier.
>
> Test run:
>
>     $ qemu-system-x86_64 -device migration,help
>     migration.skip-section-footer=3Dbool
>     migration.store-global-state=3Dbool
>     migration.only-migratable=3Dbool
>     migration.skip-configuration=3Dbool
>
> What would adding this device do?

Parameters, capabilities, options for migration.

This was what we discussed on irc.  We want to have a way to control
migration features that depend on versions.

So we disable new features for old machine types (normal thing that we
do).  But right now, creating such a new feature requires creating a
couple of functions to set/clear the feature, adding includes on the
destination side, etc.

This was supposed to be a global property (or a qemu_opt, or whatever).
Just something that could be enabled/disabled easily on machine types,
and if possible independently of machine types.  This (for instance)
would allow that store-global-state is disabled by defaulte for
machine-2.9 (I forgot the exact name for the machine type), but I can
enable it by hand.  That is very handy for testing.

So, I think that the question is, how/where can we set that kind of
properties?

At least for me, being able to *also* set migration
capabilities/parameters with this mechanism on the command line would be
very nice, for instance

   -global migration.xbzrle on

or

   -global migration.max-speed 2G

I don't care about what is the exact syntax, or where we hang them,
i.e. a new device, a new list, somewhere that already exist.  That is
what we ask for advice.

Thanks for the review and the suggestions.

Later, Juan.
