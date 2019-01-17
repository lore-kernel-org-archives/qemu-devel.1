Received: from eggs.gnu.org ([209.51.188.92]:56353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk2vX-0000wr-F1
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk2vQ-0004Ki-M5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:21:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gk2vL-0004Db-5n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:21:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so9929622wra.6
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 00:21:13 -0800 (PST)
References: <20190116121350.23863-1-alex.bennee@linaro.org>
	<c8f655ea-3c3b-290e-1bc2-8f7bb755f4af@citrix.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <c8f655ea-3c3b-290e-1bc2-8f7bb755f4af@citrix.com>
Date: Thu, 17 Jan 2019 08:21:10 +0000
Message-ID: <874la7zocp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] hw/block/xen: use proper
 format string for printing sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: peter.maydell@linaro.org, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>


Andrew Cooper <andrew.cooper3@citrix.com> writes:

> On 16/01/2019 12:13, Alex Benn=C3=A9e wrote:
>> The %lu format string is different depending on the host architecture
>> which causes builds like the debian-armhf-cross build to fail. Use the
>> correct PRi64 format string.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  hw/block/xen-block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
>> index be28b63442..a636487b3e 100644
>> --- a/hw/block/xen-block.c
>> +++ b/hw/block/xen-block.c
>> @@ -215,7 +215,7 @@ static void xen_block_realize(XenDevice *xendev, Err=
or **errp)
>>
>>      xen_device_backend_printf(xendev, "sector-size", "%u",
>>                                conf->logical_block_size);
>> -    xen_device_backend_printf(xendev, "sectors", "%lu",
>> +    xen_device_backend_printf(xendev, "sectors", "%"PRIi64,
>
> PRIu64.
>
> You've changed the signed-ness of what gets printed.

I was deliberate as:
  int64_t blk_getlength(BlockBackend *blk);

although I have to admit a signed block length doesn't make much sense
to me. At least it isn't going to overflow and will show-up if the block
length is ever negative.

>
> ~Andrew


--
Alex Benn=C3=A9e
