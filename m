Received: from eggs.gnu.org ([2001:4830:134:3::10]:44811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewqWq-0003Tz-1N
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewqWl-0006eO-KU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:40:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ewqWl-0006da-5Z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:40:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GEaS3F067635
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:40:12 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grbjvu8uu-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:40:12 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 08:40:11 -0600
Received: from b03ledav002.gho.boulder.ibm.com
	(b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w2GEe8Pr6881728
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:40:08 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BE00136044
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 08:40:08 -0600 (MDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP id DD48D136040
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 08:40:07 -0600 (MDT)
References: <20180316142223.28745-1-marcandre.lureau@redhat.com>
	<20180316142503.GM3066@redhat.com>
	<CAJ+F1CJJEi=5TZCZRe8NSEaJmfSp1cTYPEGedNtm3D0B4hw5SQ@mail.gmail.com>
	<20180316143040.GO3066@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 10:40:07 -0400
MIME-Version: 1.0
In-Reply-To: <20180316143040.GO3066@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <767d01e6-cfe8-aacd-cc1b-79522c1cc5db@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: fix tpm-crb tpm-tis tests race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 03/16/2018 10:30 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 16, 2018 at 03:29:04PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Fri, Mar 16, 2018 at 3:25 PM, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
>>> On Fri, Mar 16, 2018 at 03:22:23PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
>>>> No need to close the TPM data socket on the emulator end, qemu will
>>>> close it after a SHUTDOWN. This avoids a race between close() and
>>>> read() in the TPM data thread.
>>>>
>>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>   tests/tpm-emu.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
>>>> index 4dada76834..8c2bd53cad 100644
>>>> --- a/tests/tpm-emu.c
>>>> +++ b/tests/tpm-emu.c
>>>> @@ -125,7 +125,7 @@ void *tpm_emu_ctrl_thread(void *data)
>>>>           case CMD_SHUTDOWN: {
>>>>               ptm_res res =3D 0;
>>>>               qio_channel_write(ioc, (char *)&res, sizeof(res), &err=
or_abort);
>>>> -            qio_channel_close(s->tpm_ioc, &error_abort);
>>>> +            /* the tpm data thread is expected to finish now */
>>>>               g_thread_join(s->emu_tpm_thread);
>>> Won't this leave an orphaed FD open in the test suite ? Is it perhaps
>>> sufficient to just swap the order of the g_thread_join and qio_channe=
l_close
>>> calls, so that we join the thread before we close the channel that th=
e
>>> thread is using ?
>> Isn't the socket close on the last unref? (at end of tpm_emu_tpm_threa=
d())
> Oh yes, that is true. I should have looked at more than just diff conte=
xt.
> In that case
>
>    Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Ha. It's already done :-)

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


>
> Regards,
> Daniel
