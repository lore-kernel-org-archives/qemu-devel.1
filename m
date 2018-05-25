Received: from eggs.gnu.org ([2001:4830:134:3::10]:42993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fM5T9-00015v-1W
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fM5T5-0007Fo-Uu
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:40:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fM5T5-0007Fb-Qo
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:40:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1527176250-178968-1-git-send-email-mst@redhat.com>
	<d0edcb79-3dae-c3a5-f9f4-50b3062f8cff@redhat.com>
	<70262dde-3b96-b650-f0fb-8143e869c4ab@redhat.com>
	<20180524190123-mutt-send-email-mst@kernel.org>
	<6492471e-f8a7-5f5b-9cf9-95cb604f203a@redhat.com>
	<20180524211726-mutt-send-email-mst@kernel.org>
Date: Fri, 25 May 2018 07:40:43 +0200
In-Reply-To: <20180524211726-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Thu, 24 May 2018 21:20:00 +0300")
Message-ID: <87efi0xpgk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/1] libqtest: add more exit status
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, May 24, 2018 at 01:16:24PM -0500, Eric Blake wrote:
>> On 05/24/2018 11:01 AM, Michael S. Tsirkin wrote:
>> > On Thu, May 24, 2018 at 11:00:19AM -0500, Eric Blake wrote:
>> > > On 05/24/2018 10:52 AM, Eric Blake wrote:
>> > > 
>> > > > Also, since waitpid() can only return either s->qemu_pid or -1 as we
>> > > > aren't using WNOHANG, it may also be worth asserting that if pid == -1,
>> > > > we either have EAGAIN (but why aren't we looping in that case?) or
>> > > > ECHILD.
>> > > 
>> > > I meant EINTR, not EAGAIN.  But in general, using waitpid() to collect
>> > > process status without doing it in a loop is risky.
>> > 
>> > Interesting. Risky how?
>> 
>> If your process has any signal handler installed, then an EINTR failure
>> means you interpret a transient failure to grab process status (because your
>> check was interrupted by something else) as a permanent failure, unless you
>> go back to another waitpid() in a loop.
>
> I don't think we have a handler installed, though.

That's a nasty assumption to make for a library.
