Received: from eggs.gnu.org ([2001:4830:134:3::10]:44852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpFfM-0002qe-7G
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpFfH-0006Le-9p
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:21:28 -0400
Date: Tue, 5 Sep 2017 17:21:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905152107.GN4633@localhost.localdomain>
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-5-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132028.6184-5-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v9 4/6] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 25.08.2017 um 15:20 hat Manos Pitsidianakis geschrieben:
> ThrottleGroup is converted to an object. This will allow the future
> throttle block filter drive easy creation and configuration of throttle
> groups in QMP and cli.
> 
> A new QAPI struct, ThrottleLimits, is introduced to provide a shared
> struct for all throttle configuration needs in QMP.
> 
> ThrottleGroups can be created via CLI as
>     -object throttle-group,id=foo,x-iops-total=100,x-..
> where x-* are individual limit properties. Since we can't add non-scalar
> properties in -object this interface must be used instead. However,
> setting these properties must be disabled after initialization because
> certain combinations of limits are forbidden and thus configuration
> changes should be done in one transaction. The individual properties
> will go away when support for non-scalar values in CLI is implemented
> and thus are marked as experimental.
> 
> ThrottleGroup also has a `limits` property that uses the ThrottleLimits
> struct.  It can be used to create ThrottleGroups or set the
> configuration in existing groups as follows:
> 
> { "execute": "object-add",
>   "arguments": {
>     "qom-type": "throttle-group",
>     "id": "foo",
>     "props" : {
>       "limits": {
>           "iops-total": 100
>       }
>     }
>   }
> }
> { "execute" : "qom-set",
>     "arguments" : {
>         "path" : "foo",
>         "property" : "limits",
>         "value" : {
>             "iops-total" : 99
>         }
>     }
> }
> 
> This also means a group's configuration can be fetched with qom-get.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

> +static bool throttle_group_can_be_deleted(UserCreatable *uc, Error **errp)
> +{
> +    return OBJECT(uc)->ref == 1;
> +}
> +
> +static void throttle_group_obj_class_init(ObjectClass *klass, void *class_data)
> +{
> +    size_t i = 0;
> +    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
> +
> +    ucc->complete = throttle_group_obj_complete;
> +    ucc->can_be_deleted = throttle_group_can_be_deleted;

block/throttle-groups.c: In function 'throttle_group_obj_class_init':
block/throttle-groups.c:880:25: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
     ucc->can_be_deleted = throttle_group_can_be_deleted;

This is from a semantic conflict with commit 3beacfb9 ('qom: Remove
unused errp parameter from can_be_deleted()'). If the rest of the series
is okay, I'll just remove the **errp parameter while applying.

Kevin
