Received: from eggs.gnu.org ([2001:4830:134:3::10]:34502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dRyY6-0003rA-I9
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dRyY1-0001hn-J3
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:25:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dRyY1-0001gT-99
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:25:41 -0400
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-2-git-send-email-yang.zhong@intel.com>
	<20170703102043.GE5663@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68cbc479-3707-cdab-4dcd-d055b02ede7d@redhat.com>
Date: Mon, 3 Jul 2017 12:25:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170703102043.GE5663@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/15] configure: add the disable-tcg
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com



On 03/07/2017 12:20, Daniel P. Berrange wrote:
>>  
>> +if test "$tcg" = "no"; then
>> +   for target in $target_list; do
>> +      if test "$softmmu" = "yes"; then
>> +        case $target in
>> +           i386-softmmu|x86_64-softmmu)
>> +           ;;
>> +        *)
>> +           error_exit "The current $target can't support disable-tcg,"\
>> +              "only i386-softmmu|x86_64-softmmu support disable-tcg"
>> +           ;;
> This looks too simplistic in its logic.
> 
> You can disable TCG, if-and-only-if the system emulator supports KVM.
> 
> KVM is supported on many architectures, not only x86-64 & i386.
> 
> KVM is only supported if the guest emulator architecture matches the
> host build target architecture.
> 
> ie if you are building an x86_64 system emulator on a PPC64 host,
> then you can't disable TCG.
> 
> So this needs rewriting to *not* special case x86_64 / i386. Instead
> you need to compare & match build target / system emulator architectures,
> across all architectures supporting KVM.

i386-softmmu and x86_64-softmmu are singled out here, because they're
the only targets where --disable-tcg compiles.  For the others, more
work is needed (see patches 6-15 in Yang Zhong's series).

The part that is missing in this patch is disabling non-hypervisor
targets when --disable-tcg is specified.  My original patch built only
i386-softmmu and x86_64-softmmu if you specified --disable-tcg, see

https://lists.nongnu.org/archive/html/qemu-devel/2012-09/msg02570.html
https://lists.nongnu.org/archive/html/qemu-devel/2012-09/msg02571.html

Paolo
