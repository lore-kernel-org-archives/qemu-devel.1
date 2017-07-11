Received: from eggs.gnu.org ([2001:4830:134:3::10]:56292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUqG9-0007UC-Fg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUqG8-0007Pl-A1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:11:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170710193047.z2t6eww7nhckgg3z@postretch>
Date: Tue, 11 Jul 2017 10:10:56 +0200
In-Reply-To: <20170710193047.z2t6eww7nhckgg3z@postretch> (Manos
	Pitsidianakis's message of "Mon, 10 Jul 2017 22:30:47 +0300")
Message-ID: <87d197mm0f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v14 15/21] qom: support non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, afaerber@suse.de, berrange@redhat.com

Manos Pitsidianakis <el13635@mail.ntua.gr> writes:

> Is there a specific reason this patch wasn't finished? If I'm not
> wrong using non-scalar properties with -object is still not possible,
> yet would be a very useful feature for drivers with UserCreatable
> objects.
>
> Archive link since this is an old patch:
> https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg08252.html

Yes, we want non-scalar properties with -object.

This series attempts to provide them by extending QemuOpts.  The trouble
is that we've already pushed QemuOpts beyond its design limits, and this
series pushes it some more.  We need to stop working around the design
limits of QemuOpts and start replacing them by something that serves our
current needs, as I explained in:

    Subject: Re: [PATCH v14 00/19] QAPI/QOM work for non-scalar object properties
    Message-ID: <87vawnnjpi.fsf@dusky.pond.sub.org>
    https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04895.html

I started the replacement work (merge commit 8746709).  It provides
non-scalar properties for -blockdev.  I stole Dan's PATCH 07 for it,
which became commit cbd8acf.  See also the design thread

    Subject: Non-flat command line option argument syntax
    Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
    https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html

PATCH 02-06 have been merged separately (merge commit ede0cbe).

More work is needed to apply the solution for -blockdev to -object, and
I intend to work on it.  A main difficulty is backwards compatibility to
all the ill-designed / accidental QemuOpts warts.  We may have to accept
some incompatibility to make progress.
