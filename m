Received: from eggs.gnu.org ([2001:4830:134:3::10]:33694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dE5oS-0007jC-RL
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dE5oN-0001BP-Va
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:21:16 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dE5oN-0001B9-Q1
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:21:11 -0400
Received: by mail-pf0-x241.google.com with SMTP id f27so42999974pfe.0
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 20:21:11 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20170525031936.8449-1-xiaoguangrong@tencent.com>
	<210485b2-c6f5-2f57-f196-dc1b25bbe243@redhat.com>
Message-ID: <09486d4e-7b21-06bb-ee6a-9b847e94cdd0@gmail.com>
Date: Fri, 26 May 2017 11:21:17 +0800
MIME-Version: 1.0
In-Reply-To: <210485b2-c6f5-2f57-f196-dc1b25bbe243@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qtest: add rtc periodic timer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/26/2017 12:03 AM, Paolo Bonzini wrote:
> 
> 
> On 25/05/2017 05:19, guangrong.xiao@gmail.com wrote:
>>
>> Note: as qemu needs a precise timer to drive its rtc timer callbacks,
>> that means clock=vm is not suitable for us as it's driven by icount
>> for qtest, so that we use clock=host instead, it is why we put the
>> periodic timer test separately without mixing with rtc-test
> 
> I'm not sure I understand.  Why would clock_step(1000) not be a good
> replacement for nsleep(1000)?

We can not. As we use the real time to compare with the time that is
passed in the VM, however, clock_step() is not a real time based clock
source which immediately injects a time step to the VM regardless how
much real time elapsed.

I also tried nsleep(1000) before clock_step(1000), i,e:
    nsleep(1000);
    clock_step(1000);
that can not work too, it looks like the time spend on icount update in
the VM can not be guaranteed。
