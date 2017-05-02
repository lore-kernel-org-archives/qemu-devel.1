Received: from eggs.gnu.org ([2001:4830:134:3::10]:58136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5agp-00083h-N3
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5ago-0002Ha-8j
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5ago-0002Gr-34
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:30:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<87bmrbgvzf.fsf@dusky.pond.sub.org>
	<e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org>
Date: Tue, 02 May 2017 18:30:08 +0200
In-Reply-To: <e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org> (Denis
	V. Lunev's message of "Tue, 2 May 2017 18:29:39 +0300")
Message-ID: <877f1zcjcf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

"Denis V. Lunev" <den@openvz.org> writes:

> On 05/02/2017 05:43 PM, Markus Armbruster wrote:
>> "Denis V. Lunev" <den@openvz.org> writes:
>>
>>> Right now QMP and HMP monitors read 1 byte at a time from the socket, which
>>> is very inefficient. With 100+ VMs on the host this easily reasults in
>>> a lot of unnecessary system calls and CPU usage in the system.
>>>
>>> This patch changes the amount of data to read to 4096 bytes, which matches
>>> buffer size on the channel level. Fortunately, monitor protocol is
>>> synchronous right now thus we should not face side effects in reality.
>> Can you explain briefly why this relies on "synchronous"?  I've spent
>> all of two seconds on the question myself...
> Each command is processed in sequence as it appears in the
> channel. The answer to the command is sent and only after that
> next command is processed.

Yes, that's how QMP works.

> Theoretically tith asynchronous processing we can have some side
> effects due to changed buffer size.

What kind of side effects do you have in mind?

It's quite possible that this obviously inefficient way to read had some
deep reason back when it was created.  Hmm, git-blame is our friend:

commit c62313bbdc48f72e93fa8196f2fff96ba35e4e9d
Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Fri Dec 4 14:05:29 2009 +0100

    monitor: Accept input only byte-wise
    
    This allows to suspend command interpretation and execution
    synchronously, e.g. during migration.
    
    Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
    Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
