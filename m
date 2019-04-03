Received: from eggs.gnu.org ([209.51.188.92]:59445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBcUp-0002ad-Qc
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hBcUo-0000Ii-KM
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hBcUo-0000Ft-Cx
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:47:50 -0400
Date: Wed, 3 Apr 2019 10:47:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190403094741.GN25150@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190325101556.30227-1-yury-kotov@yandex-team.ru>
	<87y3539no9.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3539no9.fsf@trasno.org>
Subject: Re: [Qemu-devel] [PATCH] hostmem: Disable add/del memory during
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Yury Kotov <yury-kotov@yandex-team.ru>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Igor Mammedov <imammedo@redhat.com>, wrfsh@yandex-team.ru, zhanghailiang <zhang.zhanghailiang@huawei.com>

On Mon, Mar 25, 2019 at 12:52:06PM +0100, Juan Quintela wrote:
> Yury Kotov <yury-kotov@yandex-team.ru> wrote:
> > I found a bug in QEMU 2.12 with adding memory-backend while live migration
> > thread is running.
> >
> > But it seems that this bug was implicitly fixed in this commit (QEMU 3.0):
> >   b895de50: migration: discard non-migratable RAMBlocks
> >
> > I think it's better to disallow add/del memory backends during migration to
> > to prevent other possible problems. Anyway, user can't use this memory because
> > of disabled hotplug/hotunplug devs.
> 
> Hi
> 
> My understanding is that we already disable memory hotplug/unplug during
> migration. At least, the idea of those patches was to disable all
> hotplug/unplug during migration.  The only reason that I can think for
> using this patch is if anyone is planning about support some
> hotplug/upplug during migration (to my knowledge, nobody is working on
> that).
> 
> So, I think it is better to just disallow on high level all hoplug
> operations, instead of in all backends.
> 
> But will wait to see what everybody else think about it.

FWIW, libvirt already rejects any API call that would change guest
ABI while migration is taking place, which covers any hotplug or
hotunplug operation for devices or memory or anything else.

In fact libvirt whitelist which QMP commands it is willing to allow
during migration to only those which it knows are going to be safe
to use.  Libvirt's whitelist is quite narrow since there are many
QMP command it'll never run at any time.

> BTW,   if we plan to ship this for an old qemu, I will try to disable
> hotplug for all devices, not only memory, no?

Perhaps QMP could have some concept of a dynamic whitelist of commands,
so at start of migration, migration code would register a whitelist with
QMP, so it would reject everything else upfront. This would avoid needing
to put migration checks into every QMP command handler that can cause
problems ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
