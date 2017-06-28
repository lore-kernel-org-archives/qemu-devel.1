Received: from eggs.gnu.org ([2001:4830:134:3::10]:37531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQF1o-0000f5-QA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dQF1k-0000vi-Mw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dQF1k-0000vC-GA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:37:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5DDC3B73E
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 15:37:09 +0000 (UTC)
Date: Wed, 28 Jun 2017 12:37:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170628153704.GF12152@localhost.localdomain>
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498634144-26508-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498634144-26508-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 11/10] migration: add comment for
 TYPE_MIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, eblake@redhat.com, armbru@redhat.com, quintela@redhat.com, dgilbert@redhat.com

On Wed, Jun 28, 2017 at 03:15:44PM +0800, Peter Xu wrote:
> It'll be strange that the migration object inherits TYPE_DEVICE. Add
> some explanations to it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b1b0825..2398a9d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2046,6 +2046,14 @@ static void migration_instance_init(Object *obj)
>  
>  static const TypeInfo migration_type = {
>      .name = TYPE_MIGRATION,
> +    /*
> +     * NOTE: "migration" itself is not really a device. We used

I suggest extending this as:

  TYPE_MIGRATION is not really a device, as the object is not created
  using qdev_create(), it is not attached to the qdev device tree, and
  it is never realized.


> +     * TYPE_DEVICE here only to leverage some existing QDev features
> +     * like "-global" properties, and HW_COMPAT_* fields (which are
> +     * finally applied as global properties as well). If one day the
> +     * global property feature can be migrated from QDev to QObject in
> +     * general, then we can switch to QObject as well.
> +     */

QOM objects (qom/object.h) are not QObject (qapi/qmp/qobject.h).  People
often confuse them with each other.  (It probably doesn't help that both
are described as "QEMU Object Model" at their headers.)

I suggest rewriting it as:

  If one day we allow non-device QOM objects to use the global property
  system, we can switch this from TYPE_DEVICE to TYPE_OBJECT."


>      .parent = TYPE_DEVICE,
>      .class_init = migration_class_init,
>      .class_size = sizeof(MigrationClass),
> -- 
> 2.7.4
> 

-- 
Eduardo
