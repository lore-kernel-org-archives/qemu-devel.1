Received: from eggs.gnu.org ([209.51.188.92]:37535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1UW9-0002pR-4J
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1UW8-00061D-4N
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:15:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1UW7-00060e-P9
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:15:20 -0500
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
	<ab98409f-89f3-62d2-f5aa-b460eaa0cd05@redhat.com>
	<3c67eb5e-6a7e-d884-9ce7-639584c0c63f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e49a9e0-a532-5fe2-d17f-040f3e8fe3eb@redhat.com>
Date: Wed, 6 Mar 2019 12:15:15 +0100
MIME-Version: 1.0
In-Reply-To: <3c67eb5e-6a7e-d884-9ce7-639584c0c63f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yang Zhong <yang.zhong@intel.com>

On 06/03/19 12:04, Thomas Huth wrote:
> On 06/03/2019 11.57, Paolo Bonzini wrote:
>> On 05/03/19 10:32, Peter Maydell wrote:
>>> Everything fails to build with errors like
>>> make: *** No rule to make target `config-all-devices.mak', needed by
>>> `subdir-aarch64-softmmu'.  Stop.
>>>
>>> or
>>> make: *** No rule to make target
>>> `/home/pm215/qemu/default-configs/pci.mak', needed by
>>> `aarch64-softmmu/config-devices.mak'.  Stop.
>>>
>>> If there are special instructions for what to do with
>>> build trees over the transition to kconfig, the pullreq
>>> cover letter would be a good place to mention them :-)
>>
>> As others mentioned, this is the "usual" stale dependency issue
>> requiring distclean.
> 
> Can't we somehow add a dependency for the *.mak.d file so that they get
> regenerated in this case? ... I tried to hack the Makefile, but so far I
> failed...

What we should do is add dummy dependencies for the .mak files, so that
they do not trigger the error messages; this is how gcc -MD avoids the
issue for include files.

With Kconfig it should be a one-line patch, something like

    for fname in data.previously_included:
        print('%s: %s' % (argv[1], fname), file=deps)
        print('%s:' % fname, file=deps)

but it wouldn't fix this case where the stale .mak file is preexisting.

Paolo
