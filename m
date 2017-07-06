Received: from eggs.gnu.org ([2001:4830:134:3::10]:48127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT81R-0005JA-Qx
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT81Q-0001f0-VH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT81Q-0001eS-Li
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:44:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499276048.git.alistair.francis@xilinx.com>
	<2c9645b5dce991f7a324dc2b61e2553e08230a9f.1499276048.git.alistair.francis@xilinx.com>
	<87r2xuay5h.fsf@dusky.pond.sub.org> <20170706080741.GB3988@redhat.com>
	<87lgo14xgs.fsf@dusky.pond.sub.org> <20170706114509.GL3988@redhat.com>
	<87lgo1lpss.fsf@dusky.pond.sub.org> <20170706131028.GM3988@redhat.com>
Date: Thu, 06 Jul 2017 16:44:45 +0200
In-Reply-To: <20170706131028.GM3988@redhat.com> (Daniel P. Berrange's message
	of "Thu, 6 Jul 2017 14:10:28 +0100")
Message-ID: <877ezliq02.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v3 2/3] qemu-error: Implement a more generic
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net, Alistair Francis <alistair.francis@xilinx.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Thu, Jul 06, 2017 at 02:20:51PM +0200, Markus Armbruster wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>> 
>> > On Thu, Jul 06, 2017 at 01:27:15PM +0200, Markus Armbruster wrote:
>> >> "Daniel P. Berrange" <berrange@redhat.com> writes:
[...]
>> >> > Do we really need to care about compatibility of the precise way we output
>> >> > error messages. It has never been something we call a "stable API", as we
>> >> > don't guarantee error message text will remain the same across releases. So
>> >> > anyone relying on scraping QEMU stderr to match some error message has always
>> >> > been liable to break.
>> >> >
>> >> > IOW, just add an "error: " prefix to the text
>> >> 
>> >> I agree the error message format isn't ABI.
>> >> 
>> >> But what would adding "error: " buy us?
>> >
>> > It would clearly distinguish errors from any other output on stderr, which
>> > may not be error related (for example SPICE commonly pollutes stderr with
>> > lots of messages).
>> 
>> Changing the current error message format
>> 
>>     <TIMESTAMP><PROGNAME>:<LOCATION><MSG>
>> 
>> to
>> 
>>     <TIMESTAMP><PROGNAME>:<LOCATION>error: <MSG>
>> 
>> makes recognizing error messages a bit easier, but it also makes them
>> even longer.  Can't we make do with recognizing <PROGNAME>:?
>
> I'm not convinced 7 extra characters is a big deal compared with the
> size of the timestamps, program name, location & error message itself.
> We'll already have such a prefix for info & warnings, so consistency is
> good IMHO.

I don't see the value of consistency here.  What matters is whether
errors are easy to spot and recognize.

GCC doesn't put "error:" into its error messages.  Clang does.  Feels
like a matter of taste to me.

If adding "error:" solves a problem people have, let's do it.  If not, I
don't see why we should change what we have.

> If line length is a concern, perhaps we should make the error printing
> function able to intelligently line wrap at 80 chars, taking into account
> the size of the metadata (timestamp, program, location, msg type prefix).

Uh, that cure feels worse than the disease :)
