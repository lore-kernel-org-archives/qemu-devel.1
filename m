Received: from eggs.gnu.org ([2001:4830:134:3::10]:56204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPLIf-0006lg-TV
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gPLIb-0006K4-TR
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:43:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gPLIb-0006JY-Kg
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:43:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAL5hX2T024333
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 00:43:40 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nvwd9g2j3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 00:43:40 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Wed, 21 Nov 2018 05:43:38 -0000
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120155500.GA29471@morn.lan>
	<03cf3bbc-d557-1c12-dd2b-6acf7934db3c@silicom-usa.com>
	<CAGxU2F4FtdLb-aWCS_9E7kLGDdgR0-QT_KQpkNs6Zhucv6PF9g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 21 Nov 2018 00:43:34 -0500
MIME-Version: 1.0
In-Reply-To: <CAGxU2F4FtdLb-aWCS_9E7kLGDdgR0-QT_KQpkNs6Zhucv6PF9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <4c5a4f44-b707-e40a-a82b-81f59f83d59a@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SeaBIOS]  SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, stephend@silicom-usa.com
Cc: kevin@koconnor.net, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com

On 11/20/18 11:51 AM, Stefano Garzarella wrote:
> On Tue, Nov 20, 2018 at 5:13 PM Steve Douthit <stephend@silicom-usa.com=
> wrote:
>> On 11/20/18 10:55 AM, Kevin O'Connor wrote:
>>> On Mon, Nov 19, 2018 at 07:38:39PM +0100, Stefano Garzarella wrote:
>>>> just an update, I enabled the debug prints and I saw two timeouts fi=
red
>>>> with a lot
>>>> of time lost (~780ms between "init timer" and "Scan for VGA ..."),
>>>> putting other prints I discovered that a lot of time is spent in the
>>>> tpm_setup(),
>>>> during the probe of the 2 TPM devices:
>>>>
>>>> 00.548869 init timer
>>>> 00.549677 ./src/post.c:157 platform_hardware_setup
>>>> 00.550182 ./src/hw/tpm_drivers.c:579 tpmhw_probe
>>>> 01.300833 WARNING - Timeout at wait_reg8:81!
>>>> 01.301388 ./src/hw/tpm_drivers.c:579 tpmhw_probe
>>>> 01.331843 WARNING - Timeout at wait_reg8:81!
>>>> 01.332316 ./src/post.c:160 platform_hardware_setup
>>>> 01.333358 Scan for VGA option rom
>>> FYI, this was raised a few months ago - see:
>>>
>>> https://mail.coreboot.org/pipermail/seabios/2018-March/012186.html
>>>
>>> IIRC, it should be possible to verify the TPM device is present befor=
e
>>> trying to wait for it.
>> We could skip probing entirely if there's no TCPA or TPM2 ACPI tables.
>> There'd need to be some option to force probing in the case of
>> missing/broken ACPI configurations.
> I've just tried the
> 0001-tpm-Check-for-TPM-related-ACPI-tables-before-attempt.patch
> (https://mail.coreboot.org/pipermail/seabios/2018-March/012188.html)
> and it solves my issue with the TPM.

I have tried it with the attached patch of that mail. We have to apply=20
it, also for QEMU. It is this patch here:

From: Stephen Douthit <stephend@silicom-usa.com>
Date: Wed, 7 Mar 2018 13:17:36 -0500
Subject: [PATCH] tpm: Check for TPM related ACPI tables before attempting=
 hw
 =C2=A0probe

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 =C2=A0src/tcgbios.c | 14 +++++++-------
 =C2=A01 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/tcgbios.c b/src/tcgbios.c
index 40b3028..24846d3 100644
--- a/src/tcgbios.c
+++ b/src/tcgbios.c
@@ -968,6 +968,13 @@ tpm_setup(void)
 =C2=A0=C2=A0=C2=A0=C2=A0 if (!CONFIG_TCGBIOS)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;

+=C2=A0=C2=A0=C2=A0 int ret =3D tpm_tpm2_probe();
+=C2=A0=C2=A0=C2=A0 if (ret) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D tpm_tcpa_probe();
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n;
+=C2=A0=C2=A0=C2=A0 }
+
 =C2=A0=C2=A0=C2=A0=C2=A0 TPM_version =3D tpmhw_probe();
 =C2=A0=C2=A0=C2=A0=C2=A0 if (TPM_version =3D=3D TPM_VERSION_NONE)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
@@ -976,13 +983,6 @@ tpm_setup(void)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "TCGBIOS: Detected a TPM %s.\n",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (TPM_version =3D=3D TPM_VERSION_1_2) ? "1.2" : "2");

-=C2=A0=C2=A0=C2=A0 int ret =3D tpm_tpm2_probe();
-=C2=A0=C2=A0=C2=A0 if (ret) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D tpm_tcpa_probe();
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n;
-=C2=A0=C2=A0=C2=A0 }
-
 =C2=A0=C2=A0=C2=A0=C2=A0 TPM_working =3D 1;

 =C2=A0=C2=A0=C2=A0=C2=A0 if (runningOnXen())
--=20
2.14.3




>
> Thanks,
> Stefano
>
>>> -Kevin
>>>
>
