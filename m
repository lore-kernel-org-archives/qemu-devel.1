Received: from eggs.gnu.org ([2001:4830:134:3::10]:53224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3KEX-0001LD-Ed
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3KES-0005ww-Ht
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3KES-0005wb-Bh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:31:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4013A61D11
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:31:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170426100623.GD16228@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 26 Apr 2017 18:06:23 +0800")
References: <20170425101758.3944-1-quintela@redhat.com>
	<20170425101758.3944-2-quintela@redhat.com>
	<20170426100623.GD16228@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 26 Apr 2017 12:31:32 +0200
Message-ID: <871ssflat7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Move check_migratable()
 into qdev.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Apr 25, 2017 at 12:17:57PM +0200, Juan Quintela wrote:
>> The function is only used once, and nothing else in migration knows
>> about objects.  Create the function vmstate_device_is_migratable() in
>> savem.c that really do the bit that is related with migration.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>
> Here the name vmstate_device_is_migratable() let me think of "return
> true if the device can migrate, false otherwise". However what it
> actually does is mixed with "--only-migratable" parameter, say, when
> without that parameter, all device will be getting "true" here, even
> unmigratable devices...
>
> Not sure whether it'll be nicer we do this:
>
> bool vmstate_device_is_migratable(const VMStateDescription *vmsd)
> {
>     return !(vmsd & vmsd->unmigratable);
> }
>
> Then we can define check_migratable() as:
>
> static int check_migratable(Object *obj, Error **err)
> {
>     DeviceClass *dc = DEVICE_GET_CLASS(obj);
>
>     /* no check needed if --only-migratable not specified */
>     if (!only_migratable) {
>        return true;
>     }
>
>     if (!vmstate_device_is_migratable(dc->vmsd)) {
>         error_setg(err, "Device %s is not migratable, but "
>                    "--only-migratable was specified",
>                    object_get_typename(obj));
>         return -1;
>     }
>
>     return 0;
> }
>
> Thanks,

I see your point.  We have to teach things about migrate to qdev.c or
things about objects to migration.

Will change.

Thanks, Juan.
