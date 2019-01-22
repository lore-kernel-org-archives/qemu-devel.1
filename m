Received: from eggs.gnu.org ([209.51.188.92]:38843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gm1XU-0003sj-IT
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gm1XS-0007Fk-Gz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:16:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gm1XS-0007Ai-41
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:16:46 -0500
References: <20190120071337.55595-1-liq3ea@163.com>
	<20190120071337.55595-3-liq3ea@163.com>
	<2e1e9b39-ed96-452a-de4b-9b7337702a89@redhat.com>
	<CAKXe6SJfThHvzuWKSqNDz79KcRfyzor16sFg1N8CxCFnaJPYTQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a7787e82-bef7-b508-a4c6-9a6917ceaf22@redhat.com>
Date: Tue, 22 Jan 2019 13:10:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJfThHvzuWKSqNDz79KcRfyzor16sFg1N8CxCFnaJPYTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On 01/22/19 02:28, Li Qiang wrote:
> Laszlo Ersek <lersek@redhat.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:38=E5=86=99=E9=81=93=EF=BC=9A
>=20
>> On 01/20/19 08:13, Li Qiang wrote:
>>> Signed-off-by: Li Qiang <liq3ea@163.com>
>>> ---
>>>  tests/fw_cfg-test.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
>>> index 1c5103fe1c..c28e6c3fb5 100644
>>> --- a/tests/fw_cfg-test.c
>>> +++ b/tests/fw_cfg-test.c
>>> @@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
>>>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D=
,
>> boot_menu);
>>>  }
>>>
>>> +static void test_fw_cfg_reboot_timeout(void)
>>> +{
>>> +    uint32_t reboot_timeout;
>>> +
>>> +    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
>>> +                     &reboot_timeout, sizeof(reboot_timeout));
>>> +    g_assert_cmpint(reboot_timeout, =3D=3D, 15);
>>> +}
>>> +
>>
>> You don't check the return status of qfw_cfg_get_file(), before readin=
g
>> "reboot_timeout". If the qfw_cfg_get_file() fails (returning 0), then
>> the comparison will refer to an indeterminate value. Also, it's
>> theoretically possible for qfw_cfg_get_file() to overwrite only part o=
f
>> the "reboot_timeout" object.
>>
>>
> Right. I will change in the next revision.
>=20
>=20
>=20
>> So I think we need the function to transfer exactly (sizeof
>> reboot_timeout) bytes.
>>
>>
> What does this mean? check the  return of 'qfw_cfg_get_file' if it is
> sizeof(reboot_timeout)?

Yes, that's what I meant.

>> BTW, this reminds me, qfw_cfg_get_file() seems to return the number of
>> bytes that would be necessary for transferring the entire file. That
>> looks like a good idea, but it should be documented. Please add some
>> docs on top of qfw_cfg_get_file().
>>
>>
> The docs like "return 0 means failed and non-zero means successful but
> the caller need check the exactly size to avoid partially file size" ?

Yes. A bit more precisely, when the return value is nonzero, it means
that some bytes have been transferred. If the fw_cfg file in question is
smaller than the allocated & passed-in buffer, then the buffer has been
populated only in part.

Vice versa, if the fw_cfg file in question is larger than the passed-in
buffer, then the return value explains how much room would have been
necessary in total. And, while the caller's buffer has been fully
populated, it has received only a starting slice of the fw_cfg file.

In the comparison that follows qfw_cfg_get_file(), we want to be sure
that the "reboot_timeout" integer object has been fully populated,
*plus* that we aren't ignoring any trailing bytes from the fw_cfg file.
Hence the strict equality on the size.

Thanks
Laszlo
