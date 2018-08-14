Received: from eggs.gnu.org ([2001:4830:134:3::10]:60036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpXoa-00067h-Hp
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpXoW-00011P-Kb
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:48:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180814111442.GH5025@dhcp-200-186.str.redhat.com>
References: <cover.1530270904.git.berto@igalia.com>
	<0ac388e86dec1afbff4b5e4e6ade1f1fb7b2d7ff.1530270904.git.berto@igalia.com>
	<20180814091750.GF5025@dhcp-200-186.str.redhat.com>
	<w51zhxpnrt8.fsf@maestria.local.igalia.com>
	<20180814111442.GH5025@dhcp-200-186.str.redhat.com>
Date: Tue, 14 Aug 2018 13:48:02 +0200
Message-ID: <w51wostnp8t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/5] block: Simplify append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 14 Aug 2018 01:14:42 PM CEST, Kevin Wolf wrote:
>> The main difference is that if you set backing.node-name=foo then it
>> means that 'node-name=foo' is an option of the child, the option
>> doesn't belong in the parent at all. So once it's transferred to the
>> child there's no reason why it shoud remain in the parent. It's
>> redundant and can interfere with the reopen operation (e.g. you
>> change the option in the child but when you reopen the parent it will
>> try to revert the child option to the previous value).
>
> That's a rather reopen-centric point of view, though.
>
> Redundant information isn't nice already, but what really makes it a
> problem is that it's potentially incorrect information because it
> isn't kept up to date. There is no point in keeping incorrect
> information, so I agree that deleting it is best.

Yes, it's indeed reopen-centric :-) I agree with you though, the reopen
problem is a practical example of the consequences of keeping both
options, but the main problem is that they can be different and
therefore wrong.

>> In the case of 'backing=foo' that's clearly an option of the parent,
>> there's no other place to put it. We could probably remove it as
>> well, but we have to see carefully that no parent needs to keep that
>> information. I think we want to keep child references because in
>> general we don't allow them to be changed in reopen.
>> 
>> Example: you cannot pass 'file=bar' on reopen unless 'bar' was
>> already the existing value of 'file' (i.e. you're not changing
>> anything). We need to look for the previous value in bs->options in
>> order to know that.
>
> My point is the backing=foo has the same problem: Storing it in
> bs->options is not only redundant, but potentially incorrect because
> we never update it when we modify the graph. There is no point in
> keeping potentially incorrect information.

I tend to agree, but there's one reason why it's not exactly the same
case: with "backing=foo" we know not only that the backing node name is
'foo', but that it was added using a reference rather than with
backing.node-name=foo. I'm not sure if that's information that we need
for anything, however (probably not).

> When you actually use that incorrect information, you've got a bug.
> Reopen with file=bar doesn't have to check whether 'file=bar' is in
> bs->options (because that may be outdated information), but whether
> the BdrvChild with the name 'file' points to a node called 'bar'.

Again, this is correct if we open the BDS with

  file.node-name=bar

and then we allow reopening it with

  file=bar

Different set of options, but the result still makes sense. For this we
need a specific check to verify that this is correct. For the current
behavior we don't need anything now: we only allow the exact same
option.

>> After x-blockdev-reopen is ready, 'backing' will perhaps be the
>> first/only exception, because we'll be able to change it and the
>> previous value doesn't matter.
>
> I certainly hope that it will not be the only kind of node references
> that you can change. Adding/removing filter nodes requires to be able
> to change more or less any kind of node references. But we'll see.

No, but anything that we allow changing has to be done on a case-by-case
basis. You can't simply allow changing any child reference, the specific
driver has to be modified in order to allow that.

Until the driver is changed, the current behavior prevails: if an option
was modified, we return an error.

Berto
