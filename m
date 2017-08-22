Received: from eggs.gnu.org ([2001:4830:134:3::10]:35554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk5t9-0005mh-8a
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk5t7-0006Nw-5p
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:54:23 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dk5t6-0006N8-RB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:54:21 -0400
Received: by mail-wr0-x229.google.com with SMTP id p14so51906262wrg.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 02:54:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b1167424-0f05-aad7-f456-22ca0aee2000@redhat.com>
References: <20170822042416.26758-1-david@gibson.dropbear.id.au>
	<CAFEAcA-iuizr9eh3=ZkPPT+YxfWzvUFzbWB-aA_Mo5BiDkrzQQ@mail.gmail.com>
	<b1167424-0f05-aad7-f456-22ca0aee2000@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 10:53:58 +0100
Message-ID: <CAFEAcA8dJe5uB-tUoeF=dE_q8HG_LLAmLUHdfR0XZihGN5JFXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ppc-for-2.10 queue 20170822
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On 22 August 2017 at 10:43, Laurent Vivier <lvivier@redhat.com> wrote:
> On 22/08/2017 11:34, Peter Maydell wrote:
>> On 22 August 2017 at 05:24, David Gibson <david@gibson.dropbear.id.au> wrote:
>>> The following changes since commit 1f296733876434118fd766cfef5eb6f29ecab6a8:
>>>
>>>   Update version for v2.10.0-rc3 release (2017-08-15 18:53:31 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170822
>>>
>>> for you to fetch changes up to d3234e2851f1630c695c681beac1e87ac0881260:
>>>
>>>   hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device (2017-08-22 11:11:30 +1000)
>>>
>>> ----------------------------------------------------------------
>>> ppc patch queue 2017-08-22
>>>
>>> Last minute ppc related fixes for qemu-2.10.  I'm not sure if these
>>> are critical enough to prompt another rc, but I'm submitting them for
>>> consideration.
>>>
>>> First, is Cornelia's fix for 480bc11e6 which meant "make check" would
>>> always fail on a ppc host.  Tracking that down delayed submission of
>>> the rest of these patches, sorry.
>>>
>>> The rest are all fairly important bugfixes for qemu crashes or guest
>>> behaviour regression on ppc.  Patches 2-4 specifically are fixes for
>>> regressions from qemu-2.9, caused by the compatibility mode and
>>> hotplug handling cleanups for the pseries machine type.
>>>
>>> ----------------------------------------------------------------
>>
>> I get a make check failure on ppc64 Linux:
>>
>> TEST: tests/postcopy-test... (pid=12468)
>>   /ppc64/postcopy:
>> Broken pipe
>> qemu-system-ppc64: RP: Received invalid message 0x0000 length 0x0000
>> FAIL
>> GTester: last random seed: R02Se5468e06f561627824306d95b0566d2b
>> (pid=13011)
>> FAIL: tests/postcopy-test
>
> This test should fail with KVM PR, but it is explicitly disabled by:
>
> tests/postcopy-test.c:
>
> 386         accel = access("/sys/module/kvm_hv", F_OK) ? "tcg" : "kvm:tcg";

There is no file of that name on the machine; but we'll be using
TCG anyway because /dev/kvm is not readable by my user.

> What is your test machine?

It's the gcc compile farm ppc64 box (gcc110 if you have compile farm
access):
Linux gcc1-power7.osuosl.org 3.10.0-514.26.2.el7.ppc64 #1 SMP Mon Jul
10 02:26:53 GMT 2017 ppc64 ppc64 ppc64 GNU/Linux

/proc/cpuinfo says

processor       : 0
cpu             : POWER7 (architected), altivec supported
clock           : 3550.000000MHz
revision        : 2.1 (pvr 003f 0201)
[etc]

timebase        : 512000000
platform        : pSeries
model           : IBM,8231-E2B
machine         : CHRP IBM,8231-E2B

git bisect blames "target/ppc: 'PVR != host PVR' in KVM_SET_SREGS workaround"
for the regression.

thanks
-- PMM
