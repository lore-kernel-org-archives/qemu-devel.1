Received: from eggs.gnu.org ([2001:4830:134:3::10]:58756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1drQt7-0006vh-HZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1drQt0-00010l-5W
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:44:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1drQsz-0000zL-M1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:44:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8BFiURA059296
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:44:32 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cwt0u04vs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:44:31 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 11 Sep 2017 09:44:10 -0600
References: <150496592440.23639.12760780482468469571.malonedeb@wampee.canonical.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 11 Sep 2017 11:44:06 -0400
MIME-Version: 1.0
In-Reply-To: <150496592440.23639.12760780482468469571.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <f1bfa5ed-7195-966e-4a2b-17fcd7f5373a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Bug 1716132] [NEW] Win 10 bitlocker won't
 initialise pass-through TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1716132 <1716132@bugs.launchpad.net>, qemu-devel@nongnu.org, kelvin.middleton@gmail.com

On 09/09/2017 10:05 AM, Kelvin Middleton wrote:
> Public bug reported:
>
> All stock Ubuntu Zesty, Win10Pro KVM guest configured with OVMF and Q35.
> My host has an ASRock Z97 Extreme 6 board with a TPM header which is
> populated with v1.2 complaint device.
>
> Testing in my host the TPM device is function, I can tpm_takeownership
> and tpm_clear successfully and similar testing by passing the device
> through to a linux guest also succeeds.
>
> However using Bitlocker in Windows 10 Pro release 1703 Windows advises
> it cannot "Prepare" the device which I take to mean it cannot take
> ownership of it.  I believe this to be related to Windows inability to
> view the TCG Event Log which is evidenced in the below 2 screencaps,
> however I'm no expert.
>
> https://s26.postimg.org/vter35eh5/Screenshot_20170907_114644.png
> https://s26.postimg.org/klo854qyx/Screenshot_20170909_143841.png

There's no event log when you were to use it with SeaBIOS. I don't know 
about OVMF.

SeaBIOS, once it recognizes that the device has already been 
initialized, presumably by the host, will back off from using the device 
and extending PCRs 0-7. Extending them would otherwise mess up the state 
of the PCRs which has to correspond to the host's BIOS log entries. OVMF 
should probably behave the same way in this case. The problem the is 
that this can lead to certain software inside of VMs not working. 
Bitlocker may be one of them.

The solution that would probably get you the farthest is to use a 
software TPM emulator, possibly with SeaBIOS as the firmware if Windows 
10 accepts it. The issue here is that the patches implementing the TPM 
emulator driver are not commonly available upstream.

    Stefan


>
> I've also tested the scenario with qemu 2.10 which provided the exact
> same results.  The only difference in the test setup is that I had to
> make the guest boot with SeaBios instead of OVMF.  (Windows wouldn't
> boot with OVMF with the boot manager giving me an error pointing to a
> BCD issue.  Researching this it seemed related to an old ACPI problem, I
> believe this unrelated to my TPM issue so will do more research and
> raise a separate bug for this if needed.)
>
> Happy to provide further configurations and build logs as necessary so
> please advise me what is needed.
>
> Lastly for background reading.  I've been trying to get TPM passthrough
> working with Windows for a long time now and have hit several different
> issues which I believe have been addressed by both code maturity in Qemu
> but also in Windows releases.  An earlier bug report can be found here
> (https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1615722) which
> concludes advising me to raise this new/separate issue.
>
> Thanks in advance,
>
> Kelvin
>
> ** Affects: qemu
>       Importance: Undecided
>           Status: New
>
