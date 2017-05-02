Received: from eggs.gnu.org ([2001:4830:134:3::10]:39160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d5ZrX-0002ZN-H5
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d5ZrU-0006fO-DW
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:37:15 -0400
Received: from mail-db5eur01on0107.outbound.protection.outlook.com
	([104.47.2.107]:11930
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1d5ZrT-0006ce-ST
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:37:12 -0400
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<da1ab237-5dd0-cae9-7eb9-687203b37a64@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e400b265-9aa9-394f-dd5b-375b6ffab939@openvz.org>
Date: Tue, 2 May 2017 18:37:03 +0300
MIME-Version: 1.0
In-Reply-To: <da1ab237-5dd0-cae9-7eb9-687203b37a64@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 05/02/2017 05:34 PM, Eric Blake wrote:
> On 05/02/2017 08:47 AM, Denis V. Lunev wrote:
>> Right now QMP and HMP monitors read 1 byte at a time from the socket, =
which
>> is very inefficient. With 100+ VMs on the host this easily reasults in=

> s/reasults/results/
>
>> a lot of unnecessary system calls and CPU usage in the system.
>>
>> This patch changes the amount of data to read to 4096 bytes, which mat=
ches
>> buffer size on the channel level. Fortunately, monitor protocol is
>> synchronous right now thus we should not face side effects in reality.=

> Do you have any easy benchmarks or measurements to prove what sort of
> efficiencies we get?  (I believe they exist, but quantifying them never=

> hurts)
>
Unfortunately I have not measured numbers, but I am sure that
this will improve the performance by the small number. I have
had in mind calculations like the following:
- our management software executes 6 QMP requests in 10 seconds
  for each VM to collect balloon statistics, disk statistics, CPU
  statistics etc
- lets assume we have 100 VMs
- each byte processing require poll(), which is expensive, and recvmsg,
  i.e. 2 syscalls per byte
- If the request is 50 bytes in length (this number is optimistic) we
  will have
   6 (amount of QMP reqs) * 50 (bytes in req) * 100 (VMs count) * 2
(syscalls per byte) / 10 (seconds) =3D 6000 syscalls/second

For me this number is not that small.


>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: Eric Blake <eblake@redhat.com>
>> ---
>>  monitor.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index be282ec..00df5d0 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -3698,7 +3698,7 @@ static int monitor_can_read(void *opaque)
>>  {
>>      Monitor *mon =3D opaque;
>> =20
>> -    return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
>> +    return (mon->suspend_cnt =3D=3D 0) ? 4096 : 0;
> Is a hard-coded number correct, or should we be asking the channel for
> an actual number?
Daniel has suggested good answer here. Though you are right,
it would be better to re-write commit message like this.
'4096 is takes as the number which allows to read most incoming
requests in one read'.

Den
