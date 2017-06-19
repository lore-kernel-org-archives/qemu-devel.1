Received: from eggs.gnu.org ([2001:4830:134:3::10]:42023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dMsVt-0000yh-6m
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dMsVq-0003iE-3G
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dMsVp-0003hx-TQ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:58:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C399F4E4C8
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 08:58:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<877f0lgsxu.fsf@dusky.pond.sub.org>
	<20170612072416.GA12928@pxdev.xzpeter.org>
Date: Mon, 19 Jun 2017 10:58:17 +0200
In-Reply-To: <20170612072416.GA12928@pxdev.xzpeter.org> (Peter Xu's message of
	"Mon, 12 Jun 2017 15:24:16 +0800")
Message-ID: <877f08qrpy.fsf@dusky.pond.sub.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jun 09, 2017 at 04:02:37PM +0200, Markus Armbruster wrote:
>> Test compile gripes:
>>=20
>>     hw/xen/xen-common.c: In function =E2=80=98xen_init=E2=80=99:
>>     hw/xen/xen-common.c:147:5: warning: implicit declaration of function=
 =E2=80=98register_compat_prop=E2=80=99 [-Wimplicit-function-declaration]
>>          register_compat_prop("migration", "store-global-state", "off");
>>          ^~~~~~~~~~~~~~~~~~~~
>>     hw/xen/xen-common.c:147:5: warning: nested extern declaration of =E2=
=80=98register_compat_prop=E2=80=99 [-Wnested-externs]
>>=20
>> You might want to install Xen development packages to catch such issues
>> earlier.
>
> Sorry I have missed to check that. I'll definitely verify this in the
> following up posts.
>
>>=20
>> Test run:
>>=20
>>     $ qemu-system-x86_64 -device migration,help
>>     migration.skip-section-footer=3Dbool
>>     migration.store-global-state=3Dbool
>>     migration.only-migratable=3Dbool
>>     migration.skip-configuration=3Dbool
>>=20
>> What would adding this device do?
>
> Hmm, the same answer in the other thread - I may need the compat bits
> and "-global", so I am using QDev for migration, not only QObject.
>
> Haven't investigate how difficult would it be to move these features
> from QDev into QObject.  For now, do you think user_creatable=3Dfalse an
> workable solution for this? We'll still see this help for sure, but at
> least we won't be able to create the device using "-device migration",
> also we won't see the migration entry in "-device help".

Hacks that aren't exposed in external interfaces can be tolerable.  In
particular when we have concrete ideas on how to get rid of them later
on.

Don't worry about visibility in "-device migration,help".
