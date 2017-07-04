Received: from eggs.gnu.org ([2001:4830:134:3::10]:38284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKO1-0001WX-7x
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKNy-0004AO-3K
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSKNx-00049p-Si
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:44:46 -0400
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-2-git-send-email-pbonzini@redhat.com>
	<20170704082805.GA3135@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <384f451b-70c6-a6c3-5b90-e87b79aada27@redhat.com>
Date: Tue, 4 Jul 2017 11:44:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170704082805.GA3135@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/22] configure: factor out list of
 supported Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com



On 04/07/2017 10:28, Daniel P. Berrange wrote:
>> +supported_kvm_target() {
>> +    test "$kvm" = "yes" || return 1
>> +    glob "$1" "*-softmmu" || return 1
>> +    case "${1%-softmmu}:$cpu" in
>> +        arm:arm | aarch64:aarch64 | \
>> +        i386:i386 | i386:x86_64 | i386:x32 | \
>> +        x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
> 
> IIUC, 'x86_64:i386' is claiming that you can run x86_64
> KVM guests on an i386 host. I thought that was impossible,
> only 32-on-64 being allowed not 64-on-32.

You can use qemu-system-x86_64 to run i386 KVM guests, by disabling long
mode with -cpu.  It's not a common scenario though.

>> +        mips:mips | mipsel:mips | \
>> +        ppc:ppc | ppcemb:ppc | ppc64:ppc | \
>> +        ppc:ppc64 | ppcemb:ppc64 | ppc64:ppc64 | \
> 
> Same question here with ppc64:ppc suggesting you can
> run 64-bit guest with KVM on a 32-bit host ?

I'm not sure about this one, but right now it is allowed so this patch
is not changing anything.

>> +        s390x:s390x)
>> +            return 0
>> +        ;;
>> +    esac
>> +    return 1
>> +}
>> +
>> +supported_xen_target() {
>> +    test "$xen" = "yes" || return 1
>> +    glob "$1" "*-softmmu" || return 1
>> +    case "${1%-softmmu}:$cpu" in
>> +        arm:arm | aarch64:aarch64 | \
>> +        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
> This again is claiming support for 64-bit guests with Xen on a
> 32-bit host, which AFAIK is impossible.

32-bit dom0 with 64-bit guests actually is not only possible, but also
widely used.

Paolo
