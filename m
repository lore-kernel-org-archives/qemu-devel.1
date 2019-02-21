Received: from eggs.gnu.org ([209.51.188.92]:59816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwrzc-0002TT-Nt
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwrzb-0000q8-Vp
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:18:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-10-armbru@redhat.com>
	<87zhqp2igg.fsf@zen.linaroharston>
Date: Thu, 21 Feb 2019 18:18:30 +0100
In-Reply-To: <87zhqp2igg.fsf@zen.linaroharston> ("Alex =?utf-8?Q?Benn?=
	=?utf-8?Q?=C3=A9e=22's?= message of
	"Thu, 21 Feb 2019 16:51:27 +0000")
Message-ID: <87tvgxvz4p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/10] pflash: Clean up after commit
 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> QOMification left parameter @size unused in pflash_cfi01_register()
>> and pflash_cfi02_register().  register().  Obviously, @size should
>> match @sector_len and @nb_blocs, i.e. size =3D=3D sector_len * nb_blocs.
>> All callers satisfy this.
>>
>> Remove @nb_blocs and compute it from @size and @sector_len.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
[...]
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index a989a8c439..a5dae67c26 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -97,7 +97,7 @@ static int sam460ex_load_uboot(void)
>>      if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32=
),
>>                                 "sam460ex.flash", FLASH_SIZE,
>>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NUL=
L,
>> -                               65536, FLASH_SIZE / 65536,
>> +                               65536,
>
> 64 * KiB?

I generally prefer to keep big, repetitive patches as mechanical as
possible.  But if it's desired, I'll make this change.

Zoltan, David, David, you're maintainers, do you have a preference?

>>                                 1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>>          error_report("Error registering flash memory");
>>          /* XXX: return an error instead? */
[...]
>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks!
