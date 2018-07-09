Received: from eggs.gnu.org ([2001:4830:134:3::10]:37607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fcS77-0003WJ-3C
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fcS72-0003fB-3n
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:05:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fcS71-0003eN-VZ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A607A402242D
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 09:05:38 +0000 (UTC)
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<20180705165348-mutt-send-email-mst@kernel.org>
	<20180705141132.GM1455@redhat.com> <20180709073647.GF16293@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9cb4ee1c-52c8-d112-4bfa-22436127826e@redhat.com>
Date: Mon, 9 Jul 2018 11:05:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180709073647.GF16293@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, jferlan@redhat.com, mxie@redhat.com

On 07/09/18 09:36, Richard W.M. Jones wrote:
> On Thu, Jul 05, 2018 at 03:11:32PM +0100, Richard W.M. Jones wrote:
>> VMware represents these internally as two signed 64 bit integers, eg:
>>
>>   vm.genid = "-570734802784577186"
>>   vm.genidx = "-5042519231342505152"
>>
>> I am still trying to get verification, but I believe the first is the
>> low 64 bit word and the second is the high 64 bit word.
> 
> I have now been able to verify how this works using a real VMware
> hypervisor (thanks to help from Ming Xie).  For the record, here is
> how it maps, since I could not find any documentation about this.
> 
> VMX file contains:
> 
>   vm.genid = "7344585841658099715"
>   vm.genidX = "-8483171368186442967"
> 
> Those numbers are signed 64 bit integers written in hex as:
> 
>   vm.genid = 65 ED 35 E8 E2 64 F8 03
>   vm.genidX = 8A 45 B8 96 1E 7B 8B 29

If you mean to describe the byte array representations: these are the
big endian ones.

> In the guest the VMGENID.EXE program prints (with my spaces added for
> clarity):

Right, it's important to note that the spaces below were added for
clarity. The decimal constant 7344585841658099715 is equal to the
hexadecimal constant 0x65ED35E8E264F803. The big endian byte array
representation for that is what you quote above, the little endian one
is the reverse.

>   VmCounterValue: 65 ED 35 E8 E2 64 F8 03 : 8A 45 B8 96 1E 7B 8B 29
> 
> So this confirms my original guess.  Note that VMware is not doing any
> endianness adjustment, but then VMware only works on LE hardware.

Thanks for tracking this down -- TIL.

(My above remarks are not meant as disagreement: it looks like VMWare
simply stores the int64_t values from the config file to guest memory,
without any kind of conversion. I only meant to comment on your
paragraph "written in hex as ...", because it wasn't clear to me whether
you meant "as uint64_t with spaces for clarity" or "as uint8_t[8]". The
latter is endianness-dependent, and the rendering you gave was BE, which
seemed to conflict with your final statement.)

Thanks!
Laszlo
