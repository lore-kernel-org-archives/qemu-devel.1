Received: from eggs.gnu.org ([2001:4830:134:3::10]:35212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cZg14-0004Ih-It
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cZg0z-0005SD-Ly
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:43:14 -0500
Received: from mail-db5eur01on0137.outbound.protection.outlook.com
	([104.47.2.137]:17521
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cZg0z-0005R3-An
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:43:09 -0500
References: <1486045515-8009-1-git-send-email-den@openvz.org>
	<20170203145218.GE642@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <9845dd75-9901-e6e4-b890-85fd7608bcfb@openvz.org>
Date: Fri, 3 Feb 2017 18:09:36 +0300
MIME-Version: 1.0
In-Reply-To: <20170203145218.GE642@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] mirror: do not increase offset
 during initial zero_or_discard phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

On 02/03/2017 05:52 PM, Stefan Hajnoczi wrote:
> On Thu, Feb 02, 2017 at 05:25:15PM +0300, Denis V. Lunev wrote:
>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>
>> If explicit zeroing out before mirroring is required for the target im=
age,
>> it moves the block job offset counter to EOF, then offset and len coun=
ters
>> count the image size twice. There is no harm but stats are confusing,
>> specifically the progress of the operation is always reported as 99% b=
y
>> management tools.
>>
>> The patch skips offset increase for the first "technical" pass over th=
e
>> image. This should not cause any further harm.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Jeff Cody <jcody@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Eric Blake <eblake@redhat.com>
>> ---
>> Changes from v1:
>> - changed the approach - we do not allow to increase the offset rather=
 then
>>   to move it back
>> - description rewritten
>> - kludges to tests are removed as not actually needed with this approa=
ch
>>
>>  block/mirror.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
> Another option is to put the flag in MirrorOp instead of MirrorBlockJob=
=2E
> That reduces the scope of the variable, but this is okay too:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
In this case we will have to pass argument through several
layers on request creation path. Current approach is better.

Thank you for the review :)

Den
