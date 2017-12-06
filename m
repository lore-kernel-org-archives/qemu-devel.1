Received: from eggs.gnu.org ([2001:4830:134:3::10]:38689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMcLL-0002mz-4I
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMcLK-00036a-6n
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:14:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171206115726.5237-1-berrange@redhat.com>
	<171741b3-39b8-7c37-8e07-4a9dd590e4c9@redhat.com>
	<20171206142513.GD18296@redhat.com>
	<f06a9a2f-2f4a-945f-739b-8be9333caf5e@redhat.com>
Date: Wed, 06 Dec 2017 17:14:27 +0100
In-Reply-To: <f06a9a2f-2f4a-945f-739b-8be9333caf5e@redhat.com> (Eric Blake's
	message of "Wed, 6 Dec 2017 08:30:27 -0600")
Message-ID: <87tvx3x28s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 12/06/2017 08:25 AM, Daniel P. Berrange wrote:
>
>>> Should we instead be looking for a match against the current termios()
>>> c_cc[VEOF] setting, in case the user prefers something other than ^D via
>>> stty?  Does readline provide any functionality for automating this?
>> 
>> I was afraid someone was going to suggest doing that. I was being lazy by
>> hardcoding Ctrl-D, but yes the real readline() library will honour the
>> VEOF value.  QEMU though is using a home-grown reimpl of readline...
>
> I understand why we can't use modern libreadline (it is licensed GPLv3+,
> making it impossible to use with our GPLv2-only code) - but doesn't BSD
> have a readline-alike library with BSD licensing that we could use
> instead of implementing readline ourselves?  (Was it named libinput?)

We've discussed this before.  Short story: we can't use the original due
to our foolish licensing mistake, and the clones don't cut the mustard.
Long story:
http://lists.gnu.org/archive/html/qemu-devel/2016-10/msg02697.html
