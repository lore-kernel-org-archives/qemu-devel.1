Received: from eggs.gnu.org ([209.51.188.92]:33010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gugpq-0000vH-Ct
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gugpn-0003BN-OV
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:59:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gugpl-00037n-RR
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:59:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190215122808.22301-1-alex.bennee@linaro.org>
	<60e020d0-ad5d-6b86-e492-1d3c91c48a13@redhat.com>
	<87lg2hujld.fsf@dusky.pond.sub.org>
Date: Fri, 15 Feb 2019 17:59:26 +0100
In-Reply-To: <87lg2hujld.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 15 Feb 2019 17:01:18 +0100")
Message-ID: <871s49vvgx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/block: report when pflash backing
 file isn't aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, stappers@stappers.nl

Markus Armbruster <armbru@redhat.com> writes:

> Laszlo Ersek <lersek@redhat.com> writes:
>
>> On 02/15/19 13:28, Alex Benn=C3=A9e wrote:
>>> It looks like there was going to be code to check we had some sort of
>>> alignment so lets replace it with an actual check. This is a bit more
>>> useful than the enigmatic "failed to read the initial flash content"
>>> when we attempt to read the number of bytes the device should have.
>>>=20
>>> This is a potential confusing stumbling block when you move from using
>>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
>>> loading your firmware code.
>>>=20
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>=20
>>> ---
>>> v2
>>>   - use PRIu64 instead of PRId64
>>>   - tweaked message output
>>> ---
>>>  hw/block/pflash_cfi01.c | 20 ++++++++++++++------
>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>> index bffb4c40e7..7532c8d8e8 100644
>>> --- a/hw/block/pflash_cfi01.c
>>> +++ b/hw/block/pflash_cfi01.c
>>> @@ -722,12 +722,20 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>>      }
>>>      device_len =3D sector_len_per_device * blocks_per_device;
>>>=20=20
>>> -    /* XXX: to be fixed */
>>> -#if 0
>>> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 =
* 1024) &&
>>> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024=
 * 1024))
>>> -        return NULL;
>>> -#endif
>
> pflash_cfi02_realize() has the same XXX.
>
> There's a pair of related XXXs in taihu_405ep_init().  Related because
> @total_len is computed like this
>
>     total_len =3D pfl->sector_len * pfl->nb_blocs;
>
> and the two factors come from callers of pflash_cfi01_realize(),
> pflash_cfi02_realize(), or from ve_pflash_cfi01_register(),
> xtfpga_flash_init().  Aside: the latter two are slight variations of
> pflash_cfi01_realize() which I'm going to clean up.  Some of these use
> fixed sizes (good, real machines do that, too).  Some of them compute
> them from blk_getlength(), with varying levels of care.

Missed one: create_one_flash().

Let's review flash size computation.

Single fixed size per machine type:

    collie_init()               0x02000000 (two times)
    connex_init()               0x01000000
    verdex_init()               0x02000000
    mainstone_common_init()     0x02000000
    sx1_init()                  (16 * 1024 * 1024) for sx1-v1
                                (32 * 1024 * 1024) for sx1
                                ( 8 * 1024 * 1024) for sx1-v1
    versatile_init()            (64 * 1024 * 1024)
    z2_init()                   0x00800000
    milkymist_init()            32 * MiB
    petalogix_ml605_init()      (32 * MiB)
    petalogix_s3adsp1800_init() (16 * MiB)
    mips_malta_init()           (4 * MiB)
    mips_r4k_init()             0x00400000
    virtex_init()               (16 * MiB)
    digic4_add_k8p3215uqb_rom() (4 * 1024 * 1024)
    zynq_init()                 (64 * 1024 * 1024)
    lm32_evr_init()             32 * MiB
    lm32_uclinux_init()         32 * MiB
    taihu_405ep_init()          32 * MiB (but see below)
    r2d_init()                  0x02000000
    ve_pflash_cfi01_register()  (64 * 1024 * 1024)
    xtfpga_flash_init()         0x00400000 for lx60*
                                0x01000000 for lx200*
                                0x01000000 for ml605*
                                0x08000000 for kc705*
    create_one_flash()          0x08000000 / 2 (two times)

Set of fixed sizes:

    musicpal_init()             image size, either 8*1024*1024,
                                16*1024*1024 or 32*1024*1024

Troublemakers:

    pc_system_flash_init()      sum of image sizes, at most 8MiB
                                rejects images whose size is not a
                                multiple of 4KiB
    sam460ex_load_uboot()       image size rounded up to multiple of
                                64KiB
    ref405ep_init()             image size rounded up to multiple of
                                64KiB
    taihu_405ep_init()          image size rounded up to multiple of
                                64KiB

> I'm afraid we need to take all that into account.

We can ignore all but the four troublemakers.

[...]
