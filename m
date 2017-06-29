Received: from eggs.gnu.org ([2001:4830:134:3::10]:55528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQPGv-0001V6-5E
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 22:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQPGs-0006Ht-3A
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 22:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQPGr-0006H4-Tq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 22:33:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A8B03DEE4
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 02:33:28 +0000 (UTC)
Date: Thu, 29 Jun 2017 10:33:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170629023323.GA32268@pxdev.xzpeter.org>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-7-git-send-email-peterx@redhat.com>
	<20170628191357.GO12152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170628191357.GO12152@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 06/10] migration: move only_migratable
 to MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jun 28, 2017 at 04:13:57PM -0300, Eduardo Habkost wrote:
> On Tue, Jun 27, 2017 at 12:10:15PM +0800, Peter Xu wrote:
> > One less global variable, and it does only matter with migration.
> > 
> > We keep the old "--only-migratable" option, but also now we support:
> > 
> >   -global migration.only-migratable=true
> > 
> > Currently still keep the old interface.
> > 
> > Hmm, now vl.c has no way to access migrate_get_current(). Export a
> > function for it to setup only_migratable.
> > 
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> [...]
> > +void migration_only_migratable_set(void)
> > +{
> > +    migrate_get_current()->only_migratable = true;
> > +}
> > +
> [...]
> > @@ -3953,7 +3952,13 @@ int main(int argc, char **argv, char **envp)
> >                  incoming = optarg;
> >                  break;
> >              case QEMU_OPTION_only_migratable:
> > -                only_migratable = 1;
> > +                /*
> > +                 * TODO: we can remove this option one day, and we
> > +                 * should all use:
> > +                 *
> > +                 * "-global migration.only-migratable=true"
> > +                 */
> > +                migration_only_migratable_set();
> 
> This triggers a premature call to migrate_get_current():
> 
>   $ qemu-system-x86_64 -only-migratable
>   qemu-system-x86_64: /home/ehabkost/rh/proj/virt/qemu/migration/migration.c:127: migrate_get_current: Assertion `current_migration' failed.
>   Aborted (core dumped)
> 
> What about just doing:
> 
>     qemu_global_option("migration.only-migratable=true");

Oops... Definitely. Thanks for pointing this out! I'll see whether I
should respin or fix on top.

-- 
Peter Xu
