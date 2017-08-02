Received: from eggs.gnu.org ([2001:4830:134:3::10]:43590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dcp3j-0002ZO-84
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dcp3i-0006lx-10
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:31:15 -0400
References: <20170726120255.14292-1-maozy.fnst@cn.fujitsu.com>
	<20170726120255.14292-5-maozy.fnst@cn.fujitsu.com>
	<20170801130544.GA22017@stefanha-x1.localdomain>
	<87o9rzpdjf.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <ed8b919e-63eb-2ed2-8c55-0a1de0a78ccf@cn.fujitsu.com>
Date: Wed, 2 Aug 2017 15:51:05 +0800
MIME-Version: 1.0
In-Reply-To: <87o9rzpdjf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] hw/block: Fix the return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Hi

On 08/01/2017 10:29 PM, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
>> On Wed, Jul 26, 2017 at 08:02:53PM +0800, Mao Zhongyi wrote:
>>> When the function no success value to transmit, it usually make the
>>> function return void. It has turned out not to be a success, because
>>> it means that the extra local_err variable and error_propagate() will
>>> be needed. It leads to cumbersome code, therefore, transmit success/
>>> failure in the return value is worth.
>>>
>>> So fix the return type of blkconf_apply_backend_options(),
>>> blkconf_geometry() and virtio_blk_data_plane_create() to avoid it.
>>>
>>> Cc: John Snow <jsnow@redhat.com>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>> ---
>>>  hw/block/block.c                | 21 ++++++++++++---------
>>>  hw/block/dataplane/virtio-blk.c | 16 +++++++++-------
>>>  hw/block/dataplane/virtio-blk.h |  6 +++---
>>>  include/hw/block/block.h        | 10 +++++-----
>>>  4 files changed, 29 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/hw/block/block.c b/hw/block/block.c
>>> index 27878d0..717bd0e 100644
>>> --- a/hw/block/block.c
>>> +++ b/hw/block/block.c
>>> @@ -51,8 +51,8 @@ void blkconf_blocksizes(BlockConf *conf)
>>>      }
>>>  }
>>>
>>> -void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>>> -                                   bool resizable, Error **errp)
>>> +int blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>>> +                                  bool resizable, Error **errp)
>>
>> I'm not a fan of these changes because it makes inconsistencies between
>> the return value and the errp argument possible (e.g. returning success
>> but setting errp, or returning failure without setting errp).
>
> Opinions and practice vary on this one, and we've discussed the
> tradeoffs a few times.
>
> Having both an Error parameter and an error return value poses the
> question whether the two agree.  When there's no success value to
> transmit, you avoid the problem by making the function return void.  The
> problem remains for all the function that return a value on success, and
> therefore must return some error value on failure.  A related problem
> even remains for functions returning void: consistency between side
> effects and the Error parameter.
>
> Returning void leads to awkward boilerplate:
>
>     Error err = NULL;
>
>     foo(..., err);
>     if (err) {
>         error_propagate(errp, err);
>         ... bail out ...
>     }
>
> Compare:
>
>     if (!foo(..., errp)) {
>         ... bail out ...
>     }
>
> Much easier on the eyes.
>
> For what it's worth, GLib wants you to transmit success / failure in the
> return value, too:
>
> https://developer.gnome.org/glib/unstable/glib-Error-Reporting.html#gerror-rules
>
> Plenty of older code returns void, some newer code doesn't, because
> returning void is just too awkward.  We willfully deviated from GLib's
> convention, and we're now paying the price.
>
> See also
> Subject: Re: [RFC 00/15] Error API: Flag errors in *errp even if errors are being ignored
> Message-ID: <87o9t8qy7d.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06191.html
>
>> If you really want to do this please use bool as the return type instead
>> of int.  int can be abused to return error information that should
>> really be in the Error object.
>
> For what it's worth, GLib wants bool[*].  Let's stick to that unless we
> have a compelling reason to differ.
>
>
> [*] Except being GLib, it wants its very own homemade version of bool.
> Which is inferior to stdbool.h's in pretty much every conceivable way.
>

Thanks for pointing that out！
I will use bool as the return type instead of int.

Thanks,
Mao
