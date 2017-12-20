Received: from eggs.gnu.org ([2001:4830:134:3::10]:40404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRcay-0002iE-Ll
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRcat-0006ha-1X
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:31:32 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRcas-0006gw-QR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:31:26 -0500
Received: by mail-wr0-f193.google.com with SMTP id l19so9640506wrc.2
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 03:31:26 -0800 (PST)
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-17-kwolf@redhat.com>
	<974e7f62-412a-21e8-d502-a0e7a99015cc@redhat.com>
	<20171220111822.GA6374@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09b75421-21f1-5e9e-8f2e-c9189ab207eb@redhat.com>
Date: Wed, 20 Dec 2017 12:31:22 +0100
MIME-Version: 1.0
In-Reply-To: <20171220111822.GA6374@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/19] block: Allow graph
 changes in subtree drained section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 20/12/2017 12:18, Kevin Wolf wrote:
> Am 20.12.2017 um 11:51 hat Paolo Bonzini geschrieben:
>> On 20/12/2017 11:34, Kevin Wolf wrote:
>>>      .inherit_options = bdrv_inherited_options,
>>>      .drained_begin   = bdrv_child_cb_drained_begin,
>>>      .drained_end     = bdrv_child_cb_drained_end,
>>> +    .attach          = bdrv_child_cb_attach,
>>> +    .detach          = bdrv_child_cb_detach,
>>>      .inactivate      = bdrv_child_cb_inactivate,
>>>  };
>>>  
>>> @@ -911,6 +933,8 @@ const BdrvChildRole child_format = {
>>>      .inherit_options = bdrv_inherited_fmt_options,
>>>      .drained_begin   = bdrv_child_cb_drained_begin,
>>>      .drained_end     = bdrv_child_cb_drained_end,
>>> +    .attach          = bdrv_child_cb_attach,
>>> +    .detach          = bdrv_child_cb_detach,
>>>      .inactivate      = bdrv_child_cb_inactivate,
>>
>> Is there any case of a BdrvChildRole that doesn't want these callbacks?
>> Maybe the functions should be called after ->attach and before ->detach
>> (e.g. bdrv_{,un}apply_subtree_drain), rather than modifying the
>> BdrvChildRole implementations.
> 
> At first I intended to implement it directly in
> bdrv_replace_child_noperm(), but the thing is that you need the
> bs->recursive_quiesce_counter of the parent BDS - but not all parents of
> a BdrvChild are even a BDS. It could also be a BB root child or a block
> job child. This is why we only have a void *opaque rather than a BDS
> pointer for the parent.
> 
> The other option would be an additional BdrvChildRole callback like
> .get_recursive_quiesce_counter, but compared to that, I like some code
> in .attach/.detach better.

I see.  What about keeping the callbacks, but exporting

void bdrv_apply_subtree_drain(BlockDriverState *child,
			      BlockDriverState *new_parent);
void bdrv_unapply_subtree_drain(BlockDriverState *child,
			        BlockDriverState *old_parent);

instead of bdrv_do_drained_{begin,end}?

Thanks,

Paolo

>> Then they can be put in block/io.c, and bdrv_do_drained_* can remain
>> static.  (I would also consider extracting block/drain.c, but it is
>> painful to do it now that you have this nice series---so let's do it after).
> 
> I can keep that in mind for part 3 (or 4, whatever it may become).
> 
> Kevin
> 
