Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1exrT2-00074F-F5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1exrSz-0002xV-DU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:52:36 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:55838
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1exrSz-0002vj-6c
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:52:33 -0400
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
	<1b9b4a96-c415-f96d-132a-82883d14d66c@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <4f4b939b-b4a9-eaee-a8f5-d480d02a0b64@adacore.com>
Date: Mon, 19 Mar 2018 10:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <1b9b4a96-c415-f96d-132a-82883d14d66c@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead
 of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: famz@redhat.com, stefanha@redhat.com

Hi Philippe,

Thanks for the review!

BTW I forgot the for 2.12 tag can this be included in 2.12 or is
it too late?

Thanks,
Fred

On 03/19/2018 12:30 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 03/16/2018 05:23 PM, KONRAD Frederic wrote:
>> Since the commit:
>> commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Wed Mar 7 14:42:05 2018 +0000
>>
>>      vl: introduce vm_shutdown()
>>
>> GDB crash when qemu exits (at least on sparc-softmmu):
>> Remote communication error.  Target disconnected.: Connection reset by=
 peer.
>> Quitting: putpkt: write failed: Broken pipe.
>>
>> So send a packet to kill GDB before we exit QEMU:
>> [Inferior 1 (Thread 0) exited normally]
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
>> ---
>>   gdbstub.c              | 7 +++++++
>>   include/exec/gdbstub.h | 2 ++
>>   vl.c                   | 2 ++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index f1d5148..a76b2fa 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -2052,6 +2052,13 @@ int gdbserver_start(const char *device)
>>       return 0;
>>   }
>>  =20
>> +void gdbserver_cleanup(void)
>> +{
>> +    if (gdbserver_state) {
>> +        put_packet(gdbserver_state, "W00");
>> +    }
>> +}
>> +
>>   static void register_types(void)
>>   {
>>       type_register_static(&char_gdb_type_info);
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index 9aa7756..2e8a4b8 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -103,6 +103,8 @@ int gdbserver_start(int);
>>   int gdbserver_start(const char *port);
>>   #endif
>>  =20
>> +void gdbserver_cleanup(void);
>> +
>>   /**
>>    * gdb_has_xml:
>>    * This is an ugly hack to cope with both new and old gdb.
>> diff --git a/vl.c b/vl.c
>> index 3ef04ce..0427b15 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4723,6 +4723,8 @@ int main(int argc, char **argv, char **envp)
>>  =20
>>       main_loop();
>>  =20
>> +    gdbserver_cleanup();
>> +
>>       /* No more vcpu or device emulation activity beyond this point *=
/
>>       vm_shutdown();
>>  =20
>>
