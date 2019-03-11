Received: from eggs.gnu.org ([209.51.188.92]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3MMY-0004j8-Hc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3MJd-0000kW-NV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:54:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1h3MJd-0000kK-FQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:54:09 -0400
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
	<CAFEAcA9=oUk_W+pqYLkd=oBC7eENU1yYKbGzoOzgxXoOmg7_+A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <85304416-5bd3-c957-b2c3-dd8e7c1aa071@redhat.com>
Date: Mon, 11 Mar 2019 15:54:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=oUk_W+pqYLkd=oBC7eENU1yYKbGzoOzgxXoOmg7_+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 3/11/19 2:26 PM, Peter Maydell wrote:
> On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
>> This commit introduces a regression when running with EDK2 FW:
>>
>> I get the following traces:
>>
>> error: kvm run failed Function not implemented
> 
> Unfortunately I can't repro this, on a Mustang host with
> 4.8.0-42-generic host kernel, with this command line:
> 
>  ./build/kvm/aarch64-softmmu/qemu-system-aarch64  -M
> virt,gic-version=host -cpu host -smp 2 -m 4G -display none
> --enable-kvm  -serial stdio -bios
> ~/QEMU_EFI_cbuild_debug_feb21_2019.fd
> 
> Does that simplified command line still repro the problem
> for you on your hardware, or does the bug require all
> the extra stuff with blk and net devices and a real
> guest filesystem to trigger? (You'll need to revert the
> revert commit 942f99c825fc94c8b1a4, obivously.)
> 
> More generally, can you strip the repro command line
> down as much as possible to something that still shows
> the bug? I'd rather not have to sort out getting TAP networking
> on this box if it isn't actually a necessary component of
> reproducing the bug :-)

yes I hit the bug with your reduced command line:

aarch64-softmmu/qemu-system-aarch64 -M virt,gic-version=host -cpu host
-smp 2 -m 4G -display none --enable-kvm  -serial stdio -bios
~/VM/UEFI/QEMU_EFI_cbuild_debug_feb21_2019.fd

[285347.260500] kvm [82944]: load/store instruction decoding not implemented

InstallProtocolInterface: CE345171-BA0B-11D2-8E4F-00A0C969723B 13E6C2F20
 BlockSize : 262144
 LastBlock : FF
error: kvm run failed Function not implemented
 PC=000000013f5a6004 X00=0000000000000000 X01=000000013e7310b0
X02=000000013f5a6004 X03=00000000404003c5 X04=0000000000000000
X05=0000000096000046 X06=000000013f828210 X07=000000013f828310
X08=000000013f8504c8 X09=0000000400000000 X10=000000013d6c1000
X11=000000013f297fff X12=0000000000000000 X13=0000000000000008
X14=0000000000000002 X15=00000000000000ff X16=000000013f872da0
X17=00000000ffffa6ab X18=0000000000000000 X19=0000000009000000
X20=000000013f5a7a78 X21=000000000000003a X22=000000013f5a7ab2
X23=0000000009000018 X24=000000013f631090 X25=0000000000000010
X26=0000000000000100 X27=000000013f89501b X28=000000013e7311b0
X29=000000013e7313e0 X30=000000013f5a5e40  SP=000000013f7bdf60
PSTATE=804003c5 N--- EL1h

Thanks

Eric

> 
> thanks
> -- PMM
> 
