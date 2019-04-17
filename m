Received: from eggs.gnu.org ([209.51.188.92]:53691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGpHp-0007q5-ET
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGpHn-0004qa-VY
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hGpHn-0004pR-EO
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:27:55 -0400
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
	<00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
	<20190417071012.fxedabu3makmoyuz@sirius.home.kraxel.org>
	<993002d4-28dd-00f0-e8c1-7b0d9ab2de12@durchholz.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4ce336d0-6651-286f-07ee-3a5b3236309a@redhat.com>
Date: Wed, 17 Apr 2019 20:27:51 +0200
MIME-Version: 1.0
In-Reply-To: <993002d4-28dd-00f0-e8c1-7b0d9ab2de12@durchholz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joachim Durchholz <jo@durchholz.org>, qemu-devel@nongnu.org

Hi Joachim,

On 04/17/19 19:09, Joachim Durchholz wrote:
> Sorry, I'm done having to argue against(!) a person who's stonewalling
> me by wilfully ignoring differences ("doesn't work perfectly"
> interpreted as "does not work at all"), discounting
> just-for-testing-purpose workarounds as if they were actual proposed
> solutions ("not a sane approach"), ignoring the use case (still
> insisting on terminal size mutability), and proposing a nonworking
> solution (-nographic does not give me any output, of course because it
> doesn't have a terminal to talk to).

you use the word "solution" twice above, but in this thread, I haven't
seen a problem statement from you.

What is the end goal you're trying to achieve?

The source file "ui/curses.c" carries the following comment at the top:

  QEMU curses/ncurses display driver

It is a display backend that is based on Curses.

Curses -- in its originally standardized form, XCURSES -- is an
interface specification for manipulating terminals. Please see:

  https://pubs.opengroup.org/onlinepubs/7908799/xcurses/intov.html

It writes:

    [...] a comprehensive API lets the application perform terminal
    operations. The Curses run-time system receives each terminal
    request and sends appropriate commands to the terminal to achieve
    the desired effect. [...]  Applications using Curses should not also
    control the terminal using capabilities of the general terminal
    interface defined in the XBD specification, General Terminal
    Interface. [...]

(I sent the link to the General Terminal Interface earlier.)

So, let's look at your original question again (which was not a problem
statement):

> what's the reasoning behind "We need a terminal output" in curses.c?

The reasoning is that "curses.c" is a QEMU display backend written in
terms of the Curses [XCURSES] interface specification, and that
interface specification is inherently based on terminals, as defined by
the General Terminal Interface of the Single Unix Specification. (BTW
SUS and POSIX have merged into one set of specs at SUSv3.)

If you tell us what you want to achieve in the end (i.e. you state the
problem), maybe we can tell you what to use *instead of* "ui/curses.c",
as the QEMU display backend. We might also be able to suggest ways to
use "ui/curses.c", so that it give you what you need.


Let me speculate a bit. You mentioned wanting to connect "ui/curses.c"
to a pipe, possibly to transfer the output elsewhere. This is a common
use case -- it's what terminal emulators such as "xterm" do, also what
"ssh" does (when you log in interactively with it). "screen" and "tmux"
are other programs in this class.

The way they all work is, they set up a pseudo-terminal (pty). The pty
has a master end and a slave end. The slave end looks like a real
terminal and provides the General Terminal Interface -- so "ui/curses.c"
would consume that. The kernel driver for pseudo-terminals provides all
the necessary terminal features. On the master end, you get a file
descriptor to a bidirectional stream (similar to a unix domain stream
socket). The various terminal emulators (xterm, ssh, screen, tmux) read
and write the master end, and perform various stuff on the data received
(e.g. "screen" passes the data for display to the other screen process
for display, if there is such an "other" screen process; xterm draws the
characters, clears the screen, changes colors, and beeps; sshd encrypts
the data, transfers it over the network, ssh decrypts the data and
writes it to the local *slave* end; and so on).

One interface to check here is posix_openpt():

http://pubs.opengroup.org/onlinepubs/9699919799/functions/posix_openpt.html

What's important here is that the translation between the master end and
the slave end is *thick*. For example, assuming appropriate settings, if
you write the appropriate character ("INTR") to the master-end file
descriptor, the program for which the slave-end is the "controlling
terminal" -- another term to look up in POSIX -- will get a SIGINT. This
translation (i.e. the raising of SIGINT) is done by the kernel's
pseudo-terminal (pty) driver. This is what happens e.g. when you press
"Ctrl-C" in xterm.

Anyway, you mentioned "pexpect":

https://pexpect.readthedocs.io/en/stable/

"pexpect" is a python facility for automating interactions with programs
that require a terminal (such as the QEMU display backend
"ui/curses.c"). I don't know "pexpect"'s internals, but it will
*unavoidably* have to use a pseudo-terminal.

I think that, if you need "just a pipe", you can satisfy "ui/curses.c"'s
need for a terminal by giving it a slave terminal device with "pexpect".
Then you can read the master-end (pexpect should let you do that as
well) -- the master-end will indeed read similarly to pipe. Just be
aware that all the terminal output goo, such as cursor positioning,
color change sequences, beeps, screen resolution changes, etc, will show
up as binary garbage in the stream.

Thanks
Laszlo
