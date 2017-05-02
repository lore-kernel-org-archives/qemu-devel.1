Received: from eggs.gnu.org ([2001:4830:134:3::10]:37275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d5ZkN-00080c-20
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d5ZkJ-00072s-QB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:29:51 -0400
Received: from mail-db5eur01on0113.outbound.protection.outlook.com
	([104.47.2.113]:45363
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1d5ZkI-0006zX-Qm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:29:47 -0400
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<87bmrbgvzf.fsf@dusky.pond.sub.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org>
Date: Tue, 2 May 2017 18:29:39 +0300
MIME-Version: 1.0
In-Reply-To: <87bmrbgvzf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 05/02/2017 05:43 PM, Markus Armbruster wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
>> Right now QMP and HMP monitors read 1 byte at a time from the socket, which
>> is very inefficient. With 100+ VMs on the host this easily reasults in
>> a lot of unnecessary system calls and CPU usage in the system.
>>
>> This patch changes the amount of data to read to 4096 bytes, which matches
>> buffer size on the channel level. Fortunately, monitor protocol is
>> synchronous right now thus we should not face side effects in reality.
> Can you explain briefly why this relies on "synchronous"?  I've spent
> all of two seconds on the question myself...
Each command is processed in sequence as it appears in the
channel. The answer to the command is sent and only after that
next command is processed.

Theoretically tith asynchronous processing we can have some side
effects due to changed buffer size.

Den
