Received: from eggs.gnu.org ([2001:4830:134:3::10]:36811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpki-0004AH-Aa
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpkh-0002i9-6i
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:51:08 -0500
References: <cover.1543590618.git.berto@igalia.com>
	<19f8c53d020fa7b71b5e129791bb556b4678f468.1543590618.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac477bbd-a984-42f4-13cc-e1e555cde952@redhat.com>
Date: Fri, 30 Nov 2018 14:50:56 -0600
MIME-Version: 1.0
In-Reply-To: <19f8c53d020fa7b71b5e129791bb556b4678f468.1543590618.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/12] block: Add an
 'x-blockdev-reopen' QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/30/18 9:17 AM, Alberto Garcia wrote:
> This command allows reopening an arbitrary BlockDriverState with a
> new set of options. Some options (e.g node-name) cannot be changed
> and some block drivers don't allow reopening, but otherwise this
> command is modelled after 'blockdev-add' and the state of the reopened
> BlockDriverState should generally be the same as if it had just been
> added by 'blockdev-add' with the same set of options.
> 
> One notable exception is the 'backing' option: 'x-blockdev-reopen'
> requires that it is always present unless the BlockDriverState in
> question doesn't have a current or default backing file.
> 
> This command allows reconfiguring the graph by using the appropriate
> options to change the children of a node. At the moment it's possible
> to change a backing file by setting the 'backing' option to the name
> of the new node, but it should also be possible to add a similar
> functionality to other block drivers (e.g. Quorum, blkverify).
> 
> Although the API is unlikely to change, this command is marked
> experimental for the time being so there's room to see if the
> semantics need changes.
> 

> +++ b/qapi/block-core.json
> @@ -3808,6 +3808,48 @@
>   { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
>   
>   ##
> +# @x-blockdev-reopen:
> +#
> +# Reopens a block device using the given set of options. Any option
> +# not specified will be reset to its default value regardless of its
> +# previous status. If an option cannot be changed or a particular
> +# driver does not support reopening then the command will return an
> +# error.

Possible alternative implementation (although it would be a major 
rewrite of this series) - if EVERY option has a counterpart OptionOrNull 
alternate type, you could use omitting the option to mean 'leave the 
option's current value unchanged', "option":null to mean 'reset the 
option to its default state', and "option":"value" to change the option 
to value.

So, what happens when a newer qemu version adds a new option field? 
Presumably, the added field is optional (if it were mandatory, it would 
break old clients), and an older client is likely to omit the field.

With your approach, the client omitting the field on reopen is thus 
requesting that the field be reset back to its default state - but since 
the client already omitted the option during open, the field is already 
in its default state, so there is no change.

With my approach, the client omitting the field is thus requesting that 
the field be left alone - but since the client already omitted the 
option during open, the field is already in its default state.

So either approach should work, and yours seems simpler (at least, less 
invasive to adding new QAPI FooOrNull alternates).

> +#
> +# The top-level @node-name option (from BlockdevOptions) must be
> +# specified and is used to select the block device to be reopened.
> +# Other @node-name options must be either omitted or set to the
> +# current name of the appropriate node. This command won't change any
> +# node name and any attempt to do it will result in an error.
> +#
> +# In the case of options that refer to child nodes, the behavior of
> +# this command depends on the value:
> +#
> +#  1) A set of options (BlockdevOptions): the child is reopened with
> +#     the specified set of options.
> +#
> +#  2) A reference to the current child: the child is reopened using
> +#     its existing set of options.
> +#
> +#  3) A reference to a different node: the current child is replaced
> +#     with the specified one.
> +#
> +#  4) NULL: the current child (if any) is detached.
> +#
> +# Options (1) and (2) are supported in all cases, but at the moment
> +# only @backing allows replacing or detaching an existing child.
> +#
> +# Unlike with blockdev-add, the @backing option must always be present
> +# unless the node being reopened does not have a backing file and its
> +# image does not have a default backing file name as part of its
> +# metadata.
> +#
> +# Since: 3.2
> +##
> +{ 'command': 'x-blockdev-reopen',
> +  'data': 'BlockdevOptions', 'boxed': true }

Looks reasonable to me.  Also a wise decision to keep the x- prefix 
while we play with it, in case we change something.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
