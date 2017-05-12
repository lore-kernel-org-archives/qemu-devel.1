Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d9G3P-0001RR-B5
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d9G3M-00059T-4V
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d9G3L-00058i-U9
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:16:40 -0400
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
	<618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
Date: Fri, 12 May 2017 21:16:31 +0200
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 12/05/2017 20:55, Xu, Anthony wrote:
>  
>> On 12/05/2017 01:55, Xu, Anthony wrote:
>>> Hi Paolo,
>>>
>>> In KVM mode, seems A20 is ignored.
>>> Do you see any potential issue here?
>>
>> No; recent processors don't have A20 at all.
> 
> I mean A20 in guest, not A20 in host.  
> Guest is running on old platform, it tries to control A20  through port 92 like what SeaBios does.
> QEMU/KVM does handle port 92 access to set correct env->a20_mask,
> but QEMU/KVM ignores A20 status when handling guest memory access.
> 
> Since QEMU/KVM works well with SeaBios, does that imply SeaBios doesn't generate address
> larger than 0x100000 in real mode?

No, only the guest's OS or software (not the firmware) might require
A20.  But really anything that ran with MS-DOS 5.0 HIMEM.SYS or newer
(which used DOS=HIGH to relocate DOS into the HMA, I think) does not
need it.

> If that's the case,  QEMU/TCG should work with SeaBios even with ignoring A20.
> 
> During SeaBios boot, there are >350 port 92 access, if we don't need to handle A20, 
> we can make A20 configurable in Seabios, It may reduce SeaBios boot time.

Yes, that's a good idea.

Paolo
