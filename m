Received: from eggs.gnu.org ([2001:4830:134:3::10]:50626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1cYEdE-00010I-Ft
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brak@gameservers.com>) id 1cYEd9-0003pu-Ja
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:16:40 -0500
Received: from mail2015.choopa.net ([208.167.225.251]:19930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brak@gameservers.com>)
	id 1cYEd9-0003ou-Dt
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:16:35 -0500
References: <b44e4a5f-cdc0-f5fd-a25e-f2d5e711d57c@gameservers.com>
	<20170127093538.GA26553@redhat.com> <20170127180820.GA6273@redhat.com>
	<20170130105147.GF27325@redhat.com>
From: Brian Rak <brak@gameservers.com>
Message-ID: <8bf50f09-5b31-f95d-52bf-5a384f99127e@gameservers.com>
Date: Mon, 30 Jan 2017 11:16:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170130105147.GF27325@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU websockets support is laggy?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>



On 1/30/2017 5:51 AM, Daniel P. Berrange wrote:
> On Fri, Jan 27, 2017 at 06:08:20PM +0000, Daniel P. Berrange wrote:
>> On Fri, Jan 27, 2017 at 09:35:38AM +0000, Daniel P. Berrange wrote:
>>> On Tue, Jan 24, 2017 at 05:02:25PM -0500, Brian Rak wrote:
>>>> We've been considering switching over to using qemu's built in websockets
>>>> support (to avoid the overhead of needing websockify running).  We've been
>>>> seeing very poor performance after the switch (it takes the console 4-5
>>>> seconds to update after pressing a key).  So far, I haven't been able to
>>>> find any indication of why this is happening.  The exact same configuration
>>>> works perfectly when running with websockify, but laggy when hitting qemu
>>>> directly.
>>>>
>>>> I've tried a few things (disabling encryption, bypassing our usual nginx
>>>> proxy, even connecting via a ssh tunnel), and haven't made any sort of
>>>> progress here.  Has anyone else seen this?  Any suggestions as to where I
>>>> should start looking?
>>> Can you clarify the exact setup you have ?  As mentioned on IRC, I don't
>>> see any degradation in performance betweeen builtin websockets vs a
>>> websockets proxy - if anything the builtin websockets is marginally less
>>> laggy.  I was connecting over TCP localhost, however, so would not see
>>> any effects of network latency. My test was QEMU git master, with noVNC
>>> git master.
>> It turns out that to see the problem you have a wait a while - the
>> connection is initially fine, but gets worse over time. Using a TCP
>> connection seems to make it get worse more quickly.
>>
>> After a painful debugging session I've discovered the problem is that
>> QEMU is reading data off the socket, decoding a websockets packet and
>> then processing it. The problem is if the read off the socket gets
>> multiple websockets packets at once, it only decodes the first packet.
>> The remaining packets aren't decoded until more data arrives on the
>> socket. This gets progressively worse & worse. I'll send a patch for
>> this next week...
> I've just sent a patch & would appreciate your testing to confirm that
> it fixes the problem for you too.
>
> Regards,
> Daniel
Confirmed, with the patch the built in websockets support performs just 
as well as vnc + websockify.  Thanks for the help!
