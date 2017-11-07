Received: from eggs.gnu.org ([2001:4830:134:3::10]:55721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eC11q-0006GJ-L3
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eC11p-0003P0-LG
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:22:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <8e2160db-338f-f1dc-7f5e-8faa3dce7090@kamp.de>
	<20171017114625.GB7660@dhcp-200-186.str.redhat.com>
	<20171020100853.GF21393@stefanha-x1.localdomain>
Date: Tue, 07 Nov 2017 11:22:33 +0100
In-Reply-To: <20171020100853.GF21393@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 20 Oct 2017 12:08:53 +0200")
Message-ID: <877ev24cd2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] Clean Block Driver Shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Oct 17, 2017 at 01:46:25PM +0200, Kevin Wolf wrote:
>> Am 17.10.2017 um 12:33 hat Peter Lieven geschrieben:
>> > I noticed that Qemu quits at several points with an exit() if the
>> > supplied parameters in the commandline are incorrect. This at some
>> > stages happens after there have already been connections to storage
>> > backends established.
>> 
>> Maybe we need to come to the conclusion that exit() is always wrong,
>> even during the initialisation.
>> 
>> > These connections are not cleanly shut down in this case. For posix
>> > file backends that doesn't matter, but for other backends this leads
>> > to errors. E.g. iSCSI Targets log an aborted iSCSI connection due to
>> > tcp reset.
>> > 
>> > I wonder what is the best way to fix this. A simply call to
>> > bdrv_close_all() in an atexit handler seems to work.  But is this a
>> > good solution? Maybe register this handler only until the VM starts.
>> > Or do we need an atexit handler in each block driver that requires a
>> > clean shutdown?
>> 
>> No, definitely not code in every single block driver. We need to make
>> sure to properly clean up what has been started.
>> 
>> An atexit handler is probably relatively easy. I think it would be
>> cleaner to have proper error paths even in main(), like in every other
>> function. I'm not sure if this would be reasonably easy to achieve,
>> though.
>
> I agree that converting from exit(3) to real error handling is cleanest.
> Doing so would also be a good opportunity to consolidate ad-hoc
> fprintf(stderr) and error_report() calls.

error_report() & exit() assume a certain context.  They're good enough
when the assumption obviously holds.

We also use them in code that can run when the assumption doesn't hold.
Sometimes because the code acquired new users, sometimes because the
code was always wrong.  Regardless, these are bugs in need of fixing.

We also use them in code that currently happens to run only when the
assumption holds.  Trap for the unwary, cleanup can make sense, but is
hardly a priority.
