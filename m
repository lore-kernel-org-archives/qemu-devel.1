Received: from eggs.gnu.org ([2001:4830:134:3::10]:51494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gOdYm-0001Nn-Ph
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 02:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gOdYe-0005Fn-EG
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 02:01:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gOdYa-0005Bs-Eb
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 02:01:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181110034115.103335-1-liq3ea@163.com>
	<20181110034115.103335-3-liq3ea@163.com>
	<87k1ld0xsl.fsf@dusky.pond.sub.org>
	<1dce907c.4226.16729914a43.Coremail.liq3ea@163.com>
Date: Mon, 19 Nov 2018 08:01:04 +0100
In-Reply-To: <1dce907c.4226.16729914a43.Coremail.liq3ea@163.com>
	(=?utf-8?B?IsOAw67Dh8K/Iidz?=
	message of "Mon, 19 Nov 2018 09:24:06 +0800 (CST)")
Message-ID: <877eh9wnyn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw: fw_cfg: refactor fw_cfg_reboot()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?w4DDrsOHwr8=?= <liq3ea@163.com>
Cc: lersek@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com, philmd@redhat.com

=C3=80=C3=AE=C3=87=C2=BF <liq3ea@163.com> writes:

> At 2018-11-17 00:52:58, "Markus Armbruster" <armbru@redhat.com> wrote:
>>Li Qiang <liq3ea@163.com> writes:
>>
>>> Currently the user can set a negative reboot_timeout.
>>> Also it is wrong to parse 'reboot-timeout' with qemu_opt_get() and then
>>> convert it to number.
>>
>>Again, it's not wrong per se, just needlessly complicated and
>>error-prone.  What makes it wrong is ...
>>
>>> convert it to number. This patch refactor this function by following:
>>> 1. ensure reboot_timeout is in 0~0xffff
>>> 2. use qemu_opt_get_number() to parse reboot_timeout
>>> 3. simlify code
>>>
>>> Signed-off-by: Li Qiang <liq3ea@163.com>
>>> ---
>>>  hw/nvram/fw_cfg.c | 23 +++++++++++------------
>>>  vl.c              |  2 +-
>>>  2 files changed, 12 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index 78f43dad93..6aca80846a 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -178,24 +178,23 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>>>=20=20
>>>  static void fw_cfg_reboot(FWCfgState *s)
>>>  {
>>> -    int reboot_timeout =3D -1;
>>> -    char *p;
>>> -    const char *temp;
>>> +    const char *reboot_timeout =3D NULL;
>>>=20=20
>>>      /* get user configuration */
>>>      QemuOptsList *plist =3D qemu_find_opts("boot-opts");
>>>      QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
>>> -    if (opts !=3D NULL) {
>>> -        temp =3D qemu_opt_get(opts, "reboot-timeout");
>>> -        if (temp !=3D NULL) {
>>> -            p =3D (char *)temp;
>>> -            reboot_timeout =3D strtol(p, &p, 10);
>>
>>... the total lack of error checking here.  Same in PATCH 1.
>
>>
>
>
> Got.
>
>
>>Here's my attempt at a clearer commit message:
>>
>>    fw_cfg: Fix -boot reboot-timeout error checking
>>
>>    fw_cfg_reboot() gets option parameter "reboot-timeout" with
>>    qemu_opt_get(), then converts it to an integer by hand.  It neglects
>>    to check that conversion for errors, and fails to reject negative
>>    values.  Positive values above the limit get reported and replaced
>>    by the limit.
>>
>>    Check for conversion errors properly, and reject all values outside
>>    0..0xffff.
>
>>
>
>
> Thanks for your advice, I appreciate it and will change in the revision v=
ersion.
>
>
>>PATCH 1's commit message could be improved the same way.
>>
>>> -        }
>>> +    reboot_timeout =3D qemu_opt_get(opts, "reboot-timeout");
>>> +
>>> +    if (reboot_timeout =3D=3D NULL) {
>>> +        return;
>>>      }
>>> +    int64_t rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
>>> +
>>>      /* validate the input */
>>> -    if (reboot_timeout > 0xffff) {
>>> -        error_report("reboot timeout is larger than 65535, force it to=
 65535.");
>>> -        reboot_timeout =3D 0xffff;
>>> +    if (rt_val < 0 || rt_val > 0xffff) {
>>> +        error_report("reboot timeout is invalid,"
>>> +                     "it should be a value between 0 and 65535");
>>> +        exit(1);
>>>      }
>>>      fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout,=
 4), 4);
>>>  }
>>
>>Change in behavior when "reboot-timeout" isn't specified.
>>
>>Before your patch, we fw_cfg_add_file() with a value of -1.
>>
>>After your patch, we don't fw_cfg_add_file().
>>
>>Why is that okay?
>
>>
>
>
> Here I following Gerd's advice.=20
> For values >0xffff  or < 0, report and exit.
> -->http://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00551.html

Cases:

0. "reboot-timeout" not specified (e.g. no -boot option given)

1. "reboot-timeout" specified, value out of bounds
1.a. < 0
1.b. > 0xffff

2. "reboot-timeout" specified, value okay

Gerd's advice is about case 1.  Your patch implements it.

My question is about case 0.

Do you understand my question now?

[...]
