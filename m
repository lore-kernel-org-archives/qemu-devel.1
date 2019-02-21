Received: from eggs.gnu.org ([209.51.188.92]:53042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwrWw-0007uR-88
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwrWt-0008N6-2l
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:49:00 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwrWr-0008Ka-Pj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:48:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id a62so10272661wmh.4
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 08:48:57 -0800 (PST)
References: <20190221134101.13903-1-alex.bennee@linaro.org>
	<e297b7f6-e964-74a1-e14c-e6cd10674209@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e297b7f6-e964-74a1-e14c-e6cd10674209@redhat.com>
Date: Thu, 21 Feb 2019 16:48:54 +0000
Message-ID: <871s413x55.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/cdrom-test: only include isapc cdrom
 test when g_test_slow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com


Thomas Huth <thuth@redhat.com> writes:

> On 21/02/2019 14.41, Alex Benn=C3=A9e wrote:
>> We are seeing instability on our CI runs which has been there since
>> the test was introduced. I suspect it triggers more on Travis due to
>> their heavy load.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/cdrom-test.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
>> index 14bd981336..05611da648 100644
>> --- a/tests/cdrom-test.c
>> +++ b/tests/cdrom-test.c
>> @@ -132,8 +132,14 @@ static void add_x86_tests(void)
>>      qtest_add_data_func("cdrom/boot/virtio-scsi",
>>                          "-device virtio-scsi -device scsi-cd,drive=3Dcd=
r "
>>                          "-blockdev file,node-name=3Dcdr,filename=3D", t=
est_cdboot);
>> -    qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
>> -                        "-drive if=3Dide,media=3Dcdrom,file=3D", test_c=
dboot);
>> +    /*
>> +     * Unstable CI test under load
>> +     * See https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg055=
09.html
>> +     */
>> +    if (g_test_slow()) {
>> +        qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
>> +                            "-drive if=3Dide,media=3Dcdrom,file=3D", te=
st_cdboot);
>> +    }
>>      qtest_add_data_func("cdrom/boot/am53c974",
>>                          "-device am53c974 -device scsi-cd,drive=3Dcd1 "
>>                          "-drive if=3Dnone,id=3Dcd1,format=3Draw,file=3D=
", test_cdboot);
>>
>
> Acked-by: Thomas Huth <thuth@redhat.com>
>
> Which tree should this go through? qtest? Block? Your test tree?

I'll put in my testing/next pull-req.

>
> At least I don't have much in the qtest queue right now and did not plan
> a pull request soon. Let me know if you want me to queue it.


--
Alex Benn=C3=A9e
