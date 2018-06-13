Received: from eggs.gnu.org ([2001:4830:134:3::10]:46962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT0gN-0002BU-PJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT0gK-0001f6-Ms
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:59:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fT0gK-0001ek-Hm
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:59:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-2-peterx@redhat.com>
	<20180530074400-mutt-send-email-mst@kernel.org>
	<20180530063955.GA27442@xz-mi>
	<20180530155347.167708cc.cohuck@redhat.com>
Date: Wed, 13 Jun 2018 09:59:02 +0200
In-Reply-To: <20180530155347.167708cc.cohuck@redhat.com> (Cornelia Huck's
	message of "Wed, 30 May 2018 15:53:47 +0200")
Message-ID: <87wov3kth5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>

Cornelia Huck <cohuck@redhat.com> writes:

> On Wed, 30 May 2018 14:39:55 +0800
> Peter Xu <peterx@redhat.com> wrote:
>
>> On Wed, May 30, 2018 at 07:47:32AM +0300, Michael S. Tsirkin wrote:
>> > On Thu, May 24, 2018 at 12:44:53PM +0800, Peter Xu wrote:  
>> > > There are many error_report()s that can be used in frequently called
>> > > functions, especially on IO paths.  That can be unideal in that
>> > > malicious guest can try to trigger the error tons of time which might
>> > > use up the log space on the host (e.g., libvirt can capture the stderr
>> > > of QEMU and put it persistently onto disk).  
>> > 
>> > I think the problem is real enough but I think the API
>> > isn't great as it stresses the mechanism. Which fundamentally does
>> > not matter - we can print once or 10 times, or whatever.
>> > 
>> > What happens here is a guest bug as opposed to hypervisor
>> > bug. So I think a better name would be guest_error.  
>> 
>> For me error_report_once() is okay since after all it's only a way to
>> dump something for the hypervisor management software (or the person
>> who manages the QEMU instance), and I don't have a strong opinion to
>> introduce a new guest_error() API.
>
> If we go with that suggestion, guest_{error,warn} should also prefix
> the message with "Guest:" or so. Otherwise, it does not offer that much
> more benefit.
>
> [And I think it should be a wrapper around the report_once
> infrastructure.]

I agree.  Keep error_report_once() as low-level function (okay to stress
mechanism there), then wrap whatever higher level functions we find
useful around them, in followup patches.

[...]
