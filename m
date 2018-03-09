Received: from eggs.gnu.org ([2001:4830:134:3::10]:53138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1euIUR-0005JY-KD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1euIUO-0001db-J7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:55:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1euIUO-0001ZG-AK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:55:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29Dt8Hn091480
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 08:55:13 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gkr2frsj9-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 08:55:11 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 06:54:27 -0700
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<06C8AB66E78EE34A949939824ABE2B313B651F39@shsmsx102.ccr.corp.intel.com>
	<CAJ+F1CKuHzO-F3XbjqQyLL49JipsR+Sk8zFy1ZuMssUz_71qvA@mail.gmail.com>
	<06C8AB66E78EE34A949939824ABE2B313B6613A0@shsmsx102.ccr.corp.intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 9 Mar 2018 08:54:22 -0500
MIME-Version: 1.0
In-Reply-To: <06C8AB66E78EE34A949939824ABE2B313B6613A0@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c5b7bc1d-c425-49d9-789c-044372588539@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 0/8] RFC: ovmf: preliminary TPM2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Shi, Steven" <steven.shi@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "lersek@redhat.com" <lersek@redhat.com>, "pjones@redhat.com" <pjones@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>

On 03/08/2018 10:03 PM, Shi, Steven wrote:
> Hi Marcandre,
> Thanks for your command steps and I tried them, but my qemu failed to c=
onnect the socket tpmemu.sock. When I added the control channel to the TP=
M, the swtpm socket command stuck there and never exit. Not sure whether =
it was successful.
> Below are the command steps running output in my side
>
>> Then you can run:
>> mkdir tpmstatedir
>> swtpm_setup.sh --tpm2 --tpm-state tpmstatedir
> $ swtpm_setup.sh --tpm2 --tpm-state tpmstatedir
> Starting vTPM manufacturing as jshi19:jshi19 @ 2018=E5=B9=B403=E6=9C=88=
09=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=BA=94 10=E6=97=B628=E5=88=8639=E7=A7=92
> TPM is listening on TCP port 47364.
> Successfully authored TPM state.
> Ending vTPM manufacturing @ 2018=E5=B9=B403=E6=9C=8809=E6=97=A5 =E6=98=9F=
=E6=9C=9F=E4=BA=94 10=E6=97=B628=E5=88=8639=E7=A7=92
>
>> Run the emulator:
>> swtpm socket --tpmstate dir=3Dtpmstatedir --ctrl type=3Dunixio,path=3D=
tpmemu.sock  --tpm2
> $ swtpm socket --tpmstate dir=3Dtpmstatedir --ctrl type=3Dunixio,path=3D=
tpmemu.sock --tpm2
> (the swtpm socket command stuck there and never exit)
>
>> Run qemu (from git) with ovmf (with this series):
>> qemu ... -chardev socket,id=3Dchrtpm,path=3Dtpmemu.sock -tpmdev
>> emulator,id=3Dtpm0,chardev=3Dchrtpm  -device tpm-crb,tpmdev=3Dtpm0
>> -drive if=3Dpflash,format=3Draw,file=3DOVMF_CODE.fd,readonly -drive
>> if=3Dpflash,format=3Draw,file=3DOVMF_VARS.fd ..
> $ qemu-system-x86_64  -serial file:serial.log -m 5120 -hda fat:. -monit=
or stdio --enable-kvm -smp 4 -bios ../Ovmf3264/NOOPT_GCC5/FV/OVMF.fd -cha=
rdev socket,id=3Dchrtpm,path=3Dtpmemu.sock -tpmdev emulator,id=3Dtpm0,cha=
rdev=3Dchrtpm  -device tpm-crb,tpmdev=3Dtpm0
> qemu-system-x86_64: -chardev socket,id=3Dchrtpm,path=3Dtpmemu.sock: Fai=
led to connect socket tpmemu.sock: No such file or directory

Try giving it both, swtpm and qemu, the full path to the socket.


>
> I use the latest version qemu as below:
> $ qemu-system-x86_64 --version
> QEMU emulator version 2.11.50 (v2.10.0-4184-g930b01138b-dirty)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>
> Thanks
> Steven Shi
>
